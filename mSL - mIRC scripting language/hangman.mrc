
/*
*   Hangman script by Zarthus!
*	Originally released somewhere in 2011
*
*	@note
*	This script is very old, I do not gurantee it working.
*	It also is accompanied by a few minor issues (hacks if you will)
*
*/

;SETTINGS: Define colours & Hangman channel. Don't edit it if you have no idea what you're doing.
alias -l hadchan { return #hangman_ } ;The advertise/main channel where everyone is, #hangman_ by default.
alias -l hchan { return #hangman } ;The hangman channel, #hangman by default.
alias -l hcol1 { return 03 }  ;Colour settings ("chat" hangman colour). Will show as 03 by default.
alias -l hcol2 { return 10 } ;Colour settings ("main" hangman colour). Will show as 10 by default.
alias -l hsynt { return $+(11,$1-,,$hcol1) } ;Syntax indicator, will show as 11SYNTAX <SYNTAX>03 by default.
alias -l htag { return $+(10,[HANGMAN],,$hcol1) } ;The Hangman tag, will show 10[HANGMAN] by default.
alias -l hmaxguesses { return 6 } ;Maximum guesses for defeat.
alias -l hbigprint { return false } ;Print out big letters, causes lagg.

;Do not touch this.
alias -l hleft { return $+($hcol2,$calc($hmaxguesses - %hangman.fguess),,$hcol1) }
alias -l hmsg { return $hchan $htag } 
alias -l htoul { return $Hangman_To_US }
alias -l hguessmsg { return The lenght of the word is $+($hcol2,$len(%hangman.word),,$hcol1) letters, There are $hleft chances left. } 
alias -l hHalfNick { return $mid($1, 1, $calc($len($1) / 2)) $+ - $+ $mid($1, - $+ $calc($len($1) / 2)) }

;Startgame via query.
on *:TEXT:!startgame*:?: {
  if ($nick isin $hchan) {
    if (%Revo.Game) { msg $hmsg $hcol1 $+ A game is already started. | halt }
    if ($2 == $null) { 
      msg $nick Error: $hsynt(!startgame <WORD TO GUESS>)
      halt
    } 
    if ($3 != $null) { msg $nick Word too long, please supply only one word. | halt }
    if ($3 == $null) {
      set %hangman.word $2
      set %hangman.target $nick($hchan, $rand(1, $nick($hchan, 0)))
      set %hangman.target $hHalfNick(%hangman.target)
      set %Revo.Game $true

      Hangman_Get_word

      msg $hmsg A game of hangman has started by $nick $+ .
      msg $hmsg You can play the game by typing $hsynt(!guess <letter>) or if you think you know the word, $hsynt(!word <word>) $+ .
      msg $hmsg Today our lucky hangman is $+($hcol2,%hangman.target,,$hcol1,.)
      msg $hadchan $htag A game of hangman has started in $+($hcol2,$hchan,,$hcol1) by $nick $+ .

      msg $hmsg $hguessmsg
      msg $hmsg WORD: $+ $hcol2 %hangman.us
    }
  }
}

;Startgame via hangman channel.
on *:TEXT:!startgame:#: {
  if ($chan == $hchan) {
    if (%Revo.Game) { msg $hmsg $hcol1 $+ A game is already started. | halt }
    set %Revo.Game $true

    msg $hmsg A game of hangman has started.
    msg $hmsg You can play the game by typing $hsynt(!guess <letter>) or if you think you know the word, $hsynt(!word <word>) $+ .
    msg $hadchan $htag A game of hangman has started in $+($hcol2,$hchan,,$hcol1,.)

    Hangman_Get_Word

    msg $hmsg $hguessmsg
    msg $hmsg WORD: $+ $hcol2 %hangman.us
  }
}

;Add a word to the hangmans word database.
on *:TEXT:!addword*:#: {
  if ($chan == $hchan) {
    if ($3 == $null) { 
      if ($nick isvoice $hchan || $nick isop $hchan) {
        msg $hmsg word $2- added $nick
        writeini -n Hangman.ini Words $+(Word,$calc($ini(Hangman.ini, Words, 0)+1)) $2
      }
      if ($nick !isvoice $hchan && $nick !isop $hchan) {
        msg $hmsg $+($hcol2,$nick,,$hcol1,$chr(44)) You do not have enough permissions to add words. You need atleast 09Voice $+ $hcol1 in $+($hcol2,$hchan,,$hcol1) to add words.
      }
      if ($3 != $null) {
        msg $hmsg $+($hcol2,$nick,,$hcol1,$chr(44)) $hsynt(!addword <word>) only supports one word. Please do not use multiple words.
      } 
    }
  }
}

on *:TEXT:!info:#: {
  if ($chan == $hchan) {
    msg $hmsg $hguessmsg
    msg $hmsg WORD: $+ $hcol2 %hangman.us
  }
}

;Notice on joining the hangman channel when a game is in progress.
on *:JOIN:*: {
  if ($chan == $hchan && %Revo.Game) {
    notice $nick $htag You can play the game by typing $hsynt(!guess <letter>) or if you think you know the word, $hsynt(!word <word>) $+ .
  }
}

