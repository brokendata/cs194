{- CIS 194 HW 10
   due Monday, 1 April
-}

module AParser where

import           Control.Applicative

import           Data.Char

-- A parser for a value of type a is a function which takes a String
-- represnting the input to be parsed, and succeeds or fails; if it
-- succeeds, it returns the parsed value along with the remainder of
-- the input.
newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

-- For example, 'satisfy' takes a predicate on Char, and constructs a
-- parser which succeeds only if it sees a Char that satisfies the
-- predicate (which it then returns).  If it encounters a Char that
-- does not satisfy the predicate (or an empty input), it fails.
satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser f
  where
    f [] = Nothing    -- fail on the empty input
    f (x:xs)          -- check if x satisfies the predicate
                        -- if so, return x along with the remainder
                        -- of the input (that is, xs)
        | p x       = Just (x, xs)
        | otherwise = Nothing  -- otherwise, fail

-- Using satisfy, we can define the parser 'char c' which expects to
-- see exactly the character c, and fails otherwise.
char :: Char -> Parser Char
char c = satisfy (== c)

{- For example:

*Parser> runParser (satisfy isUpper) "ABC"
Just ('A',"BC")
*Parser> runParser (satisfy isUpper) "abc"
Nothing
*Parser> runParser (char 'x') "xyz"
Just ('x',"yz")

-}

-- For convenience, we've also provided a parser for positive
-- integers.
posInt :: Parser Integer
posInt = Parser f
  where
    f xs
      | null ns   = Nothing
      | otherwise = Just (read ns, rest)
      where (ns, rest) = span isDigit xs

------------------------------------------------------------
-- Your code goes below here
------------------------------------------------------------

instance Functor Parser where
    fmap f p = Parser $ \s -> case runParser p s of
        Just (a,rest) -> Just (f a, rest)
        Nothing -> Nothing

instance Applicative Parser where
    pure s = Parser $ \p -> Just (s,p)

    p1 <*> p2 = Parser $ \p -> case runParser p1 p of
        Nothing -> Nothing
        Just (f,res1) -> case runParser p2 res1 of
            Nothing -> Nothing
            Just (x, res2) -> Just (f x, res2)

parserA = char 'a'
parserB = char 'b'
parseSpace = char ' '

parserAB = (,) <$> parserA <*> parserB
parserAB_ = (\x y -> ()) <$> parserA <*> parserB

parseSpaceInt = (\_ y -> y) <$> parseSpace <*> posInt
parseIntInt = (\x y -> [x,y]) <$> posInt <*> parseSpaceInt

-- alternative 3 arg function
parseIntInt2 = (\x _ z -> [x,z]) <$> posInt <*> parseSpace <*> posInt

instance Alternative Parser where
    empty = Parser $ (\_ -> Nothing)
    (<|>) pa pb = Parser $ \s ->
        runParser pa s <|> runParser pb s
