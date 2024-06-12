<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    int postId = Integer.parseInt(request.getParameter("num"));

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String db_address = "jdbc:mysql://localhost:3306/gimal";
        String db_username = "root";
        String db_pwd = "123456";
        Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);

        // 조회수 증가
        String updateQuery = "UPDATE gimal.post SET view = view + 1 WHERE num = ?";
        PreparedStatement psmt = connection.prepareStatement(updateQuery);
        psmt.setInt(1, postId);
        psmt.executeUpdate();

        // post_read.jsp 페이지로 리디렉션
        response.sendRedirect("post_read.jsp?num=" + postId);

    } catch (Exception ex) {
        out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
    }
%>