 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 <!DOCTYPE html>
 <html>
 <head>
     <meta charset="UTF-8">
 </head>
 <body>
 
 <%
     request.setCharacterEncoding("utf-8");
 
     String[] lang  = request.getParameterValues("lang" );
     String[] hobby = request.getParameterValues("hobby");
 %>
 
     관심언어 :
     <%
         for (String s : lang) {
             out.println(s + " ");
         }
     %> 
     <br>
 
     취미 :
     <%
         for (int i = 0; i < hobby.length; i++) {
             out.println(hobby[i] + " ");
         }
     %> 
     <br>
 </body>
 </html>
