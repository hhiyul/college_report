<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제</title>
</head>
<body>
<%
try {
    // JDBC 드라이버 연결
    Class.forName("com.mysql.jdbc.Driver");
    String db_address = "jdbc:mysql://localhost:3306/gimal";
    String db_username = "root";
    String db_pwd = "123456";
    Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
    
    // 문자열의 인코딩 방식 결정
    request.setCharacterEncoding("UTF-8");
    
    // 게시글 번호를 파라미터값을 통해 받아와 정수형 변수에 저장
    String num = request.getParameter("num");
    
    // MySQL로 전송하기 위한 쿼리문 선언 (해당 게시글 삭제)
    String deleteQuery = "DELETE FROM gimal.post WHERE num=?";
    
    // SQL 쿼리문을 실행 (MySQL로 전송)하기 위한 객체 선언
    PreparedStatement psmt = connection.prepareStatement(deleteQuery);
    psmt.setInt(1, Integer.parseInt(num));
    
    // 삭제 쿼리 실행
    int result = psmt.executeUpdate();
    
    if (result > 0) {
        out.println("<script>alert('글이 삭제되었습니다.'); location.href='post_list.jsp';</script>");
    } else {
        out.println("<script>alert('글 삭제에 실패했습니다.'); history.back();</script>");
    }
} catch (Exception ex) {
    out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
}
%>
</body>
</html>
