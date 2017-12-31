-------------------------------------------------------------------------------
-- Binary Search Trees
--
-- Data Structures. Grado en Informática. UMA.
-- Made by Alejandro Garau Madrigal
-------------------------------------------------------------------------------
module DataStructures.SearchTree.BinarySearchTree
  ( BST
  , empty
  , isEmpty
  , size
  , insert
  , search
  , isElem
  , delete
  --, updateOrInsert

  , inOrder
  , preOrder
  , postOrder

  --, foldInOrder
  --, foldPreOrder
  --, foldPostOrder

  , minim
  , maxim
  , deleteMinim
  , deleteMaxim

  , isBST
  , mkBST

  , pretty
  , drawOnWith
  ) where

import Data.Maybe(isJust)
import DataStructures.Graphics.DrawTrees
import Test.QuickCheck


data BST a = Empty | Node a (BST a) (BST a) deriving Show


empty :: BST a
empty = Empty

isEmpty :: BST a -> Bool
isEmpty Empty = True
isEmpty _     = False

size :: BST a -> Int
size Empty          = 0
size (Node _ lt rt) = 1 + size lt + size rt

insert :: (Ord a) => a -> BST a -> BST a
insert it Empty             = Node it Empty Empty
insert it (Node x lt rt)
    | it < x    = Node x (insert it lt) rt
    | it > x    = Node x lt (insert it rt)
    | otherwise = Node it lt rt


isElem :: (Ord a) => a -> BST a -> Bool
isElem x t = isJust (search x t)

delete :: (Ord a) => a -> BST a -> BST a
delete it Empty             = Empty
delete it (Node x lt rt)
    | it < x    = Node x (delete it lt) rt
    | it > x    = Node x lt (delete it rt)
    | otherwise = combine lt rt

minim :: BST a -> a
minim Empty             = error "minim on empty tree"
minim (Node x Empty rt) = x
minim (Node x lt rt)    = minim lt

maxim :: BST a -> a
maxim Empty             = error "maxim on empty tree"
maxim (Node x lt Empty) = x
maxim (Node x lt rt)    = maxim rt

deleteMaxim :: BST a -> BST a
deleteMaxim Empty               = error "deleteMaxim on empty tree"
deleteMaxim (Node x lt Empty)   = lt
deleteMaxim (Node x lt rt)      = Node x lt (deleteMaxim rt)

deleteMinim :: BST a -> BST a
deleteMinim Empty               = error "deleteMinim on empty tree"
deleteMinim (Node x Empty rt)   = rt
deleteMinim (Node x lt rt)      = Node x (deleteMinim lt) rt

--------------------------------------------------------------------------------
-- Private definitions
--------------------------------------------------------------------------------

combine :: BST a -> BST a -> BST a
combine Empty rt    = rt
combine lt Empty    = lt
combine lt rt       = Node x' lt rt'
    where (x', rt') = split rt

split :: BST a -> (a, BST a)
split (Node x Empty rt) = (x, rt)
split (Node x lt    rt) = (x', Node x lt' rt)
    where (x', lt') = split lt

search :: (Ord a) => a -> BST a -> Maybe a
search it Empty             = Nothing
search it (Node x lt rt)
    | it < x    = search it lt
    | it > x    = search it rt
    | otherwise = Just it


-- Generating arbitrary BinarySearchTrees
instance (Ord a, Arbitrary a) => Arbitrary (BST a) where
  arbitrary  = do
    xs <- arbitrary
    return (mkBST xs)
--------------------------------------------------------------------------------
-- Iterators
--------------------------------------------------------------------------------

inOrder :: BST a -> [a]
inOrder t  = aux t []
  where
    aux Empty          xs  = xs
    aux (Node x lt rt) xs  = aux lt (x : aux rt xs)

preOrder :: BST a -> [a]
preOrder t  = aux t []
  where
    aux Empty          xs  = xs
    aux (Node x lt rt) xs  = x : aux lt (aux rt xs)

postOrder :: BST a -> [a]
postOrder t  = aux t []
  where
    aux Empty          xs  = xs
    aux (Node x lt rt) xs  = aux lt (aux rt (x:xs))

--------------------------------------------------------------------------------
-- Auxiliar definitions
--------------------------------------------------------------------------------

isBST :: (Ord a) => BST a -> Bool
isBST Empty          = True
isBST (Node x lt rt) = forAll (<x) lt && forAll (>=x) rt
                        && isBST lt && isBST rt
    where
        forAll :: (a -> Bool) -> BST a -> Bool
        forAll p Empty          = True
        forAll p (Node x lt rt) = p x && forAll p lt && forAll p rt

