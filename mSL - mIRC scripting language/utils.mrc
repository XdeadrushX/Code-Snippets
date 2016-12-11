; multi kick
alias mkick {
  kick # $* $default_kick_reason
}

; multi kick reason
alias mkickr {
  kick # $* $?="Reason?"
}

alias clearScreen {
  var %i 0

  echo -at Clearing Screen.. (screensize set to 60 lines)
  while (%i < 60) {
    inc %i
    echo -a $chr(1)
  }
}

alias allaway {
  if ($away) {
    echo -ta You are already away on your current network with the reason: $awaymsg 
    echo -ta It will now be overwritten.
  }

  if ($len($1-)) {
    echo -ta You are now away on all networks; Reason: $1- (away since $time $date $+ )
    scid -at1 /away $1- (away since $time $date $+ )
  }
  else {
    echo -ta You are now back on all networks.
    scid -at1 /away
  }
}

; @see 'alias filternick' for an improved version by kikuchi
alias countGuests {
  var %i 0 
  var %x 0
  var %guest.nickcount $nick($active,0)
  echo -a init
  while (%i < %guest.nickcount) { 
    inc %i 
    if (Guest* iswm $nick($active,%i)) { 
      inc %x 
      echo -a $nick($active,%i) -- %x 
    }
  }
  echo -a %x guests.
  echo -a exit
}

; This script is made by kikuchi at Esper.net (#mIRC), it improves my 'countGuests' alias.
alias filternick {
  echo -a init
  filter -wklg $chan nickfilterset /^Guest/i
  if (%filternick) {
    echo -ag %filternick
    echo -ag $numtok(%filternick,32) Guests
  }
  unset %filternick
  echo -a exit
}
alias nickfilterset set %filternick $addtokcs(%filternick,$regsubex($1,/[ $prefix ]/g,\1),32)
; end 

alias strlen { echo -tnga 09[STRLEN] $+(",10,$1-,") has the length of:07 $len($1-) }

alias number_format { return $bytes($iif($1 isnum, $1, 0), b) }

; Close all queries that are open. Simply just "/scid -a /close -m" 
;  /scid -a    -> Target all networks
;  /close -m   -> Close all windows that are a query window on network
alias queryclose /closeallqueries
alias caq /closeallqueries
alias closeallqueries /scid -a /close -m

; Perform a variable dump that prints its output.
; var_dump(mixed var) - Variable dump (similiar to PHP)
; @requires gettype
alias var_dump {
  var %var $1-

  var %var.len $len(%var)
  var %var.type $gettype(%var)

  echo -ta $+(%var.type,$chr(40),%var.len,$chr(41)) $iif(%var.type == String, $+(",%var,"), %var) 
}

; Perform a variable dump that returns its output.
; ret_var_dump(mixed var) - Return variable dump (similiar to PHP)
; @requires gettype
alias ret_var_dump {
  var %var $1-

  var %var.len $len(%var)
  var %var.type $gettype(%var)

  return $+(%var.type,$chr(40),%var.len,$chr(41)) $iif(%var.type == String, $+(",%var,"), %var) 
}

; Get type - Returns the variable type but with full length output.
; gettype(mixed var) - Return variable type (similiar to PHP)
alias gettype {
  var %var $1-
  if (%var isnum && ($floor(%var) != %var || $len(%var) != $len($floor(%var)))) return Float
  else if (%var isnum) return Integer
  else if (%var == $true || %var == $false) return Boolean
  else if (%var == $null) return Null
  else return String
}

; Get type other - Returns the variable type but with shorter output.
; gettypeo(mixed var) - Return variable type, but with shorter return values. (similiar to PHP)
alias gettypeo {
  var %var $1-
  if (%var isnum && ($floor(%var) != %var || $len(%var) != $len($floor(%var)))) return float
  else if (%var isnum) return int
  else if (%var == $true || %var == $false) return bool
  else if (%var == $null) return null
  else return string
}

; Channel moderation tools (kick, kickban, op, deop, voice, and devoice).
alias ckick {
  var %reason $iif($alias(default_kick_reason), $default_kick_reason, Your behavior is not conducive to the desired environment.)

  if ($me !isop $active) {
    echo -tnga You are not an op on $active $+ .
    halt
  }
  else if ($1 == $null) {
    echo -tnga Usage: /ckick <user> [reason (takes default reason if none given)]
    halt
  } 
  else if ($1 !ison $active) {
    echo -tnga That user is not on $active $+ .
  } 
  else if ($2 != $null) {
    var %reason $2-
  }

  kick $active $1 %reason
}

alias cban {
  var %reason $iif($alias(default_ban_reason), $default_ban_reason, Banned.)

  if ($me !isop $active) {
    echo -tnga You are not an op on $active $+ .
    halt
  }
  else if ($1 == $null) {
    echo -tnga Usage: /cban <user> [reason (takes default reason if none given)]
    halt
  }
  else if ($1 !ison $active) {
    echo -tnga That user is not on $active $+ . Performing WHOIS instead.
    whois $1
    halt
  } 
  else if ($2 != $null) {
    var %reason $2-
  }

  mode $active +b $address($1, 2)
  kick $active $1 %reason
}

alias op { 
  if (!$mode_apply_check($1-)) {
    halt
  }

  mode $active +ooooo $1-
} 

alias deop { 
  if (!$mode_apply_check($1-)) {
    halt
  }

  mode $active -ooooo $1-
} 

alias voice {
  if (!$mode_apply_check($1-)) {
    halt
  }

  mode $active +vvvvv $1-
}

alias devoice {
  if (!$mode_apply_check($1-)) {
    halt
  }

  mode $active -vvvvv $1-
}

alias -l mode_apply_check {
  if ($me !isop $active && $me !ishop $active) {
    echo -tnga You are not an op on $active $+ .
    return $false
  }
  else if ($1 == $null) {
    echo -tnga No users to apply modes to specified, syntax: <username> [username, ...] - parameters are space delimited.
    return $false
  } 
  else if ($regex($1-, $+(/\,$chr(32),/g)) == 0 && $1 !ison $active) {
    echo -tnga That user is not on $active $+ .
    return $false
  } 

  return $true
}

;Channels you and target share in common.
alias cc { echo -tnga $common_channels($1) }
alias cc_ret { return $common_channels($1) }
alias -l common_channels {
  if ($1 == $null) {
    return Syntax Error: Missing first parameter in alias common_channels, expecting username.
  } 
  else if ($len($1) > 40) {
    return Syntax Error: First parameter $+([,$1,]) is too long (exceeds 40 characters)
  }
  else if ($comchan($1, 0) == 0) {
    return You and $1 do not share any channels. 
  }
  else {
    var %c $comchan($1, 0)
    var %cc
    var %loop.itter 0
    while (%c > 0) { 
      var %cc %cc $comchan($1, %c)
      dec %c
      inc %loop.itter
      if (%loop.itter > 50) {
        var %cc %cc ( $+ %c more channels)
        break
      }
    }
    return %cc
  }
}

;Format "item1 item2 item3 item4" in "item1, item2, item3, item4" format
; thanks to kikuchi for the regex improvement :)
alias list_format {
  return $regsubex($1-,/(\s)/g,$+($remove(\1,$chr(32)),$chr(44),$chr(32)))
}

