<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>

<!-- Controller layer -->
<%
	// ���� �б�  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "SELECT emp_name empName, emp_job empJob, create_date createDate FROM emp WHERE active='OFF'";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);	
	rs = stmt.executeQuery();

	
%>    

<%
	//���� ������ �� 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// �� �������� ���̴� �ο���
	int rowPerPage = 10;
	
	// DB���� ���� ������ �� ���� = (���� ������-1) *   �� �������� ���̴� �ο���
	int startRow = (currentPage-1)* rowPerPage;
	
	
	//��ü ȸ���� �� ���ϱ�
	String sql3 = "SELECT count(*) cnt FROM emp WHERE emp_id LIKE '%%'";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null; 
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();
	
	// ��ü ȸ���� 
	int totalRow = 0;
	
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	
	// ������ ������ ����ϱ� = ��ü ȸ���� / �� ���������� ���̴� �ο���
	int lastPage = totalRow / rowPerPage;
	
	//�ο����� ���� �� ������ �������� +1 ���ش�. 
	//��) ȸ������ 11���̶�� �� �������� 10���� 1�������� ���;��ϴµ� 1���� �� �ֱ� ������ �� �������� 2�������� �ȴ�.
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	
	//System.out.println(lastPage + " lastPage ȸ������ ������");
	//System.out.println(totalRow + "<----totalRow ��ü ȸ���� ");
	//System.out.println(rowPerPage + "<----rowPerPage �� �������� �������� �ο���");
	//System.out.println(startRow);
	//System.out.println(rowPerPage);
%>

<!-- model layer -->
<%
	//Ư���� ������ �ڷᱸ�� RDBMS : maradb 
	//-> API���(JDBC API)�Ͽ� �ڷᱸ��(ResultSet) ��� 
	//-> �Ϲ�ȭ�� �ڷᱸ�� (ArrayList<HashMap>) �� ���� -> �� ���
	
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql2 = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active FROM emp ORDER BY hire_date DESC limit ?,?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null; 
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, startRow);
	stmt2.setInt(2, rowPerPage);
	rs2 = stmt2.executeQuery(); // JDBC API ���ӵ� �ڷᱸ�� �� ResultSet -> �⺻ API �ڷᱸ��(ArrayList)�� ����
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();   // ��� Ÿ���� �θ�� object 
	
	// Result -> ArrayList<HashMap<String, Object>> �̵�
	
	while(rs2.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs2.getString("empid"));
		m.put("empName", rs2.getString("empName"));
		m.put("empJob", rs2.getString("empJob"));
		m.put("hireDate", rs2.getString("hireDate"));
		m.put("active", rs2.getString("active"));
		list.add(m);
	}
	
	
	// JDBC API ����� �����ٸ� DB�ڿ����� �ݳ�
%>    



<!-- View layer : �� ArrayList<HashMap<String, Object>> ��� -->
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<meta charset="EUC-KR">
	<style>
		
	</style>
	<title>empList page</title>
	
</head>
<body>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

	<div class="m-4 d-flex justify-content-between">
		<div>&nbsp;</div>
		<h1>���� ����Ʈ</h1>
		<a href="/shop/emp/empLogoutAction.jsp" class="mt-4">�α׾ƿ�</a>
	</div>
	<div>
		<table border="1"  class="table table-hover">
			<tr>
				<th>empId</th>
				<th>empName</th>
				<th>empJob</th>
				<th>hireDate</th>
				<th>active</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list){
			%>
				<tr>
					<td><%=(String)(m.get("empId"))%></td>
					<td><%=(String)(m.get("empName"))%></td>
					<td><%=(String)(m.get("empJob"))%></td>
					<td><%=(String)(m.get("hireDate"))%></td>
					<td>
						<a href="/shop/emp/modifyEmpActive.jsp?active=<%=(String)(m.get("active"))%>&empId=<%=(String)(m.get("empId"))%>">
							<%=(String)(m.get("active"))%>
						</a>
					</td>
				</tr>
			<%
				}
			%>
		</table>
		<div class="d-flex justify-content-center btn-group" role="group" aria-label="Basic example">
			<button type="button" class="btn btn-light"  >
				<%
					if(currentPage > 1){
				%>
					<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage -1%>" class="aTags">����</a>
				<%
					}else{
				%>
					<a style="color: grey; cursor: not-allowed;" class="aTags" >����</a>
				<%
					}
				%>
			</button>
			<button type="button" class="btn btn-light" id="currentNum"><%=currentPage%></button>
			<button type="button" class="btn btn-light">
				<%if(currentPage < lastPage ){
				%>
					<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage +1%>" class="aTags">����</a>		
				<%
				}else{
				%>
					<a style="color: grey; cursor: not-allowed;" class="aTags">����</a>
				<%
				}
				%>
			</button>
		</div>
	</div>
</body>
</html>