-------------------------------------------------------------------------------
-- Axioms for a Set
--
-- Data Structures. Grado en Informática. UMA.
-- Pepe Gallardo, 2011
-------------------------------------------------------------------------------

module DataStructures.Set.SetAxioms(ax1,ax2,ax3,ax4,ax5,ax6,ax7,ax8,ax9,ax10,ax11,ax12,ax13,ax14,ax15,ax16,ax17,setAxioms) where

--import DataStructures.Set.LinearSet
--import DataStructures.Set.ListSet
--import DataStructures.Set.SortedLinearSet
--import DataStructures.Set.BSTSet

import DataStructures.Set.SortedLinearSet
import Test.QuickCheck
import qualified DataStructures.Util.TestDatatype as TDT

-- type Elem = Int -- Test axioms using sets of Ints

type Elem = TDT.Elem -- Test axioms using sets of test data type elements

setAxioms = do
  quickCheck (ax1 :: Property)
  quickCheck (ax2 :: Elem -> Set Elem -> Property)
  quickCheck (ax3 :: Elem -> Property)
  quickCheck (ax4 :: Elem -> Elem -> Set Elem -> Property)
  quickCheck (ax5 :: Elem -> Property)
  quickCheck (ax6 :: Elem -> Elem -> Set Elem -> Property)
  quickCheck (ax7 :: Elem -> Elem -> Set Elem -> Property)
  quickCheck (ax8 :: Property)
  quickCheck (ax9 :: Elem -> Set Elem -> Property)
  quickCheck (ax10 :: Elem -> Set Elem -> Property)
  quickCheck (ax11 :: Set Elem -> Property)
  quickCheck (ax12 :: Elem -> Set Elem -> Set Elem -> Property)
  quickCheck (ax13 :: Set Elem -> Property)
  quickCheck (ax14 :: Elem -> Set Elem -> Set Elem -> Property)
  quickCheck (ax15 :: Elem -> Set Elem -> Set Elem -> Property)
  quickCheck (ax16 :: Set Elem -> Property)
  quickCheck (ax17 :: Elem -> Set Elem -> Set Elem -> Property)

-- the empty set is empty
ax1 = True ==> isEmpty empty

-- insert always returns non-empty sets
ax2 x s = True ==> not (isEmpty (insert x s))

-- no element is included in empty set
ax3 x = True ==> not (isElem x empty)

-- only elements previously inserted are included in set
ax4 x y s = True ==> isElem y (insert x s) == (x==y) || isElem y s

-- deleting a non-included element does not modify set
ax5 x = True ==> delete x empty == empty

-- deleting last inserted element returns set before insertion
ax6 x y s = (x==y) ==> delete x (insert y s) == delete x s

-- delete and insert commute
ax7 x y s = (x/=y) ==> delete x (insert y s) == insert y (delete x s)


-- Axioms for size
ax8 = True ==> size empty == 0

ax9 x s = isElem x s ==> size (insert x s) == size s

ax10 x s = not (isElem x s) ==> size (insert x s) == 1 + size s


-- Axioms for union
ax11 s        = True ==> union s empty == s
ax12 x s1 s2  = True ==> union s1 (insert x s2) == insert x (union s1 s2)

-- Axioms for intersection
ax13 s         = True              ==> intersection s empty == empty
ax14 x s1 s2   = isElem x s1       ==> intersection s1 (insert x s2) == insert x (intersection s1 s2)
ax15 x s1 s2   = not (isElem x s1) ==> intersection s1 (insert x s2) == intersection s1 s2

-- Axioms for difference
ax16 s        = True ==> difference s empty == s
ax17 x s1 s2  = True ==> difference s1 (insert x s2) == delete x (difference s1 s2)
