package sec03;

public class Circle {
	String name;
	int radius;
	
	Circle(String name, int radius){
		this.name=name;
		this.radius=radius;
	}

	String getName() {
		return name;
	}
	
	int gerRadius() {
		return radius;
	}
	
	double getArea() {
		return Math.PI*radius*radius;
	}
	
	double getPerimeter() {
		return Math.PI*2*radius;
	}
	
	void getPrint() {
		System.out.printf(name + "피자의 반지름"+radius+"->면적은 %.1f, 둘레길이는 %.1f\n", getArea(), getPerimeter());
	}

}
