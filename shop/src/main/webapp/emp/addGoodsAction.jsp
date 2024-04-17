<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
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
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));

	
	//파일 가져오기
	Part part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	// 원본이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);
	System.out.println("dotIdx --> "+dotIdx);
	
	UUID uuid = UUID.randomUUID(); // UUID안에 있는 글자는 절대 중복 될 수 없는 글자이다.
	String filename = uuid.toString().replace("-", "");
	filename = filename + ext;
	
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	String empId = (String)(loginEmp.get("empId"));
	

	/*
	//디버깅
	System.out.println("addGoodsAction category --> "+category);	
	System.out.println("addGoodsAction empId --> "+empId);	
	System.out.println("addGoodsAction goodsTitle --> "+goodsTitle);	
	System.out.println("addGoodsAction goodsContent --> "+goodsContent);	
	System.out.println("addGoodsAction goodsPrice --> "+goodsPrice);	
	System.out.println("addGoodsAction goodsAmount --> "+goodsAmount);	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	//goods테이블에 새로운 값 추가 SQL
	String sql1 = "insert into goods ( category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) values(?, ?, ?, ?, ?, ?, ?, now(), now())";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, category);
	stmt1.setString(2, empId);
	stmt1.setString(3, goodsTitle);
	stmt1.setString(4, filename);
	stmt1.setString(5, goodsContent);
	stmt1.setString(6, goodsPrice);
	stmt1.setString(7, goodsAmount);
	
	int row = stmt1.executeUpdate();
	
	if(row == 1){// insert 성공하면 파일 업로드 
		// part -> is -> os -> 빈파일 
		InputStream is = part.getInputStream();
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); // 빈파일을 생성함
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file 
		is.transferTo(os);
		response.sendRedirect("/shop/emp/goodsList.jsp");
		os.close();
		is.close();
	}
	*/
	
	int list = GoodsDAO.insertGoods(category, empId, goodsTitle, filename, goodsContent, goodsPrice, goodsAmount);
	//파일 지우기
	/* File df = new File(filePath, rs.getString("filename"));
	df.delete() */
%>

<!-- Controller Layer -->
<%
    if(list == 1){
        response.sendRedirect("/shop/emp/goodsList.jsp");
    } else {
    	String errMsg = URLEncoder.encode("작성에 실패했습니다. 확인 후 다시 입력하세요.", "utf-8");
    	response.sendRedirect("/shop/emp/addGoodsForm.jsp?errMsg=" + errMsg);
        return;
    }
%>
