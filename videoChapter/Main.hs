{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy as BL
import Data.List
import Data.Map hiding (mapMaybe, split)
import Data.Maybe
import Data.Text (Text, split, toLower, unpack)
import Data.Text.Lazy ()
import Data.Time.Clock
import Fmt
import System.IO (stdin)
import Text.Read

newtype Media = Media {track :: [Track]}
    deriving (Show)

data Audio = Audio deriving (Show)
newtype Video = Video {duration :: String} deriving (Show)
data General = General deriving (Show)
data Text_ = Text_ deriving (Show)
data Chapter = Chapter Text (Maybe NominalDiffTime)
    deriving (Show, Eq)

instance Buildable Media where
    build (Media tracks) =
        formatTime (fromMaybe 0 parseDuration) +| ("\n\n" :: Text) |+ blockListF menu +| ""
      where
        menu = nub $ concatMap chapters (mapMaybe toMenu tracks)
        parseDuration :: Maybe NominalDiffTime
        parseDuration = do
            let ts = mapMaybe toVideo tracks
            (Video s) <- listToMaybe ts
            t <- readMaybe s :: Maybe Double
            pure . realToFrac $ t

instance Buildable Video where
    build (Video d) = pretty d

instance Buildable Chapter where
    build (Chapter title mTime) =
        padRightF 10 ' ' (maybe "" formatTime mTime) +| toLower title |+ ""

formatTime :: NominalDiffTime -> Builder
formatTime s | s < 3600 = timeF "%02M:%02S" s
formatTime s = timeF "%02H:%02M:%02S" s

newtype Menu = Menu {chapters :: [Chapter]} deriving (Show)

data Track = GeneralT General | MenuT Menu | VideoT Video | AudioT Audio | TextT Text_
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
            "Video" -> do
                e <- v .: "Duration"
                pure $ VideoT $ Video e
            "Audio" -> pure $ AudioT Audio
            "Text" -> pure $ TextT Text_
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

toVideo :: Track -> Maybe Video
toVideo (VideoT v) = Just v
toVideo _ = Nothing

main :: IO ()
main = do
    input <- BL.hGetContents stdin
    case eitherDecode input of
        Left err -> putStrLn $ "Error parsing JSON: " <> err
        Right media -> do
            fmt . prettyLn $ (media :: Media)
