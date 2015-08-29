



index ls n =  map snd .filter (pred . fst) . zip [1..] $ ls
    where pred = (==0) . flip mod n

split' ls = map (index ls) [1.. length ls]

maxima (_:[]) = []
maxima (x:y:[]) = []
maxima (x:y:z:xs)
    | x < y && y > z = y : maxima (y:z:xs)
    | otherwise = maxima (y:z:xs)
-- skip ls = map index ls [1.. length ls]
-- f n = filter (pred)


--    where pred = (==0) . (flip mod) n

-- mapFold xs f = foldr (\x y -> f x : y) [] xs

-- skips ls = foldr (\x y -> f x :y) [1.. length ls]  where f = 9
