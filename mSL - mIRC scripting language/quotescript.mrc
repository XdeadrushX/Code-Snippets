;Written on prior to 2012, improved over the years
;This script's core was written by a friend of mine, [nas]peter. Kudos to him.

on *:TEXT:!addquote*:*: { 
  if ($network != GTAnet) { 
    set -u2 %TimeStampColor $readini(NickAlert.ini, Data, TimeStamp)
    if ($len($2-) < 10) {
      if ($2- == $null) {
        msg $chan 04ERROR:11 The quote is empty, make sure to specify the second parameter.

        echo @Actions %TimeStampColor $+ ( $+ $TIME $+ ) 07[ERROR]03 An authorized user (10 $+ $nick $+ 03) tried to add a quote, but did not fill in the nessecary parameters. 
        halt
      }
      if ($len($2-) > 1) {
        msg $chan 04ERROR:11 The quote is not long enough, Make sure the quote is atleast longer than07 10 11characters.

        echo @Actions %TimeStampColor $+ ( $+ $TIME $+ ) 07[ERROR]03 An authorized user (10 $+ $nick $+ 03) tried to add a quote, but it was too short.
        halt
      }
    }
    if ($readini(QuoteDB.ini, Permissions, $nick) == 1 || $nick isop #revo) {
      set %amountofquotes $calc($readini(QuoteDB.ini,Amount,Amount)+1)
      set -u2 %SetBy $calc($readini(QuoteDB.ini,Setby,$nick)+1)

      var %quoteadd = $replace($2-, \n, $chr(3) $chr(124) msg $chr(36) $+ chan $chr(3) $+ 13[QUOTE] $chr(3)) 15- Added by $nick on $date $+ .
      writeini -n QuoteDB.ini quote %amountofquotes %quoteadd
      writeini -n QuoteDB.ini Amount Amount %amountofquotes
      writeini -n QuoteDB.ini Setby $nick %SetBy

      echo @Actions %TimeStampColor $+ ( $+ $TIME $+ ) 07[QUOTE]03 An authorized user (10 $+ $nick $+ 03) has added a quote (ID: 07 $+ %amountofquotes $+ 03).

      msg $chan Quote added, $nick $+ . Quote number:7 %amountofquotes 
      halt
    }
    if ($readini(QuoteDB.ini, Permissions, $nick) != 1) {
      notice $nick 04ERROR: 11You do not have enough permissions to add a quote.

      echo @Actions %TimeStampColor $+ ( $+ $TIME $+ ) 07[ERROR]03 A unauthorized user (10 $+ $nick $+ 03) tried to add a quote. 
      halt
    }
  }
}

alias Qdel {
  if ($1 == $null) { echo -a You must specify the first parameter. | halt }
  remini QuoteDB.ini Permissions $1- 
  msg $active You have successfully removed04 $1- from adding quotes.04 $1- can now no longer use !addquote (Quote).
}

alias Qadd {
  if ($1 == $null) { echo -a You must specify the first parameter. | halt }
  writeini -n QuoteDB.ini Permissions $1- 1
  msg $active You have successfully added03 $1- $+ ,03 $1- can now !addquote (Quote).
}

on *:TEXT:!qamount:*: {
  if ($network == CRRPG) {
    if (%YesAntiSpam) { halt }
    set -u10 %YesAntiSpam 1 
    set %amountofquotes $readini(QuoteDB.ini,Amount,Amount)
    msg $chan 11Amount of quotes:7 %amountofquotes $+ 11!
  }
}

on *:TEXT:!quotes*:*: {
  if ($network == CRRPG || $network == MoinGaming) {
    if ( $calc( $ctime - %lastquote ) >= %quoteAntiSpam ) {
      if ($2 == $null) { 
        notice $nick 0Error! You must specify a nickname to get the total amount of quotes from. Syntax: 03!quotes <nickname>  
        set %lastquote $ctime
        halt
      }
      if ( %quoteon ) {
        var %TotQuotes $readini(QuoteDB.ini,Setby,$2)
        if (%TotQuotes == $null) { set -u2 %totquotes None }
        msg $chan %quotecolor $+ [QUOTES] 03Total amount of quotes by07 $2 $+ 03:07 %TotQuotes $+ 03.
        set %lastquote $ctime
      }
    }
  }
}

