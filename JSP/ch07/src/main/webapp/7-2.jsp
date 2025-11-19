 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 <%@ page import="java.io.*"%>
   
 <!DOCTYPE html>
 <html>
 <head>
 <meta charset="UTF-8">
 </head>
 <body>
 <%
     // "upload"라는 이름의 업로드 태그로부터 전달된 데이터를 담고 있는 파트 객체 얻기     
     Part part = request.getPart("upload");
 
     if (part.getSize() > 0) {
         // 파일을 저장할 시스템 경로 얻기
         String path = application.getRealPath("/files/");
         
         // 업로드된 파일명 얻기
         String fileName = part.getSubmittedFileName();
 
         // 파트 객체의 데이터를 파일로 쓰기
         part.write(path + fileName);
         
         out.print("업로드된 파일명 : " + fileName + "<br>");
         out.print("저장된 경로 : " + path + "<br>");
         out.print("파일 크기 : " + part.getSize() + "<br>");
         
     } else {
         out.print("업로드할 파일이 지정되지 않았습니다.");
     }
 %>
 </body>
 </html>

 