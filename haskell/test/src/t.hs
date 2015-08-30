lastdigit :: integer -> integer
lastdigit n =  mod n 10

droplastdigit :: integer -> integer 
droplastdigit n = n `div` 10

torevdigits :: integer -> [integer]
torevdigits n
    | n > 0     = lastdigit n : (torevdigits $ droplastdigit n)
    | otherwise = []
 

double li = map dbl $ zip li [1..]
    where dbl (n,i) = if even i then n *2 else n

