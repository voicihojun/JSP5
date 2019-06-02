<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Write Form</title>

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
	<h2>Writing a post</h2>
	<form action="BoardWriteProc.jsp" method="post">
		<table>
			<tr>
				<td>Writer</td>
				<td><input type="text" name="writer" /></td>
			</tr>
			<tr>
				<td>Subject</td>
				<td><input type="text" name="subject" /></td>
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
					<input type="submit" name="submit" value="post"/> &nbsp;
					<input type="reset" name="reset" value="reset"/> &nbsp;
					<button onclick="location.href='BoardList.jsp'">View full post</button>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>