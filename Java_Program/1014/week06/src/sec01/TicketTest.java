package sec01;

public class TicketTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		WalkupTicket ticket1 = new WalkupTicket(101, true);
		ticket1.setPrice(100000.0);
		System.out.println(ticket1.toString());

		AdvanceTicket ticket2 = new AdvanceTicket(201, 20);
		ticket2.setPrice(100000.0);
		System.out.println(ticket2.toString());

		AdvanceTicket ticket3 = new AdvanceTicket(201, 35);
		ticket3.setPrice(100000.0);
		System.out.println(ticket3.toString());

		AdvanceTicket ticket4 = new AdvanceTicket(203, 5);
		ticket4.setPrice(100000.0);
		System.out.println(ticket4.toString());
	}

}
