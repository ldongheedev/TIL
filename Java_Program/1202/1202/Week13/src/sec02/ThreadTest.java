package sec02;

// 스레드 클래스 정의

class MyThread1 extends Thread{
	
	public void run() {
		for(int i = 1; i <= 10; i++) {
			System.out.println(getName()+ " " +i);
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}

class MyThread2 implements Runnable{

	@Override
	public void run() {
		// A~Z 출력
		for (char i = 'A'; i <= 'Z'; i++) {
			System.out.println(i);
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
}

public class ThreadTest {

	public static void main(String[] args) {
		/*//스레드 객체 생성
		for(int i = 1; i <= 3; i++) {
		MyThread1 t = new MyThread1();
		//스레드 시작
		t.start();
		}*/
		
		//스레드 객체 생성
		//MyThread2 t = new MyThread2();
		Thread t = new Thread(new MyThread2());
		
		//스레드 시작
		t.start();
		
	}

}
