/**
 * @author Alejandro Garau Madrigal
 * 
 * Maxiphobic Heaps
 * Data Structures, Grado en Informática. UMA.
 *
 */
 
package dataStructures.MaxiphobicHeap;


/**
 * Heap implemented using maxiphobic heap-ordered binary trees.
 * @param <T> Type of elements in heap.
 */
public class MaxiphobicHeap<T extends Comparable<? super T>> implements	Heap<T> {

	protected static class Tree<E> {
		E elem;
		int weight;
		Tree<E> left;
		Tree<E> right;
	}

	private static int weight(Tree<?> heap) {
		return heap == null ? 0 : heap.weight;
	}

	private static <T extends Comparable<? super T>> Tree<T> merge(Tree<T> h1,	Tree<T> h2) {
        if (h1 == null)
            return h2;
        if (h2 == null)
            return h1;

        if(h1.elem.compareTo(h2.elem) > 0) {
            Tree<T> aux = h1;
            h1 = h2;
            h2 = aux;
        }
        /*Tree<T> ret = new Tree<>();
        Tupla<T> tup = node(h1.left, h1.right, h2);
        ret.elem = h1.elem;
        ret.left = tup.h;
        ret.right = merge(tup.lh, tup.rh);
        ret.weight = weight(h1) + weight(h2);
        return ret;*/
        Tree<T> tree = new Tree<>();
        tree.elem = h1.elem;
		// int max = Math.max(Math.max(weight(h1.left), weight(h1.right)), weight(h2));
		int wh1l = weight(h1.left);
		int wh1r = weight(h1.right);
		int wh2  = weight(h2);
        if(wh2 >= wh1l && wh2 >= wh1r){
            tree.weight = weight(h2) + 1;
            tree.left = h2;
            tree.right = merge(h1.left, h1.right);
        } else if (wh1l >= wh2 && wh1l >= wh1r){
            tree.weight = weight(h1.left) + 1;
            tree.left = h1.left;
            tree.right = merge(h1.right, h2);
        }
        else{
			tree.weight = weight(h1.right) + 1;
			tree.left = h1.right;
			tree.right = merge(h1.left, h2);
		}
		/*COMPROBAR QUE SEA ZURDO*/
		if(weight(tree.right) > weight(tree.left)){
            Tree<T> aux = tree.left;
            tree.left = tree.right;
            tree.right = aux;
        }

        return tree;
	}

    protected Tree<T> root;

	/**
	 * Constructor: creates an empty Maxiphobic Heap.
	 * <p>Time complexity: O(1)
	 */
	public MaxiphobicHeap() {
		this.root = null;
	}

	/** 
	 * <p>Time complexity: O(1)
	 */
	public boolean isEmpty() {
		return this.root == null;
	}

    /**
     * @return size
     * <p>Time complexity: O(1)
     */
	@Override
	public int size() {
		return isEmpty() ? 0 : root.weight;
	}

	/** 
	 * <p>Time complexity: O(1)
     * @throws EmptyHeapException if heap stores no element.
	 */
	public T minElem() {
		if (isEmpty())
		    throw new EmptyHeapException("minElem on empty Heap");
		return root.elem;
	}

	/** 
	 * <p>Time complexity: O(log n)
	 * @throws EmptyHeapException if heap stores no element.
	 */
	public void delMin() {
		if(isEmpty())
		    throw new EmptyHeapException("delMin on empty Heap.");
		root = merge(root.left, root.right);
	}

	/** 
	 * <p>Time complexity: O(log n)
	 */
	public void insert(T value) {
		Tree<T> item = new Tree<>();
		item.elem = value;
		item.weight = 1;
		item.right = item.left = null;
		root = merge(item, root);
	}

	private static String toStringRec(Tree<?> tree) {
		return tree == null ? "null" : "Node<" + toStringRec(tree.left) + ","
				+ tree.elem + "," + toStringRec(tree.right) + ">";
	}
	
	/** 
	 * Returns representation of heap as a String.
	 */
	public String toString() {
		String className = getClass().getSimpleName();

		return className+"("+toStringRec(this.root)+")";
	}	
	
}