package sec01;

public interface RemoteControl {
	//상수와 추상메소드 정의가능
	//final static double PI = 3.14;
	int Max = 10;
	int Min = 0;
	
	void turnOn();
	void turnOff();
	void setVolume(int volume);
}

//자식 클래스 정의
class TV implements RemoteControl {
	private int volume;

	@Override
	public void turnOn() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void turnOff() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setVolume(int volume) {
		// TODO Auto-generated method stub
		
	}
	
}