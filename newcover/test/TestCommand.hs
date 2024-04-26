module TestCommand (testCommand) where

import Lens.Micro.Platform
import Test.Tasty
import Test.Tasty.HUnit
import TestData
import Command
import PageRect

testCommand :: TestTree
testCommand = testGroup "parse" [testConvert]

testConvert :: TestTree
testConvert =
    testGroup
        "convert"
        [
            let
                got = convertCmd sut f
                sut = pageMediaE
                    & number .~ 1
                    & rotation                    .~ 0
                    & (rect . bottomLeft . x)     .~ 0
                    & (rect . bottomLeft . y)     .~ 0
                    & (rect . topRight . x)       .~ 612
                    & (rect . topRight . y)       .~ 792
                    & (cropRect . bottomLeft . x) .~ 36
                    & (cropRect . bottomLeft . y) .~ 54
                    & (cropRect . topRight . x)   .~ 567
                    & (cropRect . topRight . y)   .~ 720
                f = "/home/goon/input.jpg"
                wot = ["convert","/home/goon/input.jpg","-resize","531x666!","/home/goon/input.pdf"] in
            testCase "1" $ got @?= wot
        ]
