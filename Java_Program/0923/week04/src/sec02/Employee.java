package sec02;

public class Employee {
	protected String name;
	protected int salary;
	
	public Employee(String name, int salary) {
		this.name = name;
		this.salary = salary;
	}

	public String getName() {
		return name;
	}


	public int getSalary() {
		return salary;
	}
	
	public int raiseSalary() {
		int increased_salary;
		increased_salary = (int)(salary * 1.3);
		return increased_salary;
	}
	
	public String showInfo() {
		String result = "\n이름:"+name;
		result += "\n급여:" + salary;
		result += "\n인상된 급여:" + raiseSalary();
		return result;
	}

	
}
