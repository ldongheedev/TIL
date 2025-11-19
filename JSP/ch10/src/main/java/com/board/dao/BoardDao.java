package com.board.dao;

import java.sql.*;
import java.time.*;
import java.util.*;

import com.board.dto.*;

public class BoardDao {
	
	private Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
	}
	
	public ArrayList<BoardDto> selectList() {
		
		ArrayList<BoardDto> dtoList = new ArrayList<BoardDto>();
		
 		try (
 			Connection conn = getConnection();
 			Statement stmt = conn.createStatement();
 			ResultSet rs = stmt.executeQuery("select * from board order by num desc");
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
 			Connection conn = getConnection();
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
			Connection conn = getConnection();
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
			Connection conn = getConnection();
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
			Connection conn = getConnection();
			Statement stmt = conn.createStatement();
		) {
			stmt.executeUpdate("delete from board where num=" + num);
		
		} catch(Exception e){
			e.printStackTrace();
		}
	
		
	}


}
