import dataStructures.hashTable.HashTable;
import dataStructures.hashTable.LinearProbingHashTable;

public class mainPrueba {
    public static void main(String[] args) {
        HashTable<Integer, String> xD = new LinearProbingHashTable<>(97, 0.5);
        xD.insert(1, "a");
        xD.insert(7, "j");
        System.out.println(xD);
        xD.insert(7, "p");
        xD.insert(9, "j");
        System.out.println(xD);
        xD.insert(15, "p");
        xD.insert(2, "void");
        xD.insert(9, "p");
        System.out.println(xD.search(7));
        System.out.println(xD);
    }
}
