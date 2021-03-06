module Set1Spec where

import           Test.Hspec
import           Set1
import           MCPrelude
import           Crypto.Hash

import           Data.ByteString.Char8   hiding ( replicate )
import           Data.ByteString (ByteString)

spec :: Spec
spec = do 
  describe "fiveRands" $
    it "should multiply to 8681089573064486461641871805074254223660" $ 
      product fiveRands `shouldBe` 8681089573064486461641871805074254223660 
  describe "randString3" $ 
    it "should sha256 to 9d475eb78d3e38085220ed6ebde9d8f7d26540bb1c8f9382479c3acd4c8c94a3" $ 
      show (hashWith SHA256 $ pack randString3) `shouldBe` "9d475eb78d3e38085220ed6ebde9d8f7d26540bb1c8f9382479c3acd4c8c94a3"
  describe "randEven randOdd randTen generalA" $
    it "should multiply to 189908109902700 given a seed of 1" $
        let 
          (i, s1) = randEven $ mkSeed 1
          (i2, s2) = randOdd $ mkSeed 1
          (i3, s3) = randTen $ mkSeed 1
        in 
          product [i, i2, i3] `shouldBe` 189908109902700
  describe "randEven2 randOdd2 randTen2 generalA2" $
    it "should multiply to 189908109902700 given a seed of 1" $
        let 
          (i, s1) = randEven2 $ mkSeed 1
          (i2, s2) = randOdd2 $ mkSeed 1
          (i3, s3) = randTen2 $ mkSeed 1
        in 
          product [i, i2, i3] `shouldBe` 189908109902700
  describe "randPair" $
    it "should be ('l',282475249) given seed of 1" $
      let ((c, i), s) = randPair $ mkSeed 1
      in (c, i) `shouldBe` ('l', 282475249)
  describe "generalPair" $
    it "should be the same as randPair given randLetter and rand" $
      let ((c, i), s) = generalPair randLetter rand $ mkSeed 1
      in (c, i) `shouldBe` ('l', 282475249)
  describe "generalPair2" $
    it "should be the same as generalPair" $
      let ((c, i), s) = generalPair2 randLetter rand $ mkSeed 1
      in (c, i) `shouldBe` ('l', 282475249)
  describe "repRandom" $
    it "should produce the same results as randString3" $
      fst (repRandom (replicate 3 randLetter) (mkSeed 1)) `shouldBe` randString3