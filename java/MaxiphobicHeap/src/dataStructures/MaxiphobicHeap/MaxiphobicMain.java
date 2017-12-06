package dataStructures.MaxiphobicHeap;

public class MaxiphobicMain {
    public static void main(String[] args) {
        MaxiphobicHeap<Integer> t = new MaxiphobicHeap<Integer>();
        insertAll(t, 5,7,3,7,8,10,15,2,11,1);
        System.out.println(t.toString());
    }

    private static <T extends Comparable<? super T>> void insertAll(MaxiphobicHeap<T> q, T...items){
        for (T item : items){
            q.insert(item);
        }
    }
}
