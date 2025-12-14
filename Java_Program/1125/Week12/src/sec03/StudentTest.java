package sec03;


import java.io.*;
import java.util.*;

public class StudentTest {
	public static void main(String[] args) throws IOException {
		FileReader fin = new FileReader("student.csv");
		BufferedReader br = new BufferedReader(fin);

		String str, name, dept;
		String key, value;

		// 키(이름) 값(학과)
		HashMap<String, String> dic = new HashMap<>();

		Scanner s = new Scanner(System.in);
		System.out.println(br.readLine()); // 제목컬럼 읽기
		
		// ** 코드 작성
		
		
		
		
		System.out.println("=======================");
		
		// 전체조회 : 
		for (String k : dic.keySet())
			System.out.println(k + " : " + dic.get(k));
		
		// 검색기능 :
		while (true) {
			System.out.print("찾고 싶은 학생 이름은? ");
			key = s.next();
			if (key.equals("q"))break;

			// ** 코드 작성
			
			
			
		}

	}

}
