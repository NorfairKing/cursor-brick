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

horizontalMapCursorWidget ::
     (k -> v -> Widget n)
  -> (KeyValueCursor kc vc k v -> Widget n)
  -> (k -> v -> Widget n)
  -> MapCursor kc vc k v
  -> Widget n
horizontalMapCursorWidget beforeFunc curFunc afterFunc =
  mapCursorWidget $ \befores current afters ->
    hBox $
    concat [map (uncurry beforeFunc) befores, [curFunc current], map (uncurry afterFunc) afters]

horizontalMapCursorWidgetM ::
     Applicative f
  => (k -> v -> f (Widget n))
  -> (KeyValueCursor kc vc k v -> f (Widget n))
  -> (k -> v -> f (Widget n))
  -> MapCursor kc vc k v
  -> f (Widget n)
horizontalMapCursorWidgetM beforeFunc curFunc afterFunc =
  mapCursorWidgetM $ \befores current afters ->
    hBox <$>
    sequenceA
      (concat [map (uncurry beforeFunc) befores, [curFunc current], map (uncurry afterFunc) afters])

verticalMapCursorWidget ::
     (k -> v -> Widget n)
  -> (KeyValueCursor kc vc k v -> Widget n)
  -> (k -> v -> Widget n)
  -> MapCursor kc vc k v
  -> Widget n
verticalMapCursorWidget beforeFunc curFunc afterFunc =
  mapCursorWidget $ \befores current afters ->
    vBox $
    concat [map (uncurry beforeFunc) befores, [curFunc current], map (uncurry afterFunc) afters]

verticalMapCursorWidgetM ::
     Applicative f
  => (k -> v -> f (Widget n))
  -> (KeyValueCursor kc vc k v -> f (Widget n))
  -> (k -> v -> f (Widget n))
  -> MapCursor kc vc k v
  -> f (Widget n)
verticalMapCursorWidgetM beforeFunc curFunc afterFunc =
  mapCursorWidgetM $ \befores current afters ->
    vBox <$>
    sequenceA
      (concat [map (uncurry beforeFunc) befores, [curFunc current], map (uncurry afterFunc) afters])

mapCursorWidget ::
     ([(k, v)] -> KeyValueCursor kc vc k v -> [(k, v)] -> Widget n)
  -> MapCursor kc vc k v
  -> Widget n
mapCursorWidget = foldMapCursor

mapCursorWidgetM ::
     ([(k, v)] -> KeyValueCursor kc vc k v -> [(k, v)] -> m (Widget n))
  -> MapCursor kc vc k v
  -> m (Widget n)
mapCursorWidgetM = foldMapCursor

traverseMapCursor ::
     ([(k, v)] -> KeyValueCursor kc vc k v -> [(k, v)] -> f c) -> MapCursor kc vc k v -> f c
traverseMapCursor combFunc = foldNonEmptyCursor combFunc . mapCursorList

foldMapCursor :: ([(k, v)] -> KeyValueCursor kc vc k v -> [(k, v)] -> c) -> MapCursor kc vc k v -> c
foldMapCursor combFunc = foldNonEmptyCursor combFunc . mapCursorList
