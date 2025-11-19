 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
     
<%@ page import="java.sql.*" %>   
 
     
 <!DOCTYPE html>
 <html>
 <head>
     <meta charset="UTF-8">
     <title>회원 정보 수정</title>
 </head>
 <body>
 
  <%
     Class.forName("org.mariadb.jdbc.Driver");
     try ( 
         Connection conn = DriverManager.getConnection(
                 "jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(String.format("select * from member where id='%s'", 
        		 	session.getAttribute("userId")));
     ) {
         rs.next();
    %> 
   
  
 
 <form action="member_update.jsp" method="post">
     <table>
         <tr>
             <td>아이디</td>
             <td><input type="text" name="id" value="<%= rs.getString("id")%>"readonly></td>
         </tr>
         <tr>
             <td>비밀번호</td>
             <td><input type="password" name="pw" value="<%= rs.getString("pw")%>"></td>
         </tr>
         <tr>
             <td>이름</td>
             <td><input type="text" name="name" value="<%= rs.getString("name")%>"></td>
         </tr>
     </table>    
     <input type="submit" value="등록"> 
 </form>
 
 <%    
 
   	} catch(Exception e) {
      e.printStackTrace();
  }
%>
 
 </body>
 </html>
 