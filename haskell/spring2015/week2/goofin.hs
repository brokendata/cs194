type Parser a = String -> [(a,String)]

return :: a -> Parser a 
return v = \ x -> [(v,x)]

failure :: Parser a
failure = \ x -> []

item :: Parser Char
item =  \ v -> case v of 
    [] -> []
    (x:xs) -> [(x,xs)]

parse :: Parser a -> String -> [(a,String)]
parse p inp = p inp

(>>=) :: Parser a -> (a -> Parser b) -> Parser b
p >>= f = \ inp -> case parse p inp of 
    [] -> []
    [(v,out)] -> parse (f v) out



