<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<link rel="stylesheet" href="../resources/css/client.css"
	type="text/css" />
<script type="text/javascript">
	function loginCheck() {
		if (!document.login.storeName.value) {
			alert("매장을 입력하세요.");
			return false;
		}
		if (!document.login.userId.value) {
			alert("아이디를 입력하세요.");
			return false;
		}

		if (!document.login.passwd.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
	}
</script>
</head>
<body>
	<div align="center">
		<header>로그인</header>
		<form name="login" method="post"
			onsubmit="return loginCheck()">
			<table border="1">
				<tr>
					<td>매장명</td>
					<td><input name="storeName" id="storeName"></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input name="id" id="id"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" id="passwd"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="로그인" onclick = "logincheck();" formaction="login"></td>
					<c:if test= "${msg == 'noUser'}">
					<p style="color:red;">로그인 실패! 매장명, 아이디, 비밀번호를 확인하세요.</p>
					</c:if>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>