import           Data.Char
import           Data.List
import           Data.Maybe

data Key = One
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Star
    | Zero
    | Pound
    deriving (Eq, Show, Enum, Ord)

data Button = Button { num :: Key
              , letters    :: String}
              deriving (Show)

type Phone = [Button]


p = [Button One "1",
    Button Two "abc2",
    Button Three "def3",
    Button Four "ghi4",
    Button Five "jkl5",
    Button Six "mno6",
    Button Seven "pqrs7",
    Button Eight "tuv8",
    Button Nine "wxyz9",
    Button Star "^*",
    Button Zero "+-0 ",
    Button Pound ".,#'"]


toPush :: Phone -> Char -> Int
toPush p c = numPush $ toButton p c
    where numPush = (+1) . fromJust . elemIndex c . letters

toButton :: Phone -> Char -> Button
toButton p c  = head . filter (elem c . letters) $ p

calculate :: [Button] -> Char -> Int
calculate p c | isUpper c = (+1) $ toPush p $ toLower c
 | otherwise = toPush p c

convo = ["Wanna play 20 questions",
        "Ya",
        "U 1st haha",
        "Lol ok. Have u ever tasted alcohol lol",
        "Lol ya",
        "Wow ur cool haha. Ur turn",
        "Ok. Do u think I'm pretty Lol",
        "Lol ya",
        "Haha thanks just making sure rofl ur turn"]

process :: Phone -> [String] -> [(Int, Key)]
process p convoList = do
    text <- convoList
    map (\x -> (presses x, digit x)) text
    where digit = num . toButton p . toLower
          presses = calculate p

fingerTaps :: [(Int, Key)]  -> Int
fingerTaps = sum . map fst
