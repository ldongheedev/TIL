package sec02;

public class InheritanceTest {

	public static void main(String[] args) {
		Employee emp = new Employee("강길동", 100000);
		Manager mng = new Manager("고길동", 200000, 50000);
		Executive exc = new Executive("홍길동", 400000, 100000, 10000);
		
		emp.raiseSalary();
		mng.raiseSalary();
		exc.raiseSalary();
		
		System.out.println("===Employee(직원)===");
		System.out.println(emp.showInfo());
		System.out.println();
		
		System.out.println("===Manager(직원)===");
		System.out.println(mng.showInfo());
		System.out.println();
		
		System.out.println("===Executive(직원)===");
		System.out.println(exc.showInfo());
		System.out.println();

	}

}
