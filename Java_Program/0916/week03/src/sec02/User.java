package sec02;

class User {
	String id, pw;
	static int cnt;
	
	User(String id, String pw){
		this.id=id;
		this.pw=pw;
		cnt++;
	}
	
	static void show() {
		System.out.println("=========================");
		System.out.println("1. 회원가입");
		System.out.println("2. 회원조회");
		System.out.println("3. 종료");
		System.out.println("=========================");
		System.out.println("번호를 입력하시오: ");
	}

}
