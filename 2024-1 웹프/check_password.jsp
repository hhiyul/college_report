<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
try {
    // JDBC 드라이버 연결
    Class.forName("com.mysql.jdbc.Driver");
    String db_address = "jdbc:mysql://localhost:3306/gimal";
    String db_username = "root";
    String db_pwd = "123456";
    Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);

    // 파라미터로부터 게시글 번호와 입력된 비밀번호를 가져옴
    String num = request.getParameter("num");
    String inputPassword = request.getParameter("pass");

    // 해당 게시글 번호의 비밀번호를 조회하는 쿼리
    String query = "SELECT pass FROM gimal.post WHERE num=?";
    PreparedStatement psmt = connection.prepareStatement(query);
    psmt.setInt(1, Integer.parseInt(num));

    ResultSet result = psmt.executeQuery();

    if (result.next()) {
        String dbPassword = result.getString("pass");
        if (dbPassword.equals(inputPassword)) {
            // 비밀번호가 일치하면 수정 페이지로 리다이렉트
            response.sendRedirect("edit_post.jsp?num=" + num);
        } else {
            out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('게시글을 찾을 수 없습니다.'); history.back();</script>");
    }

    result.close();
    psmt.close();
    connection.close();
} catch (Exception ex) {
    out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
}
%>