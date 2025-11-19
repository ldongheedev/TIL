package sec02;

import java.awt.*;
import javax.swing.*;


public class Frame4 extends JFrame {


	Frame4() {
		setTitle("GridLayout 설정하기");		
		setSize(300, 300);
		//배치관리자 변경하기 시험문제는 피아노 건반
		setLayout(new GridLayout(1,8));
		//문자열 배열 선언
		//첫번째 방식
		
		String [] text = {"도", "레", "미", "파","솔","라","시","도"};
		
		//두번째 방식 for each
		for(String s:text) {
			add(new JButton(s));
		}
		setVisible(true);
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new Frame4();

	}

}
