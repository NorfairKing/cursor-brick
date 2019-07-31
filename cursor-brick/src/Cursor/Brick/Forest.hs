{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Cursor.Brick.Forest where

import Control.Monad

import Cursor.Forest
import Cursor.Tree

import Brick.Types
import Brick.Widgets.Core

import Cursor.Brick.List.NonEmpty
import Cursor.Brick.Tree

forestCursorWidgetM ::
     ([CTree b] -> TreeCursor a b -> [CTree b] -> m (Widget n)) -> ForestCursor a b -> m (Widget n)
forestCursorWidgetM = foldForestCursor

forestCursorWidget ::
     ([CTree b] -> TreeCursor a b -> [CTree b] -> Widget n) -> ForestCursor a b -> Widget n
forestCursorWidget = foldForestCursor

traverseForestCursor :: ([CTree b] -> TreeCursor a b -> [CTree b] -> f c) -> ForestCursor a b -> f c
traverseForestCursor = foldForestCursor

foldForestCursor :: ([CTree b] -> TreeCursor a b -> [CTree b] -> c) -> ForestCursor a b -> c
foldForestCursor func (ForestCursor ne) = foldNonEmptyCursor func ne
