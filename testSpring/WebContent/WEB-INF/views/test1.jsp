<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- views: 실제 웹상 에서 보이는 화면들읆 모아 놓은 곳 -->
<body>
	a b c d ${num} <!-- num : HomeController에서 설정한 왼쪽 변수들이 여기에 해당  -->
	
	<c:forEach var="getHomeVo" items="${homeVo}"> <!--homeVo는   HomeController에 가면 있음-->
		${getHomeVo.id}
		${getHomeVo.name}		<!--home_mapper에서 product에 대한 DB를 select했기 때문에 이렇게 id, name, location 데이터를 가져올 수 있다.  -->
		${getHomeVo.location}
	</c:forEach>
<%-- 	${homeVo.id} --%>	<!--HomeController에서 설정한 왼쪽 변수들이 여기에 해당  -->


	<br>
	<table>
		<tr>
			<th>id</th>
			<th>날짜</th>
			<th>이름</th>
			<th>전력</th>
			<th>위치</th>
			<th>온도</th>
			<th>습도</th>
		</tr>
		<c:forEach var="getHome" items="${homeList}">
			<tr>
				<td>${getHome.id}</td>
				<td>${getHome.datetime}</td>
				<td>${getHome.name}</td>
				<td>${getHome.electric}</td>
				<td>${getHome.location}</td>
				<td>${getHome.temp}</td>
				<td>${getHome.humid}</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>