package sec01;

public class CoffeeTest {
	
	public static void main(String[] args) {
		Coffee c1= new Coffee("아아", 3000);
		Coffee c2 = new Coffee("라떼",4000);
		Coffee c3 = new Coffee("모카",4500);
		
		Coffee [] list = {c1,c2,c3};
		
		for(Coffee item:list)
			System.out.println(item.toString());
	}

}
