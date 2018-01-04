--------------------------------------------------------------------------------
-- AVL (Adelson-Velskii and Landis) Trees
-- Data Structures. Alejandro Garau Madrigal
--------------------------------------------------------------------------------

module DataStructures.SearchTree.AVLTree
  ( AVL
  , empty
  , isEmpty
  , size
  , insert
  , search
  , isElem
  , delete
  , updateOrInsert

  , inOrder
  , preOrder
  , postOrder

  , foldInOrder
  , foldPreOrder
  , foldPostOrder

  , minim
  , maxim
  , deleteMinim
  , deleteMaxim

  , isAVL
  , mkAVL

  , height

  , drawOnWith
  ) where

import Data.Maybe(isJust)
import DataStructures.Graphics.DrawTrees
import Test.QuickCheck

data AVL a = Empty | Node a Int (AVL a) (AVL a) deriving Show

empty :: AVL a
empty = Empty

isEmpty :: AVL a -> Bool
isEmpty Empty = True
isEmpty _     = False

size :: AVL a -> Int
size Empty              = 0
size (Node _ _ lt rt)   = 1 + size lt + size rt

insert :: (Ord a) => a -> AVL a -> AVL a
insert k' Empty             = node k' Empty Empty
insert k' (Node k h lt rt)
    | k' < k    = balance k (insert k' lt) rt
    | k' > k    = balance k lt (insert k' rt)
    | otherwise = Node k' h lt rt

search :: (Ord a) => a -> AVL a -> Maybe a
search k' Empty             = Nothing
search k' (Node k h lt rt)
    | k' == k   = Just k
    | k' <  k   = search k' lt
    | otherwise = search k' rt

-- Data.Maybe(isJust) definition:
-- isJust :: Maybe a -> Bool
-- isJust Just _    = True
-- isJust Nothing   = False
isElem :: (Ord a) => a -> AVL a -> Bool
isElem k' t = isJust (search k' t)

delete :: (Ord a) => a -> AVL a -> AVL a
delete k' Empty             = Empty
delete k' (Node k h lt rt)
    | k' <  k   = balance k (delete k' lt) rt
    | k' >  k   = balance k lt (delete k' rt)
    | otherwise = combine lt rt

height :: AVL a -> Int
height Empty            = 0
height (Node x h lt rt) = h

updateOrInsert :: (Ord a) => (a -> a) -> a -> AVL a -> AVL a
updateOrInsert f x' Empty = node x' Empty Empty
updateOrInsert f x' (Node x h lt rt)
    | x' < x    = balance x (updateOrInsert f x' lt) rt
    | x' > x    = balance x lt (updateOrInsert f x' rt)
    | otherwise = Node (f x) h lt rt

minim :: AVL a -> a
minim Empty                 = error "Minim on empty tree"
minim (Node x h Empty rt)   = x
minim (Node x h lt rt)      = minim lt

maxim :: AVL a -> a
maxim Empty                 = error "Maxim on empty tree"
maxim (Node x h lt Empty)   = x
maxim (Node x h lt rt)      = maxim rt

deleteMinim :: AVL a -> AVL a
deleteMinim Empty               = error "deleteMinim on empty tree"
deleteMinim (Node x h Empty rt) = rt
deleteMinim (Node x h lt rt)    = balance x (deleteMinim lt) rt

deleteMaxim :: AVL a -> AVL a
deleteMaxim Empty               = error "deleteMaxim on empty tree"
deleteMaxim (Node x h lt Empty) = lt
deleteMaxim (Node x h lt rt)    = balance x lt (deleteMaxim rt)

--------------------------------------------------------------------------------
-- Iterator
--------------------------------------------------------------------------------

inOrder :: AVL a -> [a]
inOrder t = aux t []
    where
        aux Empty     xs        = xs
        aux (Node x h lt rt) xs = aux lt (x : aux rt xs)

preOrder :: AVL a -> [a]
preOrder t = aux t []
    where
        aux Empty   xs          = xs
        ayx (Node x h lt rt) xs = x : aux lt (aux rt xs)

postOrder :: AVL a -> [a]
postOrder t = aux t []
    where
        aux Empty xs            = xs
        aux (Node x h lt rt) xs = aux lt (aux rt (x:xs))

-- What is this tho
traversal :: ((b -> b) -> (b -> b) -> (b -> b) -> (b -> b)) ->
                     (a -> b -> b) -> b -> AVL a -> b
