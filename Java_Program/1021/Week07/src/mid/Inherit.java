package mid;
class Person{
	String name; //이름 
	String tel;  //전화번호

	Person(String name, String tel){
		this.name=name;
		this.tel=tel;
		}
 public void show(){
	 System.out.println("name:" + name);
	 System.out.println("tel:" + tel);
 	}
 }
 class Student extends Person {
	 String dept;   //학과
	 Student(String name, String tel, String dept){  
	 	super(name, tel);
	 	this.dept=dept;
	 }
 
	 public void show(){
		  super.show();
	  System.out.println("dept"+dept);
	 }
 }
 public class Inherit {
	 public static void main(String[] args) {
		 //Student s1=new Student("나신구","010-","컴공과");
		 //s1.show();
		 //객체 배열 생성 후 테스트
		 Student [] stu = {new Student("나신구", "010-", "컴공과"),
		 new Student("너신구", "010-", "보안과"),
		 new Student("박신구", "010-", "미디과")
		 };
		 
		 for(int i=0; i<stu.length; i++)
			 stu[i].show();
		 
		 //for~each문
		 for(Student s:stu)
			 s.show();
		 
	 }
 }