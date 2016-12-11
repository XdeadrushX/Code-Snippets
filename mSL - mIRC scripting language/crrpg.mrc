/*
***********************
CRRPG Script by Revo

name      CRRPG Script
version   0.1
released  2 February 2014
author    Zarthus / Revo
license   MIT

Adds multiple callbacks, and custom aliases that ease up making new scripts.
Configurable to certain extend.

@install notes
Run initialisation commands for the first time to set your ingame name, uses $me if not set.
If you know what you're doing, check "CNR_CONFIG" to make sure your configurations are to your liking, 
some of these things do not need touching.

@supported scripts
--- NOW PLAYING ---
Supports ircify (Spotify now playing script) 
http://www.equalify.me/ircify/

Any other Now Playing script, if you make your own public np_r alias (now playing, return) which returns now playing information
--- /NOW PLAYING ---

@readme for developers
Public Functions - CNR Related
$cnr_get_channel(Optional:CHANNEL) : Return channel per priority list (Spam, Regs, Default) : Specify Parameter to get specified channel returned.
\-> Example use: /msg $cnr_get_channel Hello!

$cnr_is_echobot($nick, $chan)      : Return true or false depending on if $nick is an echo bot.
$cnr_is_bot($nick, $chan)          : Return true or false depending on if $nick is a bot, also checks if echo bot 
\-> Example use: if ($cnr_is_bot($nick, $chan)) return

$cnr_msg_self(Message)             : Send a message to yourself (using !pm) - Does not check if you are actually ingame.
$cnr_msg_game(Message)             : Message the game (using !say) - Does not check if you are actually ingame.
$cnr_msg_regs(Message)             : Message the regulars (using !rc) - Does not check if you are actually ingame.
\-> Example use: $cnr_msg_self(Hello!) 

Public Functions - Unrelated
$var_dump(Mixed var)               : Return information of the data dumped, in format of "type(length) data"
$gettype(Mixed var)                : Return type of variable.
\-> Example use: //echo -a $strip($var_dump($encode(Hello!))) -> returns String(13) "&2&5L;&\A````"

$zarth_wrapnick($nick, $chan)      : Return Username in format as displayed by client - Example: <10@Zarthus>
$zarth_getircnick($nick, $chan)    : Return Username in format as configured, without < > - Example: 10@Zarthus 
\-> Example use: //echo -a $zarth_wrapnick(RegularBot, #regs) 

$colenc(hex)      : Insert a 6 or 3 character hex code and return it in brackets (e.g. fff becomes {ffffff})
\-> Example use: //echo -a $colenc(fff) 

@credits
Revo   - Making the script
Bobman - for $bob_getnick | $bob_getid | (unused) $bob_url_encode
***********************
*/

alias -l cnr_config {
  ;Return the network
  if ($1 == NETWORK) return CRRPG

  ;Your own username.
  if ($1 == SELF) return $iif(%cnr.name.self == $null, $me, %cnr.name.self)

  ;Filter input like replacing p into !P
  if ($1 == INPUT_FILTERING) return $true

  ;Echo reports to @admin window and $active
  if ($1 == ECHO_REPORT_ACTIVE) return $true

  ;Echo chat from #regs to #crrpg
  if ($1 == ECHO_REGULAR_CHAT) return $true

  ;Command Triggerer Prefix
  if ($1 == COMMAND_PREFIX) return @

  ;Check if you are an administrator
  if ($1 == IS_ADMIN) return $iif($me isop #oper, $true, $false)

  ;Use admin window @admin if you're an administrator
  if ($1 == USE_ADMIN_WINDOW) return $iif($cnr_config(IS_ADMIN), $true, $false)

  ;Admin Window name
  if ($1 == ADMIN_WINDOW) return @admin       

  ;Join a channel when you're not in it and the script has no alternative options
  if ($1 == JOIN_ON_CHANNELERROR) return $true                                        

  ;Error Reporting, NONE, NORMAL, SEVERE or ALL
  if ($1 == ERROR_REPORTING) return ALL

  ;Error Window Name
  if ($1 == ERROR_WINDOW_NAME) return @cnr_errors

  ;Script Version
  if ($1 == VERSION) return 0.1
}

;mIRC events
on *:LOAD: {
  cnr_check_username
}

on *:START: {
  cnr_create_admin_window

  if (%cnr.name.self == $null) /cnr_check_username
}

on *:TEXT:*[REPORT]*:#oper: {
  if (!$cnr_is_echobot($nick)) { return }

  $cnr_on_report($1-)
}

