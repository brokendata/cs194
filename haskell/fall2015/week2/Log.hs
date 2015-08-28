-- CIS 194 Homework 2

module Log where

import Control.Applicative
import Data.List.Split
import Data.List

data MessageType = Info
                 | Warning
                 | Error Int
  deriving (Show, Eq)

type TimeStamp = Int

data LogMessage = LogMessage MessageType TimeStamp String
                | Unknown String
  deriving (Show, Eq)

data MessageTree = Leaf
                 | Node MessageTree LogMessage MessageTree
  deriving (Show, Eq)

-- | @testParse p n f@ tests the log file parser @p@ by running it
--   on the first @n@ lines of file @f@.
testParse :: (String -> [LogMessage])
          -> Int
          -> FilePath
          -> IO [LogMessage]
testParse parse n file = take n . parse <$> readFile file

-- | @testWhatWentWrong p w f@ tests the log file parser @p@ and
--   warning message extractor @w@ by running them on the log file
--   @f@.
testWhatWentWrong :: (String -> [LogMessage])
                  -> ([LogMessage] -> [String])
                  -> FilePath
                  -> IO [String]
testWhatWentWrong parse whatWentWrong file
  = whatWentWrong . parse <$> readFile file

parseTail (x:xs) = (read x :: Int, unwords xs)


parseMessage m = case split m of 
  ("E":c:t:xs) -> (uncurry $ LogMessage (Error (read c :: Int))) $ parseTail xs
  ("I": xs) -> (uncurry $ LogMessage Info) $ parseTail xs
  s@(x:xs) -> Unknown (unwords s)
  where split = splitOn " "
        build lm t = uncurry (LogMessage lm) $ parseTail t

parseMessage2 m = case split m of 
  ("E":c:xs) -> build (Error (read c :: Int)) xs
  ("I": xs) -> build Info xs
  s@(x:xs) -> Unknown (unwords s)
  where split = splitOn " "
        build lm t = uncurry (LogMessage lm) $ parseTail t





  --  (uncurry $ LogMessage (Error 1)) $ parseTail xs  

mes = "E 2 562 help help"
mes1 =  "I 29 la la la"

test :: LogMessage -> (LogMessage, LogMessage)
test xs = (xs,xs)