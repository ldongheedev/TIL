<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%
	String tmp = request.getParameter("num");
	int num = (tmp != null && tmp.length() > 0) ? Integer.parseInt(tmp) : 0;
	
	String writer = "";
	String title = "";
	String content = "";
	String action = "insert.jsp";
	
	if(num > 0) { // 글번호가 주어졌으면 DB에서 데이터를 읽어옴
		
		 Class.forName("org.mariadb.jdbc.Driver");
 		try (
 			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
 			Statement stmt = conn.createStatement();
 			ResultSet rs = stmt.executeQuery("select * from board where num=" + num);
 		) {
 			if (rs.next()) {
 				writer = rs.getString("writer");
 				title = rs.getString("title");
 				content = rs.getString("content");
 				
 				action = "update.jsp?num=" + num;
 			}
 			
 		} catch(Exception e){
 			out.println(e.getMessage());
 		}
		
	}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        table { width:680px; text-align:center; }
        th    { width:100px; background-color:cyan; }
        input[type=text], textarea { width:100%; }
    </style>
</head>
<body>

<form method="post" action="<%= action %>">
    <table>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title"  maxlength="80" value="<%= title %>"></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><input type="text" name="writer" maxlength="20" value="<%= writer %>"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td><textarea name="content" rows="10"><%= content %></textarea></td>
        </tr>
    </table>

    <br>
    <input type="submit" value="저장">
    <input type="button" value="취소" onclick="history.back()">
</form>

</body>
</html>
