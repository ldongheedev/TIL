package sec02;

import java.util.*;

// 1. 데이터 클래스: 과일 자체를 객체로 표현
class Fruit {
    private String name;

    public Fruit(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

// 2. 비즈니스 로직: Fruit 리스트 관리 (추가, 삭제, 수정, 검색)
class FruitManager {
    private ArrayList<Fruit> fruits = new ArrayList<>();

    public void addFruit(Fruit fruit) {
        fruits.add(fruit);
    }

    public boolean removeFruit(String name) {
        Fruit f = findFruit(name);
        if (f == null) return false;
        fruits.remove(f);
        return true;
    }

    public boolean updateFruit(String oldName, String newName) {
        Fruit f = findFruit(oldName);
        if (f == null) return false;
        f.setName(newName);
        return true;
    }

    public Fruit findFruit(String name) {
        for (Fruit f : fruits) {
            if (f.getName().equals(name))
                return f;
        }
        return null;
    }

    public ArrayList<Fruit> getAllFruits() {
        return fruits;
    }
}

// 3. 입력/출력을 담당하는 서비스 계층
class FruitService {
    private Scanner scan = new Scanner(System.in);
    private FruitManager manager;

    public FruitService(FruitManager manager) {
        this.manager = manager;
    }

    // 과일 입력
    public void inputFruits() {
        for (int i = 0; i < 4; i++) {
            System.out.print("과일이름 >> ");
            String name = scan.next();
            manager.addFruit(new Fruit(name));
        }
    }

    // 전체 출력
    public void printAll() {
        for (Fruit f : manager.getAllFruits()) {
            System.out.print(f.getName() + " ");
        }
        System.out.println();
    }

    // 검색
    public void searchFruit() {
        System.out.print("찾는 이름 >> ");
        String name = scan.next();

        Fruit f = manager.findFruit(name);
        if (f == null)
            System.out.println("검색 실패");
        else
            System.out.println(f.getName() + " 존재함");
    }

    // 수정
    public void updateFruit() {
        System.out.print("수정할 과일 이름 >> ");
        String oldName = scan.next();
        System.out.print("새 이름 >> ");
        String newName = scan.next();

        if (manager.updateFruit(oldName, newName))
            System.out.println("수정 완료");
        else
            System.out.println("수정 실패 (이름 없음)");
    }

    // 삭제
    public void deleteFruit() {
        System.out.print("삭제할 과일 이름 >> ");
        String name = scan.next();

        if (manager.removeFruit(name))
            System.out.println("삭제 완료");
        else
            System.out.println("삭제 실패 (이름 없음)");
    }
}

// 4. 실행부
public class ArrayTest {

    public static void main(String[] args) {
        FruitManager manager = new FruitManager();
        FruitService service = new FruitService(manager);

        service.inputFruits();
        service.printAll();
        service.searchFruit();
        service.updateFruit();
        service.printAll();
        service.deleteFruit();
        service.printAll();
    }
}
