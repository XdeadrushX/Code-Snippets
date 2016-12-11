;Written on prior to 2012

on *:ACTION:$(*slaps* $+ $me $+ *):*: {
 if (!%spamcheck) {
  var %slapback $rand(1, 6) 
  set -u8 %spamcheck $true
  if (%slapback == 1) { describe $chan Slaps $nick back with an enormous trout. }
  if (%slapback == 2) { describe $chan slaps $nick with a large trout! }
  if (%slapback == 3) { msg $chan Hey $nick $+ , how about a foot in your ass? }
  if (%slapback == 4) { msg $chan Hey $nick $+ , I wrote a book. It's called "The road to my foot in your ass". }
  if (%slapback == 5) { msg $chan $replace($1-,$me, $nick) }
  if (%slapback == 6) { describe $chan $replace($1-,$me, $nick) }
 }
}

