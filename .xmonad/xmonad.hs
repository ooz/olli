import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.Minimize
import qualified Data.Map as M
import System.Exit -- exitWith
import XMonad.Layout.NoBorders -- no fullscreen borders
-- Fullscreen imports:
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import Monad
import Data.Monoid (All (All))

--myLayout = minimize (Tall 1 (3/100) (1/2)) -- ||| Full
myKeys conf@(XConfig {XMonad.modMask = modm}) = -- M.fromList $ -- comment M.fromList when using 'newKeys'
             [ 
	       ((modm , xK_Escape)   , kill)
	     , ((modm , xK_s)        , spawn $ XMonad.terminal conf)
--               ((modm, xK_s)              , withFocused (\f -> sendMessage (MinimizeWin f)))
--             , ((modm .|. shiftMask, xK_s), sendMessage RestoreNextMinimizedWin)
             ]

newKeys x = M.union (keys defaultConfig x) (M.fromList (myKeys x))

main = do
  xmonad $ gnomeConfig
    { terminal    = "gnome-terminal"
    , modMask     = mod4Mask
--    , doFloat     = ["Evince", "Totem"]
    , focusFollowsMouse = False
    , borderWidth = 2
    , normalBorderColor  = "#FFFFFF"
    , focusedBorderColor = "#000000" -- "#00FF00" -- terminal green -- "#A6E1FF" -- "green"
--    , layoutHook = noBorders Full
--    , layoutHook  = myLayout
    , keys        = newKeys
--    , keys        = myKeys
    , handleEventHook = evHook -- Fullscreen issue fix
    }

-- Fixing fullscreen presentation issues (= GNOME panel still visible in fullscreen)
-- from:
-- http://code.google.com/p/xmonad/issues/detail?id=339
-- http://code.google.com/p/xmonad/issues/attachmentText?id=339&aid=6617379484742651517&name=totemFullscreen.hs&token=df67f434b35f4cf6a06476b18ee5892d
-- Helper functions to fullscreen the window
fullFloat, tileWin :: Window -> X ()
fullFloat w = windows $ W.float w r
    where r = W.RationalRect 0 0 1 1
tileWin w = windows $ W.sink w

evHook :: Event -> X All
evHook (ClientMessageEvent _ _ _ dpy win typ dat) = do
  state <- getAtom "_NET_WM_STATE"
  fullsc <- getAtom "_NET_WM_STATE_FULLSCREEN"
  isFull <- runQuery isFullscreen win

  -- Constants for the _NET_WM_STATE protocol
  let remove = 0
      add = 1
      toggle = 2

      -- The ATOM property type for changeProperty
      ptype = 4 

      action = head dat

  when (typ == state && (fromIntegral fullsc) `elem` tail dat) $ do
    when (action == add || (action == toggle && not isFull)) $ do
         io $ changeProperty32 dpy win state ptype propModeReplace [fromIntegral fullsc]
         fullFloat win
    when (head dat == remove || (action == toggle && isFull)) $ do
         io $ changeProperty32 dpy win state ptype propModeReplace []
         tileWin win

  -- It shouldn't be necessary for xmonad to do anything more with this event
  return $ All False

evHook _ = return $ All True
