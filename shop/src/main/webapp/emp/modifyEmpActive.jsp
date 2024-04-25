<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@ page import="shop.dao.*" %>   
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	System.out.println("modifyEmpActive empId --> " + empId);
	System.out.println("modifyEmpActive active --> " + active);
	
	int updateState = EmpDAO.updateState(active, empId);
	
	
	//디버깅
	if(updateState == 1){
		System.out.println("변경 성공!");
		response.sendRedirect("/shop/emp/empList.jsp");
	} else {
		System.out.println("변경 실패");
	}
 	
	
%>