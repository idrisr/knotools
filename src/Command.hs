{-# LANGUAGE ImportQualifiedPost #-}

module Command where

import System.IO.Streams.Process qualified as S
import Control.Monad.IO.Class (MonadIO (..))
import Control.Monad.Trans.Reader
import GHC.Float.RealFracMethods
import Lens.Micro.Platform
import PageRect
import Params
import Parser
import System.FilePath
import System.IO.Streams.Attoparsec.ByteString qualified as SP

wgetCmd :: Params -> FilePath -> [String]
wgetCmd p f =
    [ "wget"
    , p ^. url
    , "-O"
    , f
    ]

convertCmd :: PageMedia Double -> FilePath -> [String]
convertCmd m f =
    [ "convert"
    , f
    , "-resize"
    , g width <> "x" <> g height <> "!"
    , replaceExtension f "pdf"
    ]
  where
    (width, height) = makeWH m
    g = show . roundDoubleInteger

pdftkCmd :: Params -> FilePath -> [String]
pdftkCmd p f =
    [ "pdftk"
    , replaceExtension f "pdf"
    , p ^. input
    , "cat"
    , "output"
    , replaceExtension (p ^. output) "pdf"
    ]

makeWH :: Num a => PageMedia a -> (a, a)
makeWH p =
    ( p ^. cropRect . topRight . x - p ^. cropRect . bottomLeft . x
    , p ^. cropRect . topRight . y - p ^. cropRect . bottomLeft . y
    )

getDimensions :: ReaderT Params IO [PageMedia Double]
getDimensions = do
    p <- ask
    (_, out, _, _) <- liftIO $ S.runInteractiveProcess "pdftk" [p ^. input, "dump_data_utf8"] Nothing Nothing
    liftIO $ SP.parseFromStream parseOutput out
