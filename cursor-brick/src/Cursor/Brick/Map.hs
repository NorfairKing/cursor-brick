{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Cursor.Brick.Map where

import Control.Monad

import Cursor.List.NonEmpty
import Cursor.Map

import Brick.Types
import Brick.Widgets.Core

import Cursor.Brick.List.NonEmpty
import Cursor.Brick.Map.KeyValue


traverseMapCursor ::
     ([(k, v)] -> KeyValueCursor kc vc k v -> [(k, v)] -> f c) -> MapCursor kc vc k v -> f c
traverseMapCursor combFunc = foldNonEmptyCursor combFunc . mapCursorList

foldMapCursor :: ([(k, v)] -> KeyValueCursor kc vc k v -> [(k, v)] -> c) -> MapCursor kc vc k v -> c
foldMapCursor combFunc = foldNonEmptyCursor combFunc . mapCursorList
