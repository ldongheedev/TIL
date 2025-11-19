package sec02;

public class Calculator {
	int num1;
	int num2;
	String operator;
	double result;
	
	Calculator(String operator, int num1, int num2){
		this.operator = operator;
		this.num1 = num1;
		this.num2 = num2;
	}

	public int getNum1() {
		return num1;
	}

	public int getNum2() {
		return num2;
	}

	public void setNum1(int num1) {
		this.num1 = num1;
	}

	public void setNum2(int num2) {
		this.num2 = num2;
	}
	
	public String getOperator() {
		return operator;
	}

	public double getResult() {
		return result;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public void setResult(double result) {
		this.result = result;
	}
	
	void calculatorInfo(int num1, int num2, int s) {
		if(s == 1) {
			result = num1 + num2;
		}
		else if(s == 2) {
			result = num1 - num2;
		}
		else if(s == 3) {
			result = num1 * num2;
		}
		else if(s == 4) {
			if(result != 0) {
			result = num1 / num2;
			}else {
				System.out.println("Indivisible by zero");
			}
		}
		
	}
	void printResult() {
		System.out.println("result : " + result);
	}

}
