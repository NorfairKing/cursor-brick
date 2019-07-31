{-# LANGUAGE RecordWildCards #-}

module Cursor.Brick.List where

import Cursor.List

import Brick.Types as B
import Brick.Widgets.Core as B

listCursorWidgetM :: ([a] -> [a] -> m (Widget n)) -> ListCursor a -> m (Widget n)
listCursorWidgetM = foldListCursor

listCursorWidget :: ([a] -> [a] -> Widget n) -> ListCursor a -> Widget n
listCursorWidget = foldListCursor

traverseListCursor :: ([a] -> [a] -> f b) -> ListCursor a -> f b
traverseListCursor = foldListCursor

foldListCursor :: ([a] -> [a] -> b) -> ListCursor a -> b
foldListCursor func ListCursor {..} = func (reverse listCursorPrev) listCursorNext
