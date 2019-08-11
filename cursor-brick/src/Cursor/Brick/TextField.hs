module Cursor.Brick.TextField where

import qualified Data.Text as T
import Data.Text (Text)
import Data.Tuple as Tuple

import Cursor.List.NonEmpty
import Cursor.Text
import Cursor.TextField

import Brick.Types as Brick
import Brick.Widgets.Core as Brick

import Cursor.Brick.Text

-- | This function does not wrap lines.
-- Otherwise, because of the way indexes work, there would be rendering errors for text that crosses the side of the terminal.
selectedTextFieldCursorWidget :: n -> TextFieldCursor -> Widget n
selectedTextFieldCursorWidget n (TextFieldCursor tfc) =
  flip foldNonEmptyCursor tfc $ \befores current afters ->
    vBox $ concat [map t befores, [selectedTextCursorWidget n current], map t afters]
  where
    t = txt . sanitiseText

-- | This function does not wrap lines .
textFieldCursorWidget :: TextFieldCursor -> Widget n
textFieldCursorWidget (TextFieldCursor tfc) =
  flip foldNonEmptyCursor tfc $ \befores current afters ->
    vBox $ concat [map t befores, [textCursorWidget current], map t afters]
  where
    t = txt . sanitiseText
