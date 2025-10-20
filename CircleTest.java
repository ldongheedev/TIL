package sec03;

public class CircleTest {

	public static void main(String[] args) {
		// 반지름이 10인 원 객체 생성
		Circle c1 = new Circle("자바", 10);
		Circle c2 = new Circle("도넛", 5);
		c1.getPrint();
		c2.getPrint();

	}

}
