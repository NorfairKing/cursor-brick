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

horizontalForestCursorWidgetM ::
     Monad m
  => (CTree b -> m (Widget n))
  -> (TreeCursor a b -> m (Widget n))
  -> (CTree b -> m (Widget n))
  -> ForestCursor a b
  -> m (Widget n)
horizontalForestCursorWidgetM prevFunc curFunc nextFunc =
  horizontalNonEmptyCursorWidgetM prevFunc curFunc nextFunc . forestCursorListCursor

horizontalForestCursorWidget ::
     (CTree b -> Widget n)
  -> (TreeCursor a b -> Widget n)
  -> (CTree b -> Widget n)
  -> ForestCursor a b
  -> Widget n
horizontalForestCursorWidget prevFunc curFunc nextFunc =
  horizontalNonEmptyCursorWidget prevFunc curFunc nextFunc . forestCursorListCursor

verticalForestCursorWidgetM ::
     Monad m
  => (CTree b -> m (Widget n))
  -> (TreeCursor a b -> m (Widget n))
  -> (CTree b -> m (Widget n))
  -> ForestCursor a b
  -> m (Widget n)
verticalForestCursorWidgetM prevFunc curFunc nextFunc =
  verticalNonEmptyCursorWidgetM prevFunc curFunc nextFunc . forestCursorListCursor

verticalForestCursorWidget ::
     (CTree b -> Widget n)
  -> (TreeCursor a b -> Widget n)
  -> (CTree b -> Widget n)
  -> ForestCursor a b
  -> Widget n
verticalForestCursorWidget prevFunc curFunc nextFunc =
  verticalNonEmptyCursorWidget prevFunc curFunc nextFunc . forestCursorListCursor

forestCursorWidgetM ::
     ([CTree b] -> TreeCursor a b -> [CTree b] -> m (Widget n)) -> ForestCursor a b -> m (Widget n)
forestCursorWidgetM = foldForestCursor

forestCursorWidget ::
     ([CTree b] -> TreeCursor a b -> [CTree b] -> Widget n) -> ForestCursor a b -> Widget n
forestCursorWidget = foldForestCursor