traversal order f z t  = aux t z
    where
        aux Empty             = id
        aux (Node x h lt rt)  = order (f x) (aux lt) (aux rt)

foldInOrder :: (a -> b -> b) -> b -> AVL a -> b
foldInOrder = traversal(\xf lf rf -> lf . xf . rf)

foldPreOrder :: (a -> b -> b) -> b -> AVL a -> b
foldPreOrder  = traversal (\xf lf rf -> xf . lf . rf)

foldPostOrder :: (a -> b -> b) -> b -> AVL a -> b
foldPostOrder  = traversal (\xf lf rf -> lf . rf . xf)

--------------------------------------------------------------------------------
-- useful definitions
--------------------------------------------------------------------------------

combine :: AVL a -> AVL a -> AVL a
combine Empty rt    = rt
combine lt Empty    = lt
combine lt rt       = balance k' lt rt'
    where
        (k', rt') = split rt

split :: AVL a -> (a, AVL a)
split (Node k h Empty rt) = (k, rt)
split (Node k h lt rt)    = (k', (balance k lt' rt))
    where
        (k', lt') = split lt

--------------------------------------------------------------------------------
-- Auxiliar definitions
--------------------------------------------------------------------------------

isAVL :: (Ord a) => AVL a -> Bool
isAVL Empty              = True
isAVL (Node k h lt rt)  = forAll (<k) lt && forAll (>k) rt &&
                            abs (height lt - height rt) <= 1
                            && isAVL lt && isAVL rt
    where
        forAll :: (a -> Bool) -> AVL a -> Bool
        forAll p Empty              = True
        forAll p (Node x h lt rt)   = p x && forAll p lt && forAll p rt

mkAVL :: (Ord a) => [a] -> AVL a
mkAVL xs  = foldl (flip insert) empty xs

--------------------------------------------------------------------------------
-- private definitions
--------------------------------------------------------------------------------

node :: a -> AVL a -> AVL a -> AVL a
node a lt rt = Node a h lt rt
    where h = 1 + max (height lt) (height rt)

-- Rotatations

rotR :: AVL a -> AVL a
rotR (Node x h (Node lk lh llt lrt) rt)  =
    node lk llt (node x lrt rt)

rotL :: AVL a -> AVL a
rotL (Node x h lt (Node rk rh rlt rrt))  =
    node rk (node x lt rlt) rrt



-- check which side is unbalanced
rightLeaning :: AVL a -> Bool
rightLeaning (Node x h lt rt) = height lt < height rt

leftLeaning :: AVL a -> Bool
leftLeaning (Node x h lt rt) = height lt > height rt

balance :: a -> AVL a -> AVL a -> AVL a
balance k lt rt
    | (lh - rh > 1) && leftLeaning lt  = rotR (node k lt rt)
    | (lh - rh > 1)                    = rotR (node k (rotL lt) rt)
    | (rh - lh > 1) && rightLeaning rt = rotL (node k lt rt)
    | (rh - lh > 1)                    = rotL (node k lt (rotR rt))
    | otherwise                        = node k lt rt
        where
            lh = height lt
            rh = height rt
--------------------------------------------------------------------------------
-- Arbitrary AVL trees
--------------------------------------------------------------------------------

instance (Ord a, Arbitrary a) => Arbitrary (AVL a) where
  arbitrary  = do
    xs <- arbitrary
    return (mkAVL xs)

-------------------------------------------------------------------------------
-- Drawing an AVL Tree
-------------------------------------------------------------------------------

instance Subtrees (AVL a) where
    subtrees Empty             = []
    subtrees (Node x h lt rt)  = [lt,rt]

    isEmptyTree  = isEmpty

instance (Show a) => ShowNode (AVL a) where
    showNode (Node x _ _ _)  = show x

drawOnWith :: FilePath -> (a -> String) -> AVL a -> IO ()
drawOnWith file toString  = _drawOnWith file showBST
    where
        showBST (Node x _ _ _)  = toString x


a :: AVL Int
a = Node 18 5 (Node (-20) 3 (Node (-42) 2 (Node (-43) 1 Empty Empty) (Node (-41) 1 Empty Empty)) (Node 12 2 (Node (-18) 1 Empty Empty) Empty)) (Node 38 4 (Node 28 3 (Node 26
    2 (Node 21 1 Empty Empty) Empty) (Node 34 2 Empty (Node 36 1 Empty Empty))) (Node 39 2 Empty (Node 43 1 Empty Empty)))
