 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>   
 
 <!DOCTYPE html>
 <html>
 <head>
     <meta charset="UTF-8">
 </head>
 <body>
 
  <%
     Class.forName("org.mariadb.jdbc.Driver");
     try ( 
         Connection conn = DriverManager.getConnection(
                 "jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(String.format("select * from member where id='%s'", 
        		 	request.getParameter("id")));
     ) {
         if (rs.next()) {
%>

	 <script>
    	 alert('이미 등록된 아이디입니다.');
     	history.back();
 	</script>

<%        	
     	   } else {
       	 		stmt.executeUpdate(String.format("insert into member values('%s', '%s', '%s')",
       	 				request.getParameter("id"), request.getParameter("pw"), request.getParameter("name")));
       	 
%>

	 <script>
    	 alert('가입이 완료되었습니다.');
     	window.close();
 	</script>

<% 
       		}
      	} catch(Exception e) {
         e.printStackTrace();
     }
 %>

  
 </body>
 </html>
 