<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
try
{
    // JDBC 드라이버 연결
    Class.forName("com.mysql.jdbc.Driver");
    String db_address = "jdbc:mysql://localhost:3306/gimal";
    String db_username = "root";
    String db_pwd = "123456";
    Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
    
    // 문자열의 인코딩 방식 결정
    request.setCharacterEncoding("UTF-8");
    
    // 파라미터를 통해 전해진 작성자, 제목, 내용 정보를 받아와 각 문자열 변수에 저장
    String writer = request.getParameter("writer");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    
    // 파라미터를 통해 전해진 게시글 번호를 받아와, num 변수에 저장
    String num = request.getParameter("num");
    
    // MySQL로 전송하기 위한 쿼리문인 insertQuery 문자열 선언 (읽어온 게시글 번호를 통해, 수정할 게시글을 다시한번 결정(확인)함)
    String insertQuery = "SELECT * FROM gimal.post WHERE num=" + num;
    
    // SQL 쿼리문을 실행 (MySQL로 전송)하기 위한 객체 선언
    PreparedStatement psmt = connection.prepareStatement(insertQuery);
 	
    // 조회된 결과물들을 저장하기 위한 ResultSet 객체 선언
    ResultSet result = psmt.executeQuery();
 	
    // 받아온 정보가 있을때
    while(result.next())
    {
        // MySQL로 전송하기 위한 쿼리문인 insetQuery 문자열 선언 (사용자가 post_modify.jsp 폼에서 수정한 정보를 전송)
        insertQuery = "UPDATE gimal.post set title=?, writer=?, content=? WHERE num=" + num;
 	    
        // SQL 쿼리문을, 새로운 내용을 토대로 재실행
        psmt = connection.prepareStatement(insertQuery);
        
        // VALUES ? 값에 하나씩 삽입하여 전송
        psmt.setString(1, title);
        psmt.setString(2, writer);
        psmt.setString(3, content);
        
        // INSERT 하여 반영된 레코드의 건수결과를 반환
        psmt.executeUpdate();
        
        // 모두 완료되면, post_list.jsp(글 목록) 폼으로 되돌아 온다.
        response.sendRedirect("post_list.jsp");
 	}
}
catch (Exception ex)
{
    out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
}
%>