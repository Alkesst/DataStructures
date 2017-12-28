--------------------------------------------------------------------------------
-- Priority Queues with Maxiphobic Heaps
--
-- Data Structures. Grado en Informática. UMA.
-- Alejandro Garau Madrigal 2017
--------------------------------------------------------------------------------
module DataStructures.PriorityQueue.LinearPriorityQueue(
      PQueue
    , empty
    , isEmpty
    , first
    , dequeue
    , enqueue
) where

import Data.List(intercalate)
import Test.QuickCheck

data PQueue a = Empty | Node a (PQueue a)

empty :: PQueue a
empty = Empty

isEmpty :: PQueue a -> Bool
isEmpty Empty = True
isEmpty _     = False

first :: PQueue a -> a
first Empty         = error "first on empty queue"
first (Node x t)    = x

dequeue :: PQueue a -> PQueue a
dequeue Empty       = Empty
dequeue (Node x t)  = t

enqueue :: (Ord a) => a -> PQueue a -> PQueue a
enqueue it Empty        = Node it Empty
enqueue it (Node x t)   | it == x   = (Node x (Node it t))
                        | it < x    = (Node it (Node x t))
                        | otherwise = (Node x (enqueue it t))

-- Showing a queue
instance (Show a) => Show (PQueue a) where
  show q = "PriorityQueue(" ++ intercalate "," (aux q) ++ ")"
    where
        aux lq = if isEmpty lq then [[]] else [(show (first lq))] ++ (aux (dequeue lq))



--Instance
instance (Eq a) => Eq (PQueue a) where
    qa == qb
        | isEmpty qa && isEmpty qb = True
        | not (isEmpty qa) && not (isEmpty qb) = a == b && (dequeue qa) == (dequeue qb)
        | otherwise = False
            where
                a = first qa
                b = first qb

-- Cosas de quickCheck
instance (Ord a, Arbitrary a) => Arbitrary (PQueue a) where
    arbitrary = do
      xs <- listOf arbitrary
      return (foldr enqueue empty xs)

s1 :: PQueue Int
s1 = Node 1 (Node 2 (Node 2 (Node 4 (Node 7 Empty))))
