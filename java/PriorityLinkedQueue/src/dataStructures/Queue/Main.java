package dataStructures.Queue;

public class Main {
    public static void main(String[] args) {
        Queue<xDlol> q = new PriorityLinkedQueue<xDlol>();
        enqueueAll(q, new xDlol(0, 1),new xDlol(1, 1), new xDlol(2, 1), new xDlol(3, 1), new xDlol(0, 0), new xDlol(1, 0), new xDlol(0, 2), new xDlol(1, 2));
        System.out.println(q);

    }
    static class xDlol implements Comparable<xDlol> {
        int posicion;
        int elemento;

        public xDlol(int posicion, int elemento) {
            this.posicion = posicion;
            this.elemento = elemento;
        }

        @Override
        public int hashCode() {
            return elemento;
        }

        @Override
        public boolean equals(Object obj) {
            if(obj instanceof xDlol){
                xDlol lol = (xDlol) obj;
                return this.elemento == lol.elemento;
            } else{
                return false;
            }
        }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append("xDlol(");
            sb.append(posicion);
            sb.append(", ");
            sb.append(elemento);
            sb.append(")");
            return sb.toString();
        }

        @Override
        public int compareTo(xDlol o) {
            return this.elemento - o.elemento;
        }
    }

    private static <T> void enqueueAll(Queue<T> q, T...items){
        for (T item : items){
            q.enqueue(item);
        }
    }
}
