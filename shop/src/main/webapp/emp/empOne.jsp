<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>

<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
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
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<div>
		<table border="1"  class="table table-hover">
			<%
				for(HashMap<String, Object> m : list){
			%>
				<tr>
					<th>empId</th><td><%=(String)(m.get("empId"))%></td>
				</tr>
				<tr>
					<th>empName</th><td><%=(String)(m.get("empName"))%></td>
				</tr>
				<tr>
					<th>empJob</th><td><%=(String)(m.get("empJob"))%></td>
				</tr>
				<tr>
					<th>hireDate</th><td><%=(String)(m.get("hireDate"))%></td>
				</tr>
				<tr>
					<th>createDate</th><td><%=(String)(m.get("createDate"))%></td>
				</tr>
				<tr>
					<th>updateDate</th><td><%=(String)(m.get("updateDate"))%></td>
				</tr>
			<%
				}
			%>
		</table>
</body>
</html>