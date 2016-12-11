;Can add custom options using on *:TEXT:*username*:#:{ $rHighlight($1-, $network, $chan, $nick, highlight_text_here) }
;Written on 21/02/2012, improved over the years
;Updated 2014-07-04

;CONFIG

; get speak on highlight - Performs /speak <highlight message> on highlights.
alias -l getSpeakOnHighlight return $false

; window on highlight - Opens a window on [startup | first highlight [@see getWindowOpenOnStartUp]] called $getWindowName
alias -l getWindowOnHighlight return $true

; Allow highlights on active channels.
alias -l highlightOnActive return $false

; In the event of a certain person highlighting many people in the same channel, we ignore the highlight.
alias -l ignoreChannelFlooding return $true

; Do we store recent highlights? This configuration expects a decimal number (number of hours to keep), or $false
alias -l logHighlights return 48

; ------------------------------------------------------------------------------------------
; the following settings require the getWindowOnHighlight configuration to be set to true.
; ------------------------------------------------------------------------------------------

;  Opens a window on startup called $getWindowName
alias -l getWindowOpenOnStartUp return $true

;  Configure the name the window in $getWindowOnHighlight should have
alias -l getWindowName return @highlight

;  Logs HIGHLIGHT PREVENTED messages for the ignored names to $getWindowName
alias -l showWindowIgnoreNotice return $false

;  Logs HIGHLIGHT PREVENTED messages for the antispam to $getWindowName
alias -l showWindowAntispamNotice return $false

;  Load the logged highlights into $getWindowName
alias -l loadHighlightsOnStartup return $true

/*
* This configuration needs some explanation:
* 
* Do we $strip() incoming highlights, removing any colour from them. 
*   Then set this configuration to $true
*   @example 07[HIGHLIGHT] $+ $c2 Message: $+ $c1 $strip($1)
*
* Do we keep the incoming highlights as default, displaying them as teal colour by default, 
*  your name being $c3, but any colours in it will mess with the syntax
*   Then set this configuration to $false 
*   @example 07[HIGHLIGHT] $+ $c2 Message: $+ $c1 $replace($1, $5,  $+ $c3 $+ $5 $+  $+ $c1)
*
* Do we preserve incoming highlights, to display them exactly as you would see them in the chat. 
*   Then set this configuration to $ok 
*   @example 07[HIGHLIGHT] $+ $c2 Message: $1
*/
alias -l stripIncomingHighlights return $ok

;END CONFIG

on *:START: {
  if ($getWindowOpenOnStartUp) {
    var %highlight.window.name $getWindowName
    if (!$window(%highlight.window.name)) { window -z %highlight.window.name }
	
	highlight_load
  }
}

on *:LOAD: {
  rhighlight_genini
}

on *:TEXT:$(* $+ $me $+ *):#: {
  $rHighlight($1-, $network, $chan, $nick, $me)
}

on *:ACTION:$(* $+ $me $+ *):#: {
  $rHighlight($1-, $network, $chan, $nick, $me)
}

