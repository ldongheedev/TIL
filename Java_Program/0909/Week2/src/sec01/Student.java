//2022136022 이동희
package sec01;

public class Student {

		//멤버변수 : 이름(name), 전공(major), 학점(credit)..
		String name;
		String major;
		int credit;
		
		//생성자
		Student(String name, String major)
		{
			this.name=name;
			this.major=major;
		}
		
		Student(String name, String major, int credit)
		{
			this(name, major);
			this.credit=credit;
		}
		
		// 접근자(getter)/변경자(setter) 메소드
		
		public String getName() {
			return name;
		}

		public String getMajor() {
			return major;
		}

		public int getCredit() {
			return credit;
		}

		public void setName(String name) {
			this.name = name;
		}

		public void setMajor(String major) {
			this.major = major;
		}

		public void setCredit(int credit) {
			this.credit = credit;
		}
		
		//멤버메소드 정의 : 이수학점은 120학점이항이면 "졸업가능" 그렇지 않으면 "졸업불가능"
		
		
		/*void showInfo2()
		{
			if(credit >= 120) {
			System.out.println("졸업가능");
			}else {
				System.out.println("졸업불가능");
			}
		}
		*/



		public static void main(String[] args) {
			
		}


}
