module TestOutputFileName (testOutputFileName) where

import Test.Tasty
import Test.Tasty.HUnit
import Command

testOutputFileName :: TestTree
testOutputFileName = testGroup "output file name" [tests]

tests:: TestTree
tests=
    testGroup
        "filename"
        [
            let sut = "asdf.jpg"
                got = newFileName sut "new"
                wot = "asdf.new.jpg"
            in
                testCase "" $ wot @?= got
          , let sut = "asdf"
                got = newFileName sut "new"
                wot = "asdf.new"
            in
                testCase "" $ wot @?= got
          , let sut = "asdf.new.jpg"
                got = newFileName sut "new"
                wot = "asdf.new.new.jpg"
            in
                testCase "" $ wot @?= got
        ]
