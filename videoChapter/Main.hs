{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy as BL
import Data.Map hiding (mapMaybe, split)
import Data.Maybe
import Data.Text (Text, split, toLower, unpack)
import Data.Text.Lazy ()
import Data.Time.Clock
import Data.Time.Format
import Fmt
import System.IO (stdin)
import Text.Read

newtype Media = Media {track :: [Track]}
    deriving (Show)

data Audio = Audio deriving (Show)
data Video = Video deriving (Show)
data General = General deriving (Show)
data Chapter = Chapter Text (Maybe NominalDiffTime) deriving (Show)

instance Buildable Chapter where
    build (Chapter title mTime) =
        padRightF 10 ' ' (maybe "" f mTime) +| toLower title |+ ""
      where
        f = formatTime defaultTimeLocale "%02M:%02S"

newtype Menu = Menu {chapters :: [Chapter]} deriving (Show)

data Track = GeneralT General | MenuT Menu | VideoT Video | AudioT Audio
    deriving (Show)

instance FromJSON Media where
    parseJSON = withObject "root" $ \v -> do
        mediaObj <- v .: "media"
        ts <- mediaObj .: "track"
        pure $ Media ts

instance FromJSON Track where
    parseJSON = withObject "track" $ \v -> do
        t <- v .: "@type"
        case t of
            "General" -> pure $ GeneralT General
            "Video" -> pure $ VideoT Video
            "Audio" -> pure $ AudioT Audio
            "Menu" -> do
                e <- v .: "extra"
                pure . MenuT . Menu $ uncurry toChapter <$> toList e
            _ -> fail $ "no good" <> t
readTimeStamp :: Text -> Maybe NominalDiffTime
readTimeStamp stamp =
    let xs = split ('_' ==) stamp
     in if length xs == 5
            then
                let
                    hours :: Maybe Integer
                    hours = readMaybe . unpack $ xs !! 1
                    mins = readMaybe . unpack $ xs !! 2
                    secs = readMaybe . unpack $ xs !! 3
                    timeSum h m s = h * 3600 + m * 60 + s
                 in
                    fromIntegral <$> (timeSum <$> hours <*> mins <*> secs)
            else Nothing

toChapter :: Text -> Text -> Chapter
toChapter k v = Chapter v (readTimeStamp k)

toMenu :: Track -> Maybe Menu
toMenu (MenuT m) = Just m
toMenu _ = Nothing

main :: IO ()
main = do
    input <- BL.hGetContents stdin
    case eitherDecode input of
        Left err -> putStrLn $ "Error parsing JSON: " <> err
        Right media -> do
            fmt . blockListF $ concatMap chapters (mapMaybe toMenu (track media))
