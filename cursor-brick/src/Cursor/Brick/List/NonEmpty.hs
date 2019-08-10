{-# LANGUAGE RecordWildCards #-}

module Cursor.Brick.List.NonEmpty where

import Cursor.List.NonEmpty

import Brick.Types as B
import Brick.Widgets.Core as B

horizontalNonEmptyCursorWidgetM ::
     Applicative f
  => (b -> f (Widget n))
  -> (a -> f (Widget n))
  -> (b -> f (Widget n))
  -> NonEmptyCursor a b
  -> f (Widget n)
horizontalNonEmptyCursorWidgetM beforeFunc curFunc afterFunc =
  nonEmptyCursorWidgetM $ \befores current afters ->
    hBox <$> sequenceA (concat [map beforeFunc befores, [curFunc current], map afterFunc afters])

horizontalNonEmptyCursorWidget ::
     (b -> Widget n) -> (a -> Widget n) -> (b -> Widget n) -> NonEmptyCursor a b -> Widget n
horizontalNonEmptyCursorWidget beforeFunc curFunc afterFunc =
  nonEmptyCursorWidget $ \befores current afters ->
    hBox $ concat [map beforeFunc befores, [curFunc current], map afterFunc afters]

verticalNonEmptyCursorWidgetM ::
     Applicative f
  => (b -> f (Widget n))
  -> (a -> f (Widget n))
  -> (b -> f (Widget n))
  -> NonEmptyCursor a b
  -> f (Widget n)
verticalNonEmptyCursorWidgetM beforeFunc curFunc afterFunc =
  nonEmptyCursorWidgetM $ \befores current afters ->
    vBox <$> sequenceA (concat [map beforeFunc befores, [curFunc current], map afterFunc afters])

verticalNonEmptyCursorWidget ::
     (b -> Widget n) -> (a -> Widget n) -> (b -> Widget n) -> NonEmptyCursor a b -> Widget n
verticalNonEmptyCursorWidget beforeFunc curFunc afterFunc =
  nonEmptyCursorWidget $ \befores current afters ->
    vBox $ concat [map beforeFunc befores, [curFunc current], map afterFunc afters]

nonEmptyCursorWidgetM :: ([b] -> a -> [b] -> m (Widget n)) -> NonEmptyCursor a b -> m (Widget n)
nonEmptyCursorWidgetM = foldNonEmptyCursor

nonEmptyCursorWidget :: ([b] -> a -> [b] -> Widget n) -> NonEmptyCursor a b -> Widget n
nonEmptyCursorWidget = foldNonEmptyCursor
