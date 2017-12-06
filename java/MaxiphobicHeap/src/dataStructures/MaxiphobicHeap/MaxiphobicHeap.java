/**
 * @author <<write here your name>> 
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
	    /*int max = 0;
		if (h1 == null)
		    return h2;
		else if (h2 == null)
		    return h1;
		else if (h1.elem.compareTo(h2.elem) <= 0)
            max = Math.max(Math.max(h1.right.weight, h1.left.weight), h2.weight);
		    if (h1.left.weight == max) return node(h1.elem, h1.left, merge(h1.right, h2));
		    if (h1.right.weight == max) return node(h1.elem, h1.right, merge(h1.left, h2));
		    if (h2.weight == max) return node(h1.elem, h2, merge(h1.left, h2.right));
        */
        if (h1 == null)
            return h2;
        if (h2 == null)
            return h1;
        if(h2.elem.compareTo(h1.elem) < 0) {
            Tree<T> aux = h1;
            h1 = h2;
            h2 = aux;
        }
        if (h1.left != null && h1.right != null) {
            int max = Math.max(Math.max(h1.left.weight, h1.right.weight), h2.weight);
            if(h1.right.weight == max){
                Tree<T> aux = h1.left;
                h1.left = h1.right;
                h1.right = aux;
            }
            else if(h2.weight == max){
                Tree<T> aux = h1.left;
                h1.left = h2;
                h2 = aux;
            }
            h1.right = merge(h1.left, h2);
            h1.weight = h1.left.weight + h1.right.weight + 1;
        } else {
            // TODO Arreglar
            h1.left = h2;
        }
        return h1;
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
     *
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