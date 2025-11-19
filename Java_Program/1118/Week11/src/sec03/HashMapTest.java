package sec03;
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
        System.out.println("=== 전체 단어 목록 ===");
        for (String key : dic.keySet()) {
            System.out.println(key + " : " + dic.get(key));
        }
    }

    public String search(String word) {
        return dic.get(word);
    }

    public void addWord(String eng, String kor) {
        dic.put(eng, kor);
        System.out.println("추가 완료: " + eng + " -> " + kor);
    }

    public void removeWord(String eng) {
        if(dic.remove(eng) != null) {
            System.out.println("삭제 완료: " + eng);
        } else {
            System.out.println("삭제 실패: 없는 단어입니다.");
        }
    }

    public void updateWord(String eng, String newKor) {
        if(dic.containsKey(eng)) {
            dic.put(eng, newKor);
            System.out.println("수정 완료: " + eng + " -> " + newKor);
        } else {
            System.out.println("수정 실패: 없는 단어입니다.");
        }
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
            System.out.println("\n=== 메뉴 ===");
            System.out.println("1. 단어 검색");
            System.out.println("2. 단어 추가");
            System.out.println("3. 단어 삭제");
            System.out.println("4. 단어 수정");
            System.out.println("5. 전체 출력");
            System.out.println("0. 종료");
            System.out.print("선택: ");

            int choice = scanner.nextInt();
            if (choice == 0) break;

            switch (choice) {
                case 1:
                    System.out.print("검색할 단어 입력: ");
                    String word = scanner.next();
                    String meaning = dictionary.search(word);
                    if (meaning == null) {
                        System.out.println("없는 단어입니다.");
                    } else {
                        System.out.println("뜻: " + meaning);
                    }
                    break;
                case 2:
                    System.out.print("추가할 영어 단어: ");
                    String eng = scanner.next();
                    System.out.print("뜻(한국어): ");
                    String kor = scanner.next();
                    dictionary.addWord(eng, kor);
                    break;
                case 3:
                    System.out.print("삭제할 영어 단어: ");
                    String del = scanner.next();
                    dictionary.removeWord(del);
                    break;
                case 4:
                    System.out.print("수정할 영어 단어: ");
                    String updateEng = scanner.next();
                    System.out.print("새 뜻(한국어): ");
                    String newKor = scanner.next();
                    dictionary.updateWord(updateEng, newKor);
                    break;
                case 5:
                    dictionary.printAll();
                    break;
                default:
                    System.out.println("잘못된 선택입니다.");
            }
        }
        scanner.close();
    }

    public static void main(String[] args) {
        HashMapTest app = new HashMapTest();
        app.run();
    }
}
