module Cursor.Brick.Text where

import qualified Data.Text as T
import Data.Text (Text)

import Cursor.Text

import Brick.Types as Brick
import Brick.Widgets.Core as Brick

-- | Make a text cursor widget with a blink-y box.
--
-- This function does not wrap the given text.
--
-- Otherwise, because of the way indexes work, there would be rendering errors for text that crosses the side of the terminal.
selectedTextCursorWidget :: n -> TextCursor -> Widget n
selectedTextCursorWidget n tc =
  Brick.showCursor n (Brick.Location (textCursorIndex tc, 0)) $ textCursorWidget tc

-- | Make a text cursor widget without a blink-y box.
--
-- This function does not wrap the given text.
textCursorWidget :: TextCursor -> Widget n
textCursorWidget tc = txt $ sanitiseText $ rebuildTextCursor tc

-- | Draw an arbitrary Text, it will be sanitised.
textWidget :: Text -> Widget n
textWidget = txt . sanitiseText

-- | Draw an arbitrary Text (with wrapping), it will be sanitised.
textWidgetWrap :: Text -> Widget n
textWidgetWrap = txtWrap . sanitiseText

-- | Replace tabs by spaces so that brick doesn't render nonsense.
--
-- See https://hackage.haskell.org/package/brick/docs/Brick-Widgets-Core.html#v:txt
sanitiseText :: Text -> Text
sanitiseText =
  T.map $ \c ->
    case c of
      '\t' -> ' '
      _ -> c
