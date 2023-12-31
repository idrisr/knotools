module Main (main) where

import Test.Tasty
import TestParser
import TestCommand
import TestOutputFileName

tests :: TestTree
tests =
    testGroup
        "main"
        [ testParse
        , testCommand
        , testOutputFileName
        ]

main :: IO ()
main = defaultMain tests
