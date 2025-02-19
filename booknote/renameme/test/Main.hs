module Main (main) where

import Test.Tasty
import Test.Tasty.HUnit

tests :: TestTree
tests = testGroup "" [testDummy]

testDummy :: TestTree
testDummy =
    testGroup
        "digit"
        $ let f = id
           in [ let sut = "123"
                    wot = "123"
                    got = f sut
                 in testCase sut $ wot @=? got
              , -- uncomment for failing test.
                -- `nix flake check` should fail on a failing test
                let sut = "abc"
                    wot = "cab"
                    got = f sut
                 in testCase sut $ wot @=? got
              ]

main :: IO ()
main = defaultMain tests
