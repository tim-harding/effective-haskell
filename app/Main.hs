module Main where

greet :: String -> String -> String
greet salutation person = salutation <> " " <> person

greet' :: String -> String -> String
greet' salutation = ((salutation <> " ") <>)

greet'' :: String -> String -> String
greet'' salutation = (<>) (salutation <> " ")

-- Pointfree or tacit
greet''' :: String -> String -> String
greet''' = (<>) . (<> " ")

tuple :: a -> a -> (a, a)
tuple = \a -> \b -> (a, b)

join :: a -> a -> (a, a)
join l r = (l, r)

addOne :: Int -> Int
addOne n = n + 1

timesTwo :: Int -> Int
timesTwo n = n * 2

-- (.) f1 f2 = \arg -> f1 (f2 arg)
timesEight :: Int -> Int
timesEight = timesTwo . timesTwo . timesTwo

squared :: Int -> Int
squared n = n * n

minusFive :: Int -> Int
minusFive n = n - 5

calc :: Int -> Int
calc n = minusFive (squared (timesTwo (addOne n)))

calc' :: Int -> Int
calc' n = minusFive $ squared $ timesTwo $ addOne n

-- Precedence from 0 through 9 (default)
-- infixl: Left associative (default)
-- infixr: Right associative
-- infix: Not associative
-- Required or else 2 +++ 6 * 3 == 24, eg (2 + 6) * 3
(++++) :: Int -> Int -> Int
infixl 7 ++++ -- Same as *
(++++) a b = a + b

-- Two infixl of equal precedence are evaluated left-to-right
a = 1 ++++ 2 * 3 -- 9
b = 3 * 2 ++++ 1 -- 7

(***) :: Int -> Int -> Int
infixr 7 *** -- Same as *
(***) a b = a * b

(+++) :: Int -> Int -> Int
infixr 7 +++ -- Same as *
(+++) a b = a + b

-- Two infixr of equal precedence are evaluated right-to-left
a' = 1 +++ 2 *** 3 -- 7
b' = 3 *** 2 +++ 1 -- 9

-- Operators of equal precedence and different fixity or
-- operators without fixity (such as ==) must use parentheses
-- to define the binding order

-- Uses the default precedence and fixity
c = 1 `join` 2

precedence = greet "Hello" "John" <> " and " <> greet "hi" "Alex"

bindings person =
    let hi = greet hiStr person
        bye = greet "bye" person
        hiStr = "Hi"
        collect = hi <> ". " <> bye <> "."
     in collect

main :: IO ()
main = print (calc' 10)
