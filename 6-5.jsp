 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>   
     
 <!DOCTYPE html>
 <html>
 <head>
     <meta charset="UTF-8">
     <style>
         table { width: 400px; text-align: center; }
         th    { background-color: cyan; }
     </style>    
 </head>
 <body>
 
 <table>
     <tr>
         <th>번호</th><th>이름</th><th>주소</th><th>전화번호</th>
     </tr>
<%
     Class.forName("org.mariadb.jdbc.Driver");
     try ( 
         Connection conn = DriverManager.getConnection(
                 "jdbc:mariadb://localhost:3308/jspdb", "jsp", "1234");
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery("select * from addrbook");
     ) {
         while (rs.next()) {
             
 %>          
             <tr>
                 <td><%=rs.getInt   ("num" )%></td>
                 <td><%=rs.getString("name")%></td>
                 <td><%=rs.getString("addr")%></td>
                 <td><%=rs.getString("tel")%></td>

             </tr>
 <%          
         }
         
     } catch(Exception e) {
         e.printStackTrace();
     }
 %>
 </table>
 
 </body>
 </html>
 