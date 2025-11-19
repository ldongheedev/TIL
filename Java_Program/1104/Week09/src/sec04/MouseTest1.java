package sec04;

import javax.swing.*; //클래스, 인터페이스 포함, 하위 패키지는 포함하지 않음
import java.awt.*; //배치관리자 정의
import java.awt.event.*; // 리스너 인터페이스 정의


public class MouseTest1 extends JFrame {
	JLabel lbl;
	// 생성자
	MouseTest1(){
		setTitle("내부 클래스로 마우스 이벤트 리스너 만들기");
		setLayout(new FlowLayout());
		
		//컴포넌트 생성
		lbl = new JLabel("오늘 수업 끝");
		lbl.setForeground(Color.red); // 전경색 : 도형의 테두리색, 글자색
		//컴포넌트 생성
		add(lbl);
		
		//리스너 등록
		addMouseListener(new MyMouse());
		
		setSize(500,500);
		setVisible(true);
	}
	
	//내부 클래스로 마우스 리스너 구형
	class MyMouse implements MouseListener{

		@Override
		public void mouseClicked(MouseEvent e) {
		}

		@Override
		public void mousePressed(MouseEvent e) {
			
			int x = e.getX();
			int y = e.getY();
			lbl.setLocation(x, y);
			
		}

		@Override
		public void mouseReleased(MouseEvent e) {
		}

		@Override
		public void mouseEntered(MouseEvent e) {
		}

		@Override
		public void mouseExited(MouseEvent e) {
		}
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new MouseTest1();
	}

}
