-------------------------------------------------------------------------------
-- Set implemented with BinarySearchTree
--
-- Data Structures. Software Engineering. UMA.
--
-- Students name: Garau Madrigal, Alejandro, dec 2017
-- Is requiered to implement the BST before using this implementation.
--
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
  --, difference
  ) where

import qualified DataStructures.SearchTree.BST as T

data Set a = Empty | S (T.BST a) deriving Show

empty :: Set a
empty = Empty

isEmpty :: Set a -> Bool
isEmpty Empty = True
isEmpty _     = False

--------------------------------------------------------------------------------
-- Basic behaviour
--------------------------------------------------------------------------------

size :: Set a -> Int
size Empty      = 0
size (S t)      =  T.size t

insert :: (Ord a) => a -> Set a -> Set a
insert item Empty             = S (T.insert item T.empty)
insert item (S t) | contains  = S (T.insert item t)
                  | otherwise = (S t)
    where
        contains = not (T.isElem item t)

isElem :: (Ord a) => a -> Set a -> Bool
isElem x Empty  = False
isElem x (S t)  = (T.isElem x t)

delete :: (Ord a) => a -> Set a -> Set a
delete item Empty   = Empty
delete item (S t)   = S (T.delete item t)

--------------------------------------------------------------------------------
-- Basic operations with Sets
--------------------------------------------------------------------------------

union :: (Ord a) => Set a -> Set a -> Set a
union Empty Empty   = Empty
union Empty (S t2)  = S t2
union (S t1) Empty  = S t1
union (S t1) (S t2) = addFromList list1 (S t2)
    where list1 = T.inOrder t1

intersection :: (Ord a) => Set a -> Set a -> Set a
intersection Empty Empty  = Empty
intersection Empty (S t2) = Empty
intersection (S t1) Empty = Empty
intersection (S t1) (S t2) = addEqualsFromList list1 (S t2)
    where list1 = T.inOrder t1

-- difference :: (Ord a) => Set a -> Set a -> Set a

--------------------------------------------------------------------------------
-- Auxiliar definitions
--------------------------------------------------------------------------------

-- Not working. 
addEqualsFromList :: (Ord a) => [a] -> Set a -> Set a
addEqualsFromList [] (S t)     = S t
addEqualsFromList (x:xs) (S t) = if (T.isElem x t) then equals else notEquals
    where
        equals = addEqualsFromList xs (S (T.insert x t))
        notEquals = addEqualsFromList xs (S t)

addFromList :: (Ord a) => [a] -> Set a -> Set a
addFromList [] (S t)     = S t
addFromList (x:xs) (S t) = addFromList xs (S (T.insert x t))

--------------------------------------------------------------------------------
-- Examples
--------------------------------------------------------------------------------

s1 :: Set Integer
s1 = S (T.insert 4 (T.insert 5 T.empty))

s2 :: Set Integer
s2 = S (T.insert 5 (T.insert 8 T.empty))

s3 :: Set Integer
s3 = Empty
