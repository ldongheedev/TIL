package sec02;

import java.util.*;

public class CalendarTest {
	public static void main(String[] args) {
		int year, month, date;
		Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
		month = c.get(Calendar.MONTH)+1;
		date = c.get(Calendar.DATE);
		System.out.println(year + "년");
		System.out.println(month + "월");
		System.out.println(date + "일");
	}
}
