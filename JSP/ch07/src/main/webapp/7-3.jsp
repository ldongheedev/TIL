 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
 <%@ page import="java.io.*"%>
   
 <!DOCTYPE html>
 <html>
 <head>
 <meta charset="UTF-8">
 </head>
 <body>
 <%!
     // 이미 같은 이름을 가진 파일이 있으면, 변경된 파일명을 반환하는 메서드
     String getFileNameToSave(String path, String fileName) {
         // 확장자 부분 찾기
         int extIndex = fileName.lastIndexOf(".");
         
         // 파일 base name과 확장자를 분리하여 base, ext에 담음
         String base, ext;
         if (extIndex > 0) {
             base = fileName.substring(0, extIndex);
             ext = fileName.substring(extIndex);
         } else {
             base = fileName;
             ext = "";
         }
         
         // fileName인 파일이 존재하는 동안 반복하면서 
         // (1), (2)...를 붙인 새로운 fileName을 만들어 봄 
         for (int i = 1; new File(path + fileName).exists(); i++) {
             fileName = base + " (" + i + ")" + ext;
         }
         
         return fileName;    
     }
 %>
 <%
     // "upload"라는 이름의 업로드 태그로부터 전달된 데이터를 담고있는 파트 객체 얻기     
     Part part = request.getPart("upload");
 
     if (part.getSize() > 0) {
         // 파일을 저장할 시스템 경로 얻기
         String path = application.getRealPath("/files/");
         
         // 업로드된 파일명 얻기
         String fileName = part.getSubmittedFileName();
         
         // 저장할 파일명 얻기
         String fileNameToSave = getFileNameToSave(path, fileName);
 
         // 파트 객체의 데이터를 파일로 쓰기
         part.write(path + fileNameToSave);
         
         out.print("업로드된 파일명 : " + fileName + "<br>");
         out.print("저장된 파일명 : " + fileNameToSave + "<br>");
         out.print("저장된 경로 : " + path + "<br>");
         out.print("파일 크기 : " + part.getSize() + "<br>");
         
     } else {
         out.print("업로드할 파일이 지정되지 않았습니다.");
     }
 %>
 </body>
 </html>
 