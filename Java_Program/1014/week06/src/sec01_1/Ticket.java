package sec01_1;

public class Ticket {
	protected int number;
	protected double price;
	
	public Ticket (int number, double price) {
		this.number = number;
		this.price = price;
	}

	public int getNumber() {
		return number;
	}

	public double getPrice() {
		return price;
	}

	public String toString() {
		return "번호: " + number + ", 정상 가격: " + (int)price;
	}
	
	public void setPrice(double price) {
		this.price = price;
	}
}
