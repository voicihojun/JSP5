<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardDAO, model.BoardBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Delete Form</title>
<style>
	table, td {
		border: 1px solid black;
		text-align: center;	
	}
</style>
</head>
<body>

<%
	int num = Integer.parseInt(request.getParameter("num").trim());
	BoardDAO bdao = new BoardDAO();
	BoardBean bean = bdao.getOneBoardUpdated(num);
	
%>

	<h2>Delete a post</h2>
	<form method="post" action="BoardDeleteProc.jsp">
		<table>
			<tr>
				<td>Writer</td>
				<td><%=bean.getWriter() %></td>
				<td>Reg_date</td>
				<td><%=bean.getReg_date() %></td>
			</tr>
			<tr>
				<td>Subject</td>
				<td colspan="3"><%=bean.getSubject() %></td>
				
			</tr>
			<tr>
				<td>Password</td>
				<td colspan="3"><input type="password" name="password"/></td>
			</tr>
			<tr>
				<td>Content</td>
				<td colspan="3"><%=bean.getContent() %></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="hidden" name="num" value="<%=bean.getNum() %>" />
					<input type="submit" name="submit" value="delete"/>
					<input type="button" onclick="location.href='BoardList.jsp'" value="view the full post"/>
				</td>
			</tr>
		</table>
	</form>


</body>
</html>