package sec01_1;

public class WalkupTicket extends Ticket {
	private boolean payBYcredit;
	
	public WalkupTicket(int number, double price, boolean payBYcredit) {
		super(number, price);
		this.payBYcredit = payBYcredit;
	}
	
	public double getPrice() {
		if(payBYcredit) return price * 1.05;
		else return price;
	}
	
	public double getPrice2() {
		return price;
	}
	
	public boolean getPayByCredit() {
		return payBYcredit;
	}
	
	public String toString() {
		String tempStr = "";
		tempStr += super.toString();
		tempStr += ", 신용카드 결제: " + getPayByCredit();
		tempStr += ", 결제 가격: " + getPrice();
		return tempStr;
	}
}
