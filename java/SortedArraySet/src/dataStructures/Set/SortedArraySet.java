package dataStructures.Set;

import java.util.Arrays;
import java.util.Iterator;
import java.util.NoSuchElementException;

public class SortedArraySet <T extends Comparable<? super T>> implements Set<T> {
    private T[] items;
    private int size;

    @SuppressWarnings("unchecked")
    public SortedArraySet(){
        items = (T[]) new Comparable[0x0A];
        size = 0;
    }

    public SortedArraySet(Set<T> set){
        for(T setItem : set) insert(setItem);
    }

    @Override
    public boolean isEmpty() {
        return size() == 0;
    }

    @Override
    public int size() {
        return size;
    }

    @Override
    public void insert(T item) {
        int i = whereIsMyItem(item);
        if(i < size && !items[i].equals(item) || i == size()) {
            if (size() == items.length) {
                items = Arrays.copyOf(items, items.length * 2);
            }
            System.arraycopy(items, i, items, i + 1, size() - i);
            items[i] = item;
            size++;
        }
    }

    private int whereIsMyItem(T item){
        int i = 0;
        while(i < size() && items[i].compareTo(item) < 0){
            i++;
        }
        return i;
    }

    @Override
    public boolean isElem(T item) {
        int i = whereIsMyItem(item);
        return i < size() && items[i].equals(item);
    }

    @Override
    public void delete(T item) {
        int i = whereIsMyItem(item);
        if(i < size && items[i].equals(item)){
            System.arraycopy(items, i + 1, items, i, size() - 1 - i);
            size--;
        }
    }

    @Override
    public void union(Set<T> set) {
        for(T itemSet: set){
            this.insert(itemSet);
        }
    }

    @Override
    public void intersection(Set<T> set) {
        int i = 0;
        while(i < size()) {
            if (!set.isElem(items[i])) {
                this.delete(items[i]);
            } else{
                i++;
            }
        }
    }

    @Override
    public void difference(Set<T> set) {
        for(T itemSet: set){
            if(isElem(itemSet)) {
                this.delete(itemSet);
            }
        }
    }

    @Override
    public Iterator<T> iterator() {
        return new ArraySetIterator();
    }

    private class ArraySetIterator implements Iterator<T>{
        private int current;

        private ArraySetIterator(){
            current = 0;
        }

        @Override
        public boolean hasNext() {
            return current != size;
        }

        @Override
        public T next() {
            if(!hasNext()){
                throw new NoSuchElementException();
            }
            T item = items[current];
            current++;
            return item;
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(getClass().getSimpleName());
        sb.append("(");
        for(T item: this){
            sb.append(item);
            sb.append(", ");
        }
        sb.delete(sb.length()-2,sb.length());
        sb.append(")");
        return sb.toString();
    }
}
