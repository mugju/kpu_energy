<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
</head>
<body>
	<div align="center">
		<form name="home" method="get">
			<div align="center">
				<c:if test="${client != null }">
					<p>${client.getId()}님</p>
					<input type="submit" value="로그아웃" formaction="logout"/>
				</c:if>
				<c:if test="${client == null }">
					<script>
						function back() {
							alert("로그인 해주세요.");
							location.href "/team7/client/login";
						}
					</script>
					<script>
						back()
					</script>
				</c:if>
				<table>
				<tr>
					<td><input type="submit" value="111" formaction="smart_plug" /></td>
					<td><input type="submit" value="2" formaction="smart_plug2" /></td>
					<td><input type="submit" value="3" formaction="smart_plug3" /></td>
				</tr>
			</table>
			</div>
		</form>
	</div>
</body>
</html>