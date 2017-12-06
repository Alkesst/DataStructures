package dataStructures.MaxiphobicHeap;

public class EmptyHeapException extends RuntimeException {

	private static final long serialVersionUID = -1066706303071224353L;

	public EmptyHeapException() {
	   super();
	 }

	 public EmptyHeapException(String msg) {
	   super(msg);
	 }
	}
