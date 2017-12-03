package dataStructures.Queue;

public class PriorityLinkedQueue<T extends Comparable<? super T>> implements Queue<T>{
    static private class Node<E> {
        E elem;
        Node<E> next;

        Node(E x, Node<E> node) {
            elem = x;
            next = node;
        }
    }
    private Node<T> first, last;

    public PriorityLinkedQueue(){
        first = null;
        last = null;
    }

    @Override
    public boolean isEmpty() {
        return first == null;
    }

    @Override
    public void enqueue(T item) {
        Node<T> current = first;
        Node<T> prev = null;
        while(current != null && current.elem.compareTo(item) <= 0){
            prev = current;
            current = current.next;
        }
        boolean found = (current != null && current.elem.equals(item));
        if(!found){
            if(prev == null){
                first = new Node<>(item, first);
            } else{
                prev.next = new Node<>(item, current);
            }
        } else{
            Node<T> aux = current.next;
            current.next = new Node<>(item, aux);
        }
    }

    @Override
    public T first() {
        return this.first.elem;
    }

    @Override
    public void dequeue() {
        first = first.next;
    }

    public String toString(){
        StringBuilder sb = new StringBuilder();
        Node<T> current = first;
        sb.append("PriorityLinkedQueue(");
        while(current != null){
            sb.append(current.elem);
            sb.append(", ");
            current = current.next;
        }
        sb.delete(sb.length()-2, sb.length());
        sb.append(")");
        return sb.toString();
    }
}
