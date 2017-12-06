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
    | x <= x'   = Node x s h1 (merge h2 h3)
    | otherwise = Node x' s h1' (merge h2' h3')
        where
            (h1, h2, h3) = node x lh rh h'
            (h1', h2', h3') = node x' lh' rh' h
            s = w + w'

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

-- check :: Heap a -> Heap a
--------------------------------------------------------------------------------
-- Private definitions ---------------------------------------------------------
--------------------------------------------------------------------------------
node :: a -> Heap a -> Heap a -> Heap a -> (Heap a, Heap a, Heap a)
node x lh rh h
    | m == wh = (h, rh, lh)
    | m == wl = (lh, rh, h)
    | m == wr = (rh, lh, h)
        where
            wl = weight lh
            wr = weight rh
            wh = weight h
            m = max (max wl wr) wh

--------------------------------------------------------------------------------
-- Generating arbritray Heaps --------------------------------------------------
--------------------------------------------------------------------------------

instance (Ord a, Arbitrary a) => Arbitrary (Heap a) where
  arbitrary  = do
    xs <- arbitrary
    return (mkHeap xs)
