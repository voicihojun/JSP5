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
	
	a {
		text-decoration: none;
	}
	
	#button {
		text-align: right;
		padding-right: 10px;
	}
</style>
</head>
<body>


<%
	/* declare the variables for countering to view posts */
	// number of posts
	int pageSize = 10;
	// page number value that I am seeing
	String pageNum = request.getParameter("pageNum");
	// when we first move to BoardList.jsp, pageNum value is null. so we need to treat it. 
	if(pageNum == null) {
		pageNum = "1";
	}
	int count = 0; // value for the number of posts
	int number = 0;
	
	int currentPage = Integer.parseInt(pageNum);
	
	
	
	BoardDAO bdao = new BoardDAO();
	// method 'getAllCount()' for total number of posts
	count = bdao.getAllCount();
	
	int startRow = (currentPage - 1) * pageSize;
	int endRow = currentPage * pageSize;
			
	Vector <BoardBean> vec = bdao.getAllBoard(startRow, endRow);
	
	number = count - (currentPage - 1) * pageSize;
%>
	<h2>View all of the post</h2>
	<table>	
		<tr>
			<td id="button" colspan="5"><input type="button" value="post" onclick="location.href='BoardWriteForm.jsp'"/></td>		
		</tr>
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
			<td><%=number-- %></td>
			<td id="subject"><a href="BoardInfo.jsp?num=<%=bean.getNum() %>">
		<%
			if(bean.getRe_step() > 1) {
				for(int j=0; j < (bean.getRe_step() - 1)*3; j++) {
		%>
			&nbsp;
		
		<%					
				}
			}
		
		%>			
			<%=bean.getSubject() %></a></td>
			<td><%=bean.getWriter() %></td>
			<td><%=bean.getReg_date() %></td>
			<td><%=bean.getReadcount() %></td>
		</tr>
<%		
	}
%>
	</table>
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		int startPage = 1;
		
		if (currentPage % 10 != 0) {
			startPage = (int)(currentPage / 10) * 10 + 1;
		} else {
			startPage = ((int)(currentPage / 10) - 1) * 10 + 1;
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) endPage = pageCount;
		
		// we need to know whether 'prev' button is needed
		if(startPage > 10) {
%>
	<a href="BoardList.jsp?pageNum=<%=startPage - 10 %>"> [prev] </a>
<%
		}
		// treat paging
		for(int i = startPage; i <= endPage; i++) {
%>
	<a href="BoardList.jsp?pageNum=<%=i %>"> [<%=i %>]</a>
<%			
		}
		
		if(endPage < pageCount) {
%>		
			// we need to know whether 'next' button is needed
	<a href="BoardList.jsp?pageNum=<%=startPage - 10 %>"> [next] </a>
<% 
		}
		
	}
%>

</body>
</html>