<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제</title>
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
        
        // 파라미터를 통해 전해진 댓글 번호와 비밀번호를 받아와 변수에 저장
        String comment_id = request.getParameter("comment_id");
        String post_num = request.getParameter("post_num");
        String comment_pass = request.getParameter("comment_pass");
        
        // 댓글 비밀번호 확인 쿼리
        String checkPassQuery = "SELECT comment_pass FROM comments WHERE comment_id=?";
        PreparedStatement checkPassStmt = connection.prepareStatement(checkPassQuery);
        checkPassStmt.setInt(1, Integer.parseInt(comment_id));
        ResultSet rs = checkPassStmt.executeQuery();
        
        if (rs.next()) {
            String dbPass = rs.getString("comment_pass");
            if (dbPass.equals(comment_pass)) {
                // 비밀번호가 일치하면 댓글 삭제
                String deleteCommentQuery = "DELETE FROM comments WHERE comment_id=?";
                PreparedStatement psmt = connection.prepareStatement(deleteCommentQuery);
                psmt.setInt(1, Integer.parseInt(comment_id));
                psmt.executeUpdate();
                out.println("<script>alert('댓글이 삭제되었습니다.'); location.href='post_read.jsp?num=" + post_num + "';</script>");
            }else {
                // 비밀번호가 일치하지 않으면 에러 메시지 표시
                out.println("<script>alert('비밀번호가 일치하지 않습니다.'); location.href='post_read.jsp?num=" + post_num + "';</script>");
            }
        } else {
            out.println("<script>alert('댓글을 찾을 수 없습니다.'); location.href='post_read.jsp?num=" + post_num + "';</script>");
        }
    } 
    catch (Exception ex)
    {
        out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
    }%>
</body>
</html>
