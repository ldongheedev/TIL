package app;

import lib.Calculator;

class GoodCalc extends Calculator{

	@Override
	public int add(int a, int b) {
		// TODO Auto-generated method stub
		return a+b;
	}

	@Override
	public int sub(int a, int b) {
		// TODO Auto-generated method stub
		return a-b;
	}

	@Override
	public double avg(int[] arr) {
		// TODO Auto-generated method stub
		int sum = 0;
		double average;
		// 빈 곳 채우기
		for(int i = 0; i < arr.length; i++)
			sum += arr[i];
		average = sum/arr.length;
		return average;
	}

	@Override
	public double nanu(int a, int b) {
		return (double)a/b;
	}
	
}
public class GoodCalcTest {

	public static void main(String[] args) {
		//GoodCalc 객체 생성 후 테스트해보세요.
		
		GoodCalc calc = new GoodCalc();
		int[] arr = {10, 20, 30, 40, 50};
		System.out.println(calc.add(10, 20));
		System.out.println(calc.sub(10, 20));
		System.out.println(calc.nanu(40, 20));
		System.out.println(calc.avg(arr));

	}

}
