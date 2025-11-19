<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.board.dao.*" %>
<%@ page import="com.board.dto.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	
	if(writer != null && writer.length() > 0 &&
			title != null && title.length() > 0 &&
			content != null && content.length() > 0) { //교재와 반대 조건 : 만약 빈칸이 하나도 없으면 

		BoardDto dto = new BoardDto();
		
		dto.setWriter(writer);
		dto.setTitle(title);
		dto.setContent(content);
	    
		new BoardDao().insertOne(dto);
		
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