;Word guessing.
on *:TEXT:!word*:*: {
  if ($chan == $hchan && %Revo.Game) {
    if ($2- != %hangman.word) {
      Hangman_Failed_Guess
    }
    if ($2- == %hangman.word) {
      set %hangman.win = $nick
      Hangman_Win_Game
    }
  }
}

;Letter guessing.
on *:TEXT:!guess *:#: {
  if ($chan == $hchan && %Revo.Game) {
    if ($len($2) >= 2 || $2 !isalpha) { msg $chan $+($hcol2,$nick,,$chr(44)) You can only guess letters. Not words or numbers. | halt }
    if ($2 isin %hangman.word) {
      set %hangman.letter $2
      hchecklet
      $iif(_ isin %hangman.us, msg $hmsg $+($hcol2,$2,,$hcol1) is correct - WORD: $+ $hcol2 %hangman.us, Hangman_Win_Game)
      halt
    }
    if ($2 !isin %hangman.word) {
      msg $hmsg Incorrect guess, $nick $+ .
      Hangman_Failed_Guess
    }
  }
}

;Retrieving a random word from the word database.
alias -l Hangman_Get_Word {
  set %hangman.word $readini(Hangman.ini, Words, $+(Word,$rand(1, $ini(Hangman.ini, Words, 0))))

  set %hangman.target $nick($hchan, $rand(1, $nick($hchan, 0)))
  msg $hmsg Today our lucky hangman is $+($hcol2,%hangman.target,,$hcol1,.)

  set %hangman.us $replace(%hangman.word,a,20_,b,21_,c,22_,d,23_,e,24_,f,25_,g,26_,h,27_,i,28_,j,29_,k,30_,l,31_,m,32_,n,33_,o,34_,p,35_,q,36_,r,37_,s,38_,t,39_,u,40_,v,41_,w,42_,x,43_,y,44_,z,45_)
}

;Perform the nessecary actions when a player guesses a letter incorrectly.
alias -l Hangman_Failed_Guess {
  if (%hangman.fguess == $null) { set %hangman.fguess $hmaxguesses }
  dec %hangman.fguess
  msg $hmsg WORD: $+ $hcol2 %hangman.us
  if (%hangman.fguess == 0) {
    Hangman_Lose_Game
  }
  if (%hangman.fguess != 0) {
    msg $hmsg There are only $hcol2 $+ %hangman.fguess  $+ $hcol1 $+ chances left before $+($hcol2,%hangman.target,,$hcol1) gets hanged.
  }
}

;Lose the game when too many incorrect guesses have been made.
alias -l Hangman_Lose_Game {
  if ($hbigprint != false) {
    ;Prints out big "YOU LOSE"
    msg $hchan                                                    
    msg $hchan                                                    
    msg $hchan                                                    
    msg $hchan                                                    
    msg $hchan                                                   
  }
  msg $hmsg The Hangman game has ended, the players failed to guess the word within $+($hcol2,$hmaxguesses,,$hcol1) attempts.
  msg $hmsg The word was $+($hcol2,%hangman.word,,$hcol1,.)
  msg $hmsg To restart the game you can say $hsynt(!startgame) or query $me with $hsynt(!startgame <word>) $+ .
  endgame
}

;Win the game (Guess the word.)
alias -l Hangman_Win_Game {
  if ($hbigprint != false) {
    ;Prints out big "YOU WIN"
    msg $hchan                                              
    msg $hchan                                              
    msg $hchan                                              
    msg $hchan                                              
    msg $hchan                                             
  }
  msg $hmsg The Hangman game has ended, $nick has guessed the word. $&
    There were $+($hcol2,$calc(%hangman.fguess - $hmagguesses),,$hcol1) turns left before $+($hcol2,%hangman.target,,$hcol1) would have died. $&
    $+($hcol2,%hangman.target,,$hcol1) is a very happy man and thanks all of you!
  msg $hmsg The word was $+($hcol2,%hangman.word,,$hcol1,.) $&
    To restart the game you can say $hsynt(!startgame) or query $me with $hsynt(!startgame <word>) $+ .
  endgame
}

alias -l hcheck {
  if (%i == 1) { return a }
  if (%i == 2) { return b }
  if (%i == 3) { return c }
  if (%i == 4) { return d }
  if (%i == 5) { return e }
  if (%i == 6) { return f }
  if (%i == 7) { return g }
  if (%i == 8) { return h }
  if (%i == 9) { return i }
  if (%i == 10) { return j }
  if (%i == 11) { return k }
  if (%i == 12) { return l }
  if (%i == 13) { return m }
  if (%i == 14) { return n }
  if (%i == 15) { return o }
  if (%i == 16) { return p }
  if (%i == 17) { return q }
  if (%i == 18) { return r }
  if (%i == 19) { return s }
  if (%i == 20) { return t }
  if (%i == 21) { return u }
  if (%i == 22) { return v }
  if (%i == 23) { return w }
  if (%i == 24) { return x }
  if (%i == 25) { return y }
  if (%i == 26) { return z }
}

