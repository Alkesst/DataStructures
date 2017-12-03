/*
 * @author Alejandro Garau Madrigal
 *
 * Sets implemented using without repetitions sorted linked lists. 
 */

package dataStructures.set;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class SortedLinkedSet<T extends Comparable<? super T>> implements Set<T> {
	
    static private class Node<E> {
        E elem;
        Node<E> next;

        Node(E x, Node<E> node) {
            elem = x;
            next = node;
        }
    }

    private Node<T> first; // keep nodes in linked list sorted according "elem"
    private int size;		// number of elements in this set

    // Default constructor: constructs an empty set
    public SortedLinkedSet() {
    	first = null;
    	size = 0;
    }
    
    // Copy constructor: constructs another set which is a deep copy or argument.
    // This constructor should construct another set with same elements as parameter. 
    // New nodes for each element in new set should be allocated using new and 
    // linked accordingly. Note that the parameter is an abstract set hence the only 
    // way to access its elements is by using an iterator. 
    public SortedLinkedSet(Set<T> set) {
        for (T aSet : set) insert(aSet);
    }
        
    
    public boolean isEmpty() {
        return size == 0;
    }

    public int size() { 
    	return size; 
    	}

    // Inserts a new element in this set. Linked nodes are sorted according to their values
    public void insert(T item) {
        Node<T> previous = null;
        Node<T> current = first;

        // Advance until end of linked list or until finding a larger element
        while (current != null && current.elem.compareTo(item) < 0) {
            previous = current;
            current = current.next;
        }

        // check if item is already in set
        boolean found = (current != null) && current.elem.equals(item);
        
        if(!found) { // avoid nodes with repeated elements
            if (previous == null) // Insert new element in first position of lined structure
                first = new Node<>(item, first);
            else  // Insert new element after previous
                previous.next = new Node<>(item, current);
            size++;
        }
    }

    public boolean isElem(T item) {
        Node<T> current = first;
        while(current != null && (current.elem.compareTo(item) < 0)){
            current = current.next;
        }
    	return (current != null) && current.elem.equals(item);
    }

    public void delete(T item) {
        Node<T> previous = null;
        Node<T> current = first;
        while(current != null && current.elem.compareTo(item) < 0){
            previous = current;
            current = current.next;
        }
        if(current != null && current.elem.equals(item)){
            if(previous == null){
                first = current.next;
            } else {
                previous.next = current.next;
            }
        }
    }

    /**
     * Iterator over elements in this set.
     * Note that {@code remove} method is not supported. Note also
     * that linked structure should not be modified during iteration as
     * iterator state may become inconsistent.
     * @see java.lang.Iterable#iterator()
     */
    public Iterator<T> iterator() {
        return new LinkedSetIterator();
    }

    private class LinkedSetIterator implements Iterator<T> {
        Node<T> current;

        private LinkedSetIterator(){
            current = first;
        }

        public boolean hasNext() {
        	return current != null;
        }

        public T next() {
        	if(!hasNext()){
        	    throw new NoSuchElementException();
            }
            T item = current.elem;
        	current = current.next;
        	return item;
        }
    }
        
    // This method should modify this set so that it contains the union of its 
    // elements plus those in the set parameter. Note that the parameter is an 
    // abstract set hence the only way to access its elements is by using an iterator.
    public void union(Set<T> set) {
        for (T itemsSet : set) {
            insert(itemsSet);
        }
    }
    
    // This method should modify this set so that it contains the intersection of its 
    // elements and those in the set parameter. Note that the parameter is an 
    // abstract set hence the only way to access its elements is by using an iterator.
    public void intersection(Set<T> set) {
        for (T itemSet: this){
            if(!set.isElem(itemSet)){
                this.delete(itemSet);
            }
        }
    }
    
    // This method should modify this set so that it contains the difference of its 
    // elements minus those in the set parameter. Note that the parameter is an 
    // abstract set hence the only way to access its elements is by using an iterator.
    public void difference(Set<T> set) {
    	// TODO complete implementation of this method
        for (T itemSet: set){
            if(isElem(itemSet)){
                delete(itemSet);
            }
        }
    }
    
    public String toString() {
        String className = getClass().getSimpleName();
        String text = className+"(";
        for (Node<T> p = first; p != null; p = p.next) {
            text +=  p.elem + (p.next != null ? "," : "");
        }
        return text + ")";
    }
}


