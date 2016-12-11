/*
* Rock paper scissors script by Zarthus!
*
*
* SETTINGS: Define colours & RockPaperScissors channel. Don't edit it if you have no idea what you're doing.
*           You probably want to change RPSadchan, RPSchan and RPStime.
*
*	@note
*	This script is very old, I do not gurantee it working.
*/

alias -l GameHelp { return $rpscol1 $+ You can start a game using $rpssynt(!rps (PLAYER2)) (Channel: $+($rpscol2,$rpschan,,$rpscol1) $+ ) or $hsynt(!Startgame) (Channel: $+($hcol2,$hchan,,$hcol1) $+ ) for a hangman game. } ;The help message when someone uses !help in a channel.

alias -l RPSadchan { return #rps_ } ;The advertise/main channel where everyone is, #rps_ by default.
alias -l RPSchan { return #rps } ;The Rock Paper Scissor channel, #rps default.
alias -l RPStime { return 20 } ;Timer till the players will have to have sent in their rock/paper/scissor.

alias -l RPScol1 { return 03 }  ;Colour settings ("chat" RPS colour). Will show as 03 by default.
alias -l RPScol2 { return 10 } ;Colour settings ("main" RPS colour). Will show as 10 by default.
alias -l RPSsynt { return $+(11,$1-,,$RPScol1) } ;Syntax indicator, will show as 11SYNTAX <SYNTAX>03 by default.
alias -l RPStag { return $+(10,[ROCK PAPER SCISSORS],,$RPScol1) } ;The Hangman tag, will show 10[ROCK PAPER SCISSORS] by default.

;********************************************
;* DO NOT TOUCH / MODIFY THESE SETTINGS.    *
;********************************************
alias -l RPS1 { return $+($rpscol2,%rps.CHOSE1,,$rpscol1) } 
alias -l RPS2 { return $+($rpscol2,%rps.CHOSE2,,$rpscol1) } 
alias -l RPSp1 { return $+($rpscol2,%rps.p1,,$rpscol1) } 
alias -l RPSp2 { return $+($rpscol2,%rps.p2,,$rpscol1) } 
alias -l RPSchoice1 { return $rpstag $+($rpscol2,%rps.chose1,,$rpscol1) }
alias -l RPSchoice2 { return $rpstag $+($rpscol2,%rps.chose2,,$rpscol1) } 
alias -l RPSmsg { return $RPSchan $RPStag } 
;********************************************
;* DO NOT TOUCH / MODIFY THESE SETTINGS.    *
;********************************************

on *:TEXT:!rps *:#: {
  if (%Revo.Game != $null) { msg $chan A game is already started between $rpsp1 & $rpsp2 $+ . | halt }
  if ($chan == $rpschan) {
    set %RPS.p1 $nick
    set %RPS.p2 $2

    if (%RPS.p2 == AI) { RPS_Gen_Random }

    msg %RPS.p1 You get $RPStime to reply with ROCK PAPER or SCISSORS.
    if (%rps.p2 != AI) { msg %RPS.p2 You get $RPStime to reply with ROCK PAPER or SCISSORS. }

    set %Revo.Game $true

    msg $RPSmsg A Rock Paper Scissor game has been created, this game is between $RPSp1 and $RPSp2 $+ .
    msg $RPSmsg $RPSp1 and $RPSp2 get $RPStime seconds to query $rpssynt($me) with $rpssynt(ROCK PAPER or SCISSORS) $+ .
    msg $RPSadchan $rpstag A Rock Paper Scissor game has been created in $+($rpscol2,$rpschan,,$rpscol1,$chr(44)) this game is between $RPSp1 and $RPSp2 $+ .

    .timer 1 $RPSTIME RPS_Check_Results  
  }
}

on *:INPUT:#: {
  if ($chan == $rpschan) {
    if ($1 == !rps && $2 != $null) {
      if (%Revo.Game) { msg $chan A game is already started between $rpsp1 & $rpsp2 $+ . | halt }
      set %RPS.p1 $me
      set %RPS.p2 $2

      if (%RPS.p2 == AI) { RPS_Gen_Random }
      set %Revo.Game $true

      if (%rps.p2 != AI) { msg %RPS.p2 You get $RPStime to reply with ROCK PAPER or SCISSORS. }

      msg $RPSmsg A Rock Paper Scissor game has been created, this game is between $RPSp1 and $RPSp2 $+ .
      msg $RPSmsg $RPSp1 and $RPSp2 get $RPStime seconds to query $+($rpscol2,$me,,$rpscol1) with ROCK PAPER or SCISSORS.

      .timer 1 $RPSTIME RPS_Check_Results 
    }
  }
}

