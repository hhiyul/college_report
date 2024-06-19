<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>MySQL</title>
</head>
<body>
	<h1>MySQL</h1>
	<%
		String jdbcUrl = "jdbc:mysql://localhost:3306/gimal";
		String dbId = "root";
		String dbPwd = "123456";
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);
			out.println("MySQL 됨");
		}
		catch (Exception ex)
		{
			out.println("안됨 : " + ex.getMessage());
		}
	%>
</body>
</html>	
