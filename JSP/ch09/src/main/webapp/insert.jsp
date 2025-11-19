<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.*" %>

<%
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	if(writer != null && writer.length() > 0 &&
			title != null && title.length() > 0 &&
			content != null && content.length() > 0) { //교재와 반대 조건 : 만약 빈칸이 하나도 없으면 
	    
		Class.forName("org.mariadb.jdbc.Driver");
		try (
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
			Statement stmt = conn.createStatement();
		) {
			String curTime = LocalDate.now() + " " + LocalTime.now().toString().substring(0, 8);  //2025-10-15 12:11:08
			
			stmt.executeUpdate(String.format("insert into board (writer, title, content, regtime, hits) values ('%s', '%s', '%s', '%s', 0)",
					writer, title, content, curTime));
		
		} catch(Exception e){
			out.println(e.getMessage());
		}
		
		response.sendRedirect("list.jsp");
		return;
	}
	

%> 
  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<script>
		alert('모든 항목이 빈칸없이 입력되어야 합니다.')
		history.back();
	</script>
</body>
</html>