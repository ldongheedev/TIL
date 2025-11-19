package sec02;

public abstract class Student {
	//멤버 변수 정의
	protected int type;
	protected String name;
	protected int score;
	protected String grade;
	
	//생성자 정의
	Student(String name){
		this.name=name;
	}

	
	// getter setter 메소드 정의
	public int getType() {
		return type;
	}

	public String getName() {
		return name;
	}

	public int getScore() {
		return score;
	}

	public String getGrade() {
		return grade;
	}

	public void setType(int type) {
		this.type = type;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	// 추상 메소드: 학점을 계산한다
	abstract public void computeGrade();
	
	//객체 현 상태 반환
	public String showInfo() {
		String result = "소속\t이름\t점수\t학점\n";
		if(type == 1)
			result += "학부생";
		else
			result += "대학원생";
		result += "\t"+getName();
		result += "\t"+getScore();
		result += "\t"+getGrade();
		return result;
	}
}
