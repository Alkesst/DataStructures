/**
 * @author Pepe Gallardo, Data Structures, Grado en Informática. UMA.
 *
 * Interface for sets.
 */

package dataStructures.set;

/**
 * Interface for sets (collection of non repeated elements).
 *
 * @param <T> Type of elements in set.
 */
public interface Set<T> extends Iterable<T> {
	/** 
	 * Test for set emptiness. 
	 * @return {@code true} if set is empty, else {@code false}.
	 */
	boolean isEmpty();
	
	/**
	 * Retrieves number of elements in set (its cardinal).
	 * @return Number of elements in set.
	 */
    int size();
  
	/**
	 * Inserts new element in set. If element was already included, set is not modified
	 * (this is not considered an error and thus no exception is thrown).
	 * @param x Element to insert.
	 */
	void insert(T x);
	
	/**
	 * Tests whether element is included in set.
	 * @param x Element to test for inclusion.
	 * @return {@code true} if element {@code x} is in set, else {@code false}. 
	 */
	boolean isElem(T x);

	/**
	 * Removes element from set. If element is not in set, set is not modified
	 * (this is not considered an error and thus no exception is thrown).
	 * @param x Element to remove.
	 */
	void delete(T x);
	
	
	/**
	 * This method should modify this set so that it contains the union of its 
	 * elements plus those in the set parameter. 
	 * @param set  second set for computing union
	 */
    public void union(Set<T> set);

	/**
	 * This method should modify this set so that it contains the intersection of its 
	 * elements and those in the set parameter. 
	 * @param set  second set for computing intersection
	 */
    public void intersection(Set<T> set);

	/**
	 * This method should modify this set so that it contains the difference of its 
	 * elements minus those in the set parameter. 
	 * @param set  second set for computing difference
	 */
    public void difference(Set<T> set);
}
