---------------------------------------------------------------------------------------------------------------------------------------------

-- Main --
import XMonad
import System.IO

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.ManageHook
import XMonad.Operations
import XMonad.Actions.CycleWS

-- Hooks --
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops

-- Utils --
import XMonad.Util.Themes
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
-- Layout --
import XMonad.Layout.Spiral
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Layout.ResizableTile

-- Extra --
import qualified XMonad.StackSet as W
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified Data.Map as M

import Graphics.X11.Xlib
import Data.Char
import Data.Bits ((.|.))

import System.Exit

---------------------------------------------------------------------------------------------------------------------------------------------

colLight       = "#8a999e"
colDark        = "#343d55"
colVeryDark    = "#000000"
colTextLight   = "#ffffff"
colTextDark    = "#bbbbbb"
colBorderLight = colLight --"#77cc77"
colBorderDark  = colDark

---------------------------------------------------------------------------------------------------------------------------------------------

myFont               = "xft:DejaVu Sans:size=10"
focusColor           = "#60ff45"
textColor            = "#c0c0a0"
lightTextColor       = "#fffff0"
backgroundColor      = "#304520"
lightBackgroundColor = "#456030"
urgentColor          = "#ffc000"

---------------------------------------------------------------------------------------------------------------------------------------------

myManageHook = composeAll [
    className =? "MPlayer" --> doFloat,
    className =? "Gimp" --> doFloat,
    className =? "Vncviewer" --> doFloat,
    title     =? "Downloads" --> doFloat,
    className =? "Vlc" --> doFloat,
    title     =? "Shiretoko" --> doF (W.shift "web"),
    title     =? "Downloads" --> doF (W.shift "down"),
    title     =? "Deluge" --> doF (W.shift "down"),
    className =? "XCalc" --> doFloat
    ]
    
tiled = ResizableTall 1 (2/100) (1/2) []

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#000000"

borderWidth' :: Dimension
borderWidth' = 1

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
	{ font        = myFont
	, bgColor     = backgroundColor
	, fgColor     = textColor
	, fgHLight    = lightTextColor
	, bgHLight    = lightBackgroundColor
	, position    = Bottom
    , height      = 16
    , historySize = 100
	, borderColor = lightBackgroundColor
	}

---------------------------------------------------------------------------------------------------------------------------------------------

myPP h = defaultPP 
                 { ppCurrent = wrap "^fg(#cd5c5c)^p(1)" "^p(1)^fg()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
--                 , ppVisible = wrap "^bg(grey30)^fg(grey75)^p(1)" "^p(1)^fg()^bg()"
                 , ppHidden = wrap "^fg(grey80)^p(1)" "^p(1)^fg()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
                 , ppHiddenNoWindows = wrap "^fg(#456030)^p(1)" "^p(1)^fg()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
                 , ppSep = " ^fg(grey40)^r(2x12)^fg() "
--                 , ppUrgent = dzenColor "red" ""
         		 , ppWsSep = " "
		         , ppLayout = dzenColor "grey80" "" .
		  		       (\x -> case x of
                            "Tall" -> "^i(/home/vikki/.xmonad/dzen/tall.xbm)"
                            "Mirror Tall" -> "^i(/home/vikki/.xmonad/dzen/mtall.xbm)"
                            "Accordion" -> "Accordion"
                            "Full" -> "^i(/home/vikki/.xmonad/dzen/full.xbm)"
                            "Grid" -> "Grid"
                            "Spiral" -> "sP"
                       )
--                 , ppTitle   = dzenColor "white" "" . wrap "< " " >" 
                 , ppTitle = dzenColor "#fffff0" "" .shorten 580
                 , ppOutput = hPutStrLn h
                 }

---------------------------------------------------------------------------------------------------------------------------------------------

mySpiral = spiral (4/3)
-- Define layout list
myLayout = smartBorders $ ewmhDesktopsLayout $ avoidStruts (Mirror tiled ||| tiled ||| Full ||| Grid ||| mySpiral ||| Accordion)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled      = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster    = 1

     -- Default proportion of screen occupied by master pane
     ratio      = 1/2

     -- Percent of screen to increment by when resizing panes
     delta      = 3/100
     
