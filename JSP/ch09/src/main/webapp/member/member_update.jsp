 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>   
 
   <%
     Class.forName("org.mariadb.jdbc.Driver");
     try ( 
         Connection conn = DriverManager.getConnection(
                 "jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
         Statement stmt = conn.createStatement();
     ) {
    	 stmt.executeUpdate(String.format("update member set pw='%s', name='%s' where id='%s'",
	 				request.getParameter("pw"), request.getParameter("name"), request.getParameter("id")));
    	 
    	 session.setAttribute("userName", request.getParameter("name"));
      	} 
     catch(Exception e) {
         e.printStackTrace();
     }
 %>
 
 
 <!DOCTYPE html>
 <html>
 <head>
     <meta charset="UTF-8">
 </head>
 <body>
 
<script>
	alert('수정이 완료되었습니다.');
	opener.location.reload();
	window.close();
</script>

  
 </body>
 </html>
 