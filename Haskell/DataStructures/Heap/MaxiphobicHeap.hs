--------------------------------------------------------------------------------
-- Student's name: Alejandro Garau Madrigal ------------------------------------
--------------------------------------------------------------------------------
-- Maxiphobic Heaps ------------------------------------------------------------
-- Data Structures. Grado en Informática. UMA. ---------------------------------
--------------------------------------------------------------------------------

module DataStructures.Heap.MaxiphobicHeap
  ( Heap
  , empty
  , isEmpty
  , minElem
  , delMin
  , insert
  , merge
  , mkHeap
  ) where

import Test.QuickCheck

data Heap a  = Empty | Node a Int (Heap a) (Heap a) deriving Show

-- number of elements in tree rooted at node
weight :: Heap a -> Int
weight Empty           = 0
weight (Node _ w _ _)  = w


singleton :: a -> Heap a
singleton x  = Node x 1 Empty Empty


empty :: Heap a
empty = Empty


isEmpty :: Heap a -> Bool
isEmpty Empty = True
isEmpty _     = False


insert :: (Ord a) => a -> Heap a -> Heap a
insert it h = merge (singleton it) h


minElem :: Heap a -> a
minElem Empty          = error "minElem on empty Heap"
minElem (Node x _ _ _) = x


delMin :: (Ord a) => Heap a -> Heap a
delMin Empty            = error "delMin on empty heap"
delMin (Node _ _ lh rh) = merge lh rh


merge :: (Ord a) => Heap a -> Heap a -> Heap a
merge Empty h'  = h'
merge h Empty   = h
merge h@(Node x w lh rh) h'@(Node x' w' lh' rh')
    | x <= x'   = check (Node x s h1 (merge h2 h3))
    | otherwise = check (Node x' s' h1' (merge h2' h3'))
        where
            (h1, h2, h3, s) = node lh rh h'
            (h1', h2', h3', s') = node lh' rh' h

-- Efficient O(n) bottom-up construction for heaps
mkHeap :: (Ord a) => [a] -> Heap a
mkHeap []  = empty
mkHeap xs  = mergeLoop (map singleton xs)
  where
    mergeLoop [h]  = h
    mergeLoop hs   = mergeLoop (mergePairs hs)

    mergePairs []         = []
    mergePairs [h]        = [h]
    mergePairs (h:h':hs)  = merge h h' : mergePairs hs

--------------------------------------------------------------------------------
-- Private definitions ---------------------------------------------------------
--------------------------------------------------------------------------------
node :: Heap a -> Heap a -> Heap a -> (Heap a, Heap a, Heap a, Int)
node lh rh h
    | wh >= wrh && wrh >= wlh = (h, rh, lh, wh+1)
    | wlh >= wrh && wrh >= wh = (lh, rh, h, wlh+1)
    | otherwise               = (rh, lh, h, wrh+1)
        where
            wlh = weight lh
            wrh = weight rh
            wh = weight h

check :: Heap a -> Heap a
check Empty = Empty
check (Node x w lh rh) = if wl < wr then (Node x w rh lh) else (Node x w lh rh)
    where
        wl = weight lh
        wr = weight rh

--------------------------------------------------------------------------------
-- Generating arbritray Heaps --------------------------------------------------
--------------------------------------------------------------------------------

instance (Ord a, Arbitrary a) => Arbitrary (Heap a) where
  arbitrary  = do
    xs <- arbitrary
    return (mkHeap xs)

a :: Heap Int
a = (Node 5 2) ((Node 6 0) Empty Empty) ((Node 7 0) Empty Empty)

b :: Heap Int
b = (Node 8 2) (Node 10 0 Empty Empty) (Node 15 0 Empty Empty)
