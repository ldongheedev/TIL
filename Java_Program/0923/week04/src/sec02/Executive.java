package sec02;

public class Executive extends Manager {
	protected int stockOption;
	
	public Executive (String name, int salary, int bonus, int stockOption) {
		super(name, salary, bonus);
		this.stockOption=stockOption;
	}
	
	public int getStockOption() {
		return stockOption;
	}
	
	public int raiseSalary() {
		int increased_salary;
		increased_salary = (int)(salary * 1.1);
		return increased_salary;
	}


	public String showInfo() {
		String result = super.showInfo();
		result += "\n스톡옵션: "+ stockOption;
		return result;
	}
}
