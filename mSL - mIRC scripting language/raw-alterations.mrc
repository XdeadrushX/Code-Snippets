; Kick modifier
on ^*:KICK:#: {
  var %kreason $1-
  if (%kreason == $knick) { var %kreason No reason given. }

  var %n $getircnick($chan, $nick)
  echo $color(kick) -t $chan * $knick ( $+ $right($address($knick, 0), -2) $+ ) was kicked from $chan by $iif($strip(%n), %n, $nick) ( $+ %kreason $+ )
  haltdef
}
alias -l getircnick { return $+(,$nick($1,$2).color,$nick($1,$2).pnick) }

;----

; Removes the quotation marks from the topic, so that trailing whitespace isn't obvious.
on ^*:TOPIC:#: {
  if ($nick) { 
    echo -t $chan Topic changed by $nick $+ : $1-
  } 
  else {
    echo -t $chan Topic: $1-
  }
  haltdef
}

RAW 332:*: { 
  echo -t $2 * Topic: $3-
  haltdef
}

;----

; Whois Modifier
RAW 318:*:{ 
  ; Adds compatibility with alias IDLETIMEALL.
  if (%global.idletime == $null) {
    echo 10 $iif($query($2) != $null, $2, -a) $2- $(|) WHOIS on $time - $date (Europe/Amsterdam)
    halt 
  }
}

; Whois Modifier - common channels - requires common_channels (cc_ret) and list_format aliases.
; they're found in utils.mrc
RAW 319:*:{ 
  ; Adds compatibility with alias IDLETIMEALL.
  if (%global.idletime == $null) {
    echo 10 $iif($query($2) != $null, $2, -a) $2 on $list_format($sorttok($3-, 32, c))
    echo 10 $iif($query($2) != $null, $2, -a) $2 shares channels $+($chr(40),$comchan($2, 0),$chr(41)) $list_format($sorttok($cc_ret($2), 32, c))
    halt 
  }
}

; idle time - loop through all your networks and find out how long you've been idle.
alias idletimeall { set -u3 %global.idletime $true | scid -a /whois $me $me }
RAW 317:*: {
  if (%global.idletime != $null) {
    if ($3 isnum) {
      echo -tnga ( $+ $network $+ ) Idle for $duration($3) as $me $+ .
    }
  }
}

;----

; /quote HELP to active
RAW 704:*: {
  if ($active != Status Window) {
    var %dashes.length $str(-, $round($calc((60 - $len($2)) / 2)))
    echo -tnga %dashes.length $2 %dashes.length 
    echo -tnga $3-
  }
}

RAW 705:*: {
  if ($active != Status Window) {
    if ($3 == $null) { echo -tnga - $3- }
    else { echo -tnga $3- } 
  }
}

;---- 

; Wallops to active
on *:WALLOPS:*: {
  if ($active != Status Window) {
    echo -tnga 11[WALLOP/ $+ $nick $+ ]:  $1- ( $+ $network $+ )
  } 
}

