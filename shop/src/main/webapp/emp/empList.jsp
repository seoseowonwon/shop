<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!-- Controller layer -->
<%
	// 인증 분기  
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
	//현재 페이지 값 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보이는 인원수
	int rowPerPage = 10;
	
	// DB에서 시작 페이지 값 설정 = (현재 페이지-1) *   한 페이지에 보이는 인원수
	int startRow = (currentPage-1)* rowPerPage;
	
	
	//전체 회원의 수 구하기
	String sql3 = "SELECT count(*) cnt FROM emp";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null; 
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();
	
	// 전체 회원수 
	int totalRow = 0;
	
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	
	// 마지막 페이지 계산하기 = 전체 회원수 / 한 페이지에서 보이는 인원수
	int lastPage = totalRow / rowPerPage;
	
	//인원수가 남을 때 마지막 페이지는 +1 해준다. 
	//예) 회원수가 11명이라면 한 페이지당 10명씩 1페이지가 나와야하는데 1명이 더 있기 때문에 총 페이지는 2페이지가 된다.
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	
	//System.out.println(lastPage + " lastPage 회원보기 페이지");
	//System.out.println(totalRow + "<----totalRow 전체 회원수 ");
	//System.out.println(rowPerPage + "<----rowPerPage 한 페이지당 보고싶은 인원수");
	//System.out.println(startRow);
	//System.out.println(rowPerPage);
%>

<!-- model layer -->
<%
	//특수한 형태의 자료구조 RDBMS : maradb 
	//-> API사용(JDBC API)하여 자료구조(ResultSet) 취득 
	//-> 일반화된 자료구조 (ArrayList<HashMap>) 로 변경 -> 모델 취득
	
	/*
	//전체 리스트 출력하는 문
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql2 = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active FROM emp ORDER BY hire_date DESC limit ?,?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null; 
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, startRow);
	stmt2.setInt(2, rowPerPage);
	rs2 = stmt2.executeQuery(); // JDBC API 종속된 자료구조 모델 ResultSet -> 기본 API 자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();   // 모든 타입의 부모는 object 
	
	// Result -> ArrayList<HashMap<String, Object>> 이동
	
	while(rs2.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs2.getString("empid"));
		m.put("empName", rs2.getString("empName"));
		m.put("empJob", rs2.getString("empJob"));
		m.put("hireDate", rs2.getString("hireDate"));
		m.put("active", rs2.getString("active"));
		list.add(m);
	}
	*/
	ArrayList<HashMap<String, Object>> list = EmpDAO.seeAll();
	
	// JDBC API 사용이 끝났다면 DB자원들을 반납
%>    



<!-- View layer : 모델 ArrayList<HashMap<String, Object>> 출력 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>empList page</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<style>
		.a{
			text-decoration: none;
			color: black;
		}
	</style>
</head>
<body class="container bg-success">
	<div class="row">
		<div class="col-1"></div>
		<div class="col-10 content bg-white shadow lgPgCenterDiv"><br>
		<div>
			<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		</div>
		
		<div class="m-4 d-flex justify-content-between">
			<div>&nbsp;</div>
			<h1>직원 리스트</h1>
			<div>&nbsp;</div>
		</div>
		<div>
			<table border="1"  class="table table-hover">
				<tr>
					<th>이메일</th>
					<th>이름</th>
					<th>직책</th>
					<th>고용날짜</th>
					<th>관리자</th>
				</tr>
				<%
					for(HashMap<String, Object> m : list){
				%>
					<tr>
						<td><a class="a" href="/shop/emp/empOne.jsp?empId=<%=(String)(m.get("empId"))%>"><%=(String)(m.get("empId"))%></a></td>
						<td><a class="a" href="/shop/emp/empOne.jsp?empId=<%=(String)(m.get("empId"))%>"><%=(String)(m.get("empName"))%></a></td>
						<td><a class="a" href="/shop/emp/empOne.jsp?empId=<%=(String)(m.get("empId"))%>"><%=(String)(m.get("empJob"))%></a></td>
						<td><a class="a" href="/shop/emp/empOne.jsp?empId=<%=(String)(m.get("empId"))%>"><%=(String)(m.get("hireDate"))%></a></td>
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
						<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage -1%>" class="aTags">이전</a>
					<%
						}else{
					%>
						<a style="color: grey; cursor: not-allowed;" class="aTags" >이전</a>
					<%
						}
					%>
				</button>
				<button type="button" class="btn btn-light" id="currentNum"><%=currentPage%></button>
				<button type="button" class="btn btn-light">
					<%if(currentPage < lastPage ){
					%>
						<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage +1%>" class="aTags">다음</a>		
					<%
					}else{
					%>
						<a style="color: grey; cursor: not-allowed;" class="aTags">다음</a>
					<%
					}
					%>
				</button>
			</div>
		</div>
	</div>
	<div class="col-1"></div>
	</div>
</body>
</html>