on *:TEXT:*(REGULAR CHAT)*:#regs,#oper: {
  if (!$cnr_is_echobot($nick)) { return }

  $cnr_on_regularchat($1-)
}

on *:TEXT:*[IRCPM]*:#crrpg: {
  if (!$cnr_is_echobot($nick)) { return }

  if ($left($3, 1) == $cnr_config(COMMAND_PREFIX) && $bob_getnick($2) == $cnr_config(SELF)) {
    var %command.success $cnr_on_command($remove($strip($2), :), $lower($remove($strip($3), $cnr_config(COMMAND_PREFIX))), $strip($4-))
  }
}

on *:INPUT:#crrpg,#regs,#spam,#oper: {
  if (!$cnr_config(INPUT_FILTERING) || $cnr_config(NETWORK) != $network) { return }

  if (($1 == p || $1 == players) && $2 == $null) {
    msg $chan !players
    halt
  } 
  else if (($1 == s) && $2 != $null) {
    msg $chan !say $2-
    halt
  }

}
;cnr aliases.

alias cnr_msg_game {
  if ($cnr_config(NETWORK) != $network) { return }

  msg $cnr_get_channel !say $strip($1-, bru) 
}

alias cnr_msg_self {
  if ($cnr_config(NETWORK) != $network) { return }

  if ($2 != $null) {
    if ($2 == --force-spam) {
      if ($me !ison $cnr_get_channel(SPAM_CHANNEL)) {

        if ($cnr_config(JOIN_ON_CHANNELERROR)) {
          join #spam
          msg $cnr_get_channel !pm $cnr_config(SELF) $strip($1, bru)
          return
        }
        else {
          $cnr_trigger_error(Normal, Configuration did not allow to join $cnr_get_channel(SPAM_CHANNEL) - Please enable JOIN_ON_CHANNELERROR to resolve this error or join $cnr_get_channel(SPAM_CHANNEL) $+ .)
          return
        }   
      }
    }
  }
  msg $cnr_get_channel !pm $cnr_config(SELF) $strip($1-, bru) 
}

alias cnr_msg_regs {
  if ($cnr_config(NETWORK) != $network) return

  if ($me !ison #regs) {
    if ($config(JOIN_ON_CHANNELERROR)) {
      if ($me isvoice #crrpg) {
        join #regs 
      }
      else {
        $cnr_trigger_error(Normal, Could not send message to $cnr_get_channel(REG_CHANNEL) $+ .)
        return
      }
    }
    else {
      $cnr_trigger_error(Normal, Could not send message to $cnr_get_channel(REG_CHANNEL) $+ .)
      return
    }
  }

  msg $cnr_get_channel(REG_CHANNEL) $strip($1-, bru)
}

alias -l cnr_echo_window {
  echo -t $cnr_config(ADMIN_WINDOW) $1-
}

