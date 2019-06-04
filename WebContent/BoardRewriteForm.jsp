<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Rewrite Form</title>
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
</style>
</head>
<body>
	<h2>reply for a post</h2>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
%>

	<form method="post" action="BoardRewriteProc.jsp">
		<table>
			<table>
			<tr>
				<td>Writer</td>
				<td><input type="text" name="writer" /></td>
			</tr>
			<tr>
				<td>Subject</td>
				<td><input type="text" name="subject" value="[Re]"/></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="email" name="email" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password" /></td>
			<tr>
				<td>Content</td>
				<td><textarea rows="10" cols="30" name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="hidden" name="ref" value="<%=ref %>"/>
					<input type="hidden" name="re_step" value="<%=re_step %>"/>
					<input type="hidden" name="re_level" value="<%=re_level %>"/>
					<input type="submit" name="complete"/> &nbsp;&nbsp;
					<input type="reset" name="reset"/> &nbsp;&nbsp;
					<input type="button" onclick="location.href='BoardList.jsp'" value="view the full list"/> &nbsp;&nbsp;
				</td>
			</tr>
		
		</table>
	</form>

</body>
</html>