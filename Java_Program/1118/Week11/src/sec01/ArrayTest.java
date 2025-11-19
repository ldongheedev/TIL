package sec01;

import java.util.*;

public class ArrayTest {

	public static void main(String[] args) {
		// 문자열만 삽입가능한 ArrayList 컬렉션 생성
		ArrayList<String> list = new ArrayList<String>();
		String str;
		
		//키보드로부터 4개의 문자열을 입력받아 ArrayList에 저장
		Scanner scan = new Scanner(System.in);
		for(int i= 0; i < 4; i++) {
			System.out.print("과일이름 >> ");
			String s = scan.next(); // 키보드로부터 이름 입력
			list.add(s);
		}
		
		//ArrayList에 들어 있는 모든 이름 출력
		for(int i=0; i < list.size(); i++) {
			//ArrayList의 i 번째 문자열 얻어오기
			String name = list.get(i);
			System.out.print(name + " ");
		}
		System.out.println();
		System.out.print("찾는 이름 >> ");
		str = scan.next();
		int index = list.indexOf(str);
		if(index == -1)
			System.out.println("검색실패");
		else
			System.out.println(index + "에 위치함");
	}

}
