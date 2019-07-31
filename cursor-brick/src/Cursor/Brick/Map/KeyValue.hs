{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Cursor.Brick.Map.KeyValue where

import Control.Monad

import Cursor.List.NonEmpty
import Cursor.Map

import Brick.Types
import Brick.Widgets.Core

import Cursor.Brick.List.NonEmpty

traverseKeyValueCursor :: (kc -> v -> f c) -> (k -> vc -> f c) -> KeyValueCursor kc vc k v -> f c
traverseKeyValueCursor = foldKeyValueCursor
foldKeyValueCursor :: (kc -> v -> c) -> (k -> vc -> c) -> KeyValueCursor kc vc k v -> c
foldKeyValueCursor keyFunc valFunc kvc =
  case kvc of
    KeyValueCursorKey kc v -> keyFunc kc v
    KeyValueCursorValue k vc -> valFunc k vc
