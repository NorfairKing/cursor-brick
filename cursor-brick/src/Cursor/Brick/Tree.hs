{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Cursor.Brick.Tree where

import Cursor.Tree

import Brick.Types

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
