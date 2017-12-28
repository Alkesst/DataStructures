import java.util.Random;

import dataStructures.hashTable.HashTable;
import dataStructures.hashTable.LinearProbingHashTable;
import dataStructures.hashTable.SeparateChainingHashTable;
import dataStructures.tuple.Tuple2;

public class HashTableTest {
	
	final static int maxValue = 10000;
	final static int numElems = 1000;
	
	static void initTables(Random rnd, HashTable<Integer, String> t1, HashTable<Integer, String> t2) {
		
		for(int i=0; i<numElems; i++) {
			Integer n = rnd.nextInt(maxValue);
			t1.insert(n, n.toString());
			t2.insert(n, n.toString());			
		}			
	}
	
	
	static void remove(Random rnd, HashTable<Integer, String> t1, HashTable<Integer, String> t2) {
		for(int i=0; i<numElems/2; i++) {
			Integer n = rnd.nextInt(maxValue);
			t1.delete(n);
			t2.delete(n);			
		}			
	}
	
	
	static void testEq(HashTable<Integer, String> t1, HashTable<Integer, String> t2) {
		for(int k=0; k<maxValue; k++) {
			String s1 = t1.search(k);
			String s2 = t2.search(k);
			if(s1==null) {
				if(s2!=null) {
					System.out.printf("\nERROR on search for %d",k);
					System.exit(1);
				}
				
			} else if(!s1.equals(s2)) {
				System.out.printf("\nERROR on search for %d: %s %s",k,s1,s2);
				System.exit(1);
			}			
		}
		System.out.println("OK");
	}
	
	static void oneTest(int seed) {
		Random rnd = new Random(seed);

		HashTable<Integer,String> scHashTable = new SeparateChainingHashTable<Integer,String>(97,0.5);
		HashTable<Integer,String> lpHashTable = new LinearProbingHashTable<Integer,String>(97,0.5);

		initTables(rnd,scHashTable,lpHashTable);
		System.out.println("TEST for insert and search");
		testEq(scHashTable,lpHashTable);
		
		remove(rnd,scHashTable,lpHashTable);
		System.out.println("TEST for delete and search");
		testEq(scHashTable,lpHashTable);

		System.out.println("Associations traversal:");
		for(Tuple2<Integer, String> t : lpHashTable.keysValues())
			System.out.print(t+" ");		
		System.out.println();
		
	}
	
	public static void main(String[] args) {		
		for(int seed=0; seed<10; seed++)
			oneTest(seed);
	}	
}
