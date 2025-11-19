package sec01;

public class People {
	String name;
	String ssn;
	
	People(String name, String ssn){
		this.name = name;
		this.ssn = ssn;
	}
	
	void showInfo() {
		System.out.println("name: " + name);
		System.out.println("ssn: " + ssn);
	}

}
