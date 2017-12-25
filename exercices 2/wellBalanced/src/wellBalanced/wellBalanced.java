package wellBalanced;
import dataStructures.stack.*;

public class wellBalanced {
    private final static String OPEN_PARENTHESES = "{[(";
    private final static String CLOSE_PARENTHESES = "}])";

    public static void main(String[] args) {
        Stack<Character> stack = new ArrayStack<>();
        if (wellBalanced("por la gracia de dios JESUCRISTO [ESPAÑOL] OLE ARRIBA ESPIÑA", stack)){
            System.out.println("It is balanced");
        } else{
            System.out.println("It is not balanced");
        }
    }

    public static boolean wellBalanced(String exp, Stack<Character> stack){
        boolean isBalanced = true;
        int i = 0;
        while (i < exp.length() && isBalanced) {
            char c = exp.charAt(i);
            if (isOpenParentheses(c)) {
                stack.push(c);
            } else if (isCloseParentheses(c)) {
                if (stack.isEmpty()) {
                    isBalanced = false;
                } else {
                    isBalanced = match(c, stack.top());
                    stack.pop();
                }
            }
            i++;
        }
        return stack.isEmpty() && isBalanced;
    }

    public static boolean isOpenParentheses(char c){
        return OPEN_PARENTHESES.contains(Character.toString(c));
    }

    public static boolean isCloseParentheses(char c){
        return CLOSE_PARENTHESES.contains(Character.toString(c));
    }

    public static boolean match(char x, char y){
        return OPEN_PARENTHESES.indexOf(y) ==
                CLOSE_PARENTHESES.indexOf(x);
    }
}