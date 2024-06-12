<%@page import="java.sql.*" %>
<%@page import="java.text.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 5px;
            text-align: left;
        }
    </style>
<title>게시글 목록</title>
</head>
<body>
	<h1>글 목록</h1>
	  <%
      try
      {
        Class.forName("com.mysql.jdbc.Driver");
        String db_address = "jdbc:mysql://localhost:3306/gimal";
        String db_username = "root";
        String db_pwd = "123456";
        Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
        
        // MySQL로 전송하기 위한 쿼리문인 insertQuery 문자열 선언
        String insertQuery = "SELECT * FROM gimal.post order by num desc";
        
        // MySQL 쿼리문 실행
        PreparedStatement psmt = connection.prepareStatement(insertQuery);
        
        // 쿼리문을 전송해 받아온 정보를 result 객체에 저장
        ResultSet result = psmt.executeQuery();%>
	<hr>
	<table>
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성시간</td>
			<td>조회수</td>
		</tr>
		<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MM.dd");
%>
        <%
        while (result.next())
          {%>
            <tr>
              <td><%=result.getInt("num") %></td>
              <td><a href="view_count.jsp?num=<%=result.getInt("num") %>"><%=result.getString("title") %></a></td>
              <td><%=result.getString("writer") %></td>
              <td><%=dateFormat.format(result.getTimestamp("reg_date")) %></td>
              <td><%=result.getInt("view") %></td>
            </tr>
            <%
            }%>
          </table>
        <%
        }
      catch (Exception ex)
      {
        out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
      }%>
      <tr>
		<td colspan="4" style="text-align: right;">
			<button type="button" value="신규 글 작성" onClick="location.href='new_post.jsp'"> 새 글 작성 </button>
			</td>
		</tr>
</body>
</html>