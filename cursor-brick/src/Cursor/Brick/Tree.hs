{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Cursor.Brick.Tree where

import Control.Monad

import Cursor.Tree

import Brick.Types
import Brick.Widgets.Core

treeCursorWidgetM ::
     forall a b n m. Monad m
  => ([CTree b] -> b -> [CTree b] -> Widget n -> m (Widget n))
  -> (a -> CForest b -> m (Widget n))
  -> TreeCursor a b
  -> m (Widget n)
treeCursorWidgetM = traverseTreeCursor

treeCursorWidget ::
     forall a b n.
     ([CTree b] -> b -> [CTree b] -> Widget n -> Widget n)
  -> (a -> CForest b -> Widget n)
  -> TreeCursor a b
  -> Widget n
treeCursorWidget = foldTreeCursor

traverseTreeCursor ::
     forall a b m c. Monad m
  => ([CTree b] -> b -> [CTree b] -> c -> m c)
  -> (a -> CForest b -> m c)
  -> TreeCursor a b
  -> m c
traverseTreeCursor wrapFunc currentFunc TreeCursor {..} =
  currentFunc treeCurrent treeBelow >>= wrapAbove treeAbove
  where
    wrapAbove :: Maybe (TreeAbove b) -> c -> m c
    wrapAbove Nothing = pure
    wrapAbove (Just ta) = goAbove ta
    goAbove :: TreeAbove b -> c -> m c
    goAbove TreeAbove {..} =
      wrapFunc (reverse treeAboveLefts) treeAboveNode treeAboveRights >=> wrapAbove treeAboveAbove

foldTreeCursor ::
     forall a b c.
     ([CTree b] -> b -> [CTree b] -> c -> c)
  -> (a -> CForest b -> c)
  -> TreeCursor a b
  -> c
foldTreeCursor wrapFunc currentFunc TreeCursor {..} =
  wrapAbove treeAbove $ currentFunc treeCurrent treeBelow
  where
    wrapAbove :: Maybe (TreeAbove b) -> c -> c
    wrapAbove Nothing = id
    wrapAbove (Just ta) = goAbove ta
    goAbove :: TreeAbove b -> c -> c
    goAbove TreeAbove {..} =
      wrapAbove treeAboveAbove . wrapFunc (reverse treeAboveLefts) treeAboveNode treeAboveRights
