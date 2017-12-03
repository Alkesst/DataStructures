package dataStructures.Set;

public class MainArraySet {
    public static void main(String[] args) {
        Set<Integer> conj = new SortedArraySet<>();
        System.out.println(conj.isEmpty());
        insertAll(conj, 1, 2, 3, 4);
        System.out.println(conj);
        Set<Integer> c = new SortedArraySet<>();
        insertAll(c, 3, 4, 5, 6);
        System.out.println(c);
        c.union(conj);
        System.out.println(c);
        Set<Integer> ce = new SortedArraySet<>();
        insertAll(ce, 3, 4, 5, 6);
        ce.difference(conj);
        System.out.println(ce);
    }

    @SafeVarargs
    private static <T> void insertAll(Set<T> conj, T...items){
        for (T item: items) {
            conj.insert(item);
        }
    }
}
