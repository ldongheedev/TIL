package sec01;

import javax.swing.*;

public class HelloFrame extends JFrame {

	//생성자
	HelloFrame(){
		setTitle("엑스포에 오신 것을 환영합니다.");
		
		//버튼 컴포넌트 추가 및 배치
		JButton b1=new JButton("경품추천");
		add(b1);
		
		setSize(300, 300);
		setVisible(true);
	}
	
	public static void main(String[] args) {
		
		HelloFrame h=new HelloFrame();
	}

}
