package com.board.service;

import java.util.*;

import com.board.dao.*;
import com.board.dto.*;

public class BoardService {
	
	private BoardDao dao = new BoardDao();
	private static final int listSize = 4;
	private static final int paginationSize = 3;
	
	public ArrayList<Pagination> getPagination(int pageNo) {
		ArrayList<Pagination> pgnList = new ArrayList<Pagination>();
		int numRecords = dao.getNumRecords();
		int numPages = (int)Math.ceil((double)numRecords / listSize);
		
		int firstLink = ((pageNo - 1) / paginationSize) * paginationSize + 1;
		int lastLink = firstLink + paginationSize - 1;
		if(lastLink > numPages) {
			lastLink = numPages;
		}
		
		if(firstLink > 1) {
			pgnList.add(new Pagination("<", firstLink - 1, false));
		}
		
		for(int i = firstLink; i <= lastLink; i++) {
			pgnList.add(new Pagination("" + i, i, i == pageNo));
		}
		
		if(lastLink < numPages) {
			pgnList.add(new Pagination(">", lastLink + 1, false));
		}
		
		return pgnList;
	}
	
	public ArrayList<BoardDto> getMsgList(int pageNo) {
		return dao.selectList((pageNo - 1) * listSize, listSize);
	}

	public BoardDto getMsg(int num) {
    	BoardDto dto = dao.selectOne(num, true);
    	
    	dto.setTitle(dto.getTitle().replace (" ", "&nbsp;"));
		dto.setContent(dto.getContent().replace (" ", "&nbsp;").replace("\n", "<br>"));
		
		return dto;
	}
	public BoardDto getMsgWrite(int num) {
		 return dao.selectOne(num, false);
		 
	}
	public void writeMsg(String writer, String title, String content) throws Exception {
		if(writer != null && writer.length() > 0 &&
				title != null && title.length() > 0 &&
				content != null && content.length() > 0) { //교재와 반대 조건 : 만약 빈칸이 하나도 없으면 

			BoardDto dto = new BoardDto();
			
			dto.setWriter(writer);
			dto.setTitle(title);
			dto.setContent(content);
		    
			dao.insertOne(dto);
			
		}else {
			throw new Exception("모든 항목이 빈칸없이 입력되어야 합니다.");
		}
		
	}
	
	public void updateMsg(String writer, String title, String content, int num ) throws Exception {
		if(writer != null && writer.length() > 0 &&
				title != null && title.length() > 0 &&
				content != null && content.length() > 0) { //교재와 반대 조건 : 만약 빈칸이 하나도 없으면 
		    

			BoardDto dto = new BoardDto();
			
			dto.setWriter(writer);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setNum(num);
		    
			dao.updateOne(dto);

		}else {
			throw new Exception("모든 항목이 빈칸없이 입력되어야 합니다.");
		}
		
	}
	
	public void deleteMsg(int num) {
		dao.deleteOne(num);
	}

}