alias cnr_get_channel {
  if ($cnr_config(NETWORK) != $network) return

  if ($1 != $null) {
    var %params $1

    if (%params == SPAM_CHANNEL) return #spam
    if (%params == ADMIN_CHANNEL) return #oper
    if (%params == REG_CHANNEL) return #regs
    if (%params == CRRPG_CHANNEL) return #crrpg
  }

  if ($me ison #spam) return #spam
  if ($me ison #regs) return #regs
  if ($me ison #crrpg) return #crrpg

  if ($cnr_config(JOIN_ON_CHANNELERROR)) {
    join #crrpg
    return #crrpg
  }

  return $active
}

alias -l cnr_on_report {
  if ($cnr_config(ECHO_REPORT_ACTIVE)) {
    var %report.reportee $strip($2)
    var %report.reported $strip($5)
    var %report.reason $strip($7-)
    var %report.string $c4_wrap([REPORT]) Reportee: $c1_wrap(%report.reportee) - Reported: $c1_wrap(%report.reported) - Reason: $c2_wrap(%report.reason)

    if ($active != $cnr_get_channel(ADMIN_CHANNEL)) echo -at %report.string

    if ($cnr_config(USE_ADMIN_WINDOW)) {
      cnr_echo_window %report.string
    }
  }
}

alias -l cnr_on_regularchat {
  if ($cnr_config(ECHO_REGULAR_CHAT)) {
    echo -t #crrpg $zarth_wrapnick($chan, $nick) $1-
  }
}

alias -l cnr_on_command {
  if ($cnr_config(NETWORK) != $network) return
  if (%command.recently.triggered) return

  set -u2 %command.recently.triggered $true

  var %command $2
  var %params $3-
  var %success $true

  if (%command == np) {
    if ($isalias(ircify)) { $ircify_getnp_hack }
    else if ($isalias(np_r)) { $cnr_msg_self($np_r) }
    else if ($isalias(np)) { np }
    else { $cnr_trigger_error(Normal, Alias for "now playing" not found) }
  }
  else if (%command == eval) {
    $cnr_msg_self(Evaluation: %params)
    $cnr_msg_self(Dump Info: $strip($var_dump(%params)), --force-spam)
    [ / $+ [ %params ] ]
  }
  else {
    var %success $false
  }

  return %success
}

alias -l cnr_create_admin_window {
  if (!$cnr_config(USE_ADMIN_WINDOW)) return

  if (!$window($cnr_config(ADMIN_WINDOW))) { window -z $cnr_config(ADMIN_WINDOW) }
}

alias -l cnr_create_error_window {
  if (!$window($cnr_config(ERROR_WINDOW_NAME))) { window -z $cnr_config(ERROR_WINDOW_NAME) }
}

alias -l cnr_check_username {
  var %cnr.input $input(What is your ingame name?, e)
  if (%cnr.input != $null) set %cnr.name.self %cnr.input
}

alias -l cnr_trigger_error {
  if ($2 == $null) $cnr_trigger_error(Normal, cnr_trigger_error triggered with no error message.)

  var %error.reporting $cnr_config(ERROR_REPORTING)
  var %error.severity $1
  var %error.message $2-

  if (%error.reporting == NONE || %error.reporting == SEVERE && %severity == NORMAL) return

  cnr_create_error_window
  echo -t $cnr_config(ERROR_WINDOW_NAME) $c4_wrap($upper($+([,%error.severity,]))) %error.message
}

alias cnr_is_bot {
  if ($cnr_config(NETWORK) != $network) { return $false } 

  if ($cnr_is_echobot($1) || $cnr_is_test_echobot($1)) { return $true }

  if ($1 == dulk || $1 == Nambob || $1 == Vedbot || $1 == Xenton) { return $true }

  return $false
}

alias cnr_is_echobot {
  if ($cnr_config(NETWORK) != $network) return $false

  var %bn $iif($1, $1, NO_PARAMS_SUPPLIED) 
  if (%bn == CUMBY || %bn == KUMBY) { return $true }
  if (%bn == SpamBot || %bn == AdminBot || %bn == RegularBot) { return $true }

  return $false
}

alias cnr_is_test_echobot {
  if ($cnr_config(NETWORK) != $network) return $false

  var %bn $iif($1, $1, NO_PARAMS_SUPPLIED) 
  if (%bn == CRRPG1 || %bn == CRRPG2) { return $true }
  if (%bn == SpamBot1 || %bn == AdminBot1 || %bn == RegularBot1) { return $true }

  return $false
}

;Colours
alias -l c1 return 10
alias -l c2 return 03
alias -l c3 return 13
alias -l c4 return 05

alias -l c1_wrap return $+($c1, $1-, ) 
alias -l c2_wrap return $+($c2, $1-, )
alias -l c3_wrap return $+($c3, $1-, )
alias -l c4_wrap return $+($c4, $1-, )

;Other aliases
alias colourencode return $colenc($1-)
alias colorencode return $colenc($1-)
alias colenc { 
  var %ret $1-
  if ($len(%ret) == 3) var %ret $str($left(%ret,1),2) $+ $str($right($left(%ret,2),-1),2) $+ $str($right(%ret,1),2)
  else if ($len(%ret) != 6) {
    echo -ta Error: Invalid colour code %ret on line $scriptline $+ , please make sure it is 6 or 3 characters, resorting back to white (FFFFFF)
    var %ret FFFFFF
  }
  if (!$isHex(%ret)) {
    echo -ta Error: Invalid colour code %ret on line $scriptline $+ , please make sure it is hexadecimal, resorting back to white (FFFFFF)
    var %ret FFFFFF
  }
  return $+($chr(123),%ret,$chr(125)) 
}
alias zarth_wrapnick { return $+(<,$nick($1,$2).color,$left($nick($1,$2).pnick,1),$2,>) }
alias zarth_getircnick { return $+(,$nick($1,$2).color,$nick($1,$2).pnick) }
alias -l zarth_debug { $iif($me !ison #zarthus, join #zarthus) | msg #zarthus [Debug] Alias: $1 Line: $2 Version: $cnr_config(VERSION) Dump: $var_dump($3-) }

alias var_dump {
  var %var $1-

  var %var.len $len(%var)
  var %var.type $gettype(%var)

  return $c1_wrap(%var.type) $+ ( $+ $c2_wrap(%var.len) $+ ) $iif(%var.type == String, $c3_wrap($+(",%var,")), $c3_wrap(%var)) 
}

alias gettype {
  var %var $1-
  if (%var isnum && $floor(%var) != %var) return Float
  else if (%var isnum) return Integer
  else if (%var == $true || %var == $false) return Boolean
  else if (%var == $null) return Null
  else return String
}

alias isHex {
  return $regex($1-, /^[0-9a-f]{6}$/i)
}

;; IRCIFY ;;
alias -l ircify_getnp_hack {
  if (%np.antispam || $cnr_config(NETWORK) != $network) return
  set -u5 %np.antispam $true

  window -h @ircify_tmp
  sptell echo @ircify_tmp
  .timer 1 2 /ircify_self_sendnp
}

alias -l ircify_self_sendnp {
  var %np.info $line(@ircify_tmp, $line(@ircify_tmp, 0))
  var %np.info.clean $left(%np.info, $calc($pos(%np.info, :: spotify:track)-1))
  window -c @ircify_tmp
  $cnr_msg_self($strip(%np.info.clean), --force-spam)
}
;; /IRCIFY ;;

;Other people their scripts
;Credits to Bobman
alias -l bob_getnick { return $iif($pos($1,$chr(41),0) == 0,$strip($$1),$strip($left($$1,$calc($pos($$1,$chr(40),$pos($$1,$chr(40),0)) -1)))) }
alias -l bob_getid { var %id = $strip($right($$1,$calc($len($$1) - $pos($$1,$chr(40),$pos($$1,$chr(40),0)))))) | return $calc($left(%id,$pos(%id,$chr(41),1))) }
alias -l bob_url_encode { return $regsubex($1,/([\W\s])/Sg,$+(%,$base($asc(\t),10,16,2))) }
