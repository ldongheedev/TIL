package sec04;

import java.util.Arrays;

public class StringTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String pw = "abcd";
		//String upw = "abcd";
		char[]  upw = {'a', 'b', 'c', 'd'};
		if(pw.equals(upw))
			System.out.println("pass");
		else
			System.out.println("fail");
		
		//문자배열을 문자열 객체로 변환
		if(pw.equals(new String(upw))) 
			System.out.println("pass");
		else
			System.out.println("fail");
		
		//문자열 객체를 문자배열로 변환
		if(Arrays.equals(upw, pw.toCharArray()))
			System.out.println("pass");
		else
			System.out.println("fail");
	}

}
