package sec01;

import java.util.*;

//VectorT 클래스 정의
class VectorT{
	//멤버변수
	Vector<String> item = new Vector<>();
	
	
	//생성자
	VectorT(){
		item = new Vector<>();
	}
	
	//추가
	void addItem(String name) {
		item.add(name);
	}
	
	//전체 조회
	void show() {
		System.out.println(item);
	}
}

public class GenericTest {

	public static void main(String[] args) {
		VectorT v = new VectorT();
		v.addItem("콜라");
		v.show();
		v.addItem("사이다");
		v.show();
		
		/*
		 //Vector 생성 
		Vector<Integer> v= new Vector<>();
		v.add(100); v.add(80); v.add(90);
		
		for(int i = 0; i < v.size(); i++)
			System.out.print(v.get(i)+" ");
		*/
		
		/*
		//Vector 생성
		Vector<Integer> v= new Vector<>();
		//Vector<Integer> v= new Vector<Integer>(); ---> 이렇게도 가능
		 //추가
		v.add(100);
		v.add(80);
		// 전체 조회
		System.out.println(v);
		v.add(1, 90);
		System.out.println(v);
		
		//조회
		System.out.println(v.get(1));
		
		//검색
		*/
	}

}