alias chr { echo -tnga Character $1- $+ :07 $chr($1-) }
alias asc { echo -tnga ASCII $1- $+ :07 $asc($1-) }

; Random Slapping script.
alias slap {
  describe $active $slap_r($1)
}

alias slap_r {
  var %r $rand(0, 7)
  var %slap 
  if (%r == 0) { var %slap slaps $1 around a bit with a default menu command }
  else if (%r == 1) { var %slap slaps $1 around a bit with a large trout }
  else if (%r == 2) { var %slap slaps $1 around a bit with a [REDACTED] } 
  else if (%r == 3) { var %slap slaps $1 around a bit with nuts }
  else if (%r == 4) { var %slap slaps $1 around a bit with an atomic bomb }
  else if (%r == 5) { var %slap slaps $1 around a bit with a branch from a tree }
  else if (%r == 6) { var %slap slaps $1 around a bit with $random_channel_nickname }
  else if (%r == 7) { var %slap whacks $1 around a bit with a fishbot }
  return %slap
}

alias random_channel_nickname {
  var %n $nick($active, $rand(1, $nick($active, 0)))

  return $left(%n, 1) $+  $+ $right(%n, -1)
}

; This script overwrites the default mSL ban alias in favor of finding out if the user runs an identd or not.
; If the user does not run an identd, we ban the entire host (*!*@host), if an identd runs, we favor banning
; the ident@host (*!ident@host)

alias ban {
  if (!$len($1)) {
    echo -tnga Usage: /ban username.
    return
  }

  var %identchar $right($left($address($$1,5), $calc($len($$1) + 2)), 1)

  if (%identchar == ~) {
    echo -tnga $address($$1, 5) has no ident daemon running. Banning full host. 
    mode # +b $address($$1, 2)
  } 
  else {
    if ($identIsIgnored($getIdentFromName($1))) {
      echo -tnga $address($$1, 5) has an ident daemon running, but it is ignored. Banning full host. 
      mode # +b $address($$1, 2)
    } 
    else {
      echo -tnga $address($$1, 5) has an ident daemon running. Banning ident@host. 
      mode # +b $address($$1, 0)
    }
  }
}

alias quiet {
  if (!$len($1)) {
    echo -tnga Usage: /quiet username.
    return
  }

  var %identchar $right($left($address($$1,5), $calc($len($$1) + 2)), 1)

  if (%identchar == ~) {
    echo -tnga $address($$1, 5) has no ident daemon running. Banning full host. 
    mode # +q $address($$1, 2)
  } 
  else {
    if ($identIsIgnored($getIdentFromName($1))) {
      echo -tnga $address($$1, 5) has an ident daemon running, but it is ignored. Banning full host. 
      mode # +q $address($$1, 2)
    } 
    else {
      echo -tnga $address($$1, 5) has an ident daemon running. Banning ident@host. 
      mode # +q $address($$1, 0)
    }
  }
}

alias getIdentFromName {
  var %addr $address($1, 5)
  var %lpos $pos(%addr, !)
  var %rpos $calc($pos(%addr, @) - 1)
  var %naddr $left(%addr, %rpos)
  return $right(%naddr, $calc(%rpos - %lpos)) 
}

alias identIsIgnored {
  if ($$1) {
    if ($$1 == webchat || $$1 == Mibbit) {
      return $true
    }
  }
  return $false
}

; Stop query windows from flashing after 20 seconds by setting them to an 'event' state.
; Ensure Options -> IRC -> Flash On Message (Query) is turned off.
ON *:OPEN:?: { 
  flash -r20 $nick
  .timer 1 20 setQueryColourToEvent $nick
}

ON *:TEXT:*:?: {
  flash -r20 $nick
  .timer 1 20 setQueryColourToEvent $nick
}

alias setQueryColourToEvent {
  if ($window($$1).sbcolor != $null && $window($$1).sbcolor != event) { 
    window -g3 $$1
  }
}
