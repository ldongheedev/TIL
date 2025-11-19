package sec01;

public class StudentTest {

	public static void main(String[] args) {
		
		//객체 생성 후 출력
		Student s1 = new Student("나신구", "IT");
		Student2 s2 = new Student2("나신구", "IT", "110");
		/*
		s1.showInfo();
		s2.showInfo();
		//System.out.println (s1.toStr());
		System.out.println (s1.toString());
		*/
		s2.showInfo2(s2.credit);
	}

}
