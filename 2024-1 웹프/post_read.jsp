<%@page import="java.sql.*" %>
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
       textarea{resize: none;
        overflow: auto;} /* 잡고 늘리기 방지*/  
          </style>
<meta charset="UTF-8">
<title>게시글 열람</title>
<script>
function confirmDelete(commentId, postNum) {
    var pass = prompt("비밀번호를 입력하세요:");
    if (pass != null && pass != "") {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "delete_comment.jsp");

        var hiddenField1 = document.createElement("input");
        hiddenField1.setAttribute("type", "hidden");
        hiddenField1.setAttribute("name", "comment_id");
        hiddenField1.setAttribute("value", commentId);
        form.appendChild(hiddenField1);

        var hiddenField2 = document.createElement("input");
        hiddenField2.setAttribute("type", "hidden");
        hiddenField2.setAttribute("name", "post_num");
        hiddenField2.setAttribute("value", postNum);
        form.appendChild(hiddenField2);

        var hiddenField3 = document.createElement("input");
        hiddenField3.setAttribute("type", "hidden");
        hiddenField3.setAttribute("name", "comment_pass");
        hiddenField3.setAttribute("value", pass);
        form.appendChild(hiddenField3);

        document.body.appendChild(form);
        form.submit();
    }
}
function checkFun() {
    var pass = document.getElementsByName("comment_pass")[0].value;
    var pattern = /^[A-Za-z0-9!@#$%^&*]+$/;
    if (!pattern.test(pass)) {
        alert("비밀번호는 영어, 숫자, 특수문자만 가능합니다.");
        return false;
    }
    return true;
}
</script>
</head>
<body>
    <h1>게시글 열람</h1>
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
        
        // 파라미터를 통해 전해진 게시글 번호를 받아와, num 변수에 저장
        String num = request.getParameter("num");
        
        // MySQL로 전송하기 위한 쿼리문인 insertQuery 문자열 선언 (읽어온 게시글 번호를 통해, 불러올 게시글을 결정함)
        String insertQuery = "SELECT * FROM gimal.post WHERE num=" + num;
        
        // SQL 쿼리문을 실행 (MySQL로 전송)하기 위한 객체 선언
        PreparedStatement psmt = connection.prepareStatement(insertQuery);
        
        // 조회된 결과물들을 저장하기 위한 ResultSet 객체 선언
        ResultSet result = psmt.executeQuery(); %>
        <hr>
        <table>
            <%
            // 받아온 정보가 있을때
            while(result.next()){
            %>
            	<tr>
            	    <!-- 번호 <td> 옆에 DB에서 받아온 num 칼럼값 삽입 -->
            	    <td>번호</td>
            	    <td><%=result.getInt("num") %></td>
            	    <td>작성일</td>
            	    <td><%=result.getTimestamp("reg_date") %></td>
            	</tr>
            	<tr>
            	    <!-- 작성자 <td> 옆에 DB에서 받아온 writer 칼럼값 삽입 -->
            	    <td>작성자</td>
            	    <td><%=result.getString("writer") %></td>
            	    <td>제목</td>
            	    <td><%=result.getString("title") %></td>
            	</tr>
            	<tr>
            	    <!-- 내용 <td> 옆에 DB에서 받아온 content 칼럼값 삽입 -->
            	    <td colspan="4">내용</td>
            	    
            	</tr>
            	<tr>
            	    <td colspan="4"><%=result.getString("content").replaceAll("\n", "<br>") %></td>
            	</tr>
            	
            	<%            	
            }%>
         	</table>
 				<form action="check_password.jsp" method="post">
                <input type="hidden" name="num" value="<%=num %>">
                <label for="pass">비밀번호: </label>
                <input type="password" id="pass" name="pass" required>
                <button type="submit">수정</button>
            </form>
            <button type="button" onclick="location.href='post_list.jsp'">목록으로</button>
            
            <br>
            <br>
            <br>
            <br>
            
            <hr>
        <h2>댓글</h2>
        <table>
            <%
            // 댓글 조회 쿼리
            String commentQuery = "SELECT * FROM comments WHERE post_num=" + num + " ORDER BY reg_date DESC";
            PreparedStatement psmtComment = connection.prepareStatement(commentQuery);
            ResultSet commentResult = psmtComment.executeQuery();
                while(commentResult.next()){
            %>
            <!-- 댓글 출력 -->
                <tr>
                    <td>작성자</td>
                    <td><%=commentResult.getString("writer") %></td>
                    <td>작성일</td>
                    <td><%=commentResult.getTimestamp("reg_date") %></td>
                    <td>

                        <button type="button" onclick="confirmDelete(<%=commentResult.getInt("comment_id") %>, <%=num %>)">삭제</button>
                       </td>
     
                </tr>
                <tr>
                    <td colspan="4"><%=commentResult.getString("content").replaceAll("\n", "<br>") %></td>
                </tr>
            <%
            }
            %>
            </table>
            
            <br>
          <!-- 댓글 작성 -->
        <form action="add_comment.jsp" method="post" onsubmit="return checkFun()">
            <input type="hidden" name="num" value="<%=num %>">
            <label for="writer">작성자 </label>
            <input type="text" id="writer" name="writer" required><br>
            <label for="writer">비 번 </label>
            <input type="password" name="comment_pass" required><br>
            <label for="content">내용 </label><br>
            <textarea id="content" name="content" rows="4" cols="50" required></textarea><br>
            <button type="submit">댓글 작성</button>
        </form>
        
        
    <%
    }
    catch (Exception ex)
    {
        out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
    }%>

</body>
</html>