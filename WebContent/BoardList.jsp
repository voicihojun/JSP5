<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardDAO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="model.BoardBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
<style>
	table, td {
		border: 1px solid black;
		text-align: center;
		
	}
	
	#subject {
		text-align: left;
	}
</style>
</head>
<body>


<%
	BoardDAO bdao = new BoardDAO();
	Vector <BoardBean> vec = bdao.getAllBoard();
%>
	<h2>View all of the post</h2>
	<table>	
		<tr>
			<td>num</td>
			<td>subject</td>
			<td>writer</td>
			<td>reg_date</td>
			<td>readCount</td>
		</tr>
<%
	for(int i=0; i < vec.size(); i++) {
		BoardBean bean = vec.get(i);
%>
		<tr>
			<td><%=i+1 %></td>
			<td id="subject"><a href="BoardInfo.jsp?num=<%=bean.getNum() %>"><%=bean.getSubject() %></a></td>
			<td><%=bean.getWriter() %></td>
			<td><%=bean.getReg_date() %></td>
			<td><%=bean.getReadcount() %></td>
		</tr>

<%		
	}
%>
		<tr>
			<td colspan="5"><input type="button" value="post" onclick="location.href='BoardWriteForm.jsp'"/></td>
			
		</tr>
			
	
	</table>

</body>
</html>