<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 인증분기 : 세션변수 이름 - loginEmp
if (session.getAttribute("loginEmp") != null) {
	response.sendRedirect("/shop/emp/empList.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empLoginForm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<style>
.container {
	display: flex;
	flex-direction: column;
	align-items: center;
}
</style>
</head>
<body>
	<div class="container">
		<form action="/shop/emp/empLoginAction.jsp">
			<table>
				<tr>
					<td><input type="text" name="empId" placeholder="ID:"></td>
				</tr>
				<tr>
					<td><input type="password" name="empPw"
						placeholder="PASSWORD:"></td>
				</tr>
			</table>
			<button type="submit">로그인</button>
		</form>
	</div>
</body>
</html>