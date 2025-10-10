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
     ) {
 
         String[][] addrbook = {
             { "1", "이동희", "경기도 성남시", "010-0000-0000" }, 
             { "2", "손흥민", "강원도 춘천시", "010-1234-5678" }, 
             { "3", "구자철", "제주특별시", "010-9876-5432" }
         };
         
         for (int i = 0; i < addrbook.length; i++) {
             String sql = String.format(
                     "insert into addrbook values (%s, '%s','%s','%s')",
                     addrbook[i][0], addrbook[i][1], addrbook[i][2], 
                     addrbook[i][3]);
             
             stmt.executeUpdate(sql);
             
             
             //stmt.executeUpdate("insert into score values (1, '홍길동', 50, 60, 70)");
             //stmt.executeUpdate("insert into score values (2, '이순신', 65, 75, 85)");
             //stmt.executeUpdate("insert into score values (3, '강감찬', 60, 80, 70)");
             
             out.println("쿼리 실행 성공 : " + sql + "<br>");
         }
         
     } catch(Exception e) {
         e.printStackTrace();
     }
 %>
 </body>
 </html>