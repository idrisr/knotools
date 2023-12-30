module Main (main) where

import Test.Tasty
import TestParser
import TestCommand

tests :: TestTree
tests =
    testGroup
        "main"
        [ testParse
        , testCommand
        ]

main :: IO ()
main = defaultMain tests
