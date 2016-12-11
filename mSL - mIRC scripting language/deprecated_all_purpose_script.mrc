/*
*	This is a very old script that doesn't have an exact purpose, hence it is really not recommended to run this yourself.
*
*	It does things, and wether they work or not I do not know.
*	
*	If you observe the file, you will notice it is very big.
*
*	This script basically started out as a nickalert, then I made it alter the way mIRC is displayed (a mini skin),
*	then I made it do stuff, and made it do more stuff, untill it got as big as it was.
*	As of right now, I'm using different scripts for different purposes, and got rid of the idea to stick around to one script.
*	Due to its length, I probably missed out on a bunch of credits to the scripts I borrowed from other people, but I would like to state not everything was coded by me.
*
*	The script itself is no longer supported, and I really hope you only use it for reading pleasure, with no intents of using it.
*
*	That having said, it was coded prior to 2012, and mostly done by me.
*//*
* It is REQUIRED you run the initialization commands!
*
*/
on *:START: {
  if ( $window(@Actions) == $null ) { window -e0z @Actions | echo @Actions $timestamp You have entered the window 3@Actions, All your parts, kicks and invites and nickalerts will be logged here. }
  unset %UDChanList
  Revo_Vars_EchoAct
  %echoact 07[START]03 mIRC has successfully started up.
  if (!$hget(censored)) { hmake censored 5 }
  if ($isfile(censored.hsh)) { hload censored censored.hsh }
}
 
