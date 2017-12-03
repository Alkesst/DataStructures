module DataStructures.Stack.LinearStack (
    Stack, empty, isEmpty,
    push, pop, top, size
) where


import Data.List(intercalate)
import Test.QuickCheck

data Stack a = Empty | Node a (Stack a)


empty :: Stack a
empty = Empty

isEmpty :: Stack a -> Bool
isEmpty Empty = True
isEmpty _     = False

push :: a -> Stack a -> Stack a
push a s = (Node a s)

top :: Stack a -> a
top Empty      = error "top on epty stack"
top (Node a s) = a

pop :: Stack a -> Stack a
pop Empty      = error "pop on empty stack"
pop (Node x s) = s

size :: Stack a -> Int
size Empty      = 0
size (Node a s) = 1 + size s

instance (Show a) => Show (Stack a) where
    show s = "LinearStack(" ++ intercalate "," (stackToList s) ++ ")"

stackToList :: (Show a) => Stack a -> [String]
stackToList Empty      = []
stackToList (Node x s) = show x : stackToList s

instance (Eq a) => Eq (Stack a) where
    Empty == Empty         = True
    Node x s == Node x' s' = x==x' && s==s'
    _       == _           = False
