package dataStructures.MaxiphobicHeap;

public class MaxiphobicMain {
    public static void main(String[] args) {
        MaxiphobicHeap<Integer> t = new MaxiphobicHeap<Integer>();
        insertAll(t, 4, 3, 5, 8);
        System.out.println(t.toString());
    }

    private static <T extends Comparable<? super T>> void insertAll(MaxiphobicHeap<T> q, T...items){
        for (T item : items){
            q.insert(item);
        }
    }
}