mkBST :: (Ord a) => [a] -> BST a
mkBST xs  = foldl (flip insert) empty xs

--------------------------------------------------------------------------------
-- Printing Trees author: Pepe Gallardo (@ppgllrd)
--------------------------------------------------------------------------------
instance Subtrees (BST a) where
  subtrees Empty           = []
  subtrees (Node x lt rt)  = [lt,rt]

  isEmptyTree  = isEmpty

instance (Show a) => ShowNode (BST a) where
  showNode (Node x lt rt)  = show x

drawOnWith :: FilePath -> (a -> String) -> BST a -> IO ()
drawOnWith file toString  = _drawOnWith file showBST
 where
  showBST (Node x _ _)  = toString x


-------------------------------------------------------------------------------
-- Pretty BST adapted by Pepe Gallardo (@ppgllrd)
-- (adapted from http://stackoverflow.com/questions/1733311/pretty-print-a-tree)
-------------------------------------------------------------------------------

pretty :: (Show a) => BST a -> IO ()
pretty t  = putStrLn (unlines xss)
    where
        (xss,_,_,_) = pprint t

pprint Empty                 = ([], 0, 0, 0)
pprint (Node x Empty Empty)  = ([s], ls, 0, ls-1)
    where
      s = show x
      ls = length s
pprint (Node x lt rt)         =  (resultLines, w, lw'-swl, totLW+1+swr)

        where
            nSpaces n = replicate n ' '
            nBars n = replicate n '_'
            -- compute info for string of this node's data
            s = show x
            sw = length s
            swl = div sw 2
            swr = div (sw-1) 2
            (lp,lw,_,lc) = pprint lt
            (rp,rw,rc,_) = pprint rt
            -- recurse
            (lw',lb) = if lw==0 then (1," ") else (lw,"/")
            (rw',rb) = if rw==0 then (1," ") else (rw,"\\")
            -- compute full width of this tree
            totLW = maximum [lw', swl,  1]
            totRW = maximum [rw', swr, 1]
            w = totLW + 1 + totRW
            {-
            A suggestive example:
            dddd | d | dddd__
              / |   |       \
            lll |   |       rr
                |   |      ...
                |   | rrrrrrrrrrr
            ----       ----           swl, swr (left/right string width (of this node) before any padding)
            ---       -----------    lw, rw   (left/right width (of subtree) before any padding)
            ----                      totLW
                      -----------    totRW
            ----   -   -----------    w (total width)
            -}
            -- get right column info that accounts for left side
            rc2 = totLW + 1 + rc
            -- make left and right tree same height
            llp = length lp
            lrp = length rp
            lp' = if llp < lrp then lp ++ replicate (lrp - llp) "" else lp
            rp' = if lrp < llp then rp ++ replicate (llp - lrp) "" else rp
            -- widen left and right trees if necessary (in case parent node is wider, and also to fix the 'added height')
            lp'' = map (\s -> if length s < totLW then nSpaces (totLW - length s) ++ s else s) lp'
            rp'' = map (\s -> if length s < totRW then s ++ nSpaces (totRW - length s) else s) rp'
            -- first part of line1
            line1 = if swl < lw' - lc - 1 then
                      nSpaces (lc + 1) ++ nBars (lw' - lc - swl) ++ s
                  else
                      nSpaces (totLW - swl) ++ s
            -- line1 right bars
            lline1 = length line1
            line1' = if rc2 > lline1 then
                      line1 ++ nBars (rc2 - lline1)
                   else
                      line1
            -- line1 right padding
            line1'' = line1' ++ nSpaces (w - length line1')
            -- first part of line2
            line2 = nSpaces (totLW - lw' + lc) ++ lb
            -- pad rest of left half
            line2' = line2 ++ nSpaces (totLW - length line2)
            -- add right content
            line2'' = line2' ++ " " ++ nSpaces rc ++ rb
            -- add right padding
            line2''' = line2'' ++ nSpaces (w - length line2'')
            resultLines = line1'' : line2''' : zipWith (\lt rt -> lt ++ " " ++ rt) lp'' rp''



--------------------------------------------------------------------------------
-- Proves
--------------------------------------------------------------------------------

a :: BST Int
a = Node 4 (Node 3 (Node 2 Empty Empty) Empty) (Node 5 Empty (Node 7 Empty Empty))
