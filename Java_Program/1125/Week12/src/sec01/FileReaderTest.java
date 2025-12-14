package sec01;

import java.io.*;

public class FileReaderTest {

	public static void main(String[] args) throws IOException {
		
		// 파일 객체 생성
		FileReader in = new FileReader("song.txt");
		int ch;
		
		//파일 내용 읽기
		//	System.out.print((char)in.read());
		
		while((ch = in.read()) != -1) {
			System.out.print((char)ch);
		}
		
		/*
		 while(true) {
			ch = in.read();
			if(ch == -1) {
				break;
			}
			System.out.print((char)ch);
		}*/
	}

}
