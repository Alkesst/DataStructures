module DataStructures.Queue.DoubleStackQueue
    (Queue, empty, isEmpty,
    first, dequeue, enqueue
    ) where

import Data.List(intercalate)
import Test.QuickCheck
import qualified DataStructures.Stack.LinearStack as S


data Queue a = Q (S.Stack a) (S.Stack a)

mkValid :: Queue a -> Queue a
mkValid (Q s1 s2)
    | S.isEmpty s1 = (Q s1 s2)
    | otherwise  = mkValid (Q (S.pop s1) (S.push a s2))
        where
            a = S.top s1

empty :: Queue a
empty = Q S.empty S.empty

isEmpty :: Queue a -> Bool
isEmpty (Q s1 s2) = undefined

first :: Queue a -> a
first (Q s1 s2) undefined

dequeue :: Queue a -> Queue a
dequeue (Q s1 s2) undefined

enqueue :: a -> Queue a -> Queue a
undefined
-- Showing a queue
instance (Show a) => Show (Queue a) where
  show q = "LinearQueue(" ++ intercalate "," (aux q) ++ ")"
    where
        aux lq = if isEmpty lq then [[]] else [(show (first lq))] ++ (aux (dequeue lq))


xd (Q a b) = if S.isEmpty b then mkValid (Q a b) else (Q a b)
sos1 (Q a _) = a
sos2 (Q _ a) = a

--Instance
instance (Eq a) => Eq (Queue a) where
    qa == qb
        | isEmpty qa && isEmpty qb = True
        | not (isEmpty qa) && not (isEmpty qb) = a == b && (dequeue qa) == (dequeue qb)
        | otherwise = False
            where
                a = first qa
                b = first qb

-- Cosas de quickCheck
instance (Arbitrary a) => Arbitrary (Queue a) where
    arbitrary = do
      xs <- listOf arbitrary
      return (foldr enqueue empty xs)

s1 = (S.push 3 (S.push 4 (S.push 5 (S.push 6 S.empty))))
