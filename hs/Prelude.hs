{-#MagicHash#-}
module Prelude where

data Bool = True | False

infixl 6 +
infixl 6 -
infixl 7 *
infixr 0 $
infixr 9 .
infixr 2 ||
infixr 3 &&

($) f x = f x
(.) f g = \x -> f $ g x

(&&) x y = case x of
    False -> False
    True -> y

(||) x y = case x of
    True -> True
    False -> y

not x = case x of
    True -> False
    False -> True

otherwise = True

id x = x

map f xs = case xs of
    [] -> []
    (x:xs) -> f x : map f xs

foldr1 f xs = case xs of
    [x] -> x
    (x:xs) -> f x $ foldr1 f xs

filter f xs = case xs of
    [] -> []
    (x:xs) -> case f x of
        True -> x : filter f xs
        False -> filter f xs

iterate f x = f x : iterate f x

head xs = case xs of
    (x:_) -> x

tail xs = case xs of
    (_:xs) -> xs

fix f = let x = f x in x


data Int = I# Int#

(+) (I# i1) (I# i2) = I# (i1 +# i2)

(-) (I# i1) (I# i2) = I# (i1 -# i2)

(*) (I# i1) (I# i2) = I# (i1 *# i2)

stepDebug = stepDebug#

data Maybe a = Just a | Nothing

-- Maybe == Monad. wat

(>>) m a = case m of
     Nothing -> Nothing
     Just _ -> a

(>>=) m f = case m of
       Nothing -> Nothing
       Just a -> f a

return a = Just a

fail = Nothing


catMaybes a = case a of 
	  []            -> []
	  (Nothing:xs)  -> catMaybes xs
	  ((Just a) : xs) -> a : catMaybes xs

double m = do
       let doubleFunc = (*2)
       x <- m
       return (doubleFunc x)