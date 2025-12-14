package com.board.dao;

import java.sql.*;
import java.time.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

import com.board.dto.*;

public class BoardDao {
	
	private DataSource dataSource;
	
	public BoardDao() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/mariadb");
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<BoardDto> selectList(int start, int listSize) {
		
		ArrayList<BoardDto> dtoList = new ArrayList<BoardDto>();
		
 		try (
 			Connection conn = dataSource.getConnection();
 			Statement stmt = conn.createStatement();
 			ResultSet rs = stmt.executeQuery(String.format("select * from board order by num desc limit %d, %d", start, listSize));
 		) {
 			while (rs.next()) {
 				BoardDto dto = new BoardDto();
 				
 				dto.setNum(rs.getInt("num"));
 				dto.setWriter(rs.getString("writer"));  
 				dto.setTitle(rs.getString("title"));
 				dto.setContent(rs.getString("content"));
 				dto.setRegtime(rs.getString("regtime"));
 				dto.setHits(rs.getInt("hits"));
 				
 				dtoList.add(dto);
 				
 			}
 			
 		} catch(Exception e){
 			e.printStackTrace();
 		}
 		return dtoList;
	}
	
	public BoardDto selectOne(int num, boolean incHits) {
		
		BoardDto dto = new BoardDto();
		
 		try (
 			Connection conn = dataSource.getConnection();
 			Statement stmt = conn.createStatement();
 			ResultSet rs = stmt.executeQuery("select * from board where num=" + num);
 		) {
 			if (rs.next()) {
 				dto.setNum(rs.getInt("num"));
 				dto.setWriter(rs.getString("writer"));  
 				dto.setTitle(rs.getString("title"));
 				dto.setContent(rs.getString("content"));
 				dto.setRegtime(rs.getString("regtime"));
 				dto.setHits(rs.getInt("hits")); 				
 				
 				if(incHits) {
 				stmt.executeUpdate("update board set hits=hits+1 where num=" + num);
 				}
 			}
 			
 		} catch(Exception e){
 			e.printStackTrace();
 		}
 		return dto;
	}
	
	private String getCurrentTime() {
		return LocalDate.now() + " " + LocalTime.now().toString().substring(0, 8);  //2025-10-15 12:11:08
	}
	
	public void insertOne(BoardDto dto) {
		
		try (
			Connection conn = dataSource.getConnection();
			Statement stmt = conn.createStatement();
		) {
			
			stmt.executeUpdate(String.format("insert into board (writer, title, content, regtime, hits) values ('%s', '%s', '%s', '%s', 0)",
					dto.getWriter(), dto.getTitle(), dto.getContent(), getCurrentTime()));
		
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void updateOne(BoardDto dto) {
		try (
			Connection conn = dataSource.getConnection();
			Statement stmt = conn.createStatement();
		) {
			
			stmt.executeUpdate(String.format("update board set writer='%s', title='%s', content='%s', regtime='%s' where num=%d",
					dto.getWriter(), dto.getTitle(), dto.getContent(), getCurrentTime(), dto.getNum()));
		
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public void deleteOne(int num) {

		try (
			Connection conn = dataSource.getConnection();
			Statement stmt = conn.createStatement();
		) {
			stmt.executeUpdate("delete from board where num=" + num);
		
		} catch(Exception e){
			e.printStackTrace();
		}
	
		
	}
	
	public int getNumRecords() {
		int numRecords = 0;
		try (
	 			Connection conn = dataSource.getConnection();
	 			Statement stmt = conn.createStatement();
	 			ResultSet rs = stmt.executeQuery(String.format("select count(*) from board"));
	 		) {
	 			while (rs.next()) {
	 				numRecords = rs.getInt(1);
	 			}
	 			
	 		} catch(Exception e){
	 			e.printStackTrace();
	 		}
	 		return numRecords;
	 		}


}
