package sec01_1;

public class AdvanceTicket extends Ticket{
	private int advancedays;
	
	public AdvanceTicket (int number, double price, int advancedays) {
		super(number, price);  //중요
		this.advancedays = advancedays;
	}

	
	public double getPrice() {
		double rate = 0.0;
		if(advancedays >= 30) rate= 0.5;
		else if (advancedays >= 10) rate = 0.8;
		else if (advancedays >= 5) rate = 0.9;
		price=price*rate;
		return price;
	}
	
	public int getAdvancedays() {
		return advancedays;
	}
	
	public String toString() {
		String tempStr = "";
		tempStr += super.toString(); //중요
		tempStr += ", 사전 예약일수: " + getAdvancedays();
		tempStr += ", 결제가격: " + getPrice();
		return tempStr;
	}
}