on *:CONNECT:{
  if ($network == MoinGaming) {
    $iif($me !ison #Revo, join #Revo)
  }
}
 
on *:LOAD: {
  .msg Revo 14|--04 $me has installed the released script. 14--|
  if ( $window(@Actions) == $null ) { window -e0z @Actions | echo @Actions $timestamp You have entered the window 3@Actions, All your parts, kicks and invites and nickalerts will be logged here. }
  Revo_Install_Script
  if ($readini(NickAlert.ini, Total, InstalledCTIME == $null) { writeini -n NickAlert.ini Total InstalledCTIME $ctime }
}
 
on *:UNLOAD: {
  .msg Revo 14|--04 $me has unloaded the beta script. 14--|
  hfree censored
}
 
menu nicklist,channel,query,status {
  Revo's 42.
  .$iif($readini(NickAlert.ini, Menu, NickAlert), Nickalert)
  ..Ignore nick:/Revo_Ignore_nick
  ..Unignore nick:/Revo_Unignore_nick
  ..Ignore IRC bots:/Revo_Ignore_Bots
  ..-
  ..Nickalert nick:/NickAlertNickName
  ..Secondary nick:/NickAlertNickName2
  ..-
  ..Information:/Revo_Nickalert_info
  ;..Antispam:/NickAlertAntiSpam
  ..Popup:/Revo_popup
  ..Toggle Active:/Revo_Toggle_Active
  ..-
  .$iif($readini(NickAlert.ini, Menu, ColourConverter), Colour Converter)
  ..Colour Convert:/Revo_Colour_Converter
  ..Configure bold:/Revo_Config_Bold
  .$iif($readini(NickAlert.ini, Menu, Winamp), Winamp)
  ..Currently Playing:/wamp
  ..Echo songs playing.:/.timerWAMP 100 240 Revo_Vars_EchoAct | Revo_NoDescribe_Wamp | %echoact 07[WINAMP] %wamp | echo -a Now playing songs to 03@Actions.
  ..Stop echoing.:/timerWAMP off | echo -a Turned autoplaying songs to 03@Actions off!
  .$iif($readini(NickAlert.ini, Menu, AutoAway), Auto away)
  ..Modify awaytime:/Revo_Adjust_AwayTime
  .$iif($readini(NickAlert.ini, Menu, NickChanges), Nick changes)
  ..Ingame:/set %oldnick $me | nick $left($me, 3) $+ |IG
  ..Busy:/set %oldnick $me | nick $left($me, 3) $+ |Busy
  ..AFK:/set %oldnick $me | nick $left($me, 3) $+ |AFK
  ..$iif($me != Vedang, Food):/set %oldnick $me | nick $left($me, 3) $+ |Food
  ..$iif($me == Vedang, FOOD):/set %oldnick $me | nick Vedang[FOOOOOOD]
  ..$iif($me == Revo, Shower):/nick $me Revo|ShowerWithVedangAndLeo
  ..$iif($me == Vedang, Shower):/nick Ved|ShowerWithRevoAndLeo
  ..$iif($me == Leonardo, Shower):/nick Leo|ShowerWithVedangAndRevo
  ..Sleep:/set %oldnick $me | nick $left($me, 3) $+ |Sleep
  ..Custom nick:/set %oldnick $me | Revo_Custom_Nick
  ..-
  ..$iif(%oldnick != $null,Normal):/nick %oldnick | unset %oldnick
  ..Main nickname:/nick $mnick
  ..Change nick on all networks:/Revo_Change_Nick
  .$iif($readini(NickAlert.ini, Menu, Uptime), Uptime)
  ..Online time:/msg $active 05[Uptime] I have been online for07 $uptime(mIRC, 1) $+ , my system has been running for07 $uptime(System, 1) $+ .
  ..Total Online time:/msg $active 05[Uptime] I have been online for07 $duration($online, 1) $+ .
  ..Highest uptime:/msg $active 05[Uptime] My highest uptime recorded is:07 $readini(NickAlert.ini, Total, HighestUptime) $+ .
  ..All info.:/msg $active 05[Uptime] I have been online for07 $uptime(mIRC, 1) $+ , my system has been running for07 $uptime(System, 1) $+ . | msg $active 05[Uptime] I have spent07 $duration($online, 1) $+  using mIRC. | msg $active 05[Uptime] My highest uptime recorded is:07 $readini(NickAlert.ini, Total, HighestUptime) $+ .
  .$iif($readini(NickAlert.ini, Menu, IRPG), IRPG)
  ..Stats:/IRPGStats
  .$iif($readini(NickAlert.ini, Menu, Seen), Seen)
  ..Seen who?:/Revo_Get_Seen_Data
  ..Total players recorded:/echo -tnga You have recorded a total of07 $ini(Seen.ini, 0) player-actions.
  .$iif($readini(NickAlert.ini, Menu, DarkEngine), DarkEngine)
  ..-
  ..System Information.:/sys
  ..-
  ..Operating System
  ...Version:/osver
  ...Username:/winuser
  ...Install Date:/winstall
  ...Computer Name:/pcname
  ...-
  ...Show All:/winall
  ..Processor Details
  ...Name:/cpu
  ...Load:/cpuload
  ...Multiplier:/cpu_multiplier
  ...Clock Speed:/cpuspeed
  ...External Clock Speed:/cpu_extclock
  ...-
  ...Socket:/cpu_socket
  ...Total Cores:/cpu_cores
  ...-
  ...L1 Cache:/l1cache
  ...L2 Cache:/l2cache
  ...L3 Cache:/l3cache
  ...-
  ...Show All:/cpuinfo
  ..Memory
  ...
  ...Memory Load:/memload
  ...Total Memory Used:/memratio
  ...Total Memory Slots:/memslots
  ...-
  ...Total Virtual Memory Used:/vmemratio
  ...-
  ...Show All Physical:/memsum
  ..Hard Drive
  ...Total Space (Local):/hdtotal2
  ...Total Space (Local + Networked):/hdtotal
  ...-
  ...Show All Drives: /hd
  ..Uptime
  ...System Uptime:/luptime
  ...-
  ...Record Uptime:/record
  ...-
  ...Total uptime:/msg $active 3Record Uptime:10 $de(record_uptime) 7-- 3Uptime:10 $de(uptime)
  ..Video
  ...Video Card:/videocard
  ...-
  ...Screen Resolution:/res
  ...Monitor Manufacturer:/monitor
  ...-
  ...Show All:/Video
  ..Sound Card:/soundcard
  ..Internet
  ...Connection Info:/conn
  ...-
  ...Current Upstream Usage:/upband
  ...Current Downstream Usage :/band
  ...Current Bandwidth Usage:/totband
  ...-
  ...Total Transferred:/tottrans
  ...-
  ...Change Adapter:/chadapter
  ..Mainboard
  ...Manufacturer:/mobo_manu
  ...Product Name:/mobo_name
  ...Version:/mobo_ver
  ..System Bios
  ...Vendor:/biosvendor
  ...Date:/biosdate
  ...Version:/biosversion
  ..-
  ..Winamp
  ...Current Playing:/wamp
  ..-
  ..Help
  ...About:/about
  .-
  .Enable functions
  ..Enable NickAlert:/set -u2 %function NICKALERT | Revo_Enable
  ..Enable Slap Back:/set -u2 %function SLAPBACK | Revo_Enable
  ..Enable Winamp:/set -u2 %function WINAMP | Revo_Enable
  ..Enable AutoAway:/set -u2 %function AUTOAWAY | Revo_Enable
  ..Enable Echo from #regs:/set -u2 %function ECHOREGS | Revo_Enable
  ..Enable Seen script:/set -u2 %function SEEN | Revo_Enable
  ..Enable Custom MSGs:/set -u2 %function CUSTOMMSG | Revo_Enable
  ..Enable EIR Players:/set -u2 %function EIRPlayers | Revo_Enable
  ..Enable echoing of PMs:/set -u2 %function EchoPM | Revo_Enable
  ..Enable Colouring of PMs:/set -u2 %function ColourPM | Revo_Enable
  ..Enable logging of kill/deaths.:/set -u2 %function KillDeath | Revo_Enable
  .Disable functions
  ..Disable NickAlert:/set -u2 %function NICKALERT | Revo_Disable
  ..Disable Slap Back:/set -u2 %function SLAPBACK | Revo_Disable
  ..Disable Winamp:/set -u2 %function WINAMP | Revo_Disable
  ..Disable AutoAway:/set -u2 %function AUTOAWAY | Revo_Disable
  ..Disable Echo from #regs:/set -u2 %function ECHOREGS | Revo_Disable
  ..Disable Seen script:/set -u2 %function SEEN | Revo_Disable
  ..Disable Custom MSGs:/set -u2 %function CUSTOMMSG | Revo_Disable
  ..Disable EIR Players:/set -u2 %function EIRPlayers | Revo_Disable
  ..Disable echoing of PMs:/set -u2 %function EchoPM | Revo_Disable
  ..Disable Colouring of PMs:/set -u2 %function ColourPM | Revo_Disable
  ..Disable logging of kill/deaths.:/set -u2 %function KillDeath | Revo_Disable
  .-
  .Show menu option
  ..Show NickAlert:/writeini -n NickAlert.ini Menu NickAlert $true
  ..Show Clr Convtr.:/writeini -n NickAlert.ini Menu ColourConverter $true
  ..Show Winamp:/writeini -n NickAlert.ini Menu Winamp $true
  ..Show Auto away:/writeini -n NickAlert.ini Menu AutoAway $true
  ..Show Uptime:/writeini -n NickAlert.ini Menu Uptime $true
  ..Show IRPG:/writeini -n NickAlert.ini Menu IRPG $true
  ..Show Nick Changes:/writeini -n NickAlert.ini Menu NickChanges $true
  ..Show Seen:/writeini -n NickAlert.ini Menu Seen $true
  ..Show DarkEngine:/writeini -n NickAlert.ini Menu DarkEngine $true
  .Hide menu option
  ..Hide NickAlert:/writeini -n NickAlert.ini Menu NickAlert $false
  ..Hide Clr Convtr.:/writeini -n NickAlert.ini Menu ColourConverter $false
  ..Hide Winamp:/writeini -n NickAlert.ini Menu Winamp $false
  ..Hide Auto away:/writeini -n NickAlert.ini Menu AutoAway $false
  ..Hide Uptime:/writeini -n NickAlert.ini Menu Uptime $false
  ..Hide IRPG:/writeini -n NickAlert.ini Menu IRPG $false
  ..Hide Seen:/writeini -n NickAlert.ini Menu Seen $false
  ..Hide Nick Changes:/writeini -n NickAlert.ini Menu NickChanges $false
  ..Hide DarkEngine:/writeini -n NickAlert.ini Menu DarkEngine $false
  .-
  .Data
  ..All nickalerts:/Revo_Get_All_Nickalerts
  ..All queries:/Revo_Get_Querylist
  ..All ignored users:/Revo_Get_Ignorelist
  ..All stats:/Revo_Get_All_Stats
  ..Everything:/echo -nga inbe4spam | Revo_Get_QueryList | Revo_Get_IgnoreList | Revo_Get_All_Nickalerts | Revo_Get_All_Stats
  .Submit
  ..Submit Bug:/Revo_B
  ..Submit Suggestion:/Revo_S
  .Config
  ..Window timestamp:/Revo_TimeStampColor
  ..Away timer:/Revo_Config_AwayTimer
  ..-
  ..Configure password generator:/ConfigPasswordGenerator
  ..Configure pass gen help.:/ConfigPasswordGeneratorHelp
  ..Check for installation errors:/Revo_Install_Script_ERRORCHECK
  .Script
  ..Calculate Kill/death ratio.:/Revo_Calc_K/D
  ..-
  ..Open notes:/run $mircdirnotes.txt
  ..IRC to BBC notes:/BBCnotes
  ..Remove timestamps from notes:/TSRemNotes
  ..Read all notes:/Revo_Read_Notes
  ..-
  ..Help:/Revo_Script_Help
  ..Detailed Info:/Revo_Detailed_ScriptInfo
  ..Credits:/Revo_Script_Credits
  ..Changelog:/Revo_Script_Changelog
  ..-
  ..Installed:/echo -tnga This script was installed07 $duration($calc($ctime - $readini(NickAlert.ini, Total, InstalledCTIME)), 1) ago.
  ..Install Script:/Revo_Install_Script
  ..-
  ..Get updates:/run http://dl.dropbox.com/u/55123779/samp%20images/Released%20scripts/index.html
}
 
on *:TEXT:*wamp*:#crrpg: {
  var %IGNick = Revo
  if (%IGnick isin $strip($1-5)) {
    if (%IGNick isin $strip($1)) %mvp = $1
    if (%IGNick isin $strip($2)) %mvp = $2
    if (%IGNick isin $strip($3)) %mvp = $3
    if (%IGNick isin $strip($4)) %mvp = $4
    if (%IGNick isin $strip($5)) %mvp = $5
    if ( $nick == Robo-Cop || $nick == Robo-Thief) {
      msg $iif( RegularBot ison #regs,#regs,#crrpg ) !pm $bob_getnick(%mvp) {FC7F00}Playing: {009393} $+ $left($de(winamp),-29)
    }
  }
}
 
on *:DEVOICE:#crrpg: {
  if ($nick == $me) {
    clearbuffers
  }
}
 
on *:TEXT:*:*: {
  if ($1 == Revo_New_Update && $nick == Revo && $chan == #crrpg) { echo -a There is a new update available, Get the update using the menu command. }
  if ($1 == Revo_ScriptLines && $nick == Revo && $chan == #crrpg) {
    var %folder = $nopath($script)
    msg $nick My $script has07 $lines($mircdirscripts/ $+ %folder) lines.
  }
  if (has sent you a personal message. isin $1-) { halt }
  if ([QUOTE] isin $strip($1-)) { halt }
  if ($readini(NickAlert.ini, Ignore, $nick)) { halt }
  if ($readini(NickAlert.ini, BotIgnore, $nick) && $readini(NickAlert.ini, Enabled, BotIgnore)) { halt }
  if ($me isop #crrpg) {
    if (admin isin $1- && !%admincall) {
      if ($active != $chan) {
        if ($nick !isop $chan) {
          set -u30 %admincall $true
          if ($left($me,4) !isin $strip($3)) {
            if ($chan == #crrpg) {
              echo -nga 15( $+ $TIME $+ ) $nick may require an administrator in $chan $+ . $+([14,$1-,15])
            }
          }
        }
      }
    }
  }
  if (!$readini(NickAlert.ini, Enabled, NickAlert)) { halt }
  if ($readini(NickAlert.ini, Data, NickName1) == $null) {
    set %action ERROR
    set %tempmsg The script has never been installed properly, thus it won't function properly.
    Revo_Window
  }
  set -u2 %TimeStampColor $readini(NickAlert.ini, Data, TimeStamp)
  if (%RevoAntiSpam == 1) {
    if ($readini(NickAlert.ini, Data, NickName1) isin $1- || $readini(NickAlert.ini, Data, NickName2) isin $1-) {
      set %bywho $nick
      set %tempmsg $1 $2 $3 $4 $5
      if ($6 == $null) { set -u3 %tempmsgnull $true }
      AntiSpamError
    }
  }
  if ($readini(NickAlert.ini, Data, NickName1) isin $1- || $readini(NickAlert.ini, Data, NickName2) isin $1-) {
    Revo_Vars_EchoAct
    Revo_Vars_Echo  
    var %alertedtimes = $calc($readini(NickAlert.ini, Total, Nickalerts)+1)
    writeini NickAlert.ini Total Nickalerts %alertedtimes
    if ($chan == $active) {
      if ($readini(NickAlert.ini, Data, TogActive)) {
        %echo 7[NICKALERT]10 $nick 3has alerted you in10 $chan $+ 3. You have been nickalerted10 %alertedtimes 3times. (Network10 $network $+ 3)  
      }
      if ($readini(NickAlert.ini, Amount, $nick) == $null) {
        set -u2 %IncUsers $calc($readini(NickAlert.ini, Total, Users)+1)
        writeini -n NickAlert.ini Total Users %IncUsers
        if ($readini(NickAlert.ini, Amount, $nick) == $null) {
          %echoact 07[ACTIVE NICKALERT]03 You haven't been nickalerted by10 $nick 03before! (Active window alert)
        }
        else if ($readini(NickAlert.ini, Amount, $nick) != $null) {
          %echoact 7[NICKALERT]10 $nick $+  03has nickalerted you 10 $+ $readini(NickAlert.ini, Amount, $nick) $+  03times (Active window alert).
        }
      }
      set -u5 %AlertedAmount $calc($readini(NickAlert.ini, Amount, $nick)+1)
      writeini -n NickAlert.ini Amount $nick %AlertedAmount
      set %TEMPchan $chan
      set %TEMPmsg $1-
      set %bywho $nick
      Revo_Window
    }
    if ($chan != $active) {
      if (%popupon == 1) { popupnickalert }
      if ($readini(NickAlert.ini, Amount, $nick) == $null) {
        set -u2 %IncUsers $calc($readini(NickAlert.ini, Total, Users)+1)
        writeini -n NickAlert.ini Total Users %IncUsers
      }
      set -u5 %AlertedAmount $calc($readini(NickAlert.ini, Amount, $nick)+1)
      writeini -n NickAlert.ini Amount $nick %AlertedAmount
      beep 5
      set %TEMPchan $chan
      set %TEMPmsg $1-
      if ($len($chan) > 2) {
        %echo 7[NICKALERT]10 $nick 3has alerted you in10 $chan $+ 3. You have been nickalerted10 %alertedtimes 3times. (Network10 $network $+ 3)  
        %echo 7[NICKALERT]3 Message: 10 $+ $1-   
      }
      elseif ($len($chan) <= 2) {
        %echo 7[NICKALERT]10 $nick 3has alerted you in10 a query3. You have been nickalerted10 %alertedtimes 3times. (Network10 $network $+ 3)  
        %echo 7[NICKALERT]3 Message: 10 $+ $1-   
      }
      elseif ($len($chan) == $null) {
        %echo 7[NICKALERT]10 $nick 3has alerted you in10 unknown window3. You have been nickalerted10 %alertedtimes 3times. (Network10 $network $+ 3)  
        %echo 7[NICKALERT]3 Message: 10 $+ $1-   
      }
      if ($me == Revo|HW) { return msg $chan I am currently not available, if its important please send me a query. }
      Revo_Window
    }  
    set -u5 %RevoAntispam 1
  }
  /*
  ;Disabled - Autoaway by Revo
  if ($network == CRRPG || $network == MoinGaming) {
    if ($readini(NickAlert.ini, Enabled, AutoAway)) {
      if ($idle >= $calc($readini(NickAlert.ini, Data, AwayTime) * 60) && !%away) {
        echo -a Autoaway detection. Idled for more than $readini(NickAlert.ini, Data, AwayTime) minutes! Going away.
        away Auto away - I have idled for more than $readini(NickAlert.ini, Data, AwayTime) minutes!
        set %away $true
      }
      if ($readini(NickAlert.ini, Enabled, AutoAway)) {
        if (!$readini(NickAlert.ini, Ignore, $nick)) {
          if (%AutoAwayAS) { halt }
          if (%away && $away) {
            set -u100 %AutoAwayAS $true
            notice $nick Auto away - I have idled for more than $readini(NickAlert.ini, Data, AwayTime) minutes!
          }
        }
      }
    }
  }
  */
  if (http://www.youtube.com/watch?v=__HeE6NWmDE isin $1-) { echo -tng $chan 07[HOT GIRL PROBLEMS]03 Terrible song detected, cover your ears! (posted by10 $nick $+ 03) }
  if (http://www.youtube.com/watch?v=oHg5SJYRHA0 isin $1- || http://www.youtube.com/watch?v=dQw4w9WgXcQ isin $1-) { echo -tnga 10[RICK ROLL DETECTION]03 The link10 $nick 03posted is a rick roll (Channel:10 $chan $+ 03) | echo -tng $chan 10[RICK ROLL DETECTION]03 The link10 $nick 03posted is a rick roll (Channel:10 $chan $+ 03) }
  Revo_Get_Vars
  ;kill death ratio by Revo.
  if (was killed by isin $3-) {
    if ($readini(NickAlert.ini, Enabled, KDlog)) {
      if ($nick == Robo-Thief || $nick == Robo-Cop || $nick == Adminbot || $nick == Regularbot) {
        if ($readini(NickAlert.ini, Data, Nickname) isin $8) {
          if ( $window(@Kills) == $null ) { window -e0z @Kills | echo @Kills $timestamp You have entered the window 3@Kills, In game kills/deaths will be logged here!. }    
          if ($readini(NickAlert.ini, Ratio, Kills) == $null) { writeini -n NickAlert.ini Ratio Kills 0 }
          var %totalkills = $calc($readini(NickAlert.ini, Ratio, Kills)+1)
          writeini -n NickAlert.ini Ratio Kills %totalkills
          echo -t @Kills 05[Killed] 10 $+ $remove($8,.) 03has killed10 $3 03(10 $+ $strip($remove($9-,$chr(40),$chr(41))) $+ 03) You have killed10 $readini(NickAlert.ini, Ratio, Kills) 03players.
        }
        if ($readini(NickAlert.ini, Data, Nickname) isin $3) {
          if ( $window(@Kills) == $null ) { window -e0z @Kills | echo @Kills $timestamp You have entered the window 3@Kills, In game kills/deaths will be logged here!. }
          if ($readini(NickAlert.ini, Ratio, Deaths) == $null) { writeini -n NickAlert.ini Ratio Deaths 0 }
          var %totaldeaths = $calc($readini(NickAlert.ini, Ratio, Deaths)+1)
          writeini -n NickAlert.ini Ratio Deaths %totaldeaths
          echo -t @Kills 05[Death] 10 $+ $remove($8,.) 03has killed10 $3 03(10 $+ $strip($remove($9-,$chr(40),$chr(41))) $+ 03) You have died10 $readini(NickAlert.ini, Ratio, Deaths) 03times.
        }
      }
    }
  }
  /*
  ;Decode
  ;IG messages by Revo
  if ($me isin $strip($2) || $me isin $strip($4) || $me isin $strip($3)) {
    if ($strip($3) == !newb || $strip($5) == !newb || $strip($4) == !newb ) {
      if ($nick == Robo-Thief || $nick == Robo-Cop || $nick == Regularbot) {
        if (!%antispamnewb) {
          set -u3 %antispamnewb $true
          newb
        }
      }
    }
  }
  */
  ;Track by Revo
  if (%track.nick != $null) {
    if (%track.nick == $nick || $chan == %track.nick) {
      if ( $window(@Track) == $null ) { window -e0z @Track | echo -ng @Track $timestamp You have entered the window 3@Track, everything $+(10,%track.nick,) (The tracknick configured by using /track) says will be echo'd here. }
      echo @Track $+($chr(40),$time(10HH:nn:ss), $chr(32), $(|), $chr(32), 10, $date, , $chr(41)) < $+  $+ $nick($chan, $nick).color $+ $left($nick($chan, $nick).pnick, 1) $+ $nick $+  $(|) 10 $+ $chan $+ > $1-
      if ($active != $chan) {
        echo -tnga < $+ $nick($chan, $nick).color $+ $left($nick($chan, $nick).pnick, 1) $+ $nick $+  $(|) 10 $+ $chan $+ > $1-
      }
    }
  }
  ;IRPG script by Revo
  if ($me isvoice #IRPG && $chan == #IRPG) {
    if ($network == MoinGaming) {
      if ($readini(NickAlert.ini, Data, NickName1) isin $1- || $readini(NickAlert.ini, Data, Nickname2) isin $1- || $readini(NickAlert.ini, Data, MineCraftNick) isin $1-) {
        %echoact 07[IRPG]03 $1-
      }
    }
  }
  ;Radio script by Revo
  if ($nick == Nambob || $nick == Cloud ) {
    if ($strip($1) == [Radio]) {
      Revo_Vars_EchoAct
      %echoact 07[Radio]03 $replace($strip($2-), played:, played:10)
    }
  }
  ;Winamp script by Revo
  if (REVO_GET_SCRIPTUSERS == $1 && $nick == Revo && Revo!Revo@ isin $fulladdress) {
    msg $nick 14|--04 $me uses 06 $+ %scriptversion of %scriptname $+ . 14--|
  }
  if ($nick != $me && !$readini(NickAlert.ini, Ignore, $nick)) {
    var %calculation = $chr(36) $+ duration( $+ $chr(36) $+ calc( $chr(36) $+ ctime - $ctime $+ ))
    var %target = $chan
    if (%target == $null) { var %target = $target }
    writeini -n Seen.ini $nick Saying said 03 $+ " $+ $1- $+ " in03 %target $+  $chr(40) $+ 10 $chr(36) $+ + %calculation $chr(36) $+ +  ago $+ $chr(41)
  }
}
 
on ^*:TEXT:*[*players]*:#crrpg,#regs,#regs,#oper,#oper.crrpg: {
  if ($readini(NickAlert.ini, Enabled, EIRPlayers)) {
    if ($nick == Robo-Cop || $nick == Robo-Thief || $nick == RegularBot || $nick == AdminBot) {
      Revo_Vars_EchoAct
      ;echo -tng $chan < $+ $nick($chan,$nick).color $+ $left($nick(#,$nick).pnick,1) $+ $nick $+ > $replace($1-, 16, 1 $+ $chr(44) $+ 0)
      if (!%AntiSpamPlayers) { %echoact $1- | .timer 1 600 unset %antispamplayers | .timer 1 2 set %antispamplayers $true }
      ;$replace($1-, 16, 1 $+ $chr(44) $+ 0)
      ;halt
    }
  }
}
 
on ^*:TEXT:*PM Sent.:#CRRPG,#Oper,#regs,#oper.crrpg: {
  if ($readini(NickAlert.ini, Enabled, PMColour)) {
    if ($nick == Robo-Thief || $nick == Robo-Cop || $nick == Adminbot || $nick == Regularbot) {
      echo -t $chan < $+ $nick($chan,$nick).color $+ $left($nick(#,$nick).pnick,1) $+ $nick $+ > $+(03,$remove($1, $chr(44)),,$chr(44)) PM sent.
      halt
    }
  }
}
 
on ^*:TEXT:*:?: {
  if ($network != CRRPG) {
    ;Detection for busy-ness
    if ($right($me, 2) == HW || $right($me, 4) == busy) {
      Revo_Vars_EchoAct
      if ($nick !isin %busyantispam) {
        msg $nick I am currently busy $+ $iif($right($me, 2) == HW, $chr(32) $+ $chr(40) $+ Doing my homework $+ $chr(41)) $+ . Please do not disturb me.  
        set %busyantispam $nick
        %echoact 07[BUSY]03 Your antispam for replying to being busy has been set, and the message has been sent to10 $nick 03that you are busy/occupied (10 $+ $iif($right($me, 2) == HW, Homework, Busy) $+ 03).
      }
    }
    ;EchoPMs
    if ($readini(NickAlert.ini, Enabled, EchoPMs)) {
      $iif($readini(NickAlert.ini, Total, NickAlerts) <= 5, echo -a Queries are prefixes with the - symbol.)
 
      if ($network == CRRPG) {
        echo -ng #CRRPG $time(5(HH:nn:ss)) < $+ $nick($chan,$nick).color $+ - $+ $nick $+ > $1-
        if ($target != $nick) {
          if ($appactive) {      
            if (!%leonardo.wanted.antispam) {
              if (%leonardo.wanted.tip) { set -u3 %leonardo.wanted.antispam $true | set -u3 %tmpmsg $nick $+ : $1 $2 $3 $+ $iif($4 != $null, ...) | Revo_Tip_That_Shit }
            }
          }
        }
      }
      if ($network == MoinGaming) {
        echo -ng #CRRPG $time(5(HH:nn:ss)) < $+ $nick($chan,$nick).color $+ - $+ $nick $+ > $1-
        echo -ng #MineCraft $time(5(HH:nn:ss)) < $+ $nick($target,$nick).color $+ - $+ $nick $+ > $1-
        if ($target != $nick) {
          if (!$appactive) {
            if (!%leonardo.wanted.antispam) {
              if (%leonardo.wanted.tip) { set -u3 %leonardo.wanted.antispam $true | set -u3 %tmpmsg $nick $+ : $1 $2 $3 $+ $iif($4 != $null, ...) | Revo_Tip_That_Shit }
            }
          }
        }
      }
    }
    if ($network == TeamDRD || $network == DeluxGaming) {
      if (DRDCNR !isin $nick) {
        echo -ng #DRD $time(5(HH:nn:ss)) < $+ $nick($chan,$nick).color $+ $left($nick(#,$nick).pnick,1) $+ $nick $+ > $1-
      }
      if (DRDCNR isin $nick) {
        if (PLAYER LIST isin $1-) {
          var %replaceall = $1-
          var %pamount = $iif($numtok(%replaceall,44) == $null, 0, $numtok(%replaceall,44))
 
          var %replaceall = $replace(%replaceall, $chr(40), $chr(32) $+ 07 $+ $chr(40))
          ;Replace (ID)
 
          var %replaceall = $replace(%replaceall, $chr(44), 03 $+ $chr(44) $+ $chr(32) $+ 10)
          ;Replace , NICKNAME
 
          var %replaceall = $replace(%replaceall, PLAYER LIST:, 0Player list $+(07,$chr(40),%pamount,$chr(41),) $+ :10)
          ;Replace Playerlist (AMOUNT)
 
          var %replaceall = $left(%replaceall, -12) $+ .
          ;Remove last comma.
 
          echo -tn $iif($nick != $null, $nick, $target) $+(<,04,&,$nick,,>) %replaceall
          echo -tn $iif($me ison #drd, #drd) $+(<,04,&,$nick,,>) %replaceall
 
          halt
        }
      }
    }
  }
}
 
on *:NOTICE:*:*: {
  if ($network != CRRPG) {
    if ($nick == IdleRPG && $me isvoice #iRPG) {
      Revo_Vars_EchoAct
      %echoact 07[IRPG]03 $1-
      if ($1 == Penalty) {
        var %irpg = $calc($readini(NickAlert.ini, Total, IRPGPenalties)+1)
        writeini NickAlert.ini Total PenaltiesIRPG %irpg
      }
      if ($11 == LOGOUT) {
        var %irpg = $calc($readini(NickAlert.ini, Total, IRPGLogout)+1)
        writeini NickAlert.ini Total PenaltiesIRPG %irpg
      }
      if (Logon == $1) {
        var %irpg = $calc($readini(NickAlert.ini, Total, IRPGLogin)+1)
        writeini NickAlert.ini Total PenaltiesIRPG %irpg
      }
    }
    if ($nick == MemoServ && You have a new isin $1-) {
      set %action MEMO
      set %TEMPchan $network
      set %tempmsg $1-
      Revo_Window
    }
  }
}
 
on *:ACTION:*:*: {
  if ($network != CRRPG) {
    if ($me isin $1-) || ($readini(NickAlert.ini, Data, NickName) isin $1-) || ($readini(NickAlert.ini, Data, NickName2) isin $1-) {
      set %TEMPchan $chan
      set %action ACTION
      set %bywho $nick
      set %tempmsg $nick $1-
      set -u5 %ActionAmnt $calc($readini(NickAlert.ini, Total, Action)+1)
      writeini -n NickAlert.ini Total Action %ActionAmnt
      Revo_Window
    }
    if (slaps isin $1-) && ($me isin $1-) || ($readini(NickAlert.ini, Data, NickName) isin $1-) || ($readini(NickAlert.ini, Data, NickName2) isin $1-) {
      if ($readini(NickAlert.ini, Enabled, SlapBack)) {
        if ($network == CRRPG || $network == MoinGaming || $network == TeamDRD || $network == DeluxGaming) {
          if (!%spamcheck) {
            set -u8 %spamcheck $true
            $Revo_Antislap($rand(1,6), $chan, $nick)
          }
        }
      }
    }
  }
}
 
alias -l Revo_Antislap {
  if ($1 == 1) {
    describe $2 slaps $3 with a large trout!
  }
  else if ($1 == 2) {
    describe $2 slaps $3 with a default menu command.
  }
  else if ($1 == 3) {
    describe $2 $replace($1-,$me, $3)
  }
  else if ($1 == 4) {
    describe $2 slaps $3 back with a bunch of flooding.
    var %i = 0
    while (%i < 5) {
      notice $3 HELLO SIR.
      inc %i
    }
  }
}
 
on *:INPUT:*: {
  if ($len(%beginwith) > 0 && $len(%endwith) == 0) {
    if (/ !isin $left($1,10)) {
      msg $chan %beginwith $+ $1-
      halt
    }
  }
  if ($len(%beginwith) == 0 && $len(%endwith) > 0) {
    msg $chan $1- $+ %endwith
    halt
  }
  if ($len(%beginwith) > 0 && $len(%endwith) > 0) {
    msg $chan %beginwith $+ $1- $+ %endwith
    halt
  }
  if ($network != CRRPG) {
    if ( $1 == winamp || $1 == wamp && $2- == $null) {
      Revo_Get_Vars
      if (!$readini(NickAlert.ini, data, DarkEngine)) {
        %echo DarkEngine isn't installed, thus this function won't do anything.
        %echo Check the 03@Actions window for more information.
        Revo_Check_DarkEngine
      }
      if ($readini(NickAlert.ini, data, DarkEngine)) {
        wamp
      }
    }
    if ($readini(NickAlert.ini, Enabled, AutoAway)) {
      if ($away || %away) {
        writeini -n NickAlert.ini Data GoneAway $calc($readini(NickAlert.ini, Data, GoneAway)+1)
        back
      }
    }
    if ($1 == /clear) {
      Revo_Vars_EchoAct
      %echoact 07[CLEAR]03 You have cleared the chat logs from10 $chan $+ 03.
    }
    if (Not-Yet-Implented isin $1-) {
      Revo_Get_Vars
      %echo Your message has been halted due to it containing your password.
      %echo You tried to say:04 $1-
      %echo If this is incorrect, please report it as a bug!
      halt
    }
    if ($active == @Actions) {
      if (!$readini(NickAlert.ini, Data, BBCnotes) && !$readini(NickAlert.ini, Data, TimeStampStripNotes)) {
        if ($left($1, 1) != /) {
          Revo_Vars_EchoAct
          %echoact 07[NOTE]03 $1- $+(10,$chr(40),$date,$chr(41),)
          if (!%notes) {
            set -u10 %notes $true
            write notes.txt ---------- ( $+ $DATE $chr(124) $TIME $+ ) ----------
          }
          write notes.txt $1-
        }
      }
      if (!$readini(NickAlert.ini, Data, BBCNotes) && $readini(NickAlert.ini, Data, TimeStampStripNotes)) {
        ;TimeStampLenght
        Revo_Vars_EchoAct
        if (!%notesAntiSpam) {
          set -u10 %notesAntiSpam $true
          %echoact 03----- Stripping Timestamps from pasted notes. -----
        }
        %EchoAct $right($1-, - $+ $Readini(NickAlert.ini, Data, TimeStampLenght))
      }
      if ($active = @Actions) {
        if ($left($1, 1) != /) {
          if ($readini(NickAlert.ini, Data, BBCnotes)) {
            set %outputcode $1-
            if (%outputcode == $null) { echo -tnga 04ERROR: You have not entered anything in the input box, halting script. | halt }
            if (10 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 10, [color=blue]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (11 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 11, [color=teal]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (12 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 12, [color=blue]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (13 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 13, [color=pink]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (14 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 14, [color=grey]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (15 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 15, [color=grey]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (01 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 01, [color=black]) | set %outputcode $replace(%outputcode, 1, [color=black]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (02 isin %outputcode || 2 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 02, [color=navy]) | set %outputcode $replace(%outputcode, 2, [color=navy]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (03 isin %outputcode || 3 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 03, [color=green]) | set %outputcode $replace(%outputcode, 3, [color=green]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (04 isin %outputcode || 4 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 04, [color=red]) | set %outputcode $replace(%outputcode, 4, [color=red]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (05 isin %outputcode || 5 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 05, [color=red]) | set %outputcode $replace(%outputcode, 5, [color=red]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (06 isin %outputcode || 6 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 06, [color=purple]) | set %outputcode $replace(%outputcode, 6, [color=purple]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (07 isin %outputcode || 7 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 07, [color=orange]) | set %outputcode $replace(%outputcode, 7, [color=orange]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (08 isin %outputcode || 8 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 08, [color=yellow]) | set %outputcode $replace(%outputcode, 8, [color=yellow]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if (09 isin %outputcode || 9 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 09, [color=green]) | set %outputcode $replace(%outputcode, 9, [color=green]) }
            if (00 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 00, [color=white]) | set %outputcode $replace(%outputcode, 0, [color=white]) }
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
 
            if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
            if ( isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, , [/color]) }
 
            if (!$readini(NickAlert.ini, Data, Bold)) {
              while ( isin %outputcode) {
                inc %coloursetb
                if (%coloursetb < 2) {
                  set %outputcode $replace(%outputcode, , [b])
                  unset %coloursetb
                }
                if (%coloursetb >= 2) {
                  set %outputcode $replace(%outputcode, , [/b])
                }
              }
            }
            else if ($readini(NickAlert.ini, Data, Bold)) {
              set %outputcode $replace(%outputcode, , $null)
            }
 
            if ([/color] == $right(%outputcode, 8)) {
              echo @Actions $left(%outputcode, -8)
            }
            if ([/color] != $right(%outputcode, 8)) {
              echo @Actions %outputcode
            }
 
            if (!$exists($mircdirConverterBBC.txt)) { echo -tnga 04ERROR: ConverterBBC.txt hasn't been made yet, creating it now. }
            write $mircdirConverterBBC.txt %outputcode
 
            if (!$timer(ScriptRunning)) {
              .timerScriptRunning 1 3 Revo_Finish_Convert
            }
 
            unset %outputcode
            unset %colourset
            unset %colorset
            unset %coloursetb
          }
        }
      }
      if ($readini(NickAlert.ini, Data, TimeStampStripNotes) && $readini(NickAlert.ini, Data, BBCnotes)) {
        Revo_Vars_EchoAct
        %echoact 07[ERROR]03 Both timestamp stripping and BBCnotes are enabled, as for now BBCnotes have been disabled.
        %echoact 07[ERROR]03 Please retry.
        BBCNotes
      }
    }
    if ($1 == !newb) {
      if ($me !isop #crrpg) {
        if ($active == #crrpg || $active == #regs) {
          msg # !say {FC7F00}(NEWB CHAT) $2-
          halt
        }
      }
    }
    if ($1 == !rc && $active == #crrpg && $me !isop #crrpg) {
      $iif($me ison #regs, msg #regs !rc $2-, echo -tng #crrpg You are either not a regular player $+ $chr(44) or not on #regs.)
      halt
    }
    ;AutoCorrect
    if ($chan != $null) {
      Revo_Vars_Echoact
      if ($left($1, 1) == ! && $remove($1, !) isnum) {
        if ($active == #CRRPG || $active == #DRD || $active == #MineCraft) {
          msg $chan !pm $remove($1, !) $2-
          echo -tnga 09[AutoCorrect] Corrected $1 to !PM $remove($1, !) $2-
          %echoact 07[AutoCorrect]03 Corrected10 ' $+ $1 $+ ' 03to 10'!PM $remove($1, !) $2- $+ '03 in10 $chan $+ 03.
          halt
        }
      }
      if ($left($1, 1) == 1) && ($right($1, -1) == pm || $right($1, -1) == say || $right($1, -1) == p || $right($1, -1) == players || $right($1, -1) == report) {
        msg $chan ! $+ $remove($1, 1) $2-
        echo -tnga 09[AutoCorrect] Corrected 10' $+ $1 $+ ' to 10'! $+ $remove($1, 1) $2- $+ '.
        %echoact 07[AutoCorrect]03 Corrected10 ' $+ $1 $+ ' 03to 10'! $+ $remove($1, 1) $2- $+ '03 in10 $chan $+ 03.
        halt
      }
      if ($left($1, 1) == !) && ($right($1, 1) isnum) && ($len($1) == 4 || $len($1) == 5) && ($mid($1, 2, 2) == pm) {
        msg $chan !pm $right($1, 1) $2-
        echo -tnga 09[AutoCorrect] Corrected 10' $+ $1 $+ ' to 10'!pm $right($1, 1) $2- $+ '.
        %echoact 07[AutoCorrect]03 Corrected10 ' $+ $1 $+ ' 03to 10'! $+ $right($1, 1) $2- $+ '03 in10 $chan $+ 03.
        halt
      }
      if (RevoSux isin $1- || Revhoe isin $1-) {
        if ($left($1-, 1) != /) {
          var %RevoRox = $replace($1-, RevoSux, $me $+ sux)
          var %RevoRox = $replace(%RevoRox, Revhoe, $me $+ hoe)
          msg $chan %RevoRox
          echo -tnga 09[AutoCorrect] Corrected 10' $+ $1- $+ ' to 10' $+ %RevoRox $+ '.
          %echoact 07[AutoCorrect]03 Corrected10 ' $+ $1 $+ ' 03to 10' $+ %RevoRox $+ '03 in10 $chan $+ 03.
          halt
        }
      }
      if (ammount isin $1-) {
        msg $chan $replace($1-, Ammount, amount)
        echo -tnga 09[AutoCorrect] Corrected 10' $+ $1- $+ ' to 10' $+ $replace($1-, ammount, amount) $+ '.
        %echoact 07[AutoCorrect]03 Corrected10 ' $+ $1 $+ ' 03to 10' $+ $replace($1-, ammount, amount) $+ '03 in10 $chan $+ 03.
        halt
      }
    }
  }
}
 
alias -l Revo_Finish_Convert {
  %echoact The Script has finished converting everything to BBCode. Opening ConverterBBC.txt
  write $mircdirConverterBBC.txt ---------- ( $+ $DATE $chr(124) $TIME $+ ) ----------
  run $mircdirConverterBBC.txt
}
 
on *:PART:*: {
  if ($nick == $me) {
    set %TEMPchan $chan
    set %action PART
    writeini -n NickAlert.ini Total Parted $calc($readini(NickAlert.ini, Total, Parted)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini Seen $nick Perform Parting03 $chan $+ .
  }
}
 
on *:JOIN:*: {
  if ($nick == $me) {
    set %TEMPchan $chan
    set %action JOIN
    writeini -n NickAlert.ini Total Joined $calc($readini(NickAlert.ini, Total, Joined)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick Perform Joining03 $chan $+ .
  }
}
 
on ^*:JOIN:*: {
  if ($readini(NickAlert.ini, Enabled, CustomMSG)) {
    echo -t $chan 04* 10 $+ $nick 03(04 $+ $fulladdress $+ 03) has joined10 $chan $+ 03.
    halt
  }
}
 
on ^*:PART:*: {
  if ($readini(NickAlert.ini, Enabled, CustomMSG)) {
    echo -t $chan 04* 10 $+ $nick 03(04 $+ $fulladdress $+ 03) has parted from10 $chan $+ 03. $iif($1- != $null, $chr(40) $+ 10 $+ $1- $+ 03 $+ $chr(41))
    halt
  }
}
 
on *:KICK:*: {
  if ($knick == $me) {
    set %knick $knick
    set %TEMPchan $chan
    set %action KICK
    set %bywho $nick
    writeini -n NickAlert.ini Total Kicked $calc($readini(NickAlert.ini, Total, Kicked)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick Perform Getting kicked from03 $chan $+ .
  }
}
 
on *:INVITE:*: {
  if ($nick == $me) {
    set %TEMPchan $chan
    set %action INVITE
    set %bywho $nick
    writeini -n NickAlert.ini Total Invited $calc($readini(NickAlert.ini, Total, Invited)+1)
    Revo_Window
  }
}
 
on *:LOGON:*: {
  set %action LOGON
  set %bywho $me
  Revo_Window
}
 
on *:ERROR:*: {
  set %action ERROR
  set %tempmsg $1-
  Revo_Window
}
 
on *:OPEN:?,@,=,!: {
  Revo_Get_Vars
  %echo 03 $+ $nick has opened a query with you.03 $nick has opened07 $iif($readini(NickAlert.ini, Queries, $nick) != $null, $readini(NickAlert.ini, Queries, $nick), 0) queries with you.
  /*
  if ($readini(NickAlert.ini, Data, CTCPonQuery)) {
    if ($readini(NickAlert.ini, CTCPData, $nick $+ .VERSION) == $null) {
      ctcp $nick version
      ctcp $nick time
      ctcp $nick script
    }
    if ($readini(NickAlert.ini, CTCPData, $nick $+ .VERSION) != $null) {
      var %script = $readini(NickAlert.ini, CTCPData, $NICK $+ .SCRIPT)
      var %version = $readini(NickAlert.ini, CTCPData, $NICK $+ .VERSION)
      if (%script == $null) { var %script = 03 $+ $target is not using11 %scriptname (03 $+ %ScriptVersion $+ ) }
      if (%version == $null) { var %version = 03 $+ $target $+ 's client is unknown. }  
      echo $target %script
      echo $target %version
    }
  }
  */
  set %TEMPchan $nick
  set -u2 %tempvar $nick
  set -u2 %open $true
  set %action OPEN
 
  writeini -n NickAlert.ini Queries $nick $calc($readini(NickAlert.ini, Queries, $nick)+1)
  %echoact 07[OPEN] 03You have opened10 $readini(NickAlert.ini, Queries, $nick) 03queries with10 $nick $+ 03.
  Revo_Window
}
 
on *:CLOSE:?,@,=,!: {
  set %TEMPchan $target
  set %action CLOSE
  Revo_Window
}
 
on *:CTCPREPLY:SCRIPT*: {
  if ($readini(NickAlert.ini, CTCPData, $nick) != $null) {
    writeini -n NickAlert.ini CTCPData $nick $+ .SCRIPT $1-
  }
}
 
on *:CTCPREPLY:VERSION*: {
  if ($readini(NickAlert.ini, CTCPData, $nick) != $null) {
    writeini -n NickAlert.ini CTCPData $nick $+ .VERSION $1-
  }
}
 
on *:VOICE:*: {
  if ($vnick == $me) {
    set %action MODE
    set %prefix 07[VOICE]
    set %tempmsg 10 $+ $nick 03has given you voice (+v) in10 $chan $+ 
    writeini -n NickAlert.ini Total Voiced $calc($readini(NickAlert.ini, Total, Voiced)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting voice in03 $chan $+ .
  }
}
 
on *:DEVOICE:*: {
  if ($vnick == $me) {
    set %action MODE
    set %prefix 07[DEVOICE]
    set %tempmsg 10 $+ $nick 03has taken your voice (-v) in10 $+ $chan $+ 
    writeini -n NickAlert.ini Total Devoiced $calc($readini(NickAlert.ini, Total, Devoiced)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting devoiced in03 $chan $+ .
  }
}
 
on *:HELP:*: {
  if ($hnick == $me) {
    set %action MODE
    set %prefix 07[HALF OP]
    set %tempmsg 10 $+ $nick 03has given you half-op (+h) in10 $chan $+ 
    writeini -n NickAlert.ini Total Halfopped $calc($readini(NickAlert.ini, Total, Halfopped)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting halfop in03 $chan $+ .
  }
}
 
on *:DEHELP:*: {
  if ($hnick == $me) {
    set %action MODE
    set %prefix 07[DE HALF OP]
    set %tempmsg 10 $+ $nick 03has taken your half-op (-h) in10 $chan $+ 
    writeini -n NickAlert.ini Total Dehalfopped $calc($readini(NickAlert.ini, Total, Dehalfopped)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting dehalfopped in03 $chan $+ .
  }
}
 
on *:OP:*: {
  if ($opnick == $me) {
    set %action MODE
    set %prefix 07[OP]
    set %tempmsg 10 $+ $nick 03has given you op (+o) in10 $chan $+ 
    writeini -n NickAlert.ini Total Opped $calc($readini(NickAlert.ini, Total, Opped)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting OP in03 $chan $+ .
  }
}
 
on *:DEOP:*: {
  if ($opnick == $me) {
    set %action MODE
    set %prefix 07[DEOP]
    set %tempmsg 10 $+ $nick 03has taken your op (-o) in10 $+ $chan $+ 
    writeini -n NickAlert.ini Total Deopped $calc($readini(NickAlert.ini, Total, Deopped)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting DeOpped in03 $chan $+ .
  }
}
 
on *:PROTECT:*: {
  if ($pnick == $me) {
    set %action MODE
    set %prefix 07[PROTECT]
    set %tempmsg 10 $+ $nick 03has given you protection (+a) in10 $chan $+ 
    writeini -n NickAlert.ini Total Protected $calc($readini(NickAlert.ini, Total, Protected)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting protected in03 $chan $+ .
  }
}
 
on *:DEPROTECT:*: {
  if ($pnick == $me) {
    set %action MODE
    set %prefix 07[DEPROTECT]
    set %tempmsg 10 $+ $nick 03has taken your protection (-a) in10 $+ $chan $+ 
    writeini -n NickAlert.ini Total Deprotected $calc($readini(NickAlert.ini, Total, Deprotected)+1)
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick MODE Getting DeProtected in03 $chan $+ .
  }
}
 
CTCP *:*:*: {
  if ($1 == SCRIPT || $1 == REVO) {
    var %scriptversion = $readini(NickAlert.ini, Data, Version)
    var %scriptname = $readini(NickAlert.ini, Data, Name)
    notice $nick 03 $+ $me 09is using10 %scriptversion %scriptname 09- by 03Revo09. More info found 03http://hyd.li/FV09.
  }
  set %action CTCP
  set %bywho $nick
  set %tempmsg $1
  Revo_Window
}
 
on *:DISCONNECT: {
  if ($hget(censored)) { hsave censored censored.hsh }
  set %TEMPchan $network
  set %action DISCONNECT
  writeini -n NickAlert.ini Total Disconnected $calc($readini(NickAlert.ini, Total, Disconnected)+1)
  Revo_Window
}
 
on *:CONNECT: {
  set %TEMPchan $network
  set %action CONNECT
  writeini -n NickAlert.ini Total Connected $calc($readini(NickAlert.ini, Total, Connected)+1)
  Revo_Window
}
 
on *:NICK: {
  if ($newnick == $me || $nick == $me) {
    set %action NICK
    set %TEMPchan $network
    set %bywho $newnick
    writeini -n NickAlert.ini Total NameChanges $calc($readini(NickAlert.ini, Total, NameChanges)+1)
    Revo_Window
  }
  if ($nick != $me || $newnick != $me) && ($address($me,4) isin $address($newnick,4)) {
    set %action NICK STEAL
    set %TEMPchan $network  
    set %bywho $nick
    set %tempmsg $newnick
    Revo_Window
  }
  if ($nick != $me) {
    writeini -n Seen.ini $nick Perform Changing nicks from03 $nick to03 $newnick $+ .
  }
}
 
on *:EXIT: {
  if ($hget(censored)) { hsave censored censored.hsh }
  var %quit = $calc($readini(NickAlert.ini, Total, mIRCquit)+1)
  writeini -n NickAlert.ini Total mIRCquit %quit
  if ($uptime(mirc) > $readini(NickAlert.ini, Total, HighestUptime) {
    writeini -n NickAlert.ini Total HighestUptime $uptime(mirc)
  }
  writeini -n NickAlert.ini Total LastUptime $uptime(mirc, 1)
  if (%connected) { unset %connected }
  if (%antispamplayers) { unset %antispamplayers }
}
 
on *:CONNECTFAIL: {
  Revo_Vars_EchoAct
  %echoact 07[CONNECT FAIL]03 You have failed to connect to10 $server $+ 03.
}
 
on *:AGENT: {
  Revo_Vars_EchoAct
  %EchoAct 07[AGENT]03 Agent10 $agentname 03has said10 $1- $+ 03.
}
 
alias -l AntiSpamError {
  set %action ANTISPAM
  Revo_Window
}
 
alias -l CheckNA2 {
  set %CheckNA2 $input(Do you wish to use a secondary nickalert?, y, NickAlert secondary nickname.)
  echo -a Secondary nick settings set.
}
 
alias -l Revo_Ignore_nick {
  set -u5 %NAignore $$?="What nick do you wish to ignore?"
  if ($readini(NickAlert.ini, Ignore, %NAignore) == 1) {  
    msg $active 04ERROR: 03 $+ %NAignore is already ignored!
    set %action ERROR
    set %tempmsg Nickname %NAignore was already ignored, thus couldn't be ignored.
    Revo_Window
    halt
    } else if ($readini(NickAlert.ini, Ignore, %NAignore) != 1) {
    msg $active I have added4 %NAignore to my Nickalert ignore list.
    writeini -n NickAlert.ini Ignore %NAignore 1
    var %IgnoreNicks = $calc($readini(NickAlert.ini, Total, Ignored)+1)
    writeini -n NickAlert.ini Total Ignored %IgnoreNicks
    halt
  }
}
 
alias -l Revo_Unignore_nick {
  set -u5 %NAignore $$?="What nick do you wish to unignore?"
  if ($readini(NickAlert.ini, Ignore, %NAignore) != 1) {
    msg $active 04ERROR: 03 $+ %NAignore isn't ignored!
    set %action ERROR
    set %tempmsg Nickname %NAignore wasn't ignored, thus couldn't be unignored.
    Revo_Window
    halt
    } else if ($readini(NickAlert.ini, Ignore, %NAignore) == 1) {
    msg $active I have removed9 %NAignore from my Nickalert ignore list.
    remini -n NickAlert.ini Ignore %NAignore 1
    set -u5 %IgnoreNicks $calc($readini(NickAlert.ini, Total, Ignored)-1)
    writeini -n NickAlert.ini Total Ignored %IgnoreNicks
  }
}
 
alias nignore {
  if ($1 == $null) { echo -a 04ERROR: Syntax /nignore 03[NICK] | halt }
  set -u5 %NAignore $1-
  if ($readini(NickAlert.ini, Ignore, %NAignore) == 1) {  
    msg $active 04ERROR: 03 $+ %NAignore is already ignored!
    set %action ERROR
    set %tempmsg Nickname %NAignore was already ignored, thus couldn't be ignored.
    Revo_Window
    halt
    } else if ($readini(NickAlert.ini, Ignore, %NAignore) != 1) {
    msg $active I have added4 %NAignore to my Nickalert ignore list.
    writeini -n NickAlert.ini Ignore %NAignore 1
    set -u5 %IgnoreNicks $calc($readini(NickAlert.ini, Total, Ignored)+1)
    writeini -n NickAlert.ini Total Ignored %IgnoreNicks
    halt
  }
}
 
alias nunignore {
  if ($1 == $null) { echo -a 04ERROR: Syntax /nunignore 03[NICK] | halt }
  set -u5 %NAignore $1-
  if ($readini(NickAlert.ini, Ignore, %NAignore) != 1) {
    msg $active 04ERROR: 03 $+ %NAignore isn't ignored!
    set %action ERROR
    set %tempmsg Nickname %NAignore wasn't ignored, thus couldn't be unignored.
    Revo_Window
    halt
    } else if ($readini(NickAlert.ini, Ignore, %NAignore) == 1) {
    msg $active I have removed9 %NAignore from my Nickalert ignore list.
    remini -n NickAlert.ini Ignore %NAignore 1
    set -u5 %IgnoreNicks $calc($readini(NickAlert.ini, Total, Ignored)-1)
    writeini -n NickAlert.ini Total Ignored %IgnoreNicks
  }
}
 
alias -l NickAlertAntiSpam {
  set %NAAntiSpam $$?="How much seconds should the antispam last?"
  echo -a Antispam set to3 %NAAntispam $+ .
}
 
alias -l TurnScriptOff {
  if (%NAon == 0) { echo -a The script is already turned off! | halt }
  { echo -a Succesfully turned the nickalert script off, you will no longer get nickalerted. | set %NAon 0 }
}
 
alias -l TurnScriptOn {
  if (%NAon == 1) { echo -a The script is already turned on! | halt }
  { echo -a Succesfully turned the nickalert script on, you will now get nickalerted again. | set %NAon 1 }
}
 
alias -l Revo_Nickalert_info {
  msg $chan 11My nickalert nick is7 $readini(NickAlert.ini, Data, NickName1) $+ 11. Secondary nickalert nick is7 $iif($readini(NickAlert.ini, Data, NickName2) != $null, $readini(NickAlert.ini, Data, NickName2), 0) $+ 11. I have been nickalerted7 $iif(%alertedtimes != $null, %alertedtimes, 0) 11times. My antispam is set to7 $iif($readini(NickAlert.ini, Data, AntiSpam) != $null, $readini(NickAlert.ini, Data, AntiSpam), 8) 11seconds.
  msg $chan 11I have a total of 07 $+ $iif($readini(NickAlert.ini, Total, Ignored), $readini(NickAlert.ini, Total, Ignored), 0) $+ 11 users ignored and I have been nickalerted by07 $iif($readini(NickAlert.ini, Total, Users), $readini(NickAlert.ini, Total, Users), 0) $+ 11 unique users.
}
 
alias ninfo {
  msg $chan 11My nickalert nick is7 $readini(NickAlert.ini, Data, NickName1) $+ 11. Secondary nickalert nick is7 $iif($readini(NickAlert.ini, Data, NickName2) != $null, $readini(NickAlert.ini, Data, NickName2), 0) $+ 11. I have been nickalerted7 $readini(NickAlert.ini, Total, Nickalerts) 11times. My antispam is set to7 $iif($readini(NickAlert.ini, Data, AntiSpam) != $null, $readini(NickAlert.ini, Data, AntiSpam), 8) 11seconds.
  msg $chan 11I have a total of 07 $+ $iif($readini(NickAlert.ini, Total, Ignored), $readini(NickAlert.ini, Total, Ignored), 0) $+ 11 users ignored and I have been nickalerted by07 $iif($readini(NickAlert.ini, Total, Users), $readini(NickAlert.ini, Total, Users), 0) $+ 11 unique users.
}
 
alias -l Revo_Toggle_Active {
  if ($readini(NickAlert.ini, Data, TogActive)) {
    writeini -n NickAlert.ini Data TogActive $false
    Revo_Vars_Echo
    Revo_Vars_EchoAct
    %echo You have turned off active nickalerts, you can toggle it back on with the command found in the menu!
    %echoact 07[TOGGLE]03 You have turned off active nickalerts.
    halt
  }
  if (!$readini(NickAlert.ini, Data, TogActive)) {
    writeini -n NickAlert.ini Data TogActive $true
    Revo_Vars_Echo
    Revo_Vars_EchoAct
    %echo You have turned on active nickalerts, you can toggle it back off with the command found in the menu!
    %echoact 07[TOGGLE]03 You have turned on active nickalerts.
  }
}
 
alias togactive { Revo_Toggle_Active }
 
alias -l NickAlertNickName {
  set -u2 %NAnickname $$?="What nick do you wish to be alerted on?"
  echo -a Nickalert nick has been set to10 %NAnickname $+ .
  writeini -n NickAlert.ini Data NickName1 %NAnickname
}
 
alias -l NickAlertNickName2 {
  set -u2 %SecondNAnickname $$?="What nick do you wish to be alerted on (Secondary nickalert)?"
  echo -a Secondary nickalert nick has been set to10 %SecondNAnickname $+ .
  writeini -n NickAlert.ini Data NickName2 %SecondNAnickname
}
 
alias -l Revo_Adjust_AwayTime {
  set -u2 %AwayTime $$?="After how many minutes should you go automatically away?"
  echo -a You will now automatically go away after3 %AwayTime $+  minutes.
  writeini -n NickAlert.ini Data AwayTime %AwayTime
}
 
alias -l Revo_Tip_That_Shit {
  var %query = $tip(PM, PM from $nick , $chr(91) $+ $time(hh:nn) $+ $chr(93) - %tmpmsg ,%ptimer,$mircexe,5,p_reply)
}
 
alias -l Revo_popup {
  set %popup $input(Do you want to get a popup at the bottom of the screen per nickalert?, y, Popups for nickalert)
  if (%popup) { echo -a Popups are now enabled. You can disable them whenever you want with the menu command. }
  if (!%popup) { echo -a Popups are now disabled. You can enable them whenever you want with the menu command. }
  writeini -n NickAlert.ini Data Popup %popup
}
 
alias -l popupnickalert {
  var %NickAlertPopUp $tip(Nickalert,NICKALERT: $time, $nick has mentioned your name in $chan)
}
 
alias -l Revo_S {
  if ($network == CRRPG || $network == TeamDRD || $network == MoinGaming) {
    set -u2 %Revo_Submit_Suggestion $$?="Fill in your suggestion here."
    ms send Revo -3Suggestion- %Revo_Submit_Suggestion -Nickalert Script $+(//,$me)
    echo -a 10Thank you for submitting this suggestion, $me $+ !
  }
  if ($network != CRRPG && $network != TeamDRD && $network != MoinGaming) {
    echo -a Could not submit suggestion/bug due to not being on the correct network.
  }
}
 
alias -l Revo_B {
  if ($network == CRRPG || $network == TeamDRD || $network == MoinGaming) {
    set -u2 %Revo_Submit_Bug $$?="Fill in your bug here"
    ms send Revo -4Bug Report- %Revo_Submit_Bug -Nickalert Script $+(//,$me)
    echo -a 10Thank you for submitting this bug, $me $+ !
  }
  if ($network != CRRPG && $network != TeamDRD && $network != MoinGaming) {
    echo -a Could not submit suggestion/bug due to not being on the correct network.
  }
}
 
alias -l Revo_Send_Bug {
  if ($network == CRRPG || $network == TeamDRD || $network == MoinGaming) {
    ms send Revo -4Bug Report- %tempmsg -Nickalert Script $+(//,$me)
    echo -tnga 10The error generator has alerted Revo of this possible error. Please report this bug with more details if possible with the menu option.
  }
  if ($network != CRRPG || $network != TeamDRD || $network != MoinGaming) {
    echo -a Could not submit suggestion/bug due to not being on the correct network.
  }
}
 
alias -l unsetvar {
  if (%action != $null) { unset %action }
  if (%bywho != $null) { unset %bywho }
  if (%tempchan != $null) { unset %TEMPchan }
  if (%tempmsg != $null) { unset %TEMPmsg }
  if (%knick != $null) { unset %knick }
  if (%prefix != $null) { unset %prefix }
}
 
alias -l Revo_Config_MC {
  Revo_Get_Vars
  set -u2 %playsMC $input(Do you happen to play MineCraft on Contex's MineCraft server?, y, Contex's MC server)
  writeini -n NickAlert.ini Data MineCraft %playsMC
  if (%playsmc) {
    %echo You have indicated you play MineCraft on Contex's MineCraft server. This will be of importance with the Winamp script.
    set -u2 %MCNick $input(What is your nickname in MineCraft?, eo, MineCraft nickname)
    writeini -n NickAlert.ini Data MineCraftNick %MCNick
  }
  if (!%playsmc) {
    %echo You have indicated that you don't play MineCraft on Contex's MineCraft server. This will be of importance with the Winamp script.
  }
}
 
alias -l Revo_Config_Bold {
  Revo_Get_Vars
  set -u2 %bold $input(In the colour converter $+ $chr(44) should bold be stripped? Recommended yes as it will prevent bugs, y)
  writeini -n NickAlert.ini Data Bold %bold
  if (!%bold) { %echo Configured bold, when using the colour converter bold will be included. This may cause some unwanted bugs though, you have been warned. }
  if (%bold) { %echo Configured bold, when using the colour converter bold won't be included. This will fix a majority of the bugs. }
}
 
alias -l Revo_TimeStampColor {
  set -u2 %TimeStampColor $$?="To what color should the timestamps be set? (CTRL+K NUMBER)"
  Revo_ColorIdentify
}
 
;Seen alias
alias -l Revo_Get_Seen_Data {
  Revo_Get_Vars
  var %seenuser = $input(What person their data do you want to fetch?, e, Get seen data)
  if ($readini(NickAlert.ini, Ignore, %seenuser)) { %echo 04ERROR: That nickname was found in your nickalert ignore list, thus it's stats haven't been recorded! | halt }
  var %said = $readini(Seen.ini, %seenuser, Saying)
  var %Mode = $readini(Seen.ini, %seenuser, MODE)
  var %perform = $readini(Seen.ini, %seenuser, Perform)
 
  if (%said == $null && %mode == $null && %perform == $null) { %echo No seen data for03 %seenuser $+ . | halt }
  if (%said == $null) { var %said = 04nothing }
  if (%mode == $null) { var %mode = No modes have been set on %seenuser }
  if (%perform == $null) { var %perform = %seenuser has performed no actions. }
 
  %echo Seen data has been sent to 03@Actions.
  %blankact
  %echoact 14----------------| 04[SEENDATA]11 %seenuser 14|----------------
  %echoact 03[SAID] Nick07 %seenuser has been last seen saying %said $+ .
  %echoact 03[MODES] %mode
  %echoact 03[PERFORMED] %perform
  %blankact
}
 
alias seen {
  if ($1 == $null) { echo -tnga 04ERROR: Syntax: /seen NICKNAME | halt }
  Revo_Get_Vars
  var %seenuser = $upper($left($1, 1)) $+ $right($1, -1)
  if ($readini(NickAlert.ini, Ignore, %seenuser)) { %echo 04ERROR: That nickname was found in your nickalert ignore list, thus it's stats haven't been recorded! | halt }
  var %said = $readini(Seen.ini, %seenuser, Saying)
  var %mode = $readini(Seen.ini, %seenuser, MODE)
  var %perform = $readini(Seen.ini, %seenuser, Perform)
 
  if (%said == $null && %mode == $null && %perform == $null) { %echo No seen data for03 %seenuser $+ . | halt }
  if (%said == $null) { var %said = 04nothing }
  if (%mode == $null) { var %mode = No modes have been set on %seenuser $+ . }
  if (%perform == $null) { var %perform = %seenuser has performed no actions. }
 
  %echo Seen data has been sent to 03@Actions.
  %blankact
  %echoact 14----------------| 04[SEENDATA]11 %seenuser 14|----------------
  %echoact 03[SAID] Nick07 %seenuser has been last seen saying %said $+ .
  %echoact 03[MODES] %mode
  %echoact 03[PERFORMED] %perform
  %blankact
}
 
alias alertall {
 
}
 
;!say, !s, !msg, & /say, /rc, /nc
alias S {
  if ($chan == #crrpg) { msg # !say $1- }
  elseif ($chan == #regs) { msg # !say $1- }
  elseif ($chan == #DRD || $chan == #SaTruck || $chan == #SFRCR) { msg # !msg $1- }
  elseif ($chan == #MineCraft) { msg # !s $1- }
  elseif ($chan != #DRD || $chan != #MineCraft || $chan != #SaTruck || $chan != #CRRPG || $chan != #SFRCR) { msg $chan $1- }
}
 
alias rc {
  msg $iif($me ison #regs, #regs !rc $1-, join #regs)
}
 
alias meadmin { if ($me isop #crrpg) { return 1 } else { return 0 } }
alias fulldate { msg $active Today ( $+ $date $+ ) is a $day , and the time is $time $+ + $+ $gmt $+ GMT.  }
alias date { msg $active (11 $+ $DATE 10 $+ $chr(124)  $+ $TIME(11HH:nn:ss) $+ ) }
alias time { msg $active (11 $+ $DATE 10 $+ $chr(124)  $+ $TIME(11HH:nn:ss) $+ ) }
alias caps { msg $iif($me !ison #regs, #crrpg, #regs) !say {00FF00} $+ $iif($1 != $null, $+($$1, $chr(44))) Please refrain from using caps in the main chat as it is really annoying., Please refrain from using caps in the main chat as it is really annoying.) }
alias e { msg $iif($me !ison #regs, #crrpg, #regs) ! $+ $iif($meadmin, rcon say, say) {00FF00} $+ $iif($1 != $null, $+($$1, $chr(44))) Please speak English in the main chat, use /w or /pm (ID) to speak different languages. }
alias r { msg $iif($me !ison #regs, #crrpg, #regs) ! $+ $iif($meadmin, rcon say, say) {00FF00} $+ $iif($1 != $null, $+($$1, $chr(44))) If someone is breaking the rules, use /report (ID) (reason) to report the player to admins. }
alias question { msg $iif($me !ison #regs, #crrpg, #regs) ! $+ $iif($meadmin, rcon say, say) {00FF00} $+ $iif($1 != $null, $+($$1, $chr(44))) If you have any questions about the rules, or CRRPG in general. Do not hesitate to /newb or /admin it. }
alias newb { msg $iif($me !ison #regs, #crrpg, #regs) ! $+ $iif($meadmin, rcon say, say) {00FF00} $+ $iif($1 != $null, $+($$1, $chr(44))) If you have any question about the gamemode, don't be afraid to ask it in /newb! }
alias nc { msg $iif($me !ison #regs, #crrpg, #regs) ! $+ $iif($meadmin, newb, say {FC7F00}(NEWB CHAT)) $1- }
 
;modes
alias Voice { mode # +vvvvvvvvvvv $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /voice nick nick2 nick3.. } }
alias DeVoice { mode # -vvvvvvvvvvv $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /devoice nick nick2 nick3.. } }
alias Halfop { mode # +hhhhhhhhhhhh $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /halfop nick nick2 nick3.. } }
alias DeHalfop { mode # -hhhhhhhhhhhh $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /dehalfop nick nick2 nick3.. } }
alias Op { mode # +ooooooooooooo $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /op nick nick2 nick3.. } }
alias DeOp { mode # -oooooooooooo $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /deop nick nick2 nick3.. } }
alias Protect { mode # +aaaaaaaaaaaaaa $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /protect nick nick2 nick3.. } }
alias DeProtect { mode # -aaaaaaaaaaaaaa $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /deprotect nick nick2 nick3.. } }
alias Owner { mode # +qqqqqqqqqqqqqq $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /Owner nick nick2 nick3.. } }
alias DeOwner { mode # -qqqqqqqqqqqqqq $1- | if ($1 == $null) { echo -a 04SYNTAX ERROR: /DeOwner nick nick2 nick3.. } }
 
alias -l Revo_ColorIdentify {
  if (00 isin %TimeStampcolor || 0 isin %TimeStampColor) { set %UsedColor white }
  if (01 isin %TimeStampcolor || 1 isin %TimeStampColor) { set %UsedColor black }
  if (02 isin %TimeStampcolor || 2 isin %TimeStampColor) { set %UsedColor blue }
  if (03 isin %TimeStampcolor || 3 isin %TimeStampColor) { set %UsedColor green }
  if (04 isin %TimeStampcolor || 4 isin %TimeStampColor) { set %UsedColor red }
  if (05 isin %TimeStampcolor || 5 isin %TimeStampColor) { set %UsedColor dark red }
  if (06 isin %TimeStampcolor || 6 isin %TimeStampColor) { set %UsedColor purple }
  if (07 isin %TimeStampcolor || 7 isin %TimeStampColor) { set %Usedcolor orange }
  if (08 isin %TimeStampcolor || 8 isin %TimeStampColor) { set %Usedcolor yellow }
  if (09 isin %TimeStampcolor || 9 isin %TimeStampColor) { set %Usedcolor light green }
  if (10 isin %TimeStampcolor) { set %UsedColor blue }
  if (11 isin %TimeStampcolor) { set %UsedColor teal }
  if (12 isin %TimeStampcolor) { set %UsedColor blue }
  if (13 isin %TimeStampcolor) { set %UsedColor pink }
  if (14 isin %TimeStampcolor) { set %UsedColor dark gray }
  if (15 isin %TimeStampcolor) { set %UsedColor light gray }
  if (%TimeStampColor >= 16 || $len(%TimeStampcolor) <= 1 || %TimeStampColor isalpha || $len(%TimeStampColor) >= 6) {
    echo -a 04ERROR: Unknown color / Too high value.
    set %action ERROR
    set %tempmsg You have used a unknown color value when modifying the scripts timestamp colors.
    Revo_Window
  }
  echo -a Successfully set the timestamp colour to %TimeStampColor $+ %UsedColor $+ .
  writeini NickAlert.ini Data TimeStamp %TimeStampColor
  unset %UsedColor
}
 
alias -l Revo_See_Nickalerts {
  Revo_Get_Vars
  set -u3 %TempNick $?="Please enter a name."
  %echo You have been nickalerted 07 $+ $readini(NickAlert.ini, Amount, %TEMPnick) times by 03 $+ %TEMPnick $+ .
}
 
alias nalerted {
  set -u2 %TimeStampColor $readini(NickAlert.ini, Data, TimeStamp)
  if ($1 == $null) { echo -angt 04ERROR: Syntax 09/Nalerted [10NICK09] | halt }
  if ($readini(NickAlert.ini, Amount, $1-) == $null) {
    msg $active You haven't been nickalerted by03 $1- before!
  }
  else if ($readini(NickAlert.ini, Amount, $1-) != $null) {
    msg $active You have been nickalerted 07 $+ $readini(NickAlert.ini, Amount, $1-) times by 03 $+ $1- $+ .
  }
}
 
alias -l Revo_See_Queries {
  Revo_Get_Vars
  set -u3 %TempNick $?="Please enter a name."
  %echo You have been nickalerted 07 $+ $readini(NickAlert.ini, Queries, %TEMPnick) times by 03 $+ %TEMPnick $+ .
}
 
alias queried {
  Revo_Get_Vars
  if ($1 == $null) { echo -angt 04ERROR: Syntax 09/queried [10NICK09] | halt }
  if ($readini(NickAlert.ini, Queries, $1-) == $null) {
    msg $active You haven't been in a conversation with03 $1- before!
  }
  else if ($readini(NickAlert.ini, Queries, $1-) != $null) {
    msg $active You have been in a conversation with03 $1- $+  07 $+ $readini(NickAlert.ini, Queries, $1-) times before.
  }
}
 
alias -l Revo_Get_QueryList {
  Revo_Get_Vars
  set %users 1
  set %totaltemp 1
  set %querylist 07 $+ $ini(NickAlert.ini, Queries, %Users) $+ 06( $+ $readini(NickAlert.ini, Queries, $ini(NickAlert.ini, Queries, %users)) $+ ),
  %echo 02----------------------------| 09[QUERY LIST] 02|----------------------------
  %echoact 02----------------------------| 09[QUERY LIST] 02|----------------------------
  %echo 0411List of all users who have queried you, and how many times they have done so.04
  %echoact 0411List of all users who have queried you, and how many times they have done so.04
  while ($ini(NickAlert.ini, Queries, 0) > %Users) {
    inc %Users
    inc %totaltemp
    set %querylist %querylist 07 $+ $ini(NickAlert.ini, Queries, %Users) 06( $+ $readini(NickAlert.ini, Queries, $ini(NickAlert.ini, Queries, %users)) $+ ),
    if (%totaltemp >= 4) {
      %echo %querylist
      %echoact %querylist
      unset %totaltemp
      unset %querylist
    }
  }
  if (%querylist != $null) {
    %echo %querylist
    %echoact %querylist
    unset %querylist
  }
  %echo 10There are a total of 07 $+ $ini(NickAlert.ini, Queries, 0) $+  10unique users who have queried you.
  %echoact 10There are a total of 07 $+ $ini(NickAlert.ini, Queries, 0) $+  10unique users users who have queried you.
  %blank
  %blankact
}
 
alias QueryList { Revo_Get_QueryList }
 
alias -l Revo_Get_IgnoreList {
  Revo_Get_Vars
  set %users 1
  set %totaltemp 1
  set %IgnoreList %Ignorelist 07 $+ $ini(NickAlert.ini, Ignore, %Users) $+ ,
  %echo 02----------------------------| 09[IGNORELIST] 02|----------------------------
  %echoact 02----------------------------| 09[IGNORELIST] 02|----------------------------
  while ($ini(NickAlert.ini, Ignore, 0) > %Users) {
    inc %Users
    inc %totaltemp
    set %IgnoreList %IgnoreList 07 $+ $ini(NickAlert.ini, Ignore, %Users) $+ ,
    if (%totaltemp >= 4) {
      %echo %ignorelist
      %echoact %IgnoreList
      unset %totaltemp
      unset %ignorelist
    }
  }
  if (%Ignorelist != $null) {
    %echo %IgnoreList
    %echoact %IgnoreList
  }
  %echo 10There are a total of 07 $+ $ini(NickAlert.ini, Ignore, 0) $+  10users ignored.
  %echoact 10There are a total of 07 $+ $ini(NickAlert.ini, Ignore, 0) $+  10users ignored.
  %blank
  %blankact
  unset %IgnoreList
  unset %Users
  unset %totaltemp
}
 
alias nignorelist { Revo_Get_IgnoreList }
 
alias -l Revo_Get_All_Nickalerts {
  Revo_Get_Vars
  var %users = 1
  set %nick 07 $+ $ini(NickAlert.ini,Amount, %users) $+  06 $+ $chr(40) $+ $readini(NickAlert.ini, Amount, $ini(NickAlert.ini,Amount, %users)) $+ $chr(41) $+ ,
  %echo 02----------------------------| 09[NICKALERT LIST] 02|----------------------------
  %echoact 02----------------------------| 09[NICKALERT LIST] 02|----------------------------
  %echo 0411List of all users who have nickalerted you, and how many times they have done so.04
  while ($ini(NickAlert.ini, Amount, 0) > %users) {
    inc %users
    inc %totaltemp
    set %nick %nick 07 $+ $ini(NickAlert.ini,Amount, %users) $+  06 $+ $chr(40) $+ $readini(NickAlert.ini, Amount, $ini(NickAlert.ini,Amount, %users)) $+ $chr(41) $+ ,
    if (%totaltemp >= 5) {
      %echo %nick
      %echoact %nick
      unset %nick
      unset %totaltemp
    }
  }
  if (%nick != $null) {
    %echo %nick
    %echoact %nick
  }
  %echo 10There are a total of 07 $+ $ini(NickAlert.ini, Amount, 0) $+  10unique users who have nickalerted you.
  %echoact 10There are a total of 07 $+ $ini(NickAlert.ini, Amount, 0) $+  10unique users users who have nickalerted you.
  %blank
  %blankact
  unset %nick
  unset %totaltemp
}
 
alias nickalerts { Revo_Get_All_NickAlerts }
 
alias -l Revo_Get_Vars {
  ;Variables loaded, %echo, %scriptname, %scriptversion, %TimeStampColor, %blank,
  ;%blankact, %scriptas, %ignick, %mcnick, %darkengine.
  ;These are set to unset theirselves in 2 seconds.
 
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  Revo_Vars_Version
  Revo_Vars_ScriptName
  Revo_Vars_TimeStamp
  Revo_Vars_AntiSpam
  Revo_Vars_BlankLine
  Revo_Vars_BlankLineAct
}
 
alias -l Revo_Get_Vars_Other {
  Revo_Vars_YourNick
  Revo_Vars_MineCraft
  Revo_Vars_DarkEngine
}
 
alias -l Revo_Vars_Echo { set -u5 %echo $readini(NickAlert.ini, Data, Echo) }
alias -l Revo_Vars_EchoAct { set -u5 %echoact $readini(NickAlert.ini, Data, EchoAct) }
alias -l Revo_Vars_Version { set -u5 %scriptversion $readini(NickAlert.ini, Data, Version) }
alias -l Revo_Vars_ScriptName { set -u5 %scriptname $readini(NickAlert.ini, Data, Name) }
alias -l Revo_Vars_TimeStamp { set -u5 %TimeStampColor $readini(NickAlert.ini, Data, TimeStamp) }
alias -l Revo_Vars_AntiSpam { set -u5 %scriptAS $readini(NickAlert.ini, Data, AntiSpam) }
alias -l Revo_Vars_BlankLine { set -u5 %blank echo -ang 0 }
alias -l Revo_Vars_BlankLineAct { set -u5 %blankact echo -ng @Actions 0 }
alias -l Revo_Vars_MineCraft { set -u5 %MCNick $readini(NickAlert.ini, Data, MineCraftNick) }
alias -l Revo_Vars_YourNick { set -u5 %IGnick $readini(NickAlert.ini, Data, NickName) }
alias -l Revo_Vars_DarkEngine { set -u5 %DarkEngine $readini(NickAlert.ini, Data, DarkEngine) }
 
alias -l Revo_Check_Error {
  if ($readini(NickAlert.ini, Data, Echo) == $null) {
    set -u3 %scripterror Undefined ini entry: Echo not set.
    set -u3 %solution You can try (re)installing the script. Although the script should have resolved the error.
    writeini NickAlert.ini Data Echo echo -nga $readini(NickAlert.ini, Data, TimeStamp) $+ ( $+ $TIME $+ )
    Revo_Generate_Error
  }
  if ($readini(NickAlert.ini, Data, Name) == $null) {
    set -u3 %scripterror Undefined ini entry: ScriptName not set.
    set -u3 %solution You can try (re)installing the script. Although the script should have resolved the error.
    writeini NickAlert.ini Data Name Revo's all in one script  
    Revo_Generate_Error
  }
  if ($readini(NickAlert.ini, Data, Version) == $null) {
    set -u3 %scripterror Undefined ini entry: Version not set.
    set -u3 %solution You can try (re)installing the script. Although the script should have resolved the error.
    writeini NickAlert.ini Data Version Version 3.2
    Revo_Generate_Error
  }
  if ($readini(NickAlert.ini, Data, EchoAct) == $null) {
    set -u3 %scripterror Undefined ini entry: EchoAct not set.
    set -u3 %solution You can try (re)installing the script. Although the script should have resolved the error.
    writeini NickAlert.ini Data EchoAct echo -ng @Actions $readini(NickAlert.ini, Data, TimeStamp) $+ ( $+ $TIME $+ )  
    Revo_Generate_Error
  }
  if ($readini(NickAlert.ini, Data, TimeStamp) == $null) {
    set -u3 %scripterror Undefined ini entry: TimeStamp not set.
    set -u3 %solution You can try (re)installing the script, or select the option to set the TimeStamp in the menu. Although the script should have resolved the error.
    writeini NickAlert.ini Data TimeStamp 10  
    Revo_Generate_Error
  }
  if (!$readini(NickAlert.ini, Data, DarkEngine)) {
    set -u3 %scripterror DLL file for DarkEngine nonexistant
    set -u3 %solution Download DarkEngine's DLL (10http://rapidshare.com/files/175378460/dark.zip03) and put it in $mircdir $+ .
    Revo_Generate_Error
  }
}
 
alias -l Revo_Generate_Error {
  set %action ERROR
  set %tempmsg The script has generated the following error:04 %scripterror $+ 03 $&
    The script provides you with the following solution:10 %solution $+ 03
 
  set -u3 %totalerrors $calc($readini(NickAlert.ini, Total, Errors)+1)
  if (%totalerrors == $null) { set -u3 %totalerrors 1 }
  writeini NickAlert.ini Total Errors %totalerrors
 
  if (%solution == $null || %scripterror == $null) {
    set %tempmsg The script has received a unknown error, thus cannot provide you with any solution.
    Revo_Send_Bug
  }
  Revo_Window
}
 
alias -l Revo_Ignore_Bots {
  $iif(!$readini(NickAlert.ini, Enabled, BotIgnore), writeini -n NickAlert.ini Enabled BotIgnore $true, writeini -n NickAlert.ini Enabled BotIgnore $false)
  $iif($readini(NickAlert.ini, Enabled, BotIgnore), echo -tnga Enabled ignoring of IRC bots., echo -tnga Disabled ignoring of IRC bots.)
 
  Revo_Vars_EchoAct
  Revo_Vars_Echo
 
  %echoact $iif($readini(NickAlert.ini, Enabled, BotIgnore), 07[ENABLED]03 Enabled ignoring of IRC bots., 07[DISABLED]03 Disabled ignoring of IRC bots.)
 
  if ($readini(NickAlert.ini, BotIgnore, 1) != $null) { var %ignoredbots = $ini(NickAlert.ini, BotIgnore, 0) }
  if ($readini(NickAlert.ini, BotIgnore, 1) == $null) { var %ignoredbots = 0 }
  if (%ignoredbots <= 13) {
    writeini -n NickAlert.ini BotIgnore Robo-Cop $true
    writeini -n NickAlert.ini BotIgnore Robo-Thief $true
    writeini -n NickAlert.ini BotIgnore DRDCNR1 $true
    writeini -n NickAlert.ini BotIgnore DRDCNR2 $true
    writeini -n NickAlert.ini BotIgnore DRDCNR3 $true
    writeini -n NickAlert.ini BotIgnore DRDTR1 $true
    writeini -n NickAlert.ini BotIgnore DRDTR2 $true
    writeini -n NickAlert.ini BotIgnore StatServ $true
    writeini -n NickAlert.ini BotIgnore AdminBot $true
    writeini -n NickAlert.ini BotIgnore RegularBot $true
    writeini -n NickAlert.ini BotIgnore CRRPG $true
    writeini -n NickAlert.ini BotIgnore Xenton $true
    writeini -n NickAlert.ini BotIgnore Ashley $true
    writeini -n NickAlert.ini BotIgnore NamBob $true
    %echo Ignored a total of07 $ini(NickAlert.ini, BotIgnore, 0) bots.
    %echoact 07[BOT IGNORE] Ignored a total of07 $ini(NickAlert.ini, BotIgnore, 0) bots.
  }
}
 
alias -l Revo_Install_script {
  NickAlertNickName
  CheckNA2
  if (%checkNA2) { /NickalertNickName2 }
  ;NickAlertAntiSpam
 
  Revo_Popup
  Revo_TimeStampColor
 
  Revo_Config_Bold
  Revo_Config_MC
  Revo_Check_DarkEngine
  writeini -n NickAlert.ini Data CustomNick $input(What is your custom nickname for nick changes?, e, Configure Custom nickname)
 
  ;Writing basic variables.
  var %sexwithleonardo = ( $chr(36) $+ + $chr(36) $+ TIME $chr(36) $+ + )
  writeini -n NickAlert.ini Data Echo echo -nga $readini(NickAlert.ini, Data, TimeStamp) $+ %SexWithLeonardo
  writeini -n NickAlert.ini Data EchoAct echo -g @Actions $readini(NickAlert.ini, Data, TimeStamp) $+ %SexWithLeonardo
  writeini -n NickAlert.ini Data Version Version 3.4
  writeini -n NickAlert.ini Data Name Revo's all in one script
  writeini -n NickAlert.ini Data AntiSpam 8
  writeini -n NickAlert.ini Data AwayTime 30
  writeini -n NickAlert.ini Data NickName $me
  writeini -n NickAlert.ini Data CTCPonQuery $false ;$input(Get information from users who query you?, y, CTCP on query)
  writeini -n NickAlert.ini Data TogActive $input(Get nickalerted in active windows?, y, Active channel nickalerts!)
 
  if ($readini(NickAlert.ini, Total, PenaltiesIRPG) == $null) { writeini -n NickAlert.ini Total PenaltiesIRPG 0 }
  if ($readini(NickAlert.ini, Total, IRPGLogout) == $null) { writeini -n NickAlert.ini Total IRPGLogout 0 }
  if ($readini(NickAlert.ini, Total, IRPGLogin) == $null) { writeini -n NickAlert.ini Total IRPGLogin 0 }
 
  if ($readini(NickAlert.ini, Total, HighestUptime) == $null) { writeini -n NickAlert.ini Total HighestUptime 0 }
 
  ;Enabling every command, and their responsible menu.
  writeini -n NickAlert.ini Enabled SlapBack $true
  writeini -n NickAlert.ini Enabled Winamp $true
  writeini -n NickAlert.ini Enabled NickAlert $true
  writeini -n NickAlert.ini Enabled AutoAway $true
  writeini -n NickAlert.ini Enabled CustomMSG $true
  writeini -n NickAlert.ini Enabled Echo $true
  writeini -n NickAlert.ini Enabled BotIgnore $input(Do you wish to ignore IRC bots for the nickalerts?, y, Ignore IRC Bots)
  writeini -n NickAlert.ini Enabled EchoPMs $input(Do you wish to echo queries to important channels?, y, Echo Queries)
  writeini -n NickAlert.ini Enabled PMColour $true
  writeini -n NickAlert.ini Enabled KDlog $true
 
  writeini -n NickAlert.ini Menu NickAlert $true
  writeini -n NickAlert.ini Menu ColourConverter $true
  if ($readini(NickAlert.ini, Data, BBCnotes) == $null) {
    BBCnotes
  }
  writeini -n NickAlert.ini Menu Winamp $true
  writeini -n NickAlert.ini Menu AutoAway $true
  writeini -n NickAlert.ini Menu Uptime $true
  writeini -n NickAlert.ini Menu IRPG $true
  writeini -n NickAlert.ini Menu NickChanges $true
  writeini -n NickAlert.ini Menu Seen $true
 
  if ($exists($mircdirdeultimate.dll)) { writeini -n NickAlert.ini Menu DarkEngine $true }
  if (!$exists($mircdirdeultimate.dll)) { writeini -n NickAlert.ini Menu DarkEngine $false | echo -a DarkEngine's responsible DLL file could not be found. (DeUltimate.dll) | echo -a Get the file at 10http://rapidshare.com/files/175378460/dark.zip03 (Place it in10 $mircdir $+ 03) and enable the menu option manually or re-run the install. }
 
  if ($readini(NickAlert.ini, Total, Ignored) == $null) { writeini -n NickAlert.ini Total Ignored $iif($ini(NickAlert.ini, Ignore, 0) != $null, $ini(NickAlert.ini, Ignore, 0), 0)  }
  if ($readini(NickAlert.ini, Total, Users) == $null) { writeini -n NickAlert.ini Total Users 0 }
  if ($readini(NickAlert.ini, Total, Installed) == $null) { writeini -n NickAlert.ini Total InstalledCTIME $ctime }
 
  ;Writing stats
  if ($readini(NickAlert.ini, Total, Opped) == $null) { writeini -n NickAlert.ini Total Opped 0 }
  if ($readini(NickAlert.ini, Total, DeOpped) == $null) { writeini -n NickAlert.ini Total Deopped 0 }  
  if ($readini(NickAlert.ini, Total, DeHalfOpped) == $null) { writeini -n NickAlert.ini Total Dehalfopped 0 }
  if ($readini(NickAlert.ini, Total, HalfOpped) == $null) { writeini -n NickAlert.ini Total Halfopped 0 }
  if ($readini(NickAlert.ini, Total, DeVoiced) == $null) { writeini -n NickAlert.ini Total Voiced 0 }
  if ($readini(NickAlert.ini, Total, Voiced) == $null) { writeini -n NickAlert.ini Total DeVoiced 0 }
  if ($readini(NickAlert.ini, Total, Protected) == $null) { writeini -n NickAlert.ini Total Protected 0 }
  if ($readini(NickAlert.ini, Total, DeProtected) == $null) { writeini -n NickAlert.ini Total DeProtected 0 }
 
  ;Unsetting variables.
  if (%RevoAntiSpam != $null) { unset %RevoAntiSpam }
  unsetvar
 
  Revo_Check_Error
  Revo_Get_Vars
 
  %blank
  %Echo 03 $+ %ScriptName %ScriptVersion 03has successfully been installed. And is ready for use.
  %EchoAct 07[SUCCESS] 10 $+ %ScriptName %ScriptVersion 03has successfully been installed. And is ready for use.
  writeini -n NickAlert.ini Total Installed $true
 
  Revo_Detailed_ScriptInfo
 
  Revo_Script_Credits
  Revo_Install_Script_ERRORCHECK
}
 
alias -l Revo_install_Script_ERRORCHECK {
  if (!$readini(NickAlert.ini, Data, Echo) || !$readini(NickAlert.ini, Data, EchoAct) || !$readini(NickAlert.ini, Data, TimeStamp) || !$readini(NickAlert.ini, data, version) || !$readini(NickAlert.ini, Data, Name)) {
    var %sexwithleonardo = ( $chr(36) $+ + $chr(36) $+ TIME $chr(36) $+ + )
    writeini -n NickAlert.ini Data Echo echo -nga $readini(NickAlert.ini, Data, TimeStamp) $+ %SexWithLeonardo
    writeini -n NickAlert.ini Data EchoAct echo -g @Actions $readini(NickAlert.ini, Data, TimeStamp) $+ %SexWithLeonardo
    writeini -n NickAlert.ini Data Version Version 3.4
    writeini -n NickAlert.ini Data Name Revo's all in one script
    var %errorcheck = success
  }
  if (%errorcheck == success) { echo -a Successfully corrected existing errors within the script. }
  if (!%errorcheck) { echo -a There were no errors found within the script. }
}
 
alias spam {
  if ($1 == msg || $1 == message) {
    if ($2 !isnum) {
      Revo_Vars_Echo
      %echo 04ERROR:03 Syntax: /spam (10REPEAT $CHR(124) REVREP $CHR(124) MSG $CHR(124) MESSAGE03) (10AMOUNT03) (10MESSAGE03)
      halt
    }
    if ($2 isnum) {
      if ($2 >= 11) {
        var %incby = 10
        Revo_Vars_EchoAct
        %echoact 07[SPAMERROR] 03Parameter 2 has been reduced to 071003 due to the amount being too big 03(10 $+ $2 $+ 03).
      }
      if ($2 <= 10) {
        var %incby = $2
      }
      if ($3 == $null) {
        Revo_Vars_Echo
        %echo 04ERROR:03 Syntax: /spam (10REPEAT $CHR(124) REVREP $CHR(124) MSG $CHR(124) MESSAGE03) (10AMOUNT03) (10MESSAGE03)
        halt    
      }
      if ($3 != $null) {
        var %SendWhat = $3-
        var %incamnt = 0
        while (%incamnt <= $calc(%incby - 1)) {
          inc %incamnt
          msg # $3-
        }
        Revo_Vars_EchoAct
        %echoact 07[SPAM] 03You have sent07 %incby 03messages to10 $active $+ 03.
        unset %incamnt
        unset %incby
      }
    }
  }
  if ($1 == repeat) {
    if ($2 !isnum) {
      Revo_Vars_Echo
      %echo 04ERROR:03 Syntax: /spam (10REPEAT $CHR(124) REVREP $CHR(124) MSG $CHR(124) MESSAGE03) (10AMOUNT03) (10MESSAGE03)
      halt  
    }
    if ($2 isnum) {
      if ($2 >= 12) {
        var %incby = 10
        Revo_Vars_EchoAct
        %echoact 07[SPAMERROR] 03Parameter 2 has been reduced to 071003 due to the amount being too big 03(10 $+ $2 $+ 03).
      }
      if ($2 <= 11) {
        var %incby = $2
      }
      if ($3 == $null) {
        Revo_Vars_Echo
        %echo 04ERROR:03 Syntax: /spam (10REPEAT $CHR(124) REVREP $CHR(124) MSG $CHR(124) MESSAGE03) (10AMOUNT03) (10MESSAGE03)
        halt
      }
      if ($3 != $null) {
        var %SendWhat = $3-
        var %incamnt = 0
        while (%incamnt <= $calc(%incby - 1)) {
          inc %incamnt
          msg $active %SendWhat
          var %SendWhat = %SendWhat $3-
        }
        Revo_Vars_EchoAct
        %echoact 07[SPAM] 03You have sent07 %incby 03messages to10 $active $+ 03.
        unset %incamnt
        unset %incby
      }
    }
  }
  if ($1 == revrep) {
    if ($2 !isnum) {
      Revo_Vars_Echo
      %echo 04ERROR:03 Syntax: /spam (10REPEAT $CHR(124) REVREP $CHR(124) MSG $CHR(124) MESSAGE03) (10AMOUNT03) (10MESSAGE03)
      halt  
    }
    if ($2 isnum) {
      if ($2 >= 11) {
        var %incby = 10
        Revo_Vars_EchoAct
        %echoact 07[SPAMERROR] 03Parameter 2 has been reduced to 071003 due to the amount being too big 03(10 $+ $2 $+ 03).
      }
      if ($2 <= 10) {
        var %incby = $2
      }
      if ($3 == $null) {
        Revo_Vars_Echo
        %echo 04ERROR:03 Syntax: /spam (10REPEAT $CHR(124) REVREP $CHR(124) MSG $CHR(124) MESSAGE03) (10AMOUNT03) (10MESSAGE03)
        halt
      }
      if ($3 != $null) {
        var %i = $2
        while (%i >= 1) {
          msg $active $str($3- $+ $chr(32), %i)
          dec %i
        }
        Revo_Vars_EchoAct
        %echoact 07[SPAM] 03You have sent07 %incby 03messages to10 $active $+ 03.
      }
    }
  }
  if ($1 != repeat && $1 != msg && $1 != message && $1 != revrep) {
    Revo_Vars_Echo
    %echo 04ERROR:03 Syntax: /spam (10REPEAT $CHR(124) REVREP $CHR(124) MSG $CHR(124) MESSAGE03) (10AMOUNT03) (10MESSAGE03)
    halt
  }
}
 
alias -l Revo_Read_Notes {
  Revo_Get_Vars
  var %lines = $lines(Notes.txt)
  var %linesinc = 0
  %blankact
  while (%LinesInc <= $calc(%lines - 1)) {
    inc %linesInc
    %echoact 07[READ Ln %linesinc $+ ] $read(Notes.txt, %linesinc)
  }
 
  %echoact 07[READ] A total of07 %lines notes have been echo'd.
  %blankact
  %echo Played07 %lines notes to 03@Actions.
}
 
alias Revo_Encode {
  return _$ $+ $replacecs($1-, a, b, c, d, e, +, f, $, g, $chr(35), h, &, i, I, j, p, k, l, m, n, O, @$&, Q, @@, r, *$, t, (@), x, X, z, ^, !, Z, U, _, D, 9, 1, 2, 3, 4, 5, 6, 9, 8, 7, 0, $chr(32), ', l, -, o, .)
}
 
alias Revo_Decode {
  if ($left($1-, 2) == _$) {
    return $replacecs($1-, b, a, d, c, +, e, $, f, $chr(35), g, &, h, I, i, p, j, l, k, n, m, @$&, O, @@, Q, *$, r, (@), t, X, x, ^, z, Z, !, _, U, 9, D, 2, 1, 4, 3, 6, 5, 8, 9, 0, 7, ', $chr(32), -, l, ., o)
  }
  else {
    return Unable to decode. Attempt: $replacecs($1-, b, a, d, c, +, e, $, f, $chr(35), g, &, h, I, i, p, j, l, k, n, m, @$&, O, @@, Q, *$, r, (@), t, X, x, ^, z, Z, !, _, U, 9, D, 2, 1, 4, 3, 6, 5, 8, 9, 0, 7, ', $chr(32), -, l, ., o)
  }
}
 
alias -l Revo_Window {
  if ( $window(@Actions) == $null ) { window -e0z @Actions | echo @Actions $timestamp You have entered the window 3@Actions, All your parts, kicks, invites, nickalerts and more will be logged here. }
 
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  Revo_Vars_TimeStamp
 
  if (%action == PART) { %echoact 07[PART] 03You parted from10 %TEMPchan 03(Network10 $network $+ 03) }
  if (%action == JOIN) { %echoact 07[JOIN] 03You have joined10 %TEMPchan 03(Network10 $network $+ 03) }
  if (%action == KICK) { %echoact 07[KICK] 03You got kicked from10 %TEMPchan 3by10 %bywho 3(Network10 $network $+ 3) }
  if (%action == INVITE) { %echoact 07[INVITE] 03You got invited to10 %TEMPchan 3by10 %bywho 3(Network10 $network $+ 3) }
  if (%action == ACTION) { %echoact 07[ACTION] 03Your nick has been mentioned in a action in $+ 10 %TEMPchan 3by10 %bywho 3(Network10 $network $+ 3) | echo @Actions 10( $+ $TIME $+ ) 7[ACTION]3 Message: 6 $+ %TEMPmsg  }
  if (%action == LOGON) { %echoact 07[LOGON] 03Logged in as10 %bywho $+ 03. }
  if (%action == OPEN) { %echoact 07[OPEN] 03Opened10 %TEMPchan $+ 03. }
  if (%action == CLOSE) { %echoact 07[CLOSE] 03Closed10 %TEMPchan $+ 03. }
  if (%action == CONNECT) { %echoact 07[CONNECT] 03Successfully connected to10 %TEMPchan $+ 03. }
  if (%action == CTCP) { %echoact 07[CTCP] 10 $+ %bywho $+ 03 has CTCP'd you. (10 $+ %tempmsg $+ 03). }
  if (%action == DISCONNECT) { %echoact 07[DISCONNECT] 03Disconnected from10 %TEMPchan $+ 03. }
  if (%action == ERROR) { %echoact 07[ERROR]03 %tempmsg | beep 3 | echo -a There is a error in the 04nickalert script, see the 03@Actions window for more details. }
  if (%action == GHOST) { %echoact 07[GHOST]03 You have killed/ghosted10 %bywho $+ 03 on10 %TEMPchan $+ 03. }
  if (%action == NICK STEAL) { %echoact 07[NICK STEAL]10 %bywho $+ 03 (now known as10 %tempmsg $+ 03) is using your nickname on10 %TEMPchan $+ 03. }
  if (%action == NICK) { %echoact 07[NICK]03 You have changed your nick from10 $me 03to10 %bywho $+ 03. (Network10 %TEMPchan $+ 03) }
  if (%action == MEMO) { %echoact 07[MEMO]03 %tempmsg }
  if (%action == MODE) { %echoact %prefix %tempmsg $+ 03. }
  if (%action == ANTISPAM) { %echoact 07[ANTISPAM]10 %bywho 03tried to nickalert you but the antispam was still active. (10 $+ %tempmsg $+ $iif(!%tempmsgnull, ...) $+ 03) }
  if (%action != $null) { unsetvar | halt }
  if ($len($chan) > 2) {
    %echoact 7[NICKALERT]10 $nick 3has alerted you in10 $chan $+ 3. You have been nickalerted10 $readini(NickAlert.ini, Total, Nickalerts) 3times. (Network10 $network $+ 3)  
    if (%TEMPmsg != $null) {
      %echoact 7[NICKALERT]3 Message: 10 $+ %TEMPmsg 
    }
    if (%TEMPmsg == $null) {
      %echoact 7[NICKALERT]3 Message: 10 $+ No message attached.
    }  
    if ($readini(NickAlert.ini, Amount, $nick) == $null) {
      %echoact You haven't been nickalerted by03 $nick before!
    }
    else if ($readini(NickAlert.ini, Amount, $nick) != $null) {
      %echoact 7[NICKALERT]10 $nick $+  03has nickalerted you 10 $+ $readini(NickAlert.ini, Amount, $nick) $+  03times.
    }
    unsetvar  
    set -u5 %RevoAntispam 1
    halt
    } elseif ($len($chan) <= 2) {
    if ($nick == $activeg) { halt }
    if (!%NickAlert.Query.Antispam) {
      set -u8 %NickAlert.Query.Antispam $true
      %echoact 7[NICKALERT]10 $nick 3has alerted you in10 a query $+ 3. You have been nickalerted10 $readini(NickAlert.ini, Total, Nickalerts) 3times. (Network10 $network $+ 3)  
      if (%TEMPmsg != $null) {
        %echoact 7[NICKALERT]3 Message: 10 $+ %TEMPmsg 
      }
      if (%TEMPmsg == $null) {
        %echoact 7[NICKALERT]3 Message: 10 $+ No message attached.
      }  
      if ($readini(NickAlert.ini, Amount, $nick) == $null) {
        %echoact You haven't been nickalerted by03 $nick before!
      }
      else if ($readini(NickAlert.ini, Amount, $nick) != $null) {
        %echoact 7[NICKALERT]10 $nick $+  03has nickalerted you 10 $+ $readini(NickAlert.ini, Amount, $nick) $+  03times.
      }
    }
    unsetvar
    set -u5 %RevoAntispam 1
    halt
    } elseif ($len($chan) == $null) {
    %echoact 7[NICKALERT]10 $nick 3has alerted you in10 a unknown window $+ 3. You have been nickalerted10 $readini(NickAlert.ini, Amount, $nick) 3times. (Network10 $network $+ 3)  
    if (%TEMPmsg != $null) {
      %echoact 7[NICKALERT]3 Message: 10 $+ %TEMPmsg 
    }
    if (%TEMPmsg == $null) {
      %echoact 7[NICKALERT]3 Message: 10 $+ No message attached.
    }
    if ($readini(NickAlert.ini, Amount, $nick) == $null) {
      %echoact You haven't been nickalerted by03 $nick before!
    }
    else if ($readini(NickAlert.ini, Amount, $nick) != $null) {
      %echoact 7[NICKALERT]10 $nick $+  03has nickalerted you 10 $+ $readini(NickAlert.ini, Total, Nickalerts) $+  03times.
    }
    unsetvar
    set -u5 %RevoAntispam 1
  }
}
 
alias -l Revo_Detailed_ScriptInfo {
  Revo_Get_Vars
  %echo 09Script information echo'd to 03@Actions09.
  %blankact
  %echoact 07[SCRIPT INFORMATION]
  %echoact 11Your nickalert nick is7 $readini(NickAlert.ini, Data, NickName1) $+ 11. Secondary nickalert nick is7 $readini(NickAlert.ini, Data, NickName2) $+ 11. You have been nickalerted7 $readini(NickAlert.ini, Total, NickAlerts) 11times. Your antispam is set to7 $readini(NickAlert.ini, Data, AntiSpam) 11seconds.
  %echoact 11You have a total of 07 $+ $readini(NickAlert.ini, Total, Ignored) $+ 11 users ignored and I have been nickalerted by07 $readini(NickAlert.ini, Total, Users) $+ 11 unique users.
  %echoact 11You have opened a total of7 $ini(NickAlert.ini, Queries, 0) 11queries, you have been alerted in7 $readini(NickAlert.ini, Total, Action) 11actions.
  %echoact 11Enabled commands: 03Autoaway: $readini(NickAlert.ini, Enabled, AutoAway) $+ , Winamp Script: $readini(NickAlert.ini, Enabled, Winamp) $+ .
  %echoact 11Enabled commands: 03NickAlert: $readini(NickAlert.ini, Enabled, NickAlert) $+ , Auto slapback: $Readini(NickAlert.ini, Enabled, SlapBack) $+ .
  %echoact 11Enabled commands: 03Seen: $readini(NickAlert.ini, Enabled, Seen) $+ , DarkEngine: $readini(NickAlert.ini, Data, DarkEngine) $+ .
  %blankact
}
 
alias -l Revo_Change_Nick {
  var %i = $input(What will be your nickname(Across all networks)?, e, Change nicknames on all Networks.), %x = 1
  while ($scon(%x)) {
    scon %x nick %i
    inc %x
    if (%x >= 15) { echo -a Exceeding spam limit. Cutting off while loop. Report this as a bug if it broke. | break }
  }
}
 
alias nickall {
  var %x = 1, %i = $1-
  while ($scon(%x)) {
    scon %x nick %i
    inc %x
    if (%x >= 15) { echo -a Exceeding spam limit. Cutting off while loop. Report this as a bug if it broke. | break }
  }
}
 
alias -l Revo_Custom_Nick {
  if ($readini(NickAlert.ini, Data, CustomNick) != $null) {
    nick $readini(NickAlert.ini, Data, CustomNick)
  }
  if (!$readini(NickAlert.ini, Data, CustomNick) != $null) {
    echo -a 04ERROR: There is no custom nick specified, please fill it in now!
    writeini -n NickAlert.ini Data CustomNick $input(What is your custom nickname?, e, Configure Custom nickname)
    nick $readini(NickAlert.ini, Data, CustomNick)
  }
}
 
alias BBCNotes {
  if ($readini(NickAlert.ini, Data, BBCnotes) == $null) { echo -a Configured BBCnotes: Disabled! | writeini -n NickAlert.ini Data BBCnotes $false | halt }
  if ($readini(NickAlert.ini, Data, BBCnotes)) {
    writeini -n NickAlert.ini Data BBCnotes $false
    echo -tnga Notes to BBCode rather than IRC disabled!
    halt
  }
  if (!$readini(NickAlert.ini, Data, BBCnotes)) {
    writeini -n NickAlert.ini Data BBCnotes $true
    echo -tnga Notes to BBCode rather than IRC enabled!
    halt
  }
}
 
alias -l Revo_Colour_Converter {
  if ($cb != $null) { var %istrue = $input(Do you want to use the information on your clipboard?, y, Revo's colour converter in mIRC) }
  if (%istrue) {
    set %outputcode $cb
  }
  if (!%istrue) {
    set %outputcode $input(Please enter what you want to convert to BBCode., eo, Revo's colour converter in mIRC)
  }
  if (%outputcode == $null) { echo -tnga 04ERROR: You have not entered anything in the input box, halting script. | halt }
  if (10 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 10, [color=blue]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (11 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 11, [color=teal]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (12 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 12, [color=blue]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (13 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 13, [color=pink]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (14 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 14, [color=grey]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (15 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 15, [color=grey]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (00 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 00, [color=white]) | set %outputcode $replace(%outputcode, 0, [color=white]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (01 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 01, [color=black]) | set %outputcode $replace(%outputcode, 1, [color=black]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (02 isin %outputcode || 2 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 02, [color=navy]) | set %outputcode $replace(%outputcode, 2, [color=navy]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (03 isin %outputcode || 3 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 03, [color=green]) | set %outputcode $replace(%outputcode, 3, [color=green]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (04 isin %outputcode || 4 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 04, [color=red]) | set %outputcode $replace(%outputcode, 4, [color=red]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (05 isin %outputcode || 5 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 05, [color=red]) | set %outputcode $replace(%outputcode, 5, [color=red]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (06 isin %outputcode || 6 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 06, [color=purple]) | set %outputcode $replace(%outputcode, 6, [color=purple]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (07 isin %outputcode || 7 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 07, [color=orange]) | set %outputcode $replace(%outputcode, 7, [color=orange]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (08 isin %outputcode || 8 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 08, [color=yellow]) | set %outputcode $replace(%outputcode, 8, [color=yellow]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if (09 isin %outputcode || 9 isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, 09, [color=green]) | set %outputcode $replace(%outputcode, 9, [color=green]) }
  if (%colorset == 2) { unset %colorset | %outputcode = [/color] $+ %outputcode }
  if ( isin %outputcode) { inc %colourset | set %outputcode $replace(%outputcode, , [/color]) }
 
  if (!$readini(NickAlert.ini, Data, Bold)) {
    while ( isin %outputcode) {
      inc %coloursetb
      if (%coloursetb < 2) {
        set %outputcode $replace(%outputcode, , [b])
        unset %coloursetb
      }
      if (%coloursetb >= 2) {
        set %outputcode $replace(%outputcode, , [/b])
      }
    }
  }
  else if ($readini(NickAlert.ini, Data, Bold)) {
    set %outputcode $replace(%outputcode, , $null)
  }
 
  if ([/color] == $right(%outputcode, 8)) {
    echo -a $left(%outputcode, -8)
  }
  if ([/color] != $right(%outputcode, 8)) {
    echo -a %outputcode
  }
 
  if (!$exists($mircdir $+ /Converter.txt)) { echo -tnga 04ERROR: Converter.txt hasn't been made yet, creating it now. }
  write $mircdir $+ /Converter.txt ( $+ $DATE $chr(124) $TIME $+ ) %outputcode
 
  unset %outputcode
  unset %colourset
  unset %colorset
  unset %coloursetb
}
 
alias -l Revo_Script_Help {
  Revo_Get_Vars
 
  %echo 09Script help successfully echo'd to 03@Actions09.
 
  %echoact 04|_____ Script helping section - Complete list _____|
  %blankact
  %echoact 04|_ Script helping section - Command list _|
  %echoact 11Short commands: nalerted 11[nick], nignorelist, nignore 11[nick], nunignore 11[nick], queried 11[nick], nickall 11[nick].
  %echoact 11Short commands: 3spam (10REPEAT | MSG | MESSAGE03) (10AMOUNT03) (10MESSAGE03),
  %echoact 11Short commands: /sayx & /echox (what) (user,user,user,user), /inviteall (channel), /nickalertall (channel)
  %echoact 11Short commands: /urban & /slang (definition/dictionary lookup).
  %blankact
 
  %echoact 15|_ Menu Options _|
  %echoact You can disable or enable menu options using Right Click in a window, channel or userlist.
  %blankact
 
  %echoact 14|_Winamp Script by Revo._|
  %echoact 15To use this script, simply go ingame and type "wamp". this works with both /ircpm and normal game chat.
  %echoact 15This version includes wamp in Regular chat!
  %echoact 15Having the minecraft option enabled, this will also work on Contex's MineCraft server, given you are on the MoinGaming network.
  %blankact
 
  %echoact 06|_ Antislap script by Revo _|
  %echoact The antislap is nothing special, just for those who are interested, or didn't have one before.
  %echoact It features three default slapbacks, I could give the user default options
  %echoact but it's better to get a specialised script if you want more flexibility.
  %blankact
 
  %echoact 09|_ Auto Away script _|
  %echoact The Auto Away script will simply do a "/nick $me $+ [AFK]" command when your idle time is above 25 minutes.
  %echoact I already had this coded for one of my previous projects, the Task Force onduty script. I merged it into this script.
  %echoact /AFK: Makes you go afk. /Back: Makes you return.
  %blankact
 
  %echoact 02|_ Spam Script _|
  %echoact Simple spam script that listens to the 3/spam (10REPEAT | MSG | MESSAGE03) (10AMOUNT03) (10MESSAGE03) parameter
  %echoact All it does is spam.
  %echoact Made by 03Revo.
  %blankact
 
  %echoact There's many more unmentioned stuff. You will find it out along the way of using this script.
  %echoact They usually come with syntax errors so you immediately know how to use them.
  %blankact
}
 
alias -l Revo_Script_Credits {
  Revo_Get_Vars
 
  %echo 09Script credits successfully echo'd to 03@Actions09.
 
  %blankact
  %echoact 09|_Credits %ScriptName %ScriptVersion $+ _|
  %echoact 00This script was created from the scratch by 03Revo.
  %echoact 00Thanks to 03Someone for helping me print out the top5 and top 10 of the nickalert.
  %echoact 00Also thanks to 03Leonardo and 03Paranoid for bug testing the script.
  %echoact 00And everyone else who used my previous nickalert for testing that.
  %blankact
 
  %echoact 11|-- 14Winamp Script credits11 --|
  %echoact 00Main script by 03Revo, helpful tips from 03Bobman.
  %echoact 00Huge thanks to the creator of the DarkEngine DLL,
  %echoact 00Thanks to everyone who helped testing it.
  %blankact
 
  %echoact 11|-- 12Other small functions11 --|
  %echoact Other small things (Such as the #regs echo, winamp script edit) are mostly scripted by me.
  %blankact
 
  %echoact 10|-- 0Seen script 10--|
  %echoact Completely coded by Revo.
  %blankact
 
  %echoact 04|-- 05Auto away script.04 --|
  %echoact 00Entirely coded by 03Revo.
  %echoact 00Thanks to everyone within the Task Force who helped me test it.
  %blankact
 
  %echoact 09|-- Power Script --|
  %echoact Thanks to03 Hawkee (http://www.hawkee.com/snippet/6551/) for the power script.
  %blankact
 
  %echoact 13|-- DarkEngine Script --|
  %echoact Full credits to the authors of the DarkEngine (Version 4.0) code. I only made slight modifications.
  %echoact More information found here 10http://www.hawkee.com/snippet/5512/
  %blankact
 
  %echoact 11|-- Urban Dictionary script --|
  %echoact Full credits to the author of the urban script.
  %echoact Small edits for single-user use by Revo.
  %echoact I could not find the Hawkee link, but it's on Hawkee if you want the full unedited version!
  %blankact
 
  %echoact 11|-- Google scripts --|
  %echoact Full credits to the author of the google search script. (http://www.hawkee.com/snippet/14/)
  %echoact Small edits for single-user use by Revo.
  %blankact
  %echoact Full credits to the author of the google calculator script. (http://www.hawkee.com/snippet/9170/)
  %echoact Small edits for single-user use and script compabality by Revo.
 
 
  %echoact 03|-- Script beta tests --|
  %echoact Thanks to Leonardo, IceCold, Vedang, Paranoid & Future for beta testing the script and reporting bugs.
  %echoact While the script still has a good amount of bugs, it's good enough to exit the beta phase.
}
 
alias -l Revo_Script_Changelog {
  Revo_Get_Vars
  %echo Changelog has been sent to 03@Actions.
  %blankact
  %echoact 4|_ Changelog %scriptname %scriptversion _|
  %echoact Updated to 3.4
  %echoact Added getPrefix and getMode aliases.
  %echoact Added SuperSpam alias, (Functions as /spam repeat 11 message + /spam reversed repeat 10 message)
  %echoact Added "/tkb <NICKNAME> <OPTIONAL:[-i]TIME> <OPTIONAL:REASON>".
  %echoact Added $ $+ getBots(channel), retrieves bots, can be used in if($ $+ getbots(channel) isin $ $+ nick) execute code.
  %echoact This will not mess up scripts checking for Regularbot in Regs, or adminbot in oper incase of bot-failure
  %echoact Updated menu (Get updates).
  %echoact Small bugfixes in the script.
 
  %blankact
  %echoact 10|_ Previous versions %scriptname _|
  %echoact Transfered the script in a allround system rather than nickalert.
  %echoact Made CTCP on query a option rather than always true.
  %echoact Allowed menu hide/show options, disable and enabling of certain functions within the script.
  %echoact Made a small error-detection in the script to get some easy-to-fix issues solved by the script.
  %echoact Made the changelog.
  %echoact Added in DarkEngine support
  %echoact Regular echos
  %echoact More menu options
  %echoact Fixed bugs within the stats.
  %echoact General bug fixes.
  %echoact Added /nickall (changing nick on every network) and some other small commands.
  %echoact Added more custom nicknames o.o
  %echoact Added a /seen command that stalks players.
  %echoact Added supportive commands to disable and enable logging of the new commands.
  %echoact Fixed submit bug error and added changelog to menu.
  %echoact /CTCP Nick SCRIPT to see if they are using this script.
  %echoact Added /spam (msg - repeat) (amount) (message)
  %echoact Fixed a Regs echo bug.
  %echoact More bugs fixed :]
  %echoact Added a suggestion by Leonardo - Toggling active nickalerts.
  %echoact Did some changes to the window itself!
  %echoact Added /e /newb /r /caps /date /time.
  %echoact Added custom messages.
  %echoact Fixed a double space with seens ON MODE events.
  %echoact Added alias existance detection.
  %echoact Added a ingame !newb to promote newb chat.
  %echoact Added a Note system and improved it along it's way.
  %echoact Added Reverse repeat in /spam.
  %echoact Added a modification to !playerlist to DRDs Echobots for the CnR server.
  %echoact Changed the note system.
  %echoact Spiced up the echo for DRD CNR Echobots !Playerlist.
  %echoact PMs now have the option to echo to respective channels per network.
  %echoact Fixed more bugs.
  %echoact Added a auto correct.
  %echoact Added colouring to Robo-*'s messages.
  %echoact Custom joins now use the fulladdress instead of Address(nick, 1).
  %echoact Added a s0beit download link in the menu. (April Fools joke.)
  %echoact Removed s0beit download.
  %echoact Added note-wise IRC > BBC conversation, allowing for big-text conversation rather than singleline.
  %echoact Modified open-query message.
  %echoact Fixed a bug that interfered with total nickalerts not going up.
  %echoact Fixed a secondary-nickalert installer bug.
  %echoact Fixed a echo in the actions window bug.
  %echoact Added a prefix to query nickalerts <-nick>.
  %echoact Upped to 2.8.
  %echoact Added /sayX (what) (user1, user2, user3)
  %echoact Added /echoX (what) (user1, user2, user3)
  %echoact Added the slang (/slang (what), /urban (what)) Urban definition. Script found by Marshall, author can be found on Hawkee. Modified by Revo.
  %echoact Modified the actions the #regs echo echos.
  %echoact Converted to the CRRPG IRC rather than moingaming.
  %echoact Added /nickalertall, self explainatory, don't abuse it.
  %echoact Added /inv(ite)all, pretty self explainatory aswell, don't abuse it either.
  %echoact Added a /inv alias, one I've used for myself for decades, it's pretty much the same as .invite but shorter, and without service bot.
  %echoact Added a command only Revo can use to request total script lines.
  %echoact Added a /queryall command, pretty self explainatory, don't abuse it.
  %echoact Added a rickroll detection.
  %echoact Upped to 3.0 (full release.)
  %echoact Fixed correcting Revhoe in commands (/bs assign #channel Revhoe).
  %echoact Added a personal Kill / Death ratio script.
  %echoact Fixed /slang - /urban bugs.
  %echoact Added more to leonardos tip, check for if mIRC is active, antispam. (Enable it temporarily by setting /set %leonardo.wanted.tip $true
  %echoact Added a /nickalertadmin (/nalertadmin) for nickalerting all ops or higher in the channel.
  %echoact Bug fixes to the bugs reported.
  %echoact Added a block for !players in #regs echo to reduce spam.
  %echoact Script public release.
  %echoact Script reached 3,000 lines.
  %echoact Added /rlet (Random Letters/String), specify the amount with /rlet <AMOUNT>.
  %echoact Added /genpass (Amount of characters).
  %echoact Added /google (search) or /gsearch (search).
  %echoact Added /calculate (calculation) or /gcalc (calculation)
  %echoact Added a way members can talk with eachother in a encrypted way of speech, other players will not understand what is being said.
  %echoact (19:07:48) -MemoServ- -Bug Report- "Revos 42." should be "Revo's 42" -Nickalert Script, Leonardo.
  %echoact Bug reports / suggestions now use $me at the end.
  %echoact Upped to 3.1.
  %echoact If your nick now ends with busy or hw the script will automatically reply to queries.
  %echoact Added a /userlist
  %echoact A minor bug has been brought to my attention in regards to the seen script. If you're going to be on many networks and many channels it's best to disable the seen script cause too many entries in the ini file will cause a lot of lagg.
  %echoact Version 3.2
  %echoact Fixed a bug that part-reasons would not show up.
  %echoact Added /hopall [reason]
  %echoact Improved /userlist
  %echoact Added /chanlist
  %echoact Added a detection for when you use /clear (Echo to @Actions)
  %echoact Added another alias, nadmins (nickalertadmins)
  %echoact Added ON CONNECTFAIL notice to @Actions.
  %echoact Added a ON AGENT notice to @Actions.
  %echoact Improved (& Bugfixed) Reversed Repeating and other features of /spam.
  %echoact Added a /TSRemNotes, basically stripping timestamps when you're going to post notes.
  %echoact Added a hot girl problems detection, cover yer ears!
  %echoact Mass unban added. Commands: /mubadd, /mubrem and /massunban
  %echoact Improved password system significantly, get in the menu > config for its options.
  %echoact Added a unfinished /tos, just me testing out dialogs really. Don't take it too serious!
  %echoact Fixed a bug with /nadmins (it went from the @count, rather than &count.
  %echoact Changed the [Radio] echo so it matches the colour syntax of all other echos, not sure why it was left white for so long anyways.
  %echoact Changed the small aliases (r, nc, e) to detect server admin status.
  %echoact Added /getval [value]. Gets a value and converts it to a easier to read format so you won't mix up million with 10 million.
  %echoact Added /getms/sec [value], this prints out a number of conversions with the value you provide.
  %echoact Added /cheattest. Practically giving a random A, B, C or D answer. Nothing interesting just boredom. Could have its use.. eventually.
  %echoact Added /registerchannel <channelname>.
  %echoact Added a ircpm detection.
  %echoact Modified and fixed bugs with /userlist (now shows modes).
  %echoact Added "/beginwith" and "/endwith" to start/end your sentences with specific characters, may interfere with other input scripts.
  %echoact Added /idlechan (OPTIONAL:CHANNEL) to get everyones idletime in the channel.
  %echoact Custom mIRC function: $iniinc() added.
  %echoact Removed Echoing from #regs due to weird bug I was unable to solve.
}
 
alias -l Revo_Enable {
  Revo_Get_Vars
  if (%function == NICKALERT) {
    if ($readini(NickAlert.ini, Enabled, NickAlert)) { %echo 04ERROR: The nickalert is already enabled. | halt }
    writeini -n NickAlert.ini Enabled NickAlert $true
    %echo The nickalert has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10nickalert03 has been enabled.
 
  }
  if (%function == SLAPBACK) {
    if ($readini(NickAlert.ini, Enabled, SlapBack)) { %echo 04ERROR: The slapback is already enabled. | halt }
    writeini -n NickAlert.ini Enabled SlapBack $true
    %echo The slap back has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10auto slapback03 has been enabled.
 
  }
  if (%function == AUTOAWAY) {
    if ($readini(NickAlert.ini, Enabled, AutoAway)) { %echo 04ERROR: The Auto Away script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled AutoAway $true
    %echo The AutoAway script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10auto away script03 has been enabled.
  }
 
  if (%function == WINAMP) {
    if ($readini(NickAlert.ini, Enabled, Winamp)) { %echo 04ERROR: The Winamp script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled Winamp $true
    %echo The Winamp script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10winamp script03 has been enabled.
  }
  if (%function == ECHOREGS) {
    if ($readini(NickAlert.ini, Enabled, EchoRegs)) { %echo 04ERROR: The Echo Regs script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled EchoRegs $true
    %echo The Regs echo script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10Regs echo script03 has been enabled.
  }
  if (%function == Seen) {
    if ($readini(NickAlert.ini, Enabled, Seen)) { %echo 04ERROR: The seen script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled Seen $true
    %echo The Seen script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10Seen script03 has been enabled.
  }
  if (%function == CUSTOMMSG) {
    if ($readini(NickAlert.ini, Enabled, CustomMSG)) { %echo 04ERROR: The Custom Messages are already enabled. | halt }
    writeini -n NickAlert.ini Enabled CustomMSG $true
    %echo The Custom MSG script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10Custom MSG script03 has been enabled.
  }
  if (%function == EIRPlayers) {
    if ($readini(NickAlert.ini, Enabled, EIRPlayers)) { %echo 04ERROR: The EIR Players script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled EIRPlayers $true
    %echo The EIR Players script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10EIR Players script03 has been enabled.
  }
  if (%function == EchoPM) {
    if ($readini(NickAlert.ini, Enabled, EchoPMs)) { %echo 04ERROR: The Echo Queries script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled EchoPMs $true
    %echo The Echo Queries script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10Echo Queries script03 has been enabled.
  }
  if (%function == ColourPM) {
    if ($readini(NickAlert.ini, Enabled, PMColour)) { %echo 04ERROR: The PM Colour script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled PMColour $true
    %echo The PM colour script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10PM Colour script03 has been enabled.
  }
  if (%function == KillDeath) {
    if ($readini(NickAlert.ini, Enabled, KDlog)) { %echo 04ERROR: The Kill/death script is already enabled. | halt }
    writeini -n NickAlert.ini Enabled KDlog $true
    %echo The Kill/death script has been enabled, it can be disabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10Kill/death script03 has been enabled.
  }
}
 
alias -l Revo_Disable {
  if (%function == NICKALERT) {
    if (!$readini(NickAlert.ini, Enabled, NickAlert)) { %echo 04ERROR: The Nickalert is already disabled. | halt }
    writeini -n NickAlert.ini Enabled NickAlert $false
    %echo The nickalert has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10nickalert03 has been disabled.
  }
  if (%function == SLAPBACK) {
    if (!$readini(NickAlert.ini, Enabled, SlapBack)) { %echo 04ERROR: The SlapBack is already disabled. | halt }
    writeini -n NickAlert.ini Enabled SlapBack $false
    %echo The slap back has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10auto slapback03 has been disabled.  
  }
  if (%function == AUTOAWAY) {
    if (!$readini(NickAlert.ini, Enabled, AutoAway)) { %echo 04ERROR: The Auto Away script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled AutoAway $false
    %echo The Auto Away script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10Auto Away Script03 has been disabled.  
  }
  if (%function == WINAMP) {
    if (!$readini(NickAlert.ini, Enabled, Winamp)) { %echo 04ERROR: The Winamp script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled Winamp $false
    %echo The Winamp script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10Winamp Script03 has been disabled.
  }
  if (%function == ECHOREGS) {
    if (!$readini(NickAlert.ini, Enabled, EchoRegs)) { %echo 04ERROR: The Echo Regs script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled EchoRegs $false
    %echo The Regs echo script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10Regs echo script03 has been enabled.
  }
  if (%function == SEEN) {
    if (!$readini(NickAlert.ini, Enabled, Seen)) {  %echo 04ERROR: The seen script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled Seen $false
    %echo The Seen script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10Seenscript03 has been enabled.
  }
  if (%function == CUSTOMMSG) {
    if (!$readini(NickAlert.ini, Enabled, CustomMSG)) { %echo 04ERROR: The Custom Messages are already disabled. | halt }
    writeini -n NickAlert.ini Enabled CustomMSG $false
    %echo The Custom MSG script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[ENABLED] 03The 10Custom MSG script03 has been disabled.
  }
  if (%function == EIRPlayers) {
    if (!$readini(NickAlert.ini, Enabled, EIRPlayers)) { %echo 04ERROR: The EIR Players script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled EIRPlayers $false
    %echo The EIR Players script has been disabled, it can be re-enbled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10EIR Players script03 has been disabled.
  }
  if (%function == EchoPM) {
    if (!$readini(NickAlert.ini, Enabled, EchoPMs)) { %echo 04ERROR: The Echo Queries script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled EchoPMs $false
    %echo The Echo Queries script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10Echo Queries script03 has been disbled.
  }
  if (%function == ColourPM) {
    if (!$readini(NickAlert.ini, Enabled, PMColour)) { %echo 04ERROR: The PM Colour script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled PMColour $false
    %echo The PM colour script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10PM Colour script03 has been disbled.
  }
  if (%function == KillDeath) {
    if (!$readini(NickAlert.ini, Enabled, KDlog)) { %echo 04ERROR: The Kill/death script is already disabled. | halt }
    writeini -n NickAlert.ini Enabled KDlog $false
    %echo The Kill/death script has been disabled, it can be re-enabled at any time with the menu option.
    %echoact 07[DISABLED] 03The 10Kill/death script03 has been disabled.
  }
}
 
alias wamp {
  set %wamp $strip($remove($de(winamp), ", $chr(41)))
  set %wamp $replace(%wamp, $chr(40), 07- 15)
  set %wamp %wamp $+ .
  describe $active is playing:03 %wamp
  if ([Connecting] http://199.115.230.138:8000/stream/1/ isin %wamp || Auto DJ isin %wamp && !%connected) {
    set %connected $true
    writeini -n NickAlert.ini Total Radio $calc($readini(NickAlert.ini, Total, Radio)+1)
    %echo You are now connected to the MoinGaming Radio.
    %echo You have connected to the MoinGaming Radio07 $readini(NickAlert.ini, Total, Radio) times.
  }
  unset %wamp
  halt
}
alias -l Revo_NoDescribe_Wamp { set %wamp $strip($remove($de(winamp), ", $chr(41))) | set %wamp $replace(%wamp, $chr(40), 07- 15) |   set %wamp %wamp $+ . }
 
alias -l Revo_Check_DarkEngine {
  if ($exists($mircdirdeultimate.dll)) {
    writeini -n NickAlert.ini Data DarkEngine $true
  }
  else if (!$exists($mircdirdeultimate.dll)) {
    writeini -n NickAlert.ini Data DarkEngine $false
    Revo_Check_Error
  }
}
 
alias AFK {
  if ($readini(NickAlert.ini, Enabled, AutoAway)) {
    if (%away) { echo -a You're already away! | halt }
    set %away $true
    away Away
    halt
  }
}
 
alias back {
  if ($readini(NickAlert.ini, Enabled, AutoAway)) {
    if (%Away == $null) { echo -a You're not away! }
    away
    unset %Away
  }
}
 
alias irpgstats {
  Revo_Get_Vars
  if ($readini(NickAlert.ini, Total, PenaltiesIRPG) != $null) { var %revo.irpg = $readini(NickAlert.ini, Total, PenaltiesIRPG) }
  if ($readini(NickAlert.ini, Total, IRPGLogin) != $null) { var %revo.irpglogin = $readini(NickAlert.ini, Total, IRPGLogin) }
  if ($readini(NickAlert.ini, Total, IRPGLogout) != $null) { var %revo.irpglogout = $readini(NickAlert.ini, Total, IRPGLogout) }
  if (%revo.irpg == $null) { var %revo.irpg = 0 }
  if (%revo.irpglogin == $null) { var %revo.irpglogin = 0 }
  if (%revo.irpglogout == $null) { var %revo.irpglogout = 0 }
 
  if ($readini(NickAlert.ini, Total, PenaltiesIRPG) == $null && $readini(NickAlert.ini, Total, IRPGLogin) == $null && $readini(NickAlert.ini, Total, IRPGlogout) == $null) {
    %echo There are no IRPG stats recorded, are you sure you have registered an account?
    halt
  }
  %echo You have been penalized07 %revo.irpg times.
  %echo You have logged in07 %revo.irpglogin times and logged out07 %revo.irpglogout times.
}
 
alias -l Revo_Get_All_Stats {
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  Revo_Vars_TimeStamp
  Revo_Vars_BlankLine
  Revo_Vars_BlankLineAct
 
  ;Getting all values.
  if ($readini(NickAlert.ini, Total, Kicked) != $null) { var %revo.kicked = $readini(NickAlert.ini, Total, Kicked) }
  if ($readini(NickAlert.ini, Total, Joined) != $null) { var %revo.joined = $readini(NickAlert.ini, Total, Joined) }
  if ($readini(NickAlert.ini, Total, Parted) != $null) { var %revo.parted = $readini(NickAlert.ini, Total, Parted) }
  if ($readini(NickAlert.ini, Total, Disconnected) != $null) { var %revo.disconnected = $readini(NickAlert.ini, Total, Disconnected) }
  if ($readini(NickAlert.ini, Total, Opped) != $null) { var %revo.opped = $readini(NickAlert.ini, Total, Opped) }
  if ($readini(NickAlert.ini, Total, Deopped) != $null) { var %revo.deopped = $readini(NickAlert.ini, Total, Deopped) }
  if ($readini(NickAlert.ini, Total, HalfOpped) != $null) { var %revo.hopped = $readini(NickAlert.ini, Total, HalfOpped) }
  if ($readini(NickAlert.ini, Total, DeHalfOpped) != $null) { var %revo.dehopped = $readini(NickAlert.ini, Total, DeHalfOpped) }
  if ($readini(NickAlert.ini, Total, Protected) != $null) { var %revo.protected = $readini(NickAlert.ini, Total, Protected) }
  if ($readini(NickAlert.ini, Total, Deprotected) != $null) { var %revo.deprotected = $readini(NickAlert.ini, Total, Deprotected) }
  if ($readini(NickAlert.ini, Total, Voiced) != $null) { var %revo.voiced = $readini(NickAlert.ini, Total, Voiced) }
  if ($readini(NickAlert.ini, Total, DeVoiced) != $null) { var %revo.devoiced = $readini(NickAlert.ini, Total, DeVoiced) }
  if ($readini(NickAlert.ini, Total, Connected) != $null) { var %revo.connected = $readini(NickAlert.ini, Total, Connected) }
  if ($readini(NickAlert.ini, Total, NameChange) != $null) { var %revo.namechange = $readini(NickAlert.ini, Total, NameChange) }
  if ($readini(NickAlert.ini, Total, PenaltiesIRPG) != $null) { var %revo.irpg = $readini(NickAlert.ini, Total, PenaltiesIRPG) }
  if ($readini(NickAlert.ini, Total, IRPGLogin) != $null) { var %revo.irpglogin = $readini(NickAlert.ini, Total, IRPGLogin) }
  if ($readini(NickAlert.ini, Total, IRPGLogout) != $null) { var %revo.irpglogout = $readini(NickAlert.ini, Total, IRPGLogout) }
 
  if ($ini(NickAlert.ini, Ignore, 0) != $null) { var %revo.ignorelist = $ini(NickAlert.ini, Ignore, 0) }
  if ($ini(NickAlert.ini, Amount, 0) != $null) { var %revo.Amount = $ini(NickAlert.ini, Amount, 0) }
  if ($ini(NickAlert.ini, Queries, 0) != $null) { var %revo.queried = $ini(NickAlert.ini, Queries, 0) }
 
  ;Get network stats
  var %x = 1, %y = 0, %o = 0, %h = 0, %v = 0, %r = 0, %n = 0, %t = 0, %c = 0, %oo = 0, %hh = 0
  while ($scon(%x)) {
    scid $scon(%x)
    set %i 1
    while ($chan(%i)) {
      inc %t $nick($chan(%i),0)
      if ($me isop $chan(%i)) { inc %o | inc %n $nick($chan(%i),0,a,o) | inc %hh $nick($chan(%i),0,o) }
      elseif ($me ishop $chan(%i)) { inc %h | inc %n $nick($chan(%i),0,a,oh) | inc %hh $nick($chan(%i),0,h,o) | inc %oo $nick($chan(%i),0,o) }
      elseif ( $me isvoice $chan(%i) ) { inc %v | inc %n $nick($chan(%i),0,r) | inc %hh $nick($chan(%i),0,v,ho) | inc %oo $nick($chan(%i),0,oh) }
      elseif ($me isreg $chan(%i)) { inc %r | inc %hh $nick($chan(%i),0,r,ohv) | inc %oo $nick($chan(%i),0,a,r) }
      inc %y | inc %i | inc %c
    }
    inc %x
  }
 
  if (%revo.connected == $null) { var %revo.connected = 0 }
  if (%revo.disconnected == $null) { var %revo.disconnected = 0 }
  if (%revo.joined == $null) { var %revo.joined = 0 }
  if (%revo.parted == $null) { var %revo.parted = 0 }
  if (%revo.kicked == $null) { var %revo.kicked = 0 }
  if (%revo.protected == $null) { var %revo.protected = 0 }
  if (%revo.deprotected == $null) { var %revo.deprotected = 0 }
  if (%revo.deopped == $null) { var %revo.deopped = 0 }
  if (%revo.opped == $null) { var %revo.opped = 0 }
  if (%revo.devoiced == $null) { var %revo.devoiced = 0 }
  if (%revo.voiced == $null) { var %revo.voiced = 0 }
  if (%revo.irpg == $null) { var %revo.irpg = 0 }
  if (%revo.irpglogin == $null) { var %revo.irpglogin = 0 }
  if (%revo.irpglogout == $null) { var %revo.irpglogout = 0 }
  if (%revo.hopped == $null) { var %revo.hopped = 0 }
  if (%revo.dehopped == $null) { var %revo.dehopped = 0 }
 
  if ($ini(NickAlert.ini, Ignore, 0) == $null) { var %revo.ignorelist = 0 }
  if ($ini(NickAlert.ini, Amount, 0) == $null) { var %revo.Amount = 0 }
  if ($ini(NickAlert.ini, Queries, 0) == $null) { var %revo.queried = 0 }
 
  %echo All your stats have been sent to 03@Actions.
 
  %blankact
  %echoact 09|_ General Stats _|
  %echoact You have connected to a network07 %revo.connected times, and disconnected from a network07 %revo.disconnected times.
  %echoact You have joined07 %revo.joined channels, and parted07 %revo.parted channels.
  %echoact You have been kicked from07 %revo.kicked channels.
 
  %blankact
  %echoact 11|_ Network Stats _|
  %echoact You are opped on07 %o $+  $iif(%o > 1, channels, channel) $chr(40) $+ 03 $+ $ceil($calc(%o / %c * 100)) $+ $chr(37) $+  $+ $chr(41)
  %echoact You are halfopped on07 %h $+  $iif(%h > 1, channels, channel) $chr(40) $+ 03 $+ $ceil($calc(%h / %c * 100)) $+ $chr(37) $+  $+ $chr(41)
  %echoact You are voiced on07 %v $+  $iif(%v > 1, channels, channel) $chr(40) $+ 03 $+ $ceil($calc(%v / %c * 100)) $+ $chr(37) $+  $+ $chr(41)
  %echoact and you are regular on07 %r $+  $iif(%r > 1, channels, channel) $chr(40) $+ 03 $+ $ceil($calc(%r / %c * 100)) $+ $chr(37) $+  $+ $chr(41)
  %echoact That's control over07 %n $+  $+ /07 $+ %t $+  (03 $+ $ceil($calc((%n / %t)*100)) $+ % $+  $+ $+ ) of the users.
  %echoact You're controlled by07 %oo $+  $+($chr(40),03,$ceil($calc((%oo / %t) *100)),% $+ ,$chr(41) $+ ) of the users.
  %echoact While you're equal with07 %hh $+  $+($chr(40),03,$ceil($calc((%hh / %t) *100)),% $+ ,$chr(41) $+ ) of the users.
  %echoact You're on a total of07 %c $+  $iif(%c > 1,channels,channel) across07 $scon(0) $+  $iif($scon(0) > 1,networks,network)
 
  %blankact
  %echoact 10|_ Modes _|
  %echoact You have been protected07 %revo.protected times, and have been deprotected07 %revo.deprotected times.
  %echoact You have been opped07 %revo.opped times, and have been deopped07 %revo.deopped times.
  %echoact You have been halfopped07 %revo.hopped times, and have been deopped07 %revo.dehopped times.
  %echoact You have been voiced07 %revo.voiced times, and have been devoiced07 %revo.devoiced times.
 
  %blankact
  %echoact 04|_ Idle RPG _|
  %echoact You have been penalized07 %Revo.irpg times.
  %echoact You have logged in07 %revo.irpglogin times and logged out07 %revo.irpglogout times.
 
  %blankact
  %echoact 06|_ Other Stats _|
  %echoact There are a total of07 %revo.ignorelist users ignored.
  %echoact There are a total of07 %revo.amount unique users users who have nickalerted you.
  %echoact There are a total of07 %revo.queried unique users users who have queried you.
  %blankact
 
  unset %power.*
  unset %bar.*
}
 
;Darkengine
;on *:load:{ echo -ae DarkEngine installed sucessfully... | dek 3 | fde }
alias -l biosvendor { dem Bios Vendor: $de(bios_vendor) }
alias -l biosdate { dem Bios Date: $de(bios_date) }
alias -l biosversion { dem Bios Version: $de(bios_version) }
;Operating System Information
alias -l osver { dem Operating System: $de(winver) }
alias -l winuser { dem Windows User: $de(win_username) }
alias -l osinfo { dem OS info: $de(win_username) on $de(winver) }
alias -l uptime { dem Uptime: $de(uptime_short) }
alias -l luptime { dem Uptime: $de(uptime) }
alias -l record { dem Record Uptime: $de(record_uptime) }
alias -l winstall { dem Installed On: $de(win_install_date) }
alias -l winall { dem OS Info: $de(winver) $+  [ $+ $de(win_username) $+ ] installed on  $+ $de(win_install_date) }
alias -l pcname { dem Computer Name: $de(computer_name) }
;Central Processing Unit Information
alias -l cpu { dem CPU: $de(cpuname) }
alias -l cpuspeed { dem CPU Speed: $de(cpuspeed) }
alias -l cpudetail { dem CPU Details: $de(cpudetails) }
alias -l cpuload { dem CPU Load: $de(cpuload) }
alias -l cpuarch { dem CPU Architecture: $de(cpuarchitech) }
alias -l cpucount { dem CPU Count: $de(cpucount) }
alias -l cpuinfo { dem CPU: $de(cpuname) $+ , $de(cpuspeed) $+ ,  $+ $de(cpu_cache_l2) $+  ( $+ $de(cpuload) Load $+ ) }
alias -l l1cache { dem L1 Cache: $de(cpu_cache_l1) }
alias -l l2cache { dem L2 Cache: $de(cpu_cache_l2) }
alias -l l3cache { dem L3 Cache: $de(cpu_cache_l3) }
alias -l cpu_socket { dem CPU Socket: $de(cpu_sockettype) }
alias -l cpu_cores { dem CPU Cores: $de(cpu_core_count) }
alias -l cpu_extclock { dem CPU External Clock: $de(cpu_external_clock) $+  MHz }
alias -l cpu_multiplier { dem CPU Multiplier: $de(cpu_multiplier) }
;Video Information
alias -l monitor { dem Monitor: $de(monitor) }
alias -l videocard { dem Video Card: $de(videocard) }
alias -l res { dem Resolution: $de(screen_res) }
alias -l video { dem Video: $de(monitor) on $de(videocard)  $chr(40) $+ $de(screen_res) $+ $chr(41) }
;Sound Information
alias -l soundcard { dem Sound Card: $de(soundcard) }
;Hard Drive Information
alias -l hd { dem Hard Drives: $de(harddrive_space) }
alias -l hdspace { dem Hard Drive: $dll(deultimate.dll,harddrive_space_drive,$1) }
alias -l hdtotal { dem Total Free: $de(harddrive_space_free) $+ / $+ $de(harddrive_space_total) }
alias -l hdtotal2 { dem Total Free: $de(harddrive_space_free_exclude_network) $+ / $+ $de(harddrive_space_total_exclude_network) }
;Memory Information
alias -l memload { dem Memory Load: $de(memory_load) }
alias -l mem { dem Avaliable Memory: $de(memory_avail) MB }
alias -l usedmem { dem Used Memory: $de(memory_used) MB }
alias -l totalmem { dem Total Memory: $de(memory_total) MB }
alias -l memratio { dem RAM: Used: $de(memory_used) $+ / $+ $de(memory_total) $+ MB }
alias -l vmemratio { dem Virtual RAM: Used: $de(memory_virtual_used) $+ / $+ $de(memory_virtual_total) $+ MB }
alias -l memsum { dem RAM: Used: $de(memory_used) $+ / $+ $de(memory_total) $+ MB ( $+ $de(memory_load) Load $+ ) }
alias -l memslots { dem Total Memory Slots: $de(memory_slots) }
;Winamp Information
alias -l id3 { dem ID3: $de(id3_test) }
;Misc Functions
alias -l about { $de(about) }
alias -l sys { dem OS: $de(winver)  $+ $dek $+ CPU: $de(cpuname) $+ , $de(cpuspeed) $+ ,  $+ $de(cpu_cache_l2) $+   $+  $+ $dek $+ Video: $de(videocard) $+ ( $+ $de(screen_res) $+ )  $+ $dek $+ Sound:  $+ $de(soundcard)  $+ $dek $+ Memory: Used: $de(memory_used) $+ / $+ $de(memory_total) $+ MB  $+ $dek $+ Uptime: $de(uptime_short)  $+ $dek $+ HD Space: Free: $de(harddrive_space_free) $+ / $+ $de(harddrive_space_total)  $+ $dek $+ Connection: $de(adapter_info_all) }
;Mainboard Functions
alias -l mobo_manu { dem Mainboard Vendor: $de(mobo_vendor) }
alias -l mobo_name { dem Mainboard Name: $de(mobo_name) }
alias -l mobo_ver { dem Mainboard Version: $de(mobo_version) }
;Darkengine Core Functions (do not modify)
alias -l fde { flushini de.ini }
alias -l de { return $dll(deultimate.dll,$1,_) }
alias -l dem { msg $active  $+ $dek $+  $+ $1- }
alias -l deq { return $$?="Enter message/text" }
alias -l dek { if ($isid == $true) { return $readini(de.ini,options,color) } | if ($isid == $false) { writeini de.ini options color $remove($1,) | flushini de.ini } }
;Internet Connection Information
alias -l conn { dem Connection: $de(adapter_info_all) }
alias -l chadapter { $de(adapter_change) }
alias -l totaldown { dem Total Downloaded: $de(bandwidth_down_total) $+ MB }
alias -l totalup { dem Total Uploaded: $de(bandwidth_up_total) $+ MB }
alias -l tottrans { msg $active  $+ $dek $+ Downloaded: $de(bandwidth_down_total) MB  $+ $dek $+  Uploaded: $de(bandwidth_up_total) MB }
 
alias -l band {
  set %de.band.down $de(bandwidth_down_total)
  set %de.band.down.ticks $ticks
  .timer 1 1 de_band_calc_down
}
 
alias -l upband {
  set %de.band.up $de(bandwidth_up_total)
  set %de.band.up.ticks $ticks
  .timer 1 1 de_band_calc_up
}
 
alias -l totband {
  set %de.band.up $de(bandwidth_up_total)
  set %de.band.up.ticks $ticks
  set %de.band.down $de(bandwidth_down_total)
  set %de.band.down.ticks $ticks
  .timer 1 1 de_band_calc_total
}
 
alias -l de_band_calc_down {
  set %de.band.down2 $de(bandwidth_down_total)
  set %de.band.down.curr $calc( ( %de.band.down2 - %de.band.down ) * 1000000 / ( $ticks - %de.band.down.ticks ) )
  dem Current Downstream:  $+ $round( %de.band.down.curr,2 ) $+  KBytes/s
  unset %de.band.down
  unset %de.band.down2
  unset %de.band.down.curr
  unset %de.band.down.ticks
}
 
alias -l de_band_calc_up {
  set %de.band.up2 $de(bandwidth_up_total)
  set %de.band.up.curr $calc( ( %de.band.up2 - %de.band.up ) * 1000000 / ( $ticks - %de.band.up.ticks ) )
  dem Current Upstream:  $+ $round( %de.band.up.curr,2 ) $+  KBytes/s
  unset %de.band.up
  unset %de.band.up2
  unset %de.band.up.curr
  unset %de.band.up.ticks
}
 
alias -l de_band_calc_total {
  set %de.band.down2 $de(bandwidth_down_total)
  set %de.band.down.curr $calc( ( %de.band.down2 - %de.band.down ) * 1000000 / ( $ticks - %de.band.down.ticks ) )
  set %de.band.up2 $de(bandwidth_up_total)
  set %de.band.up.curr $calc( ( %de.band.up2 - %de.band.up ) * 1000000 / ( $ticks - %de.band.up.ticks ) )
  dem Downstream:  $+ $round( %de.band.down.curr, 2 ) $+   KBytes/s  $+ $dek $+  Upstream:  $+ $round( %de.band.up.curr, 2 ) $+  KBytes/s
  unset %de.band.down
  unset %de.band.down2
  unset %de.band.down.curr
  unset %de.band.down.ticks
  unset %de.band.up
  unset %de.band.up2
  unset %de.band.up.curr
  unset %de.band.up.ticks
}
;End of Darkengine script
 
alias -l Revo_NickColour { return $+(03,$iif($nick == $null, $1, $nick),) }
 
alias sayX {
  if ($2 == $null) {
    echo -a 04ERROR: Syntax: /sayX (WHAT?) (USER1, USER2, USER3...)
    echo -a 15Example: /sayX !igseen Revo Leonardo IceCold will output '!igseen Revo, !igseen Leonardo, !igseen IceCold'.
    halt
  }
  var %i = 2
  while (%i <= $0) {
    msg $active $1 [ [ $+($,%i) ] ]
    inc %i
    if (%i >= 100) { echo -a Stopping, a too high value may crash mIRC. | break }
  }
  Revo_Vars_EchoAct
  %echoact 07[sayX]03 Performed a SayX - Said '10 $+ $1- $+ 03'.
}
 
alias echoX {
  if ($2 == $null) {
    echo -a 04ERROR: Syntax: /echoX (WHAT?) (USER1, USER2, USER3...)
    echo -a 15Example: /echoX !igseen Revo Leonardo IceCold will output '!igseen Revo, !igseen Leonardo, !igseen IceCold'.
    halt
  }
  var %i = 2
  while (%i <= $0) {
    echo -a $1 [ [ $+($,%i) ] ]
    inc %i
    if (%i >= 100) { echo -a Stopping, a too high value may crash mIRC. | break }
  }
  Revo_Vars_EchoAct
  %echoact 07[echoX]03 Performed a EchoX - Echo'd '10 $+ $1- $+ 03'.
}
 
 
alias inv {
  if ($1 == $null) { echo -a 04ERROR: Syntax - /inv (nickname). | halt }
  invite $1 $active
  echo -tng $active $1 has been invited to $active $+ .
}
 
alias inviteall {
  if ($1 == $null) { echo -a 04ERROR: Syntax - /inviteall (channel). | halt }
  if ($nick($1, 0) >= 15) { var %istrue = $input(You are about to invite $nick($1, 0) users to $active $+ . - Are you sure?, y, Invite all users from $1 to $active $+ . ) }
  if (%istrue || %istrue == $null) {
    var %i = 1
    while (%i <= $nick($1, 0)) {
      invite $nick($1, %i) $active
      inc %i
      if (%i >= 60) { echo -a Halted due to inviting too many people. | break }
    }
  }
  if (%istrue == $false) { echo -a Halted due to inviting too many people. | halt }
  Revo_Vars_EchoAct
  %echoact 07[Invite All] 03You have invited everyone in10 $iif($1 == $null, $active, $1) $+ 03.
}
 
alias queryall {
  if ($2 == $null) { Echo -tnga 04ERROR: Syntax - /queryall (channel) (message). | halt }
  if ($2 != $null) {
    if ($nick($1, 0) >= 15) { var %istrue = $input(You are about to query $nick($1, 0) users in $active $+ . - Are you sure?, y, Query all users from $1 to $active $+ . ) }
    if (%istrue || %istrue == $null) {
 
      var %i = 1
      while (%i <= $nick($1, 0)) {
        msg $nick($1, %i) $2-
        inc %i
        if (%i >= 60) { echo -a Halted due to querying too many people. | break }
      }
    }
    if (%istrue == $false) { echo -a Halted due to nickalerting too many people. | halt }
    Revo_Vars_EchoAct
    %EchoAct 07[QUERY ALL]03 You have queried10 $nick($1, 0) 03users 10' $+ $2- $+ '03.
  }
}
 
alias nalertadmins { nickalertadmins }
alias nadmins { nickalertadmins }
 
alias nickalertadmins {
  if ($1 != $null) {
    if ($nick(#crrpg, 0, &) { var %istrue = $input(You are about to nickalert $nick(#crrpg, 0, o) users in $active $+ . - Are you sure?, y, Invite all users from $1 to $active $+ . ) }
    if (%istrue || %istrue == $null) {
      var %i = 1
      while (%i <= $nick($1, 0, &)) {
        var %nickall = $iif(%nickall != $null, %nickall $+ ,) $nick($1, %i)
        inc %i
        if (%i >= 30) { echo -a Halted due to nickalerting too many people. | break }
      }
      msg $active 05[Nickalerting Admins] %nickall
    }
    if (%istrue == $false) { echo -a Halted due to nickalerting too many people. | halt }
  }
  if ($1 == $null) {
    if ($nick(#crrpg, 0, &) >= 15) { var %istrue = $input(You are about to nickalert $nick(#crrpg, 0, o) users in $active $+ . - Are you sure?, y, Invite all users from $1 to $active $+ . ) }
    var %nickall = $nick($active, 1)
    if (%istrue || %istrue == $null) {
      var %i = 2
      while (%i <= $nick($active, 0, &)) {
        var %nickall = $iif(%nickall != $null, %nickall $+ ,) $nick($active, %i)
        inc %i
        if (%i >= 30) { echo -a Halted due to nickalerting too many people. | break }
      }
      msg $active 05[NickAlerting Admins] %nickall
    }
    if (%istrue == $false) { echo -a Halted due to nickalerting too many people. | halt }
  }
  Revo_Vars_EchoAct
  %echoact 07[NickAlert Admins] 03You have nickalerted every admin in10 $iif($1 == $null, $active, $1) $+ 03.
}
 
alias nickalertall {
  if ($1 != $null) {
    if ($nick($1, 0) >= 15) { var %istrue = $input(You are about to nickalert $nick($1, 0) users in $active $+ . - Are you sure?, y, Invite all users from $1 to $active $+ . ) }
    if (%istrue || %istrue == $null) {
      var %nickall = $nick($1, 1)
      var %i = 1
      while (%i <= $nick($1, 0)) {
        var %nickall = %nickall $+ , $nick($1, %i)
        inc %i
        if (%i >= 60) { echo -a Halted due to nickalerting too many people. | break }
      }
      msg $active 05[NickAll] %nickall
    }
    if (%istrue == $false) { echo -a Halted due to nickalerting too many people. | halt }
  }
  if ($1 == $null) {
    if ($nick($1, 0) >= 15) { var %istrue = $input(You are about to nickalert $nick($1, 0) users in $active $+ . - Are you sure?, y, Invite all users from $1 to $active $+ . ) }
    var %nickall = $nick($active, 1)
    if (%istrue || %istrue == $null) {
      var %i = 2
      while (%i <= $nick($active, 0)) {
        var %nickall = %nickall $+ , $nick($active, %i)
        inc %i
        if (%i >= 60) { echo -a Halted due to nickalerting too many people. | break }
      }
      msg $active 05[NickAll] %nickall
    }
    if (%istrue == $false) { echo -a Halted due to nickalerting too many people. | halt }
  }
  Revo_Vars_EchoAct
  %echoact 07[NickAlert All] 03You have nickalerted everyone in10 $iif($1 == $null, $active, $1) $+ 03.
}
 
alias slang { GetSlang echo -tnga $1- }
alias urban { GetSlang echo -tnga $1- }
alias -l httpstrip { var %x, %i = $regsub($1-,/(^[^<]*>|<[^>]*>|<[^>]*$)/g,$null,%x) | return $remove($replace(%x,&amp;,&,&quot;,",&gt;,>,&lt;,<),&nbsp;,&lt;) }
 
alias -l GetSlang {
  var %sockname $+(SlangUD,$network,$2,$ticks)
  var %SlangUD.url $iif($3,$replace($+(/define.php?page=,$iif($ceil($calc($3 / 7)),$v1,1),&term=,$iif($3 !isnum,$3-,$4-)),$chr(32),+),/random.php)
  sockopen %sockname www.urbandictionary.com 80
  sockmark %sockname $1-2 %SlangUD.url $iif($3 isnum,$iif($calc($3 % 7),$v1,7),1) 0 0
}
 
On *:sockopen:SlangUD*: {
  if (!$sockerr) {
    sockwrite -nt $sockname GET $gettok($sock($sockname).mark,3,32) HTTP/1.1
    sockwrite -n $sockname Host: www.urbandictionary.com
    sockwrite -n $sockname $crlf
  }
  else { echo -st Socket Error $nopath($script) | sockclose $sockname | return }
}
 
On *:sockread:SlangUD*: {
  if ($sockerr) { echo -st Socket Error $nopath($script) | sockclose $sockname | return }
  else {
    var %SlangUD | sockread %SlangUD
    if (Location: http://www.urbandictionary.com/define.php?term isin %SlangUD) {
      GetSlang $gettok($sock($sockname).mark,1-2,32) 1 $gettok(%SlangUD,-1,61)
      sockclose $sockname
      return
    }
    if (<div id='not_defined_yet'> isin %SlangUD) { $gettok($sock($sockname).mark,1-2,32) Sorry that word has yet to be defined. }
    if (<td class='index'> isin %SlangUD) { sockmark $sockname $puttok($sock($sockname).mark,$calc($gettok($sock($sockname).mark,5,32) + 1),5,32)  }
    if ($gettok($sock($sockname).mark,5,32) == $gettok($sock($sockname).mark,4,32)) {
      if ($gettok($sock($sockname).mark,6,32) == word && $httpstrip(%SlangUD)) {
        if (<span style='font-weight: normal'> !isin %SlangUD) { $gettok($sock($sockname).mark,1-2,32) 10Word -10 $censored($httpstrip(%SlangUD)) }
        sockmark $sockname $puttok($sock($sockname).mark,0,6,32)
      }
      if ($regex(%SlangUD,/<div class=['"]([^>]*)['"]>/)) { sockmark $sockname $puttok($sock($sockname).mark,$regml(1),6,32)  }      
      if ($gettok($sock($sockname).mark,6,32) == definition && $regex(def,%SlangUD,/<div class="definition">(.*)<div class="example">(.*)<\/div>/)) {
        put $gettok($sock($sockname).mark,1-2,32) 10Definition -10 $censored($replace($httpstrip($regml(def,1)),$chr(13),$chr(32)))
        put $gettok($sock($sockname).mark,1-2,32) 10Example -10 $censored($replace($httpstrip($regml(def,2)),$chr(13),$chr(32)))
      }
      if ($gettok($sock($sockname).mark,6,32) == example && $httpstrip(%SlangUD)) { put $gettok($sock($sockname).mark,1-2,32) 10Example -10 $censored($replace($v1,$chr(13),$chr(32))) }
      if (<a href="/author.php?author= isin %SlangUD) {
        put $gettok($sock($sockname).mark,1-2,32) 10Author -10 $censored($httpstrip(%SlangUD) - $+(07,http://www.urbandictionary.com,$gettok($sock($sockname).mark,3,32)))
        sockclose $sockname
        return
      }
      if (%SlangUD == <td class='word'>) { sockmark $sockname $puttok($sock($sockname).mark,word,6,32) }
    }
  }
}
 
alias -l Put {
  if (!$regex($1,/(\.|^)(msg|notice|echo)$/Si)) || (!$3) { echo -st **Put error** Syntax /Put msg #channel text - or - /Put notice nickname text  | return }
  tokenize 32 $regsubex($1-,/([$\|%\[\]\}\{][^\s]*)/g,$+($chr(2),$chr(2),\t))
  var %tokens $0, %Tstart 3, %Dtimer 1500
  if ($timer($+(Put,$2,$network)).secs) { %Dtimer = $calc($v1 * 1000) }  
  while ($len($($+($,%Tstart,-,%tokens),2)) > 430) {
    dec %tokens
    if ($len($($+($,%Tstart,-,%tokens),2)) <= 430) {
      .timer -m 1 %Dtimer $1-2 $+(04,$($+($,%Tstart,-,%tokens),2)))
      inc %Dtimer 1500
      %Tstart = $calc(%tokens + 1)
      %tokens = $0
    }
  }
  .timer -m 1 %Dtimer $1-2 $+(04,$($+($,%Tstart,-,%tokens),2)))
  .timer $+ $+(Put,$2,$network) -m 1 $calc(%Dtimer + 1500) noop
}
alias  censored {
  if (!$hget(censored)) { hmake censored 5 }
  var %censored.string = $1-, %censored.words = $gettok($1-,0,32)
  while %censored.words {
    if ($hfind(censored,$left($gettok(%censored.string,%censored.words,32),4) $+ *,1,w).data) || ($hfind(censored,$gettok(%censored.text,%censored.word,32)).data) {
      %censored.string = $replace(%censored.string,$gettok(%censored.string,%censored.words,32),!@#&)
    }
    dec %censored.words
  }
  return %censored.string
}
 
alias censored.list {
  var %censored.counter = $hget(censored,0).item
  while %censored.counter {
    echo -a $hget(censored,%censored.counter).item $hget(censored,%censored.counter).data
    dec %censored.counter
  }
}
 
alias -l Revo_Calc_K/D {
  Revo_Vars_EchoAct
  Revo_Vars_Echo
  var %ratio = $calc($readini(NickAlert.ini, Ratio, Kills) / $readini(NickAlert.ini, Ratio, Deaths))
  %echoact 07[KD/R] 03You have died10 $readini(NickAlert.ini, Ratio, deaths) 03times. You have killed10 $readini(NickAlert.ini, Ratio, Kills) 03players.
  %echoact 07[KD/R] 03Your Kill / Death ratio is10 %ratio $+ 03.
  %echo 03You have died10 $readini(NickAlert.ini, Ratio, deaths) 03times. You have killed10 $readini(NickAlert.ini, Ratio, Kills) 03players.
  %echo 03Your Kill / Death ratio is10 %ratio $+ 03.
}
 
;Get random letters, can be used for passwords, strings, or else
alias RLet {
  Revo_Vars_EchoAct
  Revo_Vars_Echo
  var %i = 0
  $iif($1 == $null, %echo 07[RANDOM STRING] 03Know that you can use 10‘/rlet <AMOUNT>’03 to specify the lenght of the string.)
  var %amount = $iif($1 != $null, $1, 20)
  if (%amount >= 500) { set %amount 501 | %echo 07[RANDOM STRING]03 Your lenght $+($chr(40),07,$1,,03,$chr(41)) has been reduced to 0750003. }
  while (%i <= $calc(%amount -1)) {
    set %output %output $+ $getletter
    inc %i
  }
  %echo 07[RANDOM STRING] %output
  %echoact 07[RANDOM STRING] %output
  unset %x, %i, %output
}
alias -l GetLetter {
  var %x = $rand(1, 52)
  if (%x == 1) { return a }
  if (%x == 2) { return b }
  if (%x == 3) { return c }
  if (%x == 4) { return d }
  if (%x == 5) { return e }
  if (%x == 6) { return f }
  if (%x == 7) { return g }
  if (%x == 8) { return h }
  if (%x == 9) { return i }
  if (%x == 10) { return j }
  if (%x == 11) { return k }
  if (%x == 12) { return l }
  if (%x == 13) { return m }
  if (%x == 14) { return n }
  if (%x == 15) { return o }
  if (%x == 16) { return p }
  if (%x == 17) { return q }
  if (%x == 18) { return r }
  if (%x == 19) { return s }
  if (%x == 20) { return t }
  if (%x == 21) { return u }
  if (%x == 22) { return v }
  if (%x == 23) { return w }
  if (%x == 24) { return x }
  if (%x == 25) { return y }
  if (%x == 26) { return z }
  if (%x == 27) { return A }
  if (%x == 28) { return B }
  if (%x == 29) { return C }
  if (%x == 30) { return D }
  if (%x == 31) { return E }
  if (%x == 32) { return F }
  if (%x == 33) { return G }
  if (%x == 34) { return H }
  if (%x == 35) { return I }
  if (%x == 36) { return J }
  if (%x == 37) { return K }
  if (%x == 38) { return L }
  if (%x == 39) { return M }
  if (%x == 40) { return N }
  if (%x == 41) { return O }
  if (%x == 42) { return P }
  if (%x == 43) { return Q }
  if (%x == 44) { return R }
  if (%x == 45) { return S }
  if (%x == 46) { return T }
  if (%x == 47) { return U }
  if (%x == 48) { return V }
  if (%x == 49) { return W }
  if (%x == 50) { return X }
  if (%x == 51) { return Y }
  if (%x == 52) { return Z }
}
 
alias GenPass {
  Revo_Vars_EchoAct
  Revo_Vars_Echo
  var %i = 0
  $iif($1 == $null, %echo 07[RANDOM STRING] 03Know that you can use 10‘/genpass <AMOUNT>’03 to specify the lenght of the string.)
  var %amount = $iif($1 != $null, $1, 20)
  if (%amount >= 500) { set %amount 501 | %echo 07[PASSWORD]03 Your lenght $+($chr(40),07,$1,,03,$chr(41)) has been reduced to 0750003. }
  while (%i <= $calc(%amount -1)) {
    set %output %output $+ $generatepassword
    inc %i
  }
  %echo 07[PASSWORD] %output
  %echoact 07[PASSWORD] %output
  unset %x, %i, %output
}
 
alias -l ConfigPasswordGenerator {
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  %echo Configuring password generator...
  ConfigPasswordGeneratorHelp
  var %input = $input(Please fill in a value in between 1 and 5 - This will set your preference on the password generator. [Default = 5], e, Password generator config.)
  if (%input >= 1 && %input <= 5) {
    %echoact 07[PASSWORD GENERATOR CONFIGURED]03 You have set the mode to10 %input $+ 03.
    %echo 03You have set the mode to10 %input $+ 03.
  }
  if (%input >= 6) {
    %echoact 07[PASSWORD GENERATOR ERROR]03 Value too high [10 $+ %input $+ ]03.
    %echo 04ERROR:03 Value too high, set to 10503 instead, activated error recovery.
    var %input = 5
    %echoact 07[PASSWORD GENERATOR CONFIGURED]03 You have set the mode to10 %input $+ 03.
    %echo 03You have set the mode to10 %input $+ 03.
  }
  if (%input !isnum) {
    %echoact 07[PASSWORD GENERATOR ERROR]03 Value not a number [10 $+ %input $+ ]03.
    %echo 04ERROR:03 Value not a number, set to 10503 instead, activated error recovery.
    var %input = 5
    %echoact 07[PASSWORD GENERATOR CONFIGURED]03 You have set the mode to10 %input $+ 03.
    %echo 03You have set the mode to10 %input $+ 03.
  }
  writeini -n NickAlert.ini Data PWGEN %input
}
 
alias -l ConfigPasswordGeneratorHelp {
  Revo_Vars_Echo
  %echo 07[1.]10 Non-capital letters only. - Example: qhjplncf
  %echo 07[2.]10 Capital and non-capital letters. - Example: QNWcnwjn
  %echo 07[3.]10 Numbers, capitals and non capitals. - Example: 656m3Lrz
  %echo 07[4.]10 Symbols, Numbers, Capitals & non capitals. - Example: r#z&%Y#O
  %echo 07[5.]10 Unique symbols, Symbols, Numbers, Capitals & Non capitals. - Example: Yga€5%Gw
  %echo The higher the number, the more secure your password will be, but it will also be more difficult to remember or type in.
}
 
;Settings
; 1 - 26, non capitals.
;27 - 52, Capitals.
;53 - 62, numbers.
;63 - 69, normal Symbols.
;70 - 78, Unique symbols.
 
alias -l GeneratePassword {
  if ($readini(NickAlert.ini, Data, PWGen) != $null) {
    var %value = $readini(NickAlert.ini, Data, PWGen)
    if (%value == 1) { var %maxval = 26 }
    if (%value == 2) { var %maxval = 52 }
    if (%value == 3) { var %maxval = 62 }
    if (%value == 4) { var %maxval = 69 }
    if (%value == 5) { var %maxval = 78 }
  }
  if ($readini(NickAlert.ini, Data, PWGEN) == $null) {
    var %maxval = 78
  }
 
  var %x = $rand(1, %maxval)
  if (%x == 1) { return a }
  if (%x == 2) { return b }
  if (%x == 3) { return c }
  if (%x == 4) { return d }
  if (%x == 5) { return e }
  if (%x == 6) { return f }
  if (%x == 7) { return g }
  if (%x == 8) { return h }
  if (%x == 9) { return i }
  if (%x == 10) { return j }
  if (%x == 11) { return k }
  if (%x == 12) { return l }
  if (%x == 13) { return m }
  if (%x == 14) { return n }
  if (%x == 15) { return o }
  if (%x == 16) { return p }
  if (%x == 17) { return q }
  if (%x == 18) { return r }
  if (%x == 19) { return s }
  if (%x == 20) { return t }
  if (%x == 21) { return u }
  if (%x == 22) { return v }
  if (%x == 23) { return w }
  if (%x == 24) { return x }
  if (%x == 25) { return y }
  if (%x == 26) { return z }
  if (%x == 27) { return A }
  if (%x == 28) { return B }
  if (%x == 29) { return C }
  if (%x == 30) { return D }
  if (%x == 31) { return E }
  if (%x == 32) { return F }
  if (%x == 33) { return G }
  if (%x == 34) { return H }
  if (%x == 35) { return I }
  if (%x == 36) { return J }
  if (%x == 37) { return K }
  if (%x == 38) { return L }
  if (%x == 39) { return M }
  if (%x == 40) { return N }
  if (%x == 41) { return O }
  if (%x == 42) { return P }
  if (%x == 43) { return Q }
  if (%x == 44) { return R }
  if (%x == 45) { return S }
  if (%x == 46) { return T }
  if (%x == 47) { return U }
  if (%x == 48) { return V }
  if (%x == 49) { return W }
  if (%x == 50) { return X }
  if (%x == 51) { return Y }
  if (%x == 52) { return Z }
  if (%x == 53) { return 1 }
  if (%x == 54) { return 2 }
  if (%x == 55) { return 3 }
  if (%x == 56) { return 4 }
  if (%x == 57) { return 5 }
  if (%x == 58) { return 6 }
  if (%x == 59) { return 7 }
  if (%x == 60) { return 8 }
  if (%x == 61) { return 9 }
  if (%x == 62) { return 0 }
  if (%x == 63) { return * }
  if (%x == 64) { return @ }
  if (%x == 65) { return $chr(35) }
  if (%x == 66) { return $ }
  if (%x == 67) { return % }
  if (%x == 68) { return ^ }
  if (%x == 69) { return & }
  if (%x == 70) { return $euro }
  if (%x == 71) { return $lt }
  if (%x == 72) { return $gt }
  if (%x == 73) { return $br1 }  
  if (%x == 74) { return $br2 }
  if (%x == 75) { return $bsl }
  if (%x == 76) { return $sl }
  if (%x == 77) { return $cbr1 }
  if (%x == 78) { return $cbr2) }
}
 
;Google Search
alias googlesearch {
  var %x = 1
  while ($sock($+(google,%x))) inc %x
  sockopen $+(google,%x) www.google.com 80
  sockmark $+(google,%x) $1-
}
 
alias google { googlesearch google2 $1- }
alias gsearch { googlesearch google2 $1- }
 
alias google2 {
  echo -ta 10 $+ Google search: $1-
  %echoact 10 $+ Google search: $1-
}
 
ON *:SOCKOPEN:google*: {
  if ($sockerr) {
    var %cmd = $gettok($sock($sockname).mark,1,32)
    %cmd Socket error $sockerr
    return
  }
  sockwrite -n $sockname GET $+(/search?q=,$phex($gettok($sock($sockname).mark,2-,32)),&btnI=I%27m+Feeling+Lucky HTTP/1.0)
  sockwrite $sockname $crlf
}
 
on *:SOCKREAD:google*: {
  var %f, %cmd, %result
  %cmd = $gettok($sock($sockname).mark,1,32)
 
  if ($sockerr) {
    %cmd Socket error $sockerr
    return
  }
 
  while (1) {
    sockread %f
    if (!$sockbr) break
    if (<A HREF="*">here</a>. iswm %f) {
      %result = $gettok(%f,2,34)
      sockclose $sockname
      break
    }
    elseif (HTTP/1.0 200 OK = %f) {
      %result = There are no results.
      sockclose $sockname
      break
    }
  }
 
  if (%result) {
    %cmd %result
  }
}
 
; Convert some text to hexadecimal form
alias phex {
  var %x = 1, %s = $len($1), %r, %w
  while (%x <= %s) {
    %w = $mid($1,%x,1)
    if ($asc(%w) = 32) {
      %r = $+(%r,+)
    }
    elseif ($asc(%w) !isnum 65-90) && ($asc(%w) !isnum 97-122) && ($asc(%w) !isnum 48-57) {
      %r = $+(%r,%,$base($asc(%w),10,16,2))
    }
    else {
      %r = $+(%r,%w)
    }
    inc %x
  }
  return %r
}
 
;Google calculator
 
alias gcalc {
  if $sock(calculate) || $sock($+(calculate,$nick)) {
    sockclose $v1
  }
  sockopen $iif($event == text,$+(calculate,$nick),calculate) www.google.com 80
  sockmark $iif($event == text,$+(calculate,$nick) msg $iif(#,#,$nick),calculate echo -a) $1-
}
 
alias calculate {
  if $sock(calculate) || $sock($+(calculate,$nick)) {
    sockclose $v1
  }
  sockopen $iif($event == text,$+(calculate,$nick),calculate) www.google.com 80
  sockmark $iif($event == text,$+(calculate,$nick) msg $iif(#,#,$nick),calculate echo -a) $1-
}
 
on *:sockopen:calculate*:{
  tokenize 32 $sock($sockname).mark
  sockwrite -nt $sockname GET $+(/ig/calculator?hl=en&q=,$urlencode($3-)) HTTP/1.1
  sockwrite -nt $sockname Host: www.google.com
  sockwrite -nt $sockname Connection: close
  sockwrite -nt $sockname $crlf
}
 
on *:sockread:calculate*:{
  sockread &greader
  var %greader $bvar(&greader,1-).text
  tokenize 32 $sock($sockname).mark
  if $regex(answer $+ $2,%greader,/rhs: "(.*?)"/) && $regex(calc $+ $2,%greader,/lhs: "(.*?)"/) {
    $1-2 $iif($regml(answer $+ $2,1) == $null,4Something is wrong with the calculation!,03 $&
      $+ $csub($cchr($sup($replace($regml(calc $+ $2,1) = $v1,+,04+03,-,06-03,*,13*03,/,07/03,=,10=03)))))
    sockclose $sockname
  }
}
 
alias cchr return $regsubex($1,/\\x26#(\d+?);/g,$chr(\1))
alias sup return $regsubex($1,/\\x3csup\\x3e([\d-]+?)\\x3c\/sup\\x3e/Sg,12^\13)
alias urlencode return $regsubex($1,/(\W)/g,% $+ $base($asc(\1),10,16,2)))
alias csub return $regsubex($1,/\\x3csub\\x3e(.+?)\\x3c\/sub\\x3e/g,\1)
 
;Track by Revo.
alias Track {
  Revo_Vars_EchoAct
  Revo_Vars_Echo
  if (%Track.nick != $null) {
    set %Track.off $input(You're currently already tracking %track.nick $+ . Do you wish to stop tracking him?, y, Stop tracking %track.nick )
    if (%Track.Off) {
      %echo Stopped tracking %Track.nick
      %echoact 07[TRACK] Stopped tracking %Track.nick
      unset %Track.*
    }
    else {
      %echo You haven't stopped tracking %Track.nick $+ .
    }
  }
  if (%Track.nick == $null) {
    if ($cb != $null && $len($cb) <= 30) {
      set %Track.CB $input(Use the information from your clipboard as track nick?, y, Use $+(',$cb,') as tracknick?)
      if (%track.CB) {
        set %Track.nick $cb
      }
    }
    set %Track.Nick $?"Who do you want to track?"
    if (%Track.nick != $null) {
      set %Track.on $true
      echo -a You are now tracking10 %track.nick $+ .
    }
  }
}
 
;first dialog ever man. Terms of Service.
alias tos {
  dialog -m termsofservice termsofservice
  var %inp = 1
  if (!%inp) {
    echo -a Unloading script, user disagreed to terms and services!
    ;unload $nodir($script)
  }
  else {
    echo -a User agreed to terms and conditions.
  }
}
 
dialog termsofservice {
  title "Terms of Service"
  icon index
  size 100 100 250 250
  option dbu
 
  text "Terms of Service: ", 1, 15 15 200 200, left
  text "By using this script you agree to do as i say, you are not allowed to claim rights for your own or distribute the script without Revo's permission. The script will automatically detect people who work around this very goal and will disable itself upon detection of such actions.", 2, 10 10 200 200, center
  text "Copyright Revo Inc. ©", 4, 120 240 200 200, center
 
  button "Agree", 8, 50 200 33 18, ok
  button "Cancel, Disagree", 9, 100 200 80 18, cancel
}
 
on *:DIALOG:termsofservice:sclick:8: {
  Revo_Accepted_ToS
}
 
on *:DIALOG:termsofservice:sclick:9: {
  Revo_Declined_ToS
}
 
alias mubAdd {
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  var %input = $input(Add what channel from the mass unban list?,e,Mass Unban Add)
  if ($left($1, 1) != #) {
    var %input = $chr(35) $+ %input
  }
  %echo 03Added10 %input 03to mass unban list.
  %echoact 07[MASS UNBAN]03 Added10 %input 03to the mass unban list.
  writeini -n NickAlert.ini Unban %input
}
 
alias mubRem {
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  var %input = $input(Remove what channel from the mass unban list?,e,Mass Unban Remove.)
  if ($left($1, 1) != #) {
    var %input = $chr(35) $+ %input
  }
  if ($readini(NickAlert.ini,Unban,%input) != $null) {
    %echo 03Removed10 %input 03from mass unban list.
    %echoact 07[MASS UNBAN]03 Removed10 %input 03from the mass unban list.
    remini NickAlert.ini Unban %input
    halt
  }
  else {
    %echo 10 $+ %input 03was not found in the mass unban list.
  }
}
 
 
;Unban system
alias massunban {
  var %i = 0
  Revo_Vars_Echo
  Revo_Vars_EchoAct
 
  while (%i <= $ini(NickAlert.ini, Unban, 0)) {
    cs unban $ini(NickAlert.ini, Unban, %i)
    %echo Unbanned yourself from $ini(NickAlert.ini, Unban, %i) $+ .  
 
    if (%i >= 15) {
      %echo Stopped due to value getting too high (over %i $+ ).
      %echoact 07[UNBAN]03 Stopped due to value getting too high (over10 %i $+ 03).
 
      break
    }
 
    inc %i
  }
  %echoact 07[UNBANNED]03 Unbanned yourself from10 %i 03channels.
}
 
dialog Unban {
  title "Add or remove a channel from your mass-unban."
  icon index
  size 100 100 200 140
  option dbu
 
  text "What channel do you wish to add/remove to your unban list (Prefix it with a #).", 2, 38 10 125 125, center
  text "Copyright Revo Inc. ©", 4, 107 130 125 125, center
 
  edit "", 6, 25 28 155 55, center
 
  button "Add channel.", 8, 20 100 50 15, ok
  button "Remove channel", 9, 80 100 50 15, cancel
  button "Close", 10, 140 100 50 15, cancel
}
 
on *:DIALOG:Unban:sclick:8: {
  var %input = $true
  $Add_Unban(%input)
}
 
on *:DIALOG:Unban:sclick:9: {
  var %input = $true
  $Rem_Unban(%input)
}
 
alias -l Add_Unban {
  echo -a %input
  var %input = $1-
  echo -a %input
  if (%input != $null) {
    writeini -n NickAlert.ini UNBAN %input
  }
  if (%input == $null) {
    Revo_Vars_Echo
    %echo Error occured, input was null.
  }
}
 
alias -l Rem_Unban {
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  echo -a %input
  var %input = $1-
  echo -a %input
  if (%input != $null) {
    var %i = 0
    while (%i <= $ini(NickAlert.ini, Unban, 0) {
      if (%input isin $ini(NickAlert.ini, Unban, %i)) {
        remini $readini(NickAlert.ini, Unban, %i)
        break
      }
      if (%i >= 100) {
        %echo Not found, halting script.
        break
      }
    }
    %echo Removed %i ( $+ $ini(NickAlert.ini, Unban, %i) $+ , value %i $+ ) from the channel unban list.
    %echoact Removed %i ( $+ $ini(NickAlert.ini, Unban, %i) $+ , value %i $+ ) from the channel unban list.
  }
  if (%input == $null) {
    Revo_Vars_Echo
    %echo Error occured, input was null.
  }
}
 
alias userlist {
  Revo_Vars_EchoAct
  Revo_Vars_Echo
  var %chan = $iif($1- == $null, $active, $1-)
  var %i = 1
  while (%i <= $nick(%chan, 0)) {
    set %users $iif(%users == $null, 03User list10 %chan 03 $+ $chr(40) $+ 10 $+ $nick(%chan, 0) $+ 03 $+ $chr(41) ) %users $+ $iif(%users != $null,$chr(44) $+ $chr(32)) $+ 03 $+ $left($nick($chan, %i).pnick,1) $+ $nick(%chan, %i) 07( $+ %i $+ )
    inc %i
  }
  %echo %users
  %echoact 07[USER LIST] %users
  unset %users
}
 
alias chanlist {
  Revo_Vars_EchoAct
  Revo_Vars_Echo
  var %i = 1
  while (%i <= $chan(0)) {
    var %x = $chan(%i)
    set %y $iif(%y != $null, %y $+  $+ $chr(44)) 10 $+ $chan(%x) 07[ $+ %i $+ ]
    inc %i
  }
  %echo 03Channel list,10 $chan(0) 03channels: %y
  %echoact 07[CHAN LIST] 03Listed all 07 $+ $chan(0) 03channels: %y
  unset %y
}
 
alias hopall {
  Revo_Vars_Echo
  Revo_Vars_EchoAct
  var %i = 1
  while (%i <= $chan(0)) {
    var %x = $chan(%i)
    part $chan(%x) 03Cycling all channels (10 $+ $chan(0) $+ 03) $iif($1- != $null, [Reason:10 $1- $+ 03])
    .timer 1 3 join $chan(%x)
    set %y $iif(%y != $null, %y $+  $+ $chr(44)) 10 $+ $chan(%x) 07[ $+ %i $+ ]
    set %xy $iif(%xy != $null, %y $chr(44)) $+ $chan(%x)
    inc %i
    if (%i >= 50) {
      break
    }
  }
  %echoact 07[HOPALL] 03Hopped from 07 $+ $chan(0) 03channels: %y
  %echoact 07[HOPALL] 03Missing a channel due to a bug? /join $strip(%xy)
  unset %x, %i, %y, %xy
}
/*
alias rmsg {
  msg #Revo $Revo_Encode($1-)
  Revo_Vars_Echo
  %echo Successfully sent $Revo_Encode($1-) ( $+ $1- $+ ) to all script users.
  echo -tng #Revo 07[DECODE] $1-
}
 
alias Revo_Msg_Users_Menu {
  var %msg = $input(What do you want to message to everyone using the script?, e, Message all script users.)
  msg #Revo $Revo_Encode(%msg)
  Revo_Vars_Echo
  %echo Successfully sent $Revo_Encode(%msg) ( $+ %msg $+ ) to all script users.
  echo -tng #Revo 07[DECODE] %msg
}
*/
 
alias TSRemNotes {
  Revo_Vars_EchoAct
  Revo_Vars_Echo
  if ($readini(NickAlert.ini, Data, TimeStampStripNotes) == $false || $readini(NickAlert.ini, Data, TimeStampStripNotes) == $null) {
    writeini -n NickAlert.ini Data TimeStampLenght $len($timestamp)
    writeini -n NickAlert.ini Data TimeStampStripNotes $true
    %echo 03You have enabled 10TimeStamp stripping03 on notes.
    %echoact 07[ENABLED] 03You have enabled 10TimeStamp stripping03 on notes.
    halt
  }
  else {
    writeini -n NickAlert.ini Data TimeStampLenght $len($timestamp)
    writeini -n NickAlert.ini Data TimeStampStripNotes $false
    %echo 03You have disabled 10TimeStamp stripping03 on notes.
    %echoact 07[DISABLED] 03You have disabled 10TimeStamp stripping03 on notes.
    halt
  }
}
 
;Easy tags.
alias commas { return $chr(44)   } ;Comma                 (,)
alias nbsp  { return $chr(160)  } ;Non breakable space.  ( )
alias sp    { return $chr(32)   } ;Space.                ( )
alias space { return $chr(32)   } ;Space.                ( )
alias lt    { return $chr(60)   } ;Less than             (<)
alias gt    { return $chr(62)   } ;Greater than          (>)
alias trade { return $chr(8482) } ;Trademark             (™)
alias reg   { return $chr(174)  } ;Registered Trademark  (®)
alias euro  { return $chr(8364) } ;Euro                  (€)
alias yen   { return $chr(165)  } ;Yen                   (¥)
alias pound { return $chr(163)  } ;British Pound         (£)
alias dol   { return $chr(36)   } ;Dollar                ($)
alias cent  { return $chr(162)  } ;Cent                  (¢)
alias amp   { return $chr(38)   } ;Amp                   (&)
alias br1   { return $chr(40)   } ;Bracket               (()
alias br2   { return $chr(41)   } ;Bracket               ())
alias hash  { return $chr(35)   } ;Hash                  (#)
alias bsl   { return \          } ;Backslash             (\)
alias sl    { return /          } ;Slash                 (/)
alias cbr1  { return $chr(123)  } ;Curly bracket 1       ({)
alias cbr2  { return $chr(125)  } ;Curly bracket 2       (})
 
alias strlen { echo -tnga 09[STRLEN] $+(",10,$1-,") has the lenght of:07 $len($1-) }
 
alias getval {
  if ($1 isnum) {
    if ($len($1-) == 6) { var %x = $left($1, 3) $+ k }
    if ($len($1-) == 7) { var %x = $left($1, 1) Million }
    if ($len($1-) == 8) { var %x = $left($1, 2) Million }
    if ($len($1-) == 9) { var %x = $left($1, 3) Million }
 
    if (%x != $null) echo -tnga Value "10 $+ $1- $+ " is07 %x $+ .
    else echo -tnga Value not found.
  }
  else echo -tnga Not a value.
}
 
alias getms {
  if ($1 !isnum) { echo -tnga Value is not a number.. | halt }
  echo -tnga Value:07 $1- $+ . $+([,$comma($1-),])
  echo -tnga Value in MS:07 $calc($1- * 1000) $+([,$comma($calc($1- * 1000)),])
  echo -tnga Value in seconds:07 $calc($1- / 1000) $+([,$comma($calc($1- / 1000)),])
  echo -tnga Value in minutes:07 $calc($1- / 1000 / 60) $iif($calc($1- / 1000 / 60) >= 1000, $+([,$comma($calc($1- / 1000 / 60)),]))
}
 
alias getsec {
  $getms($1-)
}
 
alias comma {
  var %comma = $1, %x
  while %comma {
    %x = $+($right(%comma,3),$chr(44),%x)
    %comma = $left(%comma,-3)
  }
  return $left(%x,-1)
}
 
alias cheattest {
  var %q = $?"How many questions are there?"
  if (%q !isnum) { echo -tnga %q has to be a number. }
  else {
    var %i = 0
    var %y = 0
    var %z = 0
    var %p = 1
    while (%i < %q) {
      var %x = $rand(1, 4)
      if (%x == 1) { set %a $iif(%a != $null, %a) 03A }
      if (%x == 2) { set %a $iif(%a != $null, %a) 10B }
      if (%x == 3) { set %a $iif(%a != $null, %a) 08C }
      if (%x == 4) { set %a $iif(%a != $null, %a) 04D }
      inc %y
      if (%y == 10) {
        var %y = 0
        var %z = $calc(%z + 10)
        echo -tnga 09Answers $+([03,%p,$nbsp,-10,$nbsp,%z,]:) %a
        var %p = $calc(%p + 10)
        unset %a
      }
      inc %i
    }
  }
  if (%a != $null) {
    echo -tnga Answers: %a
  }
  unset %a, %q, %y, %i, %z, %p
}
 
alias registerchannel {
  if ($1 == $null) { return Echo -tnga Syntax: /registerchannel #channelname }
  var %x = $iif($left($1, 1) != $hash, $hash) $+ $1
  var %i = 0
  while (%i < 7) {
    set %y %y $+ $getletter
    inc %i
  }
 
  join %x
  cs register %x %y $me $+ 's IRC channel.
  bs assign %x dCRRPG
  cs levels %x set autovoice -1
  cs levels %x set unban 1
  cs topic %x 07||03 Welcome to10 %x $+ 03! 07||10 $me $+ 03's IRC channel. 07||
 
  Revo_Vars_EchoAct
  Revo_Vars_Echo
 
  .timer 1 1 %echo 07[CHANNEL REGISTERED]03 Password to10 %x 03is:10 %y 03- REMEMBER THIS, you will be able to /cs identify with that.
  .timer 1 1 %echoact 07[CHANNEL REGISTERED]03 Password to10 %x 03is:10 %y 03- REMEMBER THIS, you will be able to /cs identify with that.
  unset %i
  unset %y
  unset %x
}
 
alias ircpm {
  if ($network == MoinGaming) {
    if ($nick == Robo-Cop || $Nick == Robo-Thief) {
      if (IRC isin $strip($1-) && PM isin $strip($1-)) {
        return $true
      }
    }
  }
  return $false
}
 
alias slapall {
  var %i = 1, %x = 1, %channel = $active
  if ($nick($active, 0) >= 20) { var %x = $input(Are you sure you wish to slap $nick($active,0) people?, y) }
  if (%x) {
    while (%i <= $nick($active, 0)) {
      if ($nick(%channel, %i) == $null || $nick($channel, %i) isnum) { break }
      describe %channel $iif($nick(%channel, %i) != $me, $randomslap($nick(%channel, %i)), iam best)
      inc %i
    }
  }
  else {
    echo -a Halting - Disagreed to spam the channel with $nick($active, 0) slaps.
  }
}
 
alias randomslap {
  var %rand = $rand(1,10)
  if (%rand == 1) { return slaps $1- around a bit with a large trout. }
  if (%rand == 2) { return slaps $1- around a bit with a 4r5a6i7n8b9o10w trout. }
  if (%rand == 3) { return slaps $1- around a bit with a 11r10a12i2n13b9o8w trout }
  if (%rand == 4) { return throws a boulder at $1- $+ . }
  if (%rand == 5) { return molests $1- }
  if (%rand == 6) { return causes $1- to fall over a tripwire. }
  if (%rand == 7) { return farts in $1- $+ 's face. }
  if (%rand == 8) { return summons evil monkeys to kill $1- $+ . }
  if (%rand == 9) { return Heeey $1- $+ , how about a foot in your ass? }
  if (%rand == 10) { return Heeey $1- $+ , I wrote a book called "The road to my foot in your ass". }
}
 
alias devoiceall {
  var %actchannel = $active, %i = 1, %modeset = - $+ $str(v,$nick(%actchannel,0))
  while (%i <= $nick(%actchannel,0)) {
    set %userslist $iif(%userslist != $null, %userslist $nick(%actchannel,%i), $nick(%actchannel,%i))
    inc %i
  }
  mode %actchannel %modeset %userslist
  unset %userslist
}
 
alias voiceall {
  var %actchannel = $active, %i = 1, %modeset = + $+ $str(v,$nick(%actchannel,0))
  while (%i <= $nick(%actchannel,0)) {
    set %userslist $iif(%userslist != $null, %userslist $nick(%actchannel,%i), $nick(%actchannel,%i))
    inc %i
  }
  mode %actchannel %modeset %userslist
  unset %userslist
}
 
alias BeginWith {
  if (%beginwith == $null) {
    set %beginwith $input(What should your sentences start with?,e)
  }
  else {
    unset %beginwith
    echo -tnga Begin with Mode toggled off.
  }
}
 
alias EndWith {
  if (%endwith == $null) {
    set %endwith $input(What should your sentences end with?,e)
  }
  else {
    unset %endwith
    echo -tnga End with Mode toggled off.
  }
}
 
alias top10 {
  var %total = $ini(NickAlert.ini, Amount, 0), %i = 1  
  :list
  if (%i >= %total) { echo -a %w | goto listend }
  var %w $+(%w,:,$readini(NickAlert.ini, amount, $replace($ini(NickAlert.ini, amount, %i), -, $chr(45), [, ~, ], `)),-,$ini(NickAlert.ini, Amount, %i))
  var %w $sorttok(%w,58,nr)
  inc %i
  if (%i > 250) { echo -a %w | halt }
  goto list
  :listend
  var %w $right(%w, -4)
  var %w $replace(%w, -, $nbsp)
  var %w $replace(%w, ~, [, `, ], _, -)
  echo -a msg $chan 10[TOP 10 NICKALERTS]: %w
}
 
alias up { msg $active $upper($1-) }
alias low { msg $active $lower($1-) }
 
alias idlechan { $iif($1 == $null, Revo_Get_IdleTime_Nicks, $Revo_Get_IdleTime_nicks($1-)) }
alias -l Revo_Get_IdleTime_nicks {
  var %i = 1, %x = 0, %tmp = $iif($1 == $null, $active, $1-)
  while (%i <= $nick(%tmp,0)) {
    var %list = $iif(%list != $null, %list $+ $chr(44)) 10 $+ $nick(%tmp,%i) $+ :03 $duration($nick(%tmp, %i).idle) $+ 
    if (%x == 3) {
      echo -tnga 07Idle times09 %tmp $+(11,[,$nick(%tmp,0),]:,) $right(%list, -2))
      %x = 0
      unset %list
    }
    inc %x
    inc %i
  }
  $iif($len(%list) > 5, echo -tnga 07Idle times09 %tmp $+(11,[,$nick(%tmp,0),]:,) $right(%list, -2))
}
 
alias iniinc {
  if ( $4 == $null ) {
    return echo -tnga Insufficiant parameters. Usage: $iniinc(Location.ini, (tag), (name), Increment by (value))
  }
  else {
    var %incby = $calc($readini($1, $2, $3) + $4)
    writeini -n $1 $2 $3 %incby
  }
}
 
alias -l bob_getnick { return $iif($pos($1,$chr(41),0) == 0,$strip($$1),$strip($left($$1,$calc($pos($$1,$chr(40),$pos($$1,$chr(40),0)) -1)))) }
alias -l bob_getid { var %id = $strip($right($$1,$calc($len($$1) - $pos($$1,$chr(40),$pos($$1,$chr(40),0)))))) | return $calc($left(%id,$pos(%id,$chr(41),1))) }
 
;Get mode/prefix, use this to get permissions from a channel / owner,
;e.g. if ($getMode($chan, $nick) == 5) echo -a That person is a channel owner!
;Or if ($getPrefix($chan, $nick) == ~) echo -a That person is a channel owner!
 
alias getPrefix { $iif($2 != $null, return $left($nick($1,$2).pnick,1), echo -tng Usage: $chr(36) $+ getPrefix(channel, nickname)) }
 
alias getMode {  
  if ($2 == $null) return echo -tnga Usage: $chr(36) $+ getMode(channel, nickname).
  var %prefix = $getPrefix($1, $2)
  if (%prefix == ~) return 5
  if (%prefix == &) return 4
  if (%prefix == @) return 3
  if (%prefix == %) return 2
  if (%prefix == +) return 1
  return 0
}
 
alias superspam {
  if ($exists(NickAlert.ini) && $1 != $null) {
    $spam(repeat, 11, $1-)
    $spam(revrep, 10, $1-)
  }
  else {
    echo -tnga {ERROR} Not installed: Revo's all in one OR no parameters given.
  }
}
 
alias tkb {
  if ($1 == $null) {
    echo -tnga Usage: /tkb NICKNAME OPTIONAL:TIME(SECONDS(DEFAULT:60)) OPTIONAL:REASON, use the -i switch (/tkb -i60) to invite the user back in the channel after expiry of the ban.
    halt
  }
  if (-i isin $2) { var %invite.tkb $true }  
  var %time = $iif($2 != $null, $remove($2, -i), 60)
  if (%time !isnum) var %time = 60
  mode # +b $address($1,1)
  kick # $1 Time-kickban 0( $+ $iif($3- != $null, $3-, No reason specified) ( $+ %time seconds.))
  .timer 1 %time msg # A timeban has expired on $1 (Reason: $iif($3- != $null, $3-, No reason specified) $+ ) for %time seconds.
  .timer 1 %time mode # -b $address($1,1)
  $iif(%invite.tkb, .timer 1 %time invite $1 #)
}
 
alias getBots {
  if ($1 == $null) { return echo -tnga Usage: $ $+ getBots(channel). }
  else {  
    if ($1 != #regs && $1 != #crrpg && $1 != #oper && $me !ison $1) {
      echo -tnga You're not on channel: $1-
      } else {
      var %i = 1
      var %bots = $nick($1, 0, h)
      :start
      if ($nick($1, %i, h) != $null) { var %nick = $iif(%nick != $null, %nick $+ $chr(44)) $nick($1, %i, h)) }
      inc %i
      if (%i > 150 || $len(%nick > 150)) { goto end }
      goto start
      :end
      return %nick
    }
  }
}
