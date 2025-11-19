package sec02;


public class InheritanceTest2 {

	public static void main(String[] args) {


		Employee em=new Employee("이동희", 50000);
		Manager ma=new Manager("호날두",50000,100000);
		Executive ex=new Executive("메시",50000,100000,1000000);

		Employee[] employees = {em,ma,ex};

		String[] titles = {"Employee(직원)", "Manager(매니저)", "Executive(임원)"};


		for(int i=0; i<employees.length;i++) {
			employees[i].raiseSalary();
			System.out.println("==="+titles[i]+"===");
			System.out.println(employees[i].showInfo());
			System.out.println();
		}
	}
}