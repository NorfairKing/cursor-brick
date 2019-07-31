{-# LANGUAGE RecordWildCards #-}

module Cursor.Brick.List.NonEmpty where

import Cursor.List.NonEmpty

import Brick.Types as B
import Brick.Widgets.Core as B

nonEmptyCursorWidgetM :: ([b] -> a -> [b] -> m (Widget n)) -> NonEmptyCursor a b -> m (Widget n)
nonEmptyCursorWidgetM = foldNonEmptyCursor

nonEmptyCursorWidget :: ([b] -> a -> [b] -> Widget n) -> NonEmptyCursor a b -> Widget n
nonEmptyCursorWidget = foldNonEmptyCursor

traverseNonEmptyCursor :: ([b] -> a -> [b] -> f c) -> NonEmptyCursor a b -> f c
traverseNonEmptyCursor = foldNonEmptyCursor

foldNonEmptyCursor :: ([b] -> a -> [b] -> c) -> NonEmptyCursor a b -> c
foldNonEmptyCursor func NonEmptyCursor {..} =
  func (reverse nonEmptyCursorPrev) nonEmptyCursorCurrent nonEmptyCursorNext