alias -l rHighlight { ;text network chan nick alertedNick
  if ( (!$highlightOnActive && $active == $3) || $isIgnored($4) || [ [ $+(%,highlight.antispam.,$network,.,$chan) ] ] ) { 
    if ($getWindowOnHighlight) {

      var %highlight.window.name $getWindowName
      if (!$window(%highlight.window.name)) { window -z %highlight.window.name }

      else if (!$highlightOnActive && $active == $3) {
        if ($showWindowIgnoreNotice) {
          echo -tng %highlight.window.name 07[HIGHLIGHT PREVENTED] Highlight in $3 ( $+ $2 $+ ) was prevented due to it being your active channel.
        }
      }

      else if ($isIgnored($4)) {
        if ($showWindowIgnoreNotice) {
          echo -tng %highlight.window.name 07[HIGHLIGHT PREVENTED] Highlight in $3 ( $+ $2 $+ ) was prevented due to $4 being ignored.
        }
      }

      else if ( [ [ $+(%,highlight.antispam.,$network,.,$chan) ] ] ) {
        if ($showWindowAntispamNotice) {
          echo -tng %highlight.window.name 07[HIGHLIGHT PREVENTED] Highlight in $3 ( $+ $2 $+ ) was prevented due to the channel being on antiflood.
        }
      }

    }

    return 
  } 

  var %regex /\b $+ $5 $+ \b/Si
  if ($regex($1, %regex)) {
    var %sih $stripIncomingHighlights

    if (%sih == $ok) {
      var %highlight.display.message $c2 Message: $1
    } 
    else if (%sih == $true) {
      var %highlight.display.message $c2 Message: $+ $c1 $strip($1)
    } 
    else {
      var %highlight.display.message $c2 Message: $+ $c1 $replace($1, $5,  $+ $c3 $+ $5 $+  $+ $c1)
    }

    echo -tnga 07[HIGHLIGHT] $+ $c2 You have been highlighted in $+ $c1 $3 $+  $+ $c2 on $+ $c1 $2 $+  $+ $c2 by $+ $c1 $4 $+  $+ $c2 $+ . ( $+  $+ $c1 $+ $bytes($readini(highlight.ini, count, highlighted_count), b) $+  $+ $c2 $+ )
    echo -tnga 07[HIGHLIGHT] $+ %highlight.display.message

    if ($getSpeakOnHighlight) {
      var %speak Highlight on $network $+ , on $3 $+ , by $4
      var %speak $remove(%speak, $chr(35))
      .speak %speak

      if ($getWindowOnHighlight) {
        var %highlight.window.name $getWindowName

        if (!$window(%highlight.window.name)) { window -z %highlight.window.name }

        echo -tng %highlight.window.name 07[HIGHLIGHT SPEAKING] %speak
      }

    }
    if ($getWindowOnHighlight) {
      var %highlight.window.name $getWindowName

      if (!$window(%highlight.window.name)) { window -z %highlight.window.name }

      if ($active != %highlight.window.name) {
        echo -tng %highlight.window.name 07[HIGHLIGHT] $+ $c2 You have been highlighted in $+ $c1 $3 $+  $+ $c2 on $+ $c1 $2 $+  $+ $c2 by $+ $c1 $4 $+  $+ $c2 $+ . ( $+  $+ $c1 $+ $bytes($readini(highlight.ini, count, highlighted_count), b) $+  $+ $c2 $+ )
        echo -tng %highlight.window.name 07[HIGHLIGHT] $+ %highlight.display.message
      }
    }

    /iniinc highlight.ini highlighted_count
    /highlight_log < $+ $nick $+ / $+ $chan $+ / $+ $network $+ > $1
    set -u5 [ [ $+(%,highlight.antispam.,$network,.,$chan) ] ] $true
  }
  else {
    /iniinc highlight.ini false_highlight_preventions
  }
}

alias -l c1 return 10
alias -l c2 return 03
alias -l c3 return 13

alias iniInc {
  if ($1 == $null) return echo -tnga Error: Non-specified file [iniFile.ini].
  else if ($2 == $null) return echo -tnga Error: Non-specified field [item].
  var %ini $1
  var %value $readini(%ini, count, $2)
  var %sum $calc(%value + 1)
  if (%sum isnum) { 
    writeini %ini count $2 %sum
  }
  else return echo -tnga Error: Value sum07 $iif(%sum != $null, %sum, NaN) was erronous
}

alias rhighlight_genini {
  writeini highlight.ini count highlighted_count 0
  writeini highlight.ini count false_highlight_preventions 0
  writeini highlight.ini count date_install $date
  echo -tnga ini highlight.ini has been generated!
}

alias isIgnored {
  if (*status iswm $1 || *buffextras iswm $1) { return 1 }
  return 0
}

; This is a debug function to verify how your highlight looks.
; Any input applies a few colours to it.
alias trigger_highlight {
  if ($len($1) > 0) {
    $rHighlight(13Hey there $me - What is going on?, $network, #dummychannel, Zarthus- $+ $rand(0,100), $me)
  }
  else {
    $rHighlight(Hey there $me - What is going on?, $network, #dummychannel, Zarthus- $+ $rand(0,100), $me)
  }
}

alias -l highlight_log {
  if ($logHighlights == $false) return

  writeini highlight.ini recent_highlights $ctime $1-
}

alias highlight_load {
  if (!$getWindowOpenOnStartup || $loadHighlightsOnStartup == $false || !$isfile(highlight.ini) || $logHighlights !isnum) { return $false }

  var %n $ini(highlight.ini, recent_highlights, 0)
  var %time.maxtime $calc($ctime - ($logHighlights * 3600))

  while (%n) {
    var %time.currentItter $ini(highlight.ini, recent_highlights, %n) 

    if (%time.currentItter > %time.maxtime) {
      echo -t $getWindowName 07[LOADED HIGHLIGHT] $+([,$c1,$time(%time.currentItter),$chr(32),$(|),$chr(32),$date(%time.currentItter),]) $readini(highlight.ini, recent_highlights, %time.currentItter) [ $+ $c3 $+ $duration($calc($ctime - $ini(highlight.ini, recent_highlights, %n))) old]
    }
    else {
      remini highlight.ini recent_highlights %time.currentItter
    }

    dec %n
  }
}