/**
 * @author Pepe Gallardo, Data Structures, Grado en InformÃ¡tica. UMA.
 *
 * Interface for Heaps
 */
 
 package dataStructures.MaxiphobicHeap;

/**
 * Interface for heap data structures. A heap stores elements in order, providing
 * fast access to and removal of minimum element.
 *
 * @param <T> Type of elements in heap. Note that an order relation 
 *  ({@link java.lang.Comparable}) should be defined on this type.
 */
public interface Heap<T extends Comparable<? super T>> {
	/**
	 * Test for heap emptiness.
	 * @return {@code true} if heap is empty (has zero elements), else {@code false}.
	 */
	boolean isEmpty();

	/**
	 * Retrieves number of elements in heap.
	 * @return Number of elements in heap.
	 */	
	int size();
	
	/**
	 * Inserts a new element in heap.
	 * @param x Element to insert.
	 */
	void insert(T x);
	
	/**
	 * Returns (without removal) minimum element in heap.
	 * @return Minimum element in heap.
	 * @throws <code>EmptyHeapException</code> if heap stores no element.
	 */
	T minElem();
	
	/**
	 * Removes minimum element from heap.
	 * @throws <code>EmptyHeapException</code> if heap stores no element.
	 */
	void delMin();	

}
