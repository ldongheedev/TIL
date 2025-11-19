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
	int kor = Integer.parseInt(request.getParameter("kor"));
	int eng = Integer.parseInt(request.getParameter("eng"));
	int math = Integer.parseInt(request.getParameter("math"));
	int sum = kor + eng + math;
	Double avg = sum / 3.0;
%>

국어: <%= kor %><br>
영어: <%= eng %><br>
수학: <%= math %><br>
총점: <%= sum %><br>
평균: <%= String.format("%.2f", avg) %><br>


</body>
</html>