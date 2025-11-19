package sec01;
import java.util.*;


class Circle{
	static double PI=3.14;
	static double area(double r) {
		double area=PI*r*r;
		return area;
	}
}

public class StaticMemTest {
	
	
	public static void main(String[] args) {
		System.out.print("반지름 입력: ");
		Scanner sc = new Scanner(System.in);
		
		double r=sc.nextDouble();
		System.out.println(Circle.area(r));
		sc.close();
	}

}
