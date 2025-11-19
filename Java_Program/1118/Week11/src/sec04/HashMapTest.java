package sec04;
import java.util.*;

class Dictionary {
    private HashMap<String, String> dic;

    public Dictionary() {
        dic = new HashMap<>();
        init();
    }

    private void init() {
        dic.put("apple", "사과");
        dic.put("grape", "포도");
        dic.put("orange", "오렌지");
        dic.put("mango", "망고");
    }

    public void printAll() {
        for (String key : dic.keySet()) {
            System.out.println(key + " : " + dic.get(key));
        }
    }

    public String search(String word) {
        return dic.get(word);
    }
}

public class HashMapTest {
    private Dictionary dictionary;
    private Scanner scanner;

    public HashMapTest() {
        dictionary = new Dictionary();
        scanner = new Scanner(System.in);
    }

    public void run() {
        dictionary.printAll();
        while (true) {
            System.out.print("단어입력: ");
            String input = scanner.next();
            if (input.equals("quit")) break;

            String meaning = dictionary.search(input);
            if (meaning == null) {
                System.out.println("없는 단어입니다.");
            } else {
                System.out.println("뜻: " + meaning);
            }
        }
        scanner.close();
    }

    public static void main(String[] args) {
    	HashMapTest app = new HashMapTest();
        app.run();
    }
}
