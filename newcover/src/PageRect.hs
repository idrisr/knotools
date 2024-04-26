{-# LANGUAGE TemplateHaskell #-}

module PageRect where

import Lens.Micro.Platform

data PageMedia a = PageMedia
    { _number :: Int
    , _rotation :: Int
    , _rect :: Rect a
    , _cropRect :: Rect a
    }
    deriving (Show, Eq)

data Rect a = Rect
    { _bottomLeft :: Coordinate a
    , _topRight :: Coordinate a
    }
    deriving (Show, Eq)

data Coordinate a = Coordinate {_x :: a, _y :: a}
    deriving (Show, Eq)

data Command = Command
    { _name :: String
    , _args :: [String]
    }

makeLenses ''Command
makeLenses ''Coordinate
makeLenses ''PageMedia
makeLenses ''Rect
