<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardDAO, model.BoardBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Procedure</title>
</head>
<body>

<%
	String pwd = request.getParameter("password"); 
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDAO bdao = new BoardDAO();
	String password = bdao.getPass(num);
	
	if(pwd.equals(password)) {
		bdao.deleteBoard(num);
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