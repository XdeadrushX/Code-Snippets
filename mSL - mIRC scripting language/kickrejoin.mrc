alias isAllowedChannel {
  if (($1 == #channel) && ($2 == freenode)) return 0
  else if (($1 == #channel) && ($2 == QuakeNet)) return 0
  else return 1
}

on *:KICK:#: {
  if ($knick == $me) {
    if ($isAllowedChannel($chan, $network) == 1) {
      join $chan
    }
    else {
      echo -tnga Kick-rejoin for $chan disabled. Not rejoining $chan $+ .
      beep 8
    }
  }
}
