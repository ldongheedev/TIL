package sec02;

import java.util.*;

public class HashMapTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//해시맵 생성
		//편의점 물품 관리 : 상품명(key)과 가격(value)
		HashMap<String, Integer> item = new HashMap<>();
		
		//추가
		item.put("콜라", 1200);
		item.put("사이다", 1100);
		item.put("환타", 1500);
		item.put("포카리", 2000);
		
		//전체 조회
		System.out.print(item);
		System.out.println();
		System.out.print(item.keySet());
		System.out.println();
		for(String key : item.keySet()) {
			System.out.print(key + " ");
		}
		
		System.out.println();
		
		//조회 : 키 -> 값
		String name = "콜라";
		if(item.containsKey(name)) {
			System.out.println(name + " : " + item.get(name));
		}
		else {
			System.out.println("not Found");
		}
	}

}
