<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>신규글 작성</title>
	<script type="text/javascript">
        function checkFun() {
            var pass = document.getElementsByName("pass")[0].value;
            var pattern = /^[A-Za-z0-9!@#$%^&*]+$/;
            if (!pattern.test(pass)) {
                alert("비밀번호는 영어, 숫자, 특수문자만 가능합니다.");
                return false;
            }
            return true;
        }
    </script>
    <style>
        input[type="text"], textarea {
            font-family: Arial, sans-serif; /* 원하는 폰트 패밀리로 변경하세요 */
            font-size: 13px; /* 원하는 폰트 크기로 변경하세요 */
            line-height: 1.5; /* 원하는 라인 높이로 변경하세요 */
            letter-spacing: normal; /* 원하는 글자 간격으로 변경하세요 */
        }
    </style>
	 <style>
        textarea{resize: none;
        overflow: auto;} /* 잡고 늘리기 방지*/
    </style>
</head>
<body>
	<h1> 신규글 작성</h1>
	<hr>

	<form action="send_post.jsp" method="post" onsubmit="return checkFun()">
	<table>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer"  style="width: 310px;"></td>
				<td>암호</td>
				<td><input type="password" name="pass"  style="width: 310px;"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3"><input type="text" name="title" style="width: 99%;"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3"><textarea rows="30" cols="82" name="content" style="font-size: 16px;"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" style="padding-right: 20px;">
					<button type="submit">저장</button>
					<button type="button" onclick="location.href='post_list.jsp'">목록으로</button>
					<button type="reset">초기화</button>
				</td>
			</tr>
	</form>				
	</table>	
</body>
</html>