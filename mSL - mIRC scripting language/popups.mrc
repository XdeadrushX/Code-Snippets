;Info:/uwho $1
$iif($network == QuakeNet, Q WHOIS, NickServ Info):/msg $iif($network == QuakeNet, Q WHOIS $$1, NickServ INFO $$1)
Whois:/whois $$1
Query:/query $$1
-
Control
.Ignore:/ignore $$1 1
.Unignore:/ignore -r $$1 1 
.-
.$iif($me isop $active, Op):{ /mode # +ooo $$1 $2 $3 } 
.$iif($me isop $active, Deop):{ /mode # -ooo $$1 $2 $3 } 
.$iif($me isop $active, Voice):{ /mode # +vvv $$1 $2 $3 }
.$iif($me isop $active, Devoice):{ /mode # -vvv $$1 $2 $3 }
.$iif($me isop $active, Quiet):{ mode $active +q $1 } 
.$iif($me isop $active, Quiet Hostmask):{ mode $active +q $address($1,2) } 
.$iif($me isop $active, Quiet and Devoice):{ mode $active +q-v $1 $1 } 
.$iif($me isop $active, Quiet Hostmask and Devoice):{ mode $active +q $address($1,2) $1 } 
.$iif($me isop $active, Kick): { /kick # $$1 }
.$iif($me isop $active, Kick [reason]): { /kick # $$1 $$?="Reason:" }
.$iif($me isop $active, Ban): { mode # +b $address($$1, 2) }
.$iif($me isop $active, Kickban): { mode # +b $$1 $address($2,2) | /kick # $$1 $default_kick_reason }
.$iif($me isop $active, Kickban [reason] - @host):{ var %reason $$?="Reason:" | mode # +b $address($1,2) | /kick # $$1 %reason }
.$iif($me isop $active, Kickban [reason] - ident@host):{ var %reason $$?="Reason:" | mode # +b $address($1,0) | /kick # $$1 %reason }
.$iif($me isop $active, Kickban [reason] - account):{ var %reason $$?="Reason:" | mode # +b $$1 $ $+ a: $+ $2 | /kick # $$1 %reason }
.$iif($me !isop $active, Attempt to aquire op): { /msg chanserv op $active }
Channel
.Chanserv Info: { msg ChanServ INFO $active }
.Fetch Channel Topic: { /topic $active }
.Fetch Ban List: { /mode $active b }
.Fetch Quiet List: { /mode $active q }
.Open log directory: { run $iif($exists($mircdirlogs\ $+ $network), $mircdirlogs\ $+ $network, $mircdirlogs) } 
CTCP
.Ping:/ctcp $$1 ping
.Time:/ctcp $$1 time
.Version:/ctcp $$1 version
;DCC
;.Send:/dcc send $$1
;.Chat:/dcc chat $$1
-
Slap!:/me slaps $$1 around a bit with a large trout
