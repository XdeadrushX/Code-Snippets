on *:TEXT:*:?: { 
  if ($isRelayNetwork) {
    echo -tng $getRelayChannel <03- $+ $nick $+ > $1-
  }
}

alias isRelayNetwork {
  var %n $network

  if (%n == freenode || %n == EsperNet || %n == QuakeNet) { 
    return 1 
  }
  else { 
    return 0 
  }

}

alias getRelayChannel {
  var %n $network

  if ($cid == $activecid && $active != $nick) {
    return $active
  }
  else if (%n == freenode) {
    return #freenode
  }
  else if (%n == EsperNet) {
    return #lobby
  }
  else if (%n == QuakeNet) {
    return #teamliquid
  }

  ;nothing was returned: Return active channel + error.
  return $active :ERR_GET_RELAY_NORETURN
}
