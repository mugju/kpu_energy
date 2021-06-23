<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<link rel="stylesheet" href="//mugifly.github.io/jquery-simple-datetimepicker/jquery.simple-dtpicker.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="//mugifly.github.io/jquery-simple-datetimepicker/jquery.simple-dtpicker.js"></script>
<script type="text/javascript">
$(function(){
    $('.datetimepicker').appendDtpicker({'locale':'ko'});
});
</script>
</head>
<body>
<div align="center">
		<form name="home" method="post">
			<div align="center">
				<c:if test="${client != null }">
					<p>${client.getId()}님</p>
					<input type="submit" value="로그아웃" formaction="logout" />
				</c:if>
				<c:if test="${client == null }">
					<script>
						alert("로그인 해주세요.");
						location.href("/team7/client/login");
					</script>
				</c:if>
				<input type="submit" value="홈으로" formaction="<c:url value="home"/>" />
			</div>
		</form>
	</div>
	<form name="date" method="post">
	<p>기계 종류<p>
	<p>시작</p>
	<input class="datetimepicker" id="startDate" type="text" name="sDate">
	<p>~
	종료</p>
	<input class="datetimepicker" id="endDate" type="text" name="eDate">
	<input type="submit" value="확인" formaction="smart_plug"/>
	</form>
</body>
</html>