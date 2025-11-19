package sec01;

import java.util.*;

public class VectorTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// 정수 값만 다루는 제네릭 백터 생성
		Vector<Integer> v = new Vector<Integer>();
		
		//요소 삽입
		v.add(100);
		v.add(90);
		System.out.println(v);
		
		//요소 중간 삽입
		v.add(1, 70);
		System.out.println(v);
		Collections.sort(v);
		System.out.println(v);
		
		//모든 요소의 합계 출력하기
		int sum = 0;
		for(int i = 0; i < v.size(); i++) {
			int n = v.get(i); // 자동 언박싱
			sum += n;
		}
		System.out.println("백터에 있는 모든 요소의 합:" + sum);;
	}

}
