package sec02;

public class Manager extends Employee {
	protected int bonus;
	
	public Manager (String name, int salary, int bonus) {
		super(name, salary);
		this.bonus = bonus;
	}
	
	public int getBonus() {
		return bonus;
	}
	
	public int raiseSalary() {
		int increased_salary;
		increased_salary = (int)(salary * 1.3);
		return increased_salary;
	}


	public String showInfo() {
		String result = super.showInfo();
		result += "\n보너스: "+ bonus;
		return result;
	}
}
