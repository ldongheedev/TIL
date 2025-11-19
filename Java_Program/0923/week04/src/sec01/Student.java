package sec01;

public class Student extends People {
	int stuNo;
	Student(String name, String ssn, int stuNo){
		super(name, ssn);
		this.stuNo=stuNo;
	}
	
	void showInfo() {
		super.showInfo();
		System.out.println("stuNo: " + stuNo);
	}

}
