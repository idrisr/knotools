{-# LANGUAGE TemplateHaskell #-}

module Params where

import Options.Applicative
import Lens.Micro.Platform

data Params = Params
    { _input :: FilePath
    , _url :: String
    , _output:: FilePath
    }
    deriving (Show)

makeLenses ''Params

cmdLineParser :: IO Params
cmdLineParser = execParser opts
  where
    opts = info (parseParams <**> helper) (fullDesc <> progDesc "insert new cover from url to pdf file")

parseParams :: Parser Params
parseParams =
    Params
        <$> strArgument (metavar "<INPUT>" <> help "pdf file for processing")
        <*> strOption (metavar "<URL>" <> short 'u' <> long "url" <> help "url for new cover")
        <*> strOption (metavar "<OUTPUT>" <> short 'o' <> long "output" <> help "output file for new pdf")
