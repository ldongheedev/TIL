package sec01_1;

public class TicketTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		WalkupTicket ticket1 = new WalkupTicket(101, 100000, true);
		System.out.println(ticket1.toString());

		AdvanceTicket ticket2 = new AdvanceTicket(201, 100000, 20);
		System.out.println(ticket2.toString());

		AdvanceTicket ticket3 = new AdvanceTicket(201, 100000, 35);
		System.out.println(ticket3.toString());

		AdvanceTicket ticket4 = new AdvanceTicket(203, 100000, 5);
		System.out.println(ticket4.toString());
	}

}
