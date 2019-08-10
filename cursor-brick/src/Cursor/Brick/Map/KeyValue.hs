{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Cursor.Brick.Map.KeyValue where

import Control.Monad

import Cursor.List.NonEmpty
import Cursor.Map

import Brick.Types
import Brick.Widgets.Core

import Cursor.Brick.List.NonEmpty

keyValueWidget ::
     (kc -> v -> Widget n) -> (k -> vc -> Widget n) -> KeyValueCursor kc vc k v -> Widget n
keyValueWidget = foldKeyValueCursor

keyValueWidgetM ::
     (kc -> v -> f (Widget n))
  -> (k -> vc -> f (Widget n))
  -> KeyValueCursor kc vc k v
  -> f (Widget n)
keyValueWidgetM = foldKeyValueCursor
