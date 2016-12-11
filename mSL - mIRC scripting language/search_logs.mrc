;;;
;; NOTICE: This file contains two of the same aliases, one of them is set
;; for a specific configuration, the other for the other configuration.
;; Please check which of the two configurations you use!
;; To check:
;; ALT+O -> IRC -> Logging,
;; if "make folder" by "include network" is checked, grab the bottom alias.
;; otherwise grab the first.
;;
;; The following script checks for the same, but may be inaccurate if you
;; previously had such setting enabled and never removed the directory:
;; //echo -tag $iif($isdir($logdir $+ $network), Grab the bottom script, Grab the upper script)
;;;

alias searchlog {
  if ($1 == $null || $len($1-) < 3) {
    echo -tnga Usage: /searchlog [search] - Search the logs of the active channel for [search].
    halt
  }
  var %fcount $findfile($logdir, $chan $+ .*.log, 0) 
  var %ffound %fcount
  var %fresults 0

  var %itters 0
  while (%fcount) {
    var %fname $findfile($logdir, $chan $+ .*.log, %fcount)

    var %search $read(%fname, w, $+(*, $1-, *), 0)
    echo -tnga 03>> Entering file: %fname
    while (%search) {
      var %fread $read(%fname, w, $+(*, $1-, *), $calc($readn + 1)) 
      if (%fread == $null) { break }

      echo -tnga $+([line,$chr(32),$readn,]) %fread 

      inc %fresults
      inc %itters
      dec %search
      if (%itters >= 50 || $readn == 0) { break }
    }

    inc %itters
    dec %fcount
    if (%itters >= 50) { break }
  }

  if (%itters == 0 || $calc(%itters - %ffound) == 0) {
    echo -tnga No results found in %ffound files.
  } 
  else {
    echo -tnga Found %fresults  $+ $iif(%fresults == 1, result, results) in %ffound  $+ $iif(%ffound == 1, file, files) $+ .
  }
}

alias searchlog {
  if ($1 == $null || $len($1-) < 3) {
    echo -tnga Usage: /searchlog [search] - Search the logs of the active channel for [search].
    halt
  }
  var %fcount $findfile($logdir/ $+ $network $+ /, $chan $+ .*.log, 0) 
  var %ffound %fcount
  var %fresults 0

  var %itters 0
  while (%fcount) {
    var %fname $findfile($logdir/ $+ $network $+ /, $chan $+ .*.log, %fcount)

    var %search $read(%fname, w, $+(*, $1-, *), 0)
    echo -tnga 03>> Entering file: %fname
    while (%search) {
      var %fread $read(%fname, w, $+(*, $1-, *), $calc($readn + 1)) 
      if (%fread == $null) { break }

      echo -tnga $+([line,$chr(32),$readn,]) %fread 

      inc %fresults
      inc %itters
      dec %search
      if (%itters >= 50 || $readn == 0) { break }
    }

    inc %itters
    dec %fcount
    if (%itters >= 50) { break }
  }

  if (%itters == 0 || $calc(%itters - %ffound) == 0) {
    echo -tnga No results found in %ffound files.
  } 
  else {
    echo -tnga Found %fresults  $+ $iif(%fresults == 1, result, results) in %ffound  $+ $iif(%ffound == 1, file, files) $+ .
  }
}
