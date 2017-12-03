package dataStructures.set;

public class MainLinkedSet {
    public static void main(String[] args) {
        Set<Integer> conj = new SortedLinkedSet<>();
        insertAll(conj, 1,2,3,4);
        System.out.println(conj);
        Set<Integer> con = new SortedLinkedSet<>();
        insertAll(con, 1,2,3,4,5,6,7,8);
        con.delete(8);
        System.out.println(con);
        conj.union(con);
        System.out.println(conj);
        Set<Integer> c = new SortedLinkedSet<>();
        insertAll(c, 10,20,30,40,2,3,4);
        c.intersection(con);
        System.out.println(c);
        c.difference(conj);
        System.out.println(c);
        Set<Integer> a = new SortedLinkedSet<>();
        insertAll(a, 1, 2, 3, 4);
        Set<Integer> b = new SortedLinkedSet<>();
        insertAll(b, 3, 4, 5, 6);
        b.intersection(a);
        System.out.println(b);
    }

    private static <T> void insertAll(Set<T> set, T...items){
        for (T item: items) {
            set.insert(item);
        }
    }
}
