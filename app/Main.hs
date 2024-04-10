{-# LANGUAGE ImportQualifiedPost #-}

module Main where

import Control.Monad.IO.Class (MonadIO (..))
import Control.Monad.Trans.Reader
import PageRect
import Params
import System.IO.Streams.Process qualified as S
import System.IO.Streams qualified as S
import System.IO.Temp
import System.IO
import Command
import Data.ByteString (ByteString)

-- TODO
-- remove bag pages
-- remove current cover
-- option to put newfile in CWD or in same dir as input file

runCommand :: [String] -> IO
        ( S.OutputStream ByteString
        , S.InputStream ByteString
        , S.InputStream ByteString
        , S.ProcessHandle
        )
runCommand xs = S.runInteractiveProcess (head xs) (tail xs) Nothing Nothing

tempThing :: Params -> PageMedia Double -> FilePath -> Handle -> IO ()
tempThing p m f _ = do
    (_, out0, err0, _) <- runCommand $ wgetCmd p f
    S.supply out0 S.stdout
    S.supply err0 S.stdout

    (_, out1, err1, _) <- runCommand $ convertCmd m f
    S.supply out1 S.stdout
    S.supply err1 S.stdout

    (_, out2, err2, _) <- runCommand $ pdftkCmd p f
    S.supply out2 S.stdout
    S.connect err2 S.stdout

makeNewPDF :: PageMedia Double -> ReaderT Params IO ()
makeNewPDF m = do
    p <- ask
    liftIO $ withSystemTempFile "image.jpg" $ tempThing p m

processParams :: ReaderT Params IO ()
processParams = do
    r <- getDimensions
    makeNewPDF $ head r

main :: IO ()
main = do
    p <- liftIO cmdLineParser
    runReaderT processParams p
