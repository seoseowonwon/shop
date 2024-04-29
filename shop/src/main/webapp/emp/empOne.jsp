<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	/*
	String empId = request.getParameter("empId");
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, create_date createDate, update_date updateDate FROM emp WHERE emp_id = ? ";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);	
	stmt.setString(1, empId);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs.getString("empId"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("createDate", rs.getString("createDate"));
		m.put("updateDate", rs.getString("updateDate"));
		list.add(m);
	}
	*/
	
	
	String empId = request.getParameter("empId");
	HashMap<String, Object> list = EmpDAO.empOne(empId);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container bg-success">
	
	<div class="row">
		<div class="col-1 row-1"></div>
		<div class="col-10 content bg-white shadow lgPgCenterDiv;"
			style="height: 100vh">
			<br>
			<div>
				<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
			</div>
		<div class="m-4 d-flex justify-content-between"></div>
		
		<div>
			<h3>내 정보</h3>
			<table border="1"  class="table table-hover">
			
			
						<tr>
							<th>아이디</th><td><%=(String)(list.get("empId"))%></td>
						</tr>
						<tr>
							<th>이름</th><td><%=(String)(list.get("empName"))%></td>
						</tr>
						<tr>
							<th>직책</th><td><%=(String)(list.get("empJob"))%></td>
						</tr>
						<tr>
							<th>고용일</th><td><%=(String)(list.get("hireDate"))%></td>
						</tr>
						<tr>
							<th>생성날짜</th><td><%=(String)(list.get("createDate"))%></td>
						</tr>
						<tr>
							<th>수정날짜</th><td><%=(String)(list.get("updateDate"))%></td>
						</tr>
				</table>
			</div>
		<div class="col-1 row-1"></div>
		</div>
		</div>
</body>
</html>





		