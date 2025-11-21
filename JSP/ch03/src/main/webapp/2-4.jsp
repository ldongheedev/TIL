<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문제 4번 JSP</title>
</head>
<body>
<%
    // 변수 선언 및 계산 (스크립트릿)
    int a = 25;
    int b = 10;
    int sum = a + b;
    int product = a * b;
%>

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공백을 5개 찍고 이 문장이 시작됩니다.<br>
    
    이 문장은 중간에 공백이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5개 있습니다.<br><br>
    
    25 + 10 = <%= sum %><br>

    25 * 10 = <%= product %> 
    
</body>
</html>