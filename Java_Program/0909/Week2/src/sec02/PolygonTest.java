package sec02;

// import java.util.Scanner;

public class PolygonTest {
	public static void main(String[] args) {
	/*	Scanner s = new Scanner(System.in);
		Polygon p = null;
		
		System.out.print("menu select 1)삼각형 2)직사각형 3)정사각형: ");
		int select = s.nextInt();
		switch(select) {
		case 1:
			p=new Polygon("Triangle",10,20);
			p.calArea(p.width, p.height, select);
		case 2:
			p=new Polygon("Rectangle",10,20);
			p.calArea(p.width, p.height, select);
		case 3:
			p= new Polygon("square", 10);
			p.calArea(p.width);
			break;
			default:break;
		}
		p.printArea();*/
		
		Polygon s = new Polygon("square", 10);
		s.calArea(s.width);
		s.printArea();
		
		Polygon t = new Polygon("Triangle", 10, 20);
		t.calArea(t.width, t.height, 1);
		t.printArea();
		
		Polygon r = new Polygon("Rectangular", 10, 20);
		r.calArea(r.width, r.height, 2);
		r.printArea();
		
		
	}
	
}
