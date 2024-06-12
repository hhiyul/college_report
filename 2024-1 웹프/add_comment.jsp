<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 추가</title>
</head>
<body>
    <%
    try
    {
        // JDBC 드라이버 연결
        Class.forName("com.mysql.jdbc.Driver");
        String db_address = "jdbc:mysql://localhost:3306/gimal";
        String db_username = "root";
        String db_pwd = "123456";
        Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
        
        // 받아오는 문자열의 인코딩 방식 결정
        request.setCharacterEncoding("UTF-8");
        
        // 파라미터를 통해 전해진 게시글 번호를 받아와, 변수에 저장
        String num = request.getParameter("num");
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");
        String comment_pass = request.getParameter("comment_pass");
        
        // 댓글 삽입 쿼리
        String insertCommentQuery = "INSERT INTO comments (post_num, writer, content, comment_pass) VALUES (?, ?, ?, ?)";
        PreparedStatement psmt = connection.prepareStatement(insertCommentQuery);
        psmt.setInt(1, Integer.parseInt(num));
        psmt.setString(2, writer);
        psmt.setString(3, content);
        psmt.setString(4, comment_pass);
        psmt.executeUpdate();
        
        // 게시글 상세보기 페이지로 리다이렉트
        response.sendRedirect("post_read.jsp?num=" + num);
    }
    catch (Exception ex)
    {
        out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
    }%>
</body>
</html>