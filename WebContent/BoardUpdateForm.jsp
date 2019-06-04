<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardDAO, model.BoardBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Update Form</title>
<style>
	h2 {
		text-align: center;
	}
	table,td {
		border: 1px solid black;
		text-align: center;
		margin: 0 auto;
	}
	table {
		background-color: coral;
	}
	textarea {
		text-align: left;
	}
</style>
</head>
<body>
	<h2>Update a post</h2>
<%
	int num = Integer.parseInt(request.getParameter("num").trim());

	BoardDAO bdao = new BoardDAO();
	BoardBean bean = bdao.getOneBoardUpdated(num);
%>
	<form method="post" action="BoardUpdateProc.jsp">
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
				<td colspan="3"><textarea rows="10" cols="30" name="content"><%=bean.getContent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="hidden" name="num" value="<%=bean.getNum() %>"/>
					<input type="hidden" name="subject" value="<%=bean.getSubject() %>"/>
					<input type="submit" name="submit" value="update"/>
					<input type="button" onclick="location.href='BoardList.jsp'" value="view the full post"/>
				</td>
			</tr>
			
		</table>
	</form>
	
</body>
</html>