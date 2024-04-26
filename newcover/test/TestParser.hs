{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedStrings #-}

module TestParser (testParse) where

import Data.Attoparsec.ByteString (Parser)
import Data.Attoparsec.ByteString.Char8 qualified as A
import Data.ByteString (ByteString)
import PageRect
import Parser
import Test.Tasty
import Test.Tasty.HUnit
import Lens.Micro.Platform
import Control.Applicative
import TestData

testParse :: TestTree
testParse = testGroup "parse" [testParseRect]

f :: Parser a -> ByteString -> Either String a
f = A.parseOnly

testParseRect :: TestTree
testParseRect =
    testGroup
        "rect"
        [ testCase "rect"
            $ let sut = line6
                  got = f (parseRect "PageMediaCropRect: ") sut
                  wot = Right $ Rect (Coordinate 36 54) (Coordinate 567 720)
               in got @?= wot
        , testCase "double"
            $ let sut = "3"
                  got = f A.double sut
                  wot = Right 3
               in got @?= wot
        , testCase "pagemedia"
            $ let sut = multiline
                  got = f parsePageMedia sut
                  wot =
                    Right
                        $ pageMediaE
                            & number .~ 1
                            & rotation .~ 0
                            & (rect . bottomLeft . x) .~ 0
                            & (rect . bottomLeft . y) .~ 0
                            & (rect . topRight . x) .~ 612
                            & (rect . topRight . y) .~ 792
                            & (cropRect . bottomLeft . x) .~ 36
                            & (cropRect . bottomLeft . y) .~ 54
                            & (cropRect . topRight . x) .~ 567
                            & (cropRect . topRight . y) .~ 720
               in got @?= wot
        , testCase "many rects"
            $ let sut = manyRect
                  got = f (some parsePageMedia) sut
                  wot = either (const 0) length got
               in 644 @?= wot
        , testCase "many rects 2"
            $ let sut = noCropRect
                  got = f (some parsePageMedia) sut
                  wot = either (const 0) length got
               in 6 @?= wot
        , testCase "full file"
            $ let sut = fullFile
                  got = f parseOutput sut
                  wot = either (const 0) length got
               in wot @?= 644
        ]
