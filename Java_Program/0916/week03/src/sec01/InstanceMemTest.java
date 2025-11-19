package sec01;

class Student{
	String name;
	
	void setName(String name) {
		this.name=name;
	}
}


public class InstanceMemTest {

	public static void main(String[] args) {
		Student s1 = new Student();
		s1.setName("구글신");
		System.out.println(s1.name);

	}

}
