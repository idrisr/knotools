{-# OPTIONS_GHC -Wno-name-shadowing #-}

module Main where

import qualified Control.Foldl as Fold
import Data.Char
import Data.Text.IO
import Options.Applicative
import Turtle hiding (header)
import Prelude hiding (putStrLn)

main :: IO ()
main = do
    file <- execParser parserInfo
    sh $ do
        t <- shellThing . runFile $ file
        liftIO . putStrLn $ t

shellThing :: FilePath -> Shell Text
shellThing f = do
    lines <- fold (cleanFile f) Fold.list
    pure . linesToText $ lines

cleanFile :: FilePath -> Shell Line
cleanFile f = uniq . grep keepLines $ input f

keepLines :: Pattern String
keepLines = satisfy isLetter >> some keepChars

keepChars :: Pattern Char
keepChars = satisfy f
  where
    f c = isLetter c || isSpace c || c == '\''

-------------------------------------------------------------
-- CLI Parser
newtype FileInput = File {runFile :: FilePath}

parserInfo :: ParserInfo FileInput
parserInfo =
    info
        (cliParser <**> helper)
        ( fullDesc
            <> progDesc "print parsed vtt output"
            <> header "basic parser for youtube vtt files"
        )

cliParser :: Parser FileInput
cliParser =
    File
        <$> strOption
            ( long "file"
                <> metavar "file"
                <> help "vtt input file"
                <> short 'f'
            )
