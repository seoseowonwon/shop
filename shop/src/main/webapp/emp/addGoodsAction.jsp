<%@page import="shop.dao.GoodsDAO"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
		return;
	}
%>
<%

	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));

	String category = request.getParameter("category");
	System.out.println(category + "<-- addGoodsAction param category");
	String empId = (String)(loginEmp.get("empId"));
	System.out.println(empId + "<-- addGoodsAction param empId");
	String goodsTitle = request.getParameter("goodsTitle");
	System.out.println(goodsTitle + "<-- addGoodsAction param goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	System.out.println(goodsContent + "<-- addGoodsAction param goodsContent");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	System.out.println(goodsPrice + "<-- addGoodsAction param goodsPrice");
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	System.out.println(goodsAmount + "<-- addGoodsAction param goodsAmount");
	
	Part part = request.getPart("goodsImage");
	
	
	String originalName = null;
	int dotIdx = 0;
	String ext = null;
	String filename = null;
	if(part.getSize() > 0){
		originalName = part.getSubmittedFileName();
		dotIdx = originalName.lastIndexOf(".");
		ext = originalName.substring(dotIdx);
		UUID uuid = UUID.randomUUID();
		filename = uuid.toString().replace("-", "");
		filename = filename + ext;
	}
	
	System.out.println(filename + "<-- addGoodsAction filename");

	int row = GoodsDAO.insertGoods(filename, category, empId, goodsTitle, goodsContent, goodsPrice, goodsAmount);
	
	if(row == 1){
		//입력 성공
		System.out.println("입력성공");
		if(filename != null){
			InputStream is = part.getInputStream();
			String filePath = request.getServletContext().getRealPath("upload");
			File f = new File(filePath, filename);
			OutputStream os = Files.newOutputStream(f.toPath());
			is.transferTo(os);
			
			os.close();
			is.close();
		}
	} else {
		//입력 실패
		System.out.println("입력실패");
	}
	
	response.sendRedirect("/shop/emp/goodsList.jsp");
%>