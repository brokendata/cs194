

type Parser a = String -> [(a,String)]

return :: a -> Parser a
return v = \inp -> [(v,inp)]

failure :: Parser a
failure = \x -> []

item :: Parser Char
item = \x -> case x of 
    [] -> []
    (x:xs) -> [(x,xs)]

parse :: Parser a -> String -> [(a,String)]
parse p inp = p inp