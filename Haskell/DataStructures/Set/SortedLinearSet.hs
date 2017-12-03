-------------------------------------------------------------------------------
-- Linear implementation of Sets. Nodes are sorted according to
-- value of their elements and elements are non-repeated
--
-- Data Structures. Software Engineering. UMA.
--
-- Students name: Garau Madrigal, Alejandro
-------------------------------------------------------------------------------

module DataStructures.Set.SortedLinearSet
  ( Set
  , empty
  , isEmpty
  , size
  , insert
  , isElem
  , delete

  -- to be done lately, fold

  , union
  , intersection
  , difference
  ) where

import Data.List(intercalate)
import Test.QuickCheck

data Set a  = Empty | Node a (Set a)

empty :: Set a
empty  = Empty

isEmpty :: Set a -> Bool
isEmpty Empty = True
isEmpty _     = False

insert :: (Ord a) => a -> Set a -> Set a
insert x Empty  = Node x Empty
insert x (Node y s)
 | x < y        = Node x (Node y s)
 | x == y       = Node y s
 | otherwise    = Node y (insert x s)

-- checks if an element is in set or not
isElem :: (Ord a) => a -> Set a -> Bool
isElem x Empty       = False
isElem x (Node y s) = x == y || isElem x s

-- removes an element from a set
delete :: (Ord a) => a -> Set a -> Set a
delete x Empty      = Empty
delete x (Node y s) | x < y     = Node y s
                    | x == y    = s
                    | otherwise = Node y (delete x s)

-- return number of elements in set
size :: Set a -> Int
size Empty      = 0
size (Node x s) = 1 + size s

-- union of two sets
union :: (Ord a) => Set a -> Set a -> Set a
union Empty s2 = s2
union s1 Empty = s1
union (Node x s1) (Node y s2)
  | x == y    = (s1 `union` (Node y s2))
  | x < y     = Node x (s1 `union` (Node y s2))
  | otherwise = Node y (s2 `union` (Node x s1))

-- intersection of two sets
intersection :: (Ord a) => Set a -> Set a -> Set a
intersection s1 Empty   = Empty
intersection Empty s2   = Empty
intersection (Node x s1) (Node y s2)
    | x < y = (s1 `intersection` (Node y s2))
    | y < x = (s2 `intersection` (Node x s1))
    | x == y = Node x (s1 `intersection` (Node y s2))


-- difference of two sets
difference :: (Ord a) => Set a -> Set a -> Set a
difference Empty _  = Empty
difference s Empty  = s
difference s1 s2    = deleting s1 (inter)
        where
            inter = intersection s1 s2
            deleting Empty _        = Empty
            deleting s1 Empty       = s1
            deleting s1 (Node y s2) = deleting (delete y s1) s2


-- Showing a set
instance (Show a) => Show (Set a) where
  show s  = "SortedLinearSet(" ++ intercalate "," (aux s) ++ ")"
    where
      aux Empty       = []
      aux (Node x s)  = show x : aux s

-- Set equality
instance (Eq a) => Eq (Set a) where
  Empty      == Empty         = True
  (Node x s) == (Node x' s')  = x==x' && s==s'
  _          == _             = False

-- This instance is used by QuickCheck to generate random sets
instance (Ord a, Arbitrary a) => Arbitrary (Set a) where
    arbitrary  = do
      xs <- listOf arbitrary
      return (foldr insert empty xs)



s1 :: Set Int
s1 = insert 1 (insert 2 (insert 3 (insert 1 empty)))

s2 :: Set Int
s2 = insert 3 (insert 8 (insert 14 (insert 6 (insert 4 (insert 2 empty)))))