on *:TEXT:!quote*:*: {
  if ($network != GTAnet) { 
    if ($network != DRD-Family) {
      if ( $calc( $ctime - %lastquote ) >= %quoteAntiSpam ) {
        if ( %quoteon ) {
          set %lastquote $ctime
          if ($2 == credits) {
            notice $nick Credits to [NAS]peter for helping & starting the script, massive edits done by Revo.
            halt
          }
          if ($2 == help || $2 == cmds || $2 == commands) {
            notice $nick %quotecolor $+ [QUOTE CMDS] 03!addquote (10Requires OP in #Revo03), !quote (10Optionally number03), !quotes (10nickname03), !quote ALL (10Total quotes03)
            halt
          }
          if ($2 == all || $2 == amount) {
            var %amountofquotes = $readini(QuoteDB.ini,amount,amount)
            msg $chan %quotecolor $+ [QUOTE] 03There are a total of 07 $+ %amountofquotes $+ 03 quotes.
            set %lastquote $ctime
            halt
          }
          set %quoteamount $readini(QuoteDB.ini,Amount,Amount)
          if ( $2 == $null ) {
            set %rnd $rand(1,%quoteamount)
            if ( $readini(QuoteDB.ini, quote, %rnd) == 1337 ) {
              set %search %rnd $+ =
              $read(LongQuotes.txt,sp, %search)
              halt
              } else {
              msg $chan $iif(%msg != $null, %msg, %quotecolor $+ [QUOTE] %quotecolor $+ [ $+ %rnd $+ ] $readini(QuoteDB.ini,quote,%rnd))
              ; msg $chan %quotecolor $+ [QUOTE] %quotecolor $+ [ $+ %rnd $+ ] ($readini(QuoteDB.ini,quote,%rnd)
            }
            ; msg $chan %quotecolor $+ [QUOTE] %quotecolor $+ [ $+ %rnd $+ ] $Revo_NewLine($readini(QuoteDB.ini,quote,%rnd))
          }
          elseif ( $2 != $null ) {
            if ( $2 == amount ) {
              msg $chan %quotecolor $+ [QUOTE] $readini(QuoteDB.ini,Amount,Amount)
              } else {
              ; msg $chan %quotecolor $+ [QUOTE] $readini(QuoteDB.ini,quote,$2)
              if ( $readini(QuoteDB.ini, quote, $2) == 1337 ) {
                set %search $2 $+ =
                $read(LongQuotes.txt,sp, %search)
                halt
                } else {
                msg $chan %quotecolor $+ [QUOTE] $readini(QuoteDB.ini,quote,$remove($2, $(|), msg, $($chan)))
              }
            }
          }
        }
        else {
          notice $nick Quotes are off.
        }
      }
    }
    unset %Quote.readTXT
  }
}

alias Add.Quote.To.DB {
  set %amountofquotes $calc($readini(QuoteDB.ini,Amount,Amount)+1)
  set %multilinequote $?!="Is it multiple lines?"
  if ( %multilinequote ) {
    set %quotepart1 $?="What's the first part of the Quote:"
    set %quotepart2 $?="What's the second part of the Quote:"
    set %q.s %amountofquotes $+ =
    write -n LongQuotes.txt %q.s msg $chan %quotecolor $+ [QUOTE] %quotepart1 $chr(124) msg $chan %quotecolor $+ [QUOTE] %quotepart2
    writeini -n QuoteDB.ini quote %amountofquotes 1337
    writeini -n QuoteDB.ini Amount Amount %amountofquotes
    halt
    } else {
    set %quotepart1 $?="insert quote here"
    writeini -n QuoteDB.ini quote %amountofquotes %quotepart1
    writeini -n QuoteDB.ini Amount Amount %amountofquotes
  }
  unset %q.s
  unset %multilinequote
  unset %quotepart1
  unset %quotepart2
}

alias Quote.On {
  set %quoteon 1
  echo -a Quotes are now ON
}

alias Quote.off {
  set %quoteon 0
  echo -a Quotes are now off
}

alias Quote.color {
  set %quotecolor $$?="What will the colors be? (ctrl+k)"
  echo -a COLORS SET
}

alias Quote.Antispam {
  set %quoteAntiSpam $$?="How many seconds should antispam last?"
  echo -a Antispam set to %quoteAntiSpam seconds
}

alias Quote.amount {
  msg $chan %quotecolor $+ [QUOTE] Amount of quotes: $readini(QuoteDB.ini,Amount,Amount)
}

Menu * {
  .Quote Menu
  ..Quote ON:/Quote.On
  ..Quote OFF:/Quote.off
  ..Add Quote:/Add.Quote.To.DB
  ..Color:/Quote.color
  ..Set Antispam:/Quote.Antispam
  ..Amount of Quotes:/Quote.amount
}

on *:INPUT:*: {
  if ($1 == !quotes) {
    if ($2 == $null) { 
      echo -tnga 0Error! You must specify a nickname to get the total amount of quotes from. Syntax: 03!quotes <nickname>  

    }
    if ($2 != $null) {
      var %TotQuotes $readini(QuoteDB.ini,Setby,$2)
      if (%TotQuotes == $null) { set -u2 %totquotes None }
      msg $chan $1-
      .timer 1 1 msg $chan %quotecolor $+ [QUOTES] 03Total amount of quotes by07 $2 $+ 03:07 %TotQuotes $+ 03.
      halt
    }
  }
  if ( $1 == !quote ) {
    ; if ( $calc( $ctime - %lastquote ) >= %quoteAntiSpam ) {
    if ( %quoteon ) {
      set %quoteamount $readini(QuoteDB.ini,Amount,Amount)
      if ($2 == help || $2 == cmds || $2 == commands) {
        notice $nick %quotecolor $+ [QUOTE CMDS] 03!addquote (10Requires OP in #Revo03), !quote (10Optionally number03), !quotes (10nickname03), !quote ALL (10Total quotes03)
        halt
      }
      if ($2 == del || $2 == delete) {
        if ($3 != $null) {
          if ($readini(QuoteDB.ini, quote, $3) == $null) {
            msg $chan 04Error! There is no quote7 $3 $+ 04.
            halt
          }
          set %amountofquotes $calc($readini(QuoteDB.ini,Amount,Amount)-1)
          writeini -n QuoteDB.ini Amount Amount %amountofquotes
          remini QuoteDB.ini quote $3
          msg $chan 03Successfully deleted quote 07 $+ $3 $+ 03 from the database.
          halt
        }
      }
      if ($2 == all || $2 == amount) {
        var %amountofquotes = $readini(QuoteDB.ini,Amount,Amount)
        msg $chan %quotecolor $+ [QUOTE] 03There are a total of 07 $+ %amountofquotes $+ 03 quotes.
        set %lastquote $ctime
        halt
      }
      if ($2 == credits) {
        notice $nick Credits to [NAS]peter for helping & starting the script, massive edits done by Revo.
        halt
      }
      if ( $2 == $null ) {
        set %rnd $rand(1,%quoteamount)
        if ( $readini(QuoteDB.ini, quote, %rnd) == 1337 ) {
          set %search %rnd $+ =
          .timer 1 0.5 $read(LongQuotes.txt,sp, %search)
          halt
          } else {
          .timer 1 0.5 msg $chan %quotecolor $+ [QUOTE] %quotecolor $+ [ $+ %rnd $+ ] $readini(QuoteDB.ini,quote,%rnd)
        }
        ; msg $chan %quotecolor $+ [QUOTE] %quotecolor $+ [ $+ %rnd $+ ] $readini(QuoteDB.ini,quote,%rnd)
      }
      elseif ( $2 != $null ) {
        if ( $2 == amount ) {
          msg $chan %quotecolor $+ [QUOTE] $readini(QuoteDB.ini,Amount,Amount)
          } else {
          ; msg $chan %quotecolor $+ [QUOTE] $readini(QuoteDB.ini,quote,$2)
          if ( $readini(QuoteDB.ini, quote, $2) == 1337 ) {
            set %search $2 $+ =
            .timer 1 0.5 $read(LongQuotes.txt,sp, %search)
            halt
            } else {
            .timer 1 0.5 msg $chan %quotecolor $+ [QUOTE] $readini(QuoteDB.ini,quote,$2)
          }
        }
      }
      ;set %lastquote $ctime
      ;}
      else {
        notice $nick Quotes are off.
      }
    }
    unset %Quote.readTXT
  }
  set %amountofquotes $calc($readini(QuoteDB.ini,Amount,Amount)+1)
  set -u2 %SetBy $calc($readini(QuoteDB.ini,Setby,$nick)+1)

  if ($1 == !addquote) {
    msg $chan $1-
    .timer 1 1 msg $chan Quote added, $nick $+ . Quote number:7 %amountofquotes 

    var %quoteadd = $replace($2-, \n, $chr(3) $chr(124) msg $chr(36) $+ chan $chr(3) $+ 13[QUOTE] $chr(3)) 15- Added by $nick on $date $+ .
    writeini -n QuoteDB.ini quote %amountofquotes %quoteadd
    writeini -n QuoteDB.ini Amount Amount %amountofquotes
    writeini -n QuoteDB.ini Setby $nick %SetBy
    halt
  }
  if ($1 == !qamount) {
    timer 1 1 msg $active 11Amount of quotes:7 %amountofquotes $+ 11!
  }
}