alias RPS_Check_Results {
  msg $RPSmsg The time is up, $rpsp1 has chosen for %RPS.CHOSE1 and $rpsp2 has chosen for %RPS.CHOSE2 $+ .
  if (%RPS.CHOSE1 == %RPS.CHOSE2) { RPS_TIE | halt }
  if (%RPS.CHOSE1 == ROCK && %RPS.CHOSE2 != PAPER) { RPS_PLAYER1_WIN | halt }
  if (%RPS.CHOSE1 == PAPER && %RPS.CHOSE2 != SCISSORS) { RPS_PLAYER1_WIN | halt }
  if (%RPS.CHOSE1 == SCISSORS && %RPS.CHOSE2 != ROCK) { RPS_PLAYER1_WIN | halt }
  RPS_PLAYER2_WIN
}

alias -l RPS_Player1_Win {
  msg $RPSmsg $RPSp1 has won with $rps1 $+ .
  msg $rpsmsg To restart the game type $rpssynt(!RPS [player2nick]) $+ .
  RPSend
}

alias -l RPS_Player2_Win {
  msg $RPSmsg $RPSp2 has won with $rps2 $+ .
  msg $rpsmsg To restart the game type $rpssynt(!RPS [player2nick]) $+ .
  RPSend
}

alias -l RPS_TIE {
  msg $RPSmsg The game ended in a tie! ( $+ $rpsp1 - $rps1 V.S. $rpsp2 - $rps2 $+ )
  msg $rpsmsg To restart the game type $rpssynt(!RPS [player2nick]) $+ .
  RPSend
}

on *:TEXT:ROCK:?: {
  if (%Revo.Game) {
    if ($nick == $strip($RPSp1)) {
      set %RPS.CHOSE1 ROCK
      msg $nick You have chosen: $RPSchoice1
    }
    if ($nick == $strip($RPSp2)) {
      set %RPS.CHOSE2 ROCK
      msg $nick You have chosen: $RPSchoice2
    }
  }
}

on *:TEXT:PAPER:?: {
  if (%Revo.Game) {
    if ($nick == $strip($RPSp1)) {
      set %RPS.CHOSE1 PAPER
      msg $nick You have chosen: $RPSchoice1
    }
    if ($nick == $strip($RPSp2)) {
      set %RPS.CHOSE2 PAPER
      msg $nick You have chosen: $RPSchoice2
    }
  }
}

on *:TEXT:SCISSORS:?: {
  if (%Revo.Game) {
    if ($nick == $strip($RPSp1)) {
      set %RPS.CHOSE1 SCISSORS
      msg $nick You have chosen: $RPSchoice1
    }
    if ($nick == $strip($RPSp2)) {
      set %RPS.CHOSE2 SCISSORS
      msg $nick You have chosen: $RPSchoice2
    }
  }
}

alias RPSend {
  unset %RPS.*
  unset %Revo.Game
}

alias -l RPS_Gen_Random {
  var %rps.rand = $rand(1, 3)
  if (%rps.rand = 1) { set %RPS.CHOSE2 ROCK }
  if (%rps.rand = 2) { set %RPS.CHOSE2 SCISSORS }
  if (%rps.rand = 3) { set %RPS.CHOSE2 PAPER }
}
