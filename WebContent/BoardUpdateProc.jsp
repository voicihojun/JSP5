<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Update Procedure</title>
</head>
<body>
	<jsp:useBean id="boardbean" class="model.BoardBean">
		<jsp:setProperty name="boardbean" property="*"/>
	</jsp:useBean>
	
<%
	BoardDAO bdao = new BoardDAO();
	String pwd = bdao.getPass(boardbean.getNum());
	
	if(pwd.equals(boardbean.getPassword())) {
		bdao.updateBoard(boardbean);
		response.sendRedirect("BoardList.jsp");
	} else {
%>
	<script>
		alert("Invalid password");
		history.go(-1);
	</script>
<%
	}
%>

</body>
</html>