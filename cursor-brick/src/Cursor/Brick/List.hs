{-# LANGUAGE RecordWildCards #-}

module Cursor.Brick.List where

import Cursor.List

import Brick.Types

listCursorWidgetM ::
     ([a] -> [a] -> m (Widget n)) -> ListCursor a -> m (Widget n)
listCursorWidgetM = foldListCursor

listCursorWidget :: ([a] -> [a] -> Widget n) -> ListCursor a -> Widget n
listCursorWidget = foldListCursor