alias -l hchecklet {
  if (%hangman.letter == a) { set %hangman.guessedlettera $true }
  if (%hangman.letter == b) { set %hangman.guessedletterb $true }
  if (%hangman.letter == c) { set %hangman.guessedletterc $true }
  if (%hangman.letter == d) { set %hangman.guessedletterd $true }
  if (%hangman.letter == e) { set %hangman.guessedlettere $true }
  if (%hangman.letter == f) { set %hangman.guessedletterf $true }
  if (%hangman.letter == g) { set %hangman.guessedletterg $true }
  if (%hangman.letter == h) { set %hangman.guessedletterh $true }
  if (%hangman.letter == i) { set %hangman.guessedletteri $true }
  if (%hangman.letter == j) { set %hangman.guessedletterj $true }
  if (%hangman.letter == k) { set %hangman.guessedletterk $true }
  if (%hangman.letter == l) { set %hangman.guessedletterl $true }
  if (%hangman.letter == m) { set %hangman.guessedletterm $true }
  if (%hangman.letter == n) { set %hangman.guessedlettern $true }
  if (%hangman.letter == o) { set %hangman.guessedlettero $true }
  if (%hangman.letter == p) { set %hangman.guessedletterp $true }
  if (%hangman.letter == q) { set %hangman.guessedletterq $true }
  if (%hangman.letter == r) { set %hangman.guessedletterr $true }
  if (%hangman.letter == s) { set %hangman.guessedletters $true }
  if (%hangman.letter == t) { set %hangman.guessedlettert $true }
  if (%hangman.letter == u) { set %hangman.guessedletteru $true }
  if (%hangman.letter == v) { set %hangman.guessedletterv $true }
  if (%hangman.letter == w) { set %hangman.guessedletterw $true }
  if (%hangman.letter == x) { set %hangman.guessedletterx $true }
  if (%hangman.letter == y) { set %hangman.guessedlettery $true }
  if (%hangman.letter == z) { set %hangman.guessedletterz $true }

  if (%hangman.guessedlettera && 20_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 20_, $hcol2 $+ A) }
  if (%hangman.guessedletterb && 21_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 21_, $hcol2 $+ B) } 
  if (%hangman.guessedletterc && 22_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 22_, $hcol2 $+ C) }
  if (%hangman.guessedletterd && 23_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 23_, $hcol2 $+ D) }
  if (%hangman.guessedlettere && 24_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 24_, $hcol2 $+ E) }
  if (%hangman.guessedletterf && 25_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 25_, $hcol2 $+ F) }
  if (%hangman.guessedletterg && 26_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 26_, $hcol2 $+ G) }
  if (%hangman.guessedletterh && 27_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 27_, $hcol2 $+ H) }
  if (%hangman.guessedletteri && 28_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 28_, $hcol2 $+ I) }
  if (%hangman.guessedletterj && 29_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 29_, $hcol2 $+ J) }
  if (%hangman.guessedletterk && 30_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 30_, $hcol2 $+ K) }
  if (%hangman.guessedletterl && 31_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 31_, $hcol2 $+ L) }
  if (%hangman.guessedletterm && 32_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 32_, $hcol2 $+ M) }
  if (%hangman.guessedlettern && 33_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 33_, $hcol2 $+ N) }
  if (%hangman.guessedlettero && 34_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 34_, $hcol2 $+ O) }
  if (%hangman.guessedletterp && 35_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 35_, $hcol2 $+ P) }
  if (%hangman.guessedletterq && 36_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 36_, $hcol2 $+ Q) }
  if (%hangman.guessedletterr && 37_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 37_, $hcol2 $+ R) }
  if (%hangman.guessedletters && 38_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 38_, $hcol2 $+ S) }
  if (%hangman.guessedlettert && 39_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 39_, $hcol2 $+ T) }
  if (%hangman.guessedletteru && 40_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 40_, $hcol2 $+ U) }
  if (%hangman.guessedletterv && 41_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 41_, $hcol2 $+ V) }
  if (%hangman.guessedletterw && 42_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 42_, $hcol2 $+ W) }
  if (%hangman.guessedletterx && 43_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 43_, $hcol2 $+ X) }
  if (%hangman.guessedlettery && 44_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 44_, $hcol2 $+ Y) }
  if (%hangman.guessedletterz && 45_ isin %hangman.us) { set %hangman.us $replace(%hangman.us, 45_, $hcol2 $+ Z) }
}

alias Hangman_To_US { 
  if (!%hangman.us) { set %hangman.us $replace(%hangman.word,a,20_,b,21_,c,22_,d,23_,e,24_,f,25_,g,26_,h,27_,i,28_,j,29_,k,30_,l,31_,m,32_,n,33_,o,34_,p,35_,q,36_,r,37_,s,38_,t,39_,u,40_,v,41_,w,42_,x,43_,y,44_,z,45_) }
  return $hchecklet(%hangman.us)
}

alias endgame { unset %revo.game | Unset %hangman.* }

on *:TEXT:!help:#: {
  if ($chan == $rpschan || $chan == $hchan) {
    msg $chan $GameHelp
  }
}

