<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	Double r = Double.parseDouble(request.getParameter("r"));
	
%>

원의 반지름: <%= r %><br>
원의 둘레: <%= 2 * Math.PI * r  %><br>
원의 넓이: <%= r * Math.PI * r  %><br>


</body>
</html>