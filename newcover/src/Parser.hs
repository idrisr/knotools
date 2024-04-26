{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedStrings #-}

module Parser where

import Data.Attoparsec.ByteString (Parser)
import Data.Attoparsec.ByteString.Char8 qualified as P
import PageRect
import Data.ByteString (ByteString)
import Control.Applicative

parseOutput :: Parser [PageMedia Double]
parseOutput = do
    skipUntilString "PageMediaBegin"
    some parsePageMedia

parsePageMedia :: Parser (PageMedia Double)
parsePageMedia = do
    skipLine
    a <- P.string "PageMediaNumber: " *> P.decimal <* P.skipSpace
    r <- P.string "PageMediaRotation: " *> P.decimal <* P.skipSpace
    m <- parseRect "PageMediaRect: " <* P.skipSpace
    skipLine --PageMediaDimensions
    c <- P.option m (parseRect "PageMediaCropRect: " <* P.skipSpace)
    pure $ PageMedia a r m c

skipLine :: Parser ()
skipLine = P.skipWhile (/= '\n') >> P.skipSpace

parseRect :: ByteString -> Parser (Rect Double)
parseRect b = do
    _ <- P.string b
    [x1, y1, x2, y2] <- P.double `P.sepBy1` P.skipSpace
    pure $ Rect (Coordinate x1 y1) (Coordinate x2 y2)

skipUntilString :: ByteString -> Parser ()
{- hlint ignore "Use $>" -}
skipUntilString str = P.manyTill P.anyChar (P.string str) *> pure ()
