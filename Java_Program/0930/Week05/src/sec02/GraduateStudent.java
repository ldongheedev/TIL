package sec02;

public class GraduateStudent extends Student {
	
	// 생성자
	public GraduateStudent(String name) {
		super(name);
	}
	
	//학점을 계산한다
	public void computeGrade() {
		if(score >= 80)
			grade = "통과";
		else
			grade = "과락";
	}
}
