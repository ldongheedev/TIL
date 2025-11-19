<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%

	int num = Integer.parseInt(request.getParameter("num"));
	    
		Class.forName("org.mariadb.jdbc.Driver");
		try (
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
			Statement stmt = conn.createStatement();
		) {
			stmt.executeUpdate("delete from board where num=" + num);
		
		} catch(Exception e){
			out.println(e.getMessage());
		}
		
		response.sendRedirect("list.jsp");
	

%> 