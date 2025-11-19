<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.board.dao.*" %>

<%

	int num = Integer.parseInt(request.getParameter("num"));
	new BoardDao().deleteOne(num);
	response.sendRedirect("list.jsp");
	

%> 