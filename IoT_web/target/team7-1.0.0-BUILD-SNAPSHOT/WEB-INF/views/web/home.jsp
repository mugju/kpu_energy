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
		<form name="home" method="GET">
			<div align="center">
				<c:if test="${client != null }">
					<tr>
						<td>${client.getId()}님</td>
						<td><input type="submit" value="로그아웃" formaction="logout" /></td>
					</tr>
				</c:if>

				<c:if test="${client == null }">
					<script>
						function back() {
							alert("로그인 해주세요.");
							location.href
							"/team7/web/login";
						}
					</script>
					<script>
						back();
					</script>
				</c:if>
			</div>

			<div align="center">
				<table border="1">
					<tr>
						<td>평소 소비 전력</td>
						<td><input type="submit" value="일일 시간당 소비량"
							formaction="smart_plug_day" /></td>
						<td><input type="submit" value="일일 소비량"
							formaction="" /></td>
						<td><input type="submit" value="월간 소비량"
							formaction="smart_plug_month" /></td>
					</tr>
					<tr>
						<td>절감한 전력량</td>
						<td><input type="submit" value="일일 시간당 절감량"
							formaction="reduction_day" /></td>
						<td><input type="submit" value="일일 절감량"
							formaction="" /></td>
						<td><input type="submit" value="월간 절감량"
							formaction="reduction_month" /></td>
					</tr>
				</table>
			</div>
		</form>

	</div>
</body>
</html>