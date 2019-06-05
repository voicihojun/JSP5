<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="model.BoardDAO" %>
<%@ page import="model.BoardBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Info</title>
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
	BoardBean bean = bdao.getOneBoard(num);
%>
	<h2>View a post</h2>
		<table>
			<tr>
				<td>Num</td>
				<td><%=bean.getNum() %></td>
			</tr>
			<tr>
				<td>Writer</td>
				<td><%=bean.getWriter() %></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><%=bean.getEmail() %></td>
			</tr>
			<tr>
				<td>Subject</td>
				<td><%=bean.getSubject() %></td>
			</tr>
			<%-- <tr>
				<td>Password</td>
				<td><%=bean.getPassword() %></td>
			</tr> --%>
			<tr>
				<td>Reg_Date</td>
				<td><%=bean.getReg_date() %></td>
			</tr>
			<tr>
				<td>ref</td>
				<td><%=bean.getRef() %></td>
			</tr>
			<tr>
				<td>re_step</td>
				<td><%=bean.getRe_step() %></td>
			</tr>
			<tr>
				<td>re_level</td>
				<td><%=bean.getRe_level() %></td>
			</tr>
			<tr>
				<td>Readcount</td>
				<td><%=bean.getReadcount() %></td>
			</tr>
			<tr>
				<td>Content</td>
				<td><%=bean.getContent() %></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="reply" onclick="location.href='BoardRewriteForm.jsp?num=<%=bean.getNum()%>&ref=<%=bean.getRef()%>&re_step=<%=bean.getRe_step()%>&re_level=<%=bean.getRe_level()%>'"/>
					<input type="button" value="modify" onclick="location.href='BoardUpdateForm.jsp?num=<%=bean.getNum() %>'"/>
					<input type="button" value="delete" onclick="location.href='BoardDeleteForm.jsp?num=<%=bean.getNum() %>'"/>
					<input type="button" value="view full list" onclick="location.href='BoardList.jsp'"/>
				</td>
			</tr>
		</table>

</body>
</html>