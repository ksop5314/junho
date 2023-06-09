
<!-- ggiriComplete/completeList.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:import url="../default/header.jsp"></c:import>
	<div class="wrap com_write">
	<h1>프로젝트 등록</h1>
		<div class="comSave">
			<form action="../ggiriComplete/comSave" method="post">
				<b> 작성자 </b><br>
				<input type="text" name="id" size="50" value="${loginUser }"><br>
				<b> 작성일 </b><br>
				<input type="date" name="comdate" size="50"><br>
				<b> 제 목 </b><br>
				<input type="text" name="title" size="50"><br>
				<b> 내 용 </b><br>
				<textarea rows="20" cols="100" name="content"></textarea><br>
				<b> 스 킬 </b><br>
				<textarea rows="20" cols="100" name="skill"></textarea><br>
				<b> 멤 버 </b><br>
				<input type="text" name="members" size="50"><br>
				<b> 태 그 </b><br>
				<input type="text" name="tag" size="50"><br>
				<br>
				<input type="submit" value="등록"> &nbsp;
			</form>
		</div>
	</div>
	<c:import url="../default/footer.jsp"></c:import>
</body>
</html>