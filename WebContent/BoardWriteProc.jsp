<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Write Procedure</title>
</head>
<body>
	
	<jsp:useBean id="boardbean" class="model.BoardBean">
		<jsp:setProperty name="boardbean" property="*"/>
	</jsp:useBean>
	
<%
	BoardDAO bdao = new BoardDAO();
	
	bdao.insertBoard(boardbean);
	
	response.sendRedirect("BoardList.jsp");

	

%>





</body>
</html>