---------------------------------------------------------------------------------------------------------------------------------------------

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
       [((modMask,                  xK_Return),             spawn "urxvt")
      , ((modMask .|. shiftMask,    xK_l     ),             spawn "xscreensaver-command -lock")
      , ((modMask .|. shiftMask,    xK_x     ),             spawn "xscreensaver-command -exit")
      , ((modMask .|. shiftMask,    xK_r     ),             spawn "xscreensaver -no-splash")
      , ((modMask,                  xK_Home  ),             spawn "sudo shutdown -r now")
      , ((modMask,                  xK_End   ),             spawn "sudo shutdown -h now")
      , ((modMask,                  xK_c     ),             spawn "killall -SIGUSR1 conky")
      , ((modMask,                  xK_e     ),             spawn "evince")
      , ((modMask,                  xK_o     ),             spawn "ooffice")
      , ((controlMask,       	    xK_Print ),             spawn "scrot screenie-%H-%M-%d-%b.png -q 100")    
      , ((modMask,                  xK_p     ),             shellPrompt myXPConfig)
      , ((modMask .|. controlMask,  xK_Left  ),             spawn "mpc prev")
      , ((modMask .|. controlMask,  xK_p     ),             spawn "mpc toggle")
      , ((modMask .|. controlMask,  xK_s     ),             spawn "mpc stop")
      , ((modMask .|. controlMask,  xK_Right ),             spawn "mpc next")
      , ((modMask .|. controlMask,  xK_r     ),             spawn "mpc random")
      , ((modMask .|. controlMask,  xK_Down  ),             spawn "aumix -v-6")
      , ((modMask .|. controlMask,  xK_Up    ),             spawn "aumix -v+6")
      , ((modMask .|. controlMask,  xK_m     ),             spawn "amixer set Master toggle")
--      , ((modMask,                  xK_a     ),             spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") 
      , ((modMask,                  xK_v     ),             spawn "VirtualBox") 
      , ((modMask,                  xK_f     ),             spawn "firefox") 
      , ((modMask,                  xK_d     ),             spawn "eject -T") 
      , ((modMask,                  xK_n     ),             spawn "pcmanfm") 
      , ((modMask,                  xK_k     ),             spawn "brasero") 
      , ((modMask,                  xK_w     ),             spawn "deluge") 
      , ((modMask .|. shiftMask,    xK_c     ),             kill)
      
-- layouts
      , ((modMask,               xK_space ),                sendMessage NextLayout)
      , ((modMask .|. shiftMask, xK_space ),                setLayout $ XMonad.layoutHook conf)
      , ((modMask,               xK_b     ),                sendMessage ToggleStruts)

-- floating layer stuff
      , ((modMask,               xK_t     ),                withFocused $ windows . W.sink)

-- focus
      , ((modMask,               xK_Tab   ),                windows W.focusDown)
      , ((modMask .|. shiftMask, xK_Tab   ),                windows W.focusUp)
      , ((modMask,               xK_m     ),                windows W.focusMaster)

-- swapping
      , ((modMask .|. shiftMask, xK_Return),                windows W.swapMaster)
      , ((modMask .|. shiftMask, xK_j     ),                windows W.swapDown  )
      , ((modMask .|. shiftMask, xK_k     ),                windows W.swapUp    )

-- increase or decrease number of windows in the master area
      , ((modMask              , xK_comma ),                sendMessage (IncMasterN 1))
      , ((modMask              , xK_period),                sendMessage (IncMasterN (-1)))

-- resizing
      , ((modMask,               xK_h     ),                sendMessage Shrink)
      , ((modMask,               xK_l     ),                sendMessage Expand)
      , ((modMask .|. shiftMask, xK_q     ),                io (exitWith ExitSuccess))
      , ((modMask,               xK_q     ),                broadcastMessage ReleaseResources >> restart "xmonad" True)
     ]
     ++
-- mod-[1..9] %! Switch to workspace N
-- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

---------------------------------------------------------------------------------------------------------------------------------------------

statusBarCmd1 = "dzen2 -bg '#1a1a1a' -fg '#ffffff' -h 14 -w 720 -e '' -fn '-*-terminus-*-r-normal-*-12-120-*-*-*-*-iso8859-*' -ta l"

---------------------------------------------------------------------------------------------------------------------------------------------

main = do 
	bar <- spawnPipe statusBarCmd1 
        xmonad $ withUrgencyHook NoUrgencyHook
               $ defaultConfig  
          	 	{ manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
          	 	 , workspaces = ["term","web","music","down","else"]
          	 	 , layoutHook = myLayout
          	 	 , logHook = dynamicLogWithPP $ myPP bar
          	 	 , modMask = mod4Mask    -- Rebind Mod to the Windows key
          	 	 , normalBorderColor  = myNormalBorderColor
          	 	 , focusedBorderColor = myFocusedBorderColor
          	 	 , focusFollowsMouse  = myFocusFollowsMouse
          	 	 , keys = keys'
          	 	 }

---------------------------------------------------------------------------------------------------------------------------------------------