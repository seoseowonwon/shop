<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
%>
<div>
	<a href="/shop/emp/empList.jsp">사원관리</a>
	<!-- category CRUD -->
	<a href="/shop/emp/categoryList.jsp">카테고리관리</a>
	<a href="/shop/emp/goodsList.jsp">상품관리</a>
	<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>	
	<span>
		<!-- 개인정보수정 -->
		<a href="/shop/emp/empOne.jsp?empId=<%=(String)(loginMember.get("empId"))%>">
			<%=(String)(loginMember.get("empName"))%>님
		</a> 반갑습니다
	</span>
</div>
