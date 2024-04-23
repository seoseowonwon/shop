package shop.dao;

import java.sql.*;

import java.util.*;

import shop.DBHelper;
import shop.dao.*;

public class GoodsDAO {
	
	
	// 상품 수량 수정
	// 파라미터 : goodsNo, amount
	// goodsNo가 같은 상품의 amount를 파라미터 amount 만큼 빼서 수정, 성공 1 실패 0 반환(int)
	public static int updateGoodsAmount(int goodsNo, int amount) throws Exception {
		String sql = null;
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		// 파라미터 amount가 0이상이면 주문이므로 상품의 수량이 amount보다 많아야됨. 0미만일 경우 주문 취소이므로 상품의 수량은 상관없음 
		if(amount > 0) {
			sql = "update goods set goods_amount = goods_amount - ?,  update_date = now() where goods_no = ? and goods_amount > ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, amount);
			stmt.setInt(2, goodsNo);
			stmt.setInt(3, goodsNo - 1);
			System.out.println("updateGoodsAmount > 0stmt -->" + stmt);
		} else {
			sql = "update goods set goods_amount = goods_amount - ?,  update_date = now() where goods_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, amount);
			stmt.setInt(2, goodsNo);
			System.out.println("updateGoodsAmount ==0 stmt -->"+stmt);
		}
		int row = 0;
		row = stmt.executeUpdate();
		System.out.println("updateGoodsAmount row -->"+ row);
		return row;
	}


	// 상품 상세보기
	// 파라미터 : goodsNo
	// goodsNo 값이 같은 상품 반환(HashMap)
	public static HashMap<String, Object> selectGoods(int goodsNo) throws Exception{
		
		String sql = null;
		sql = "select goods_no goodsNo, category, emp_id empId, goods_title " + 
				"goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
				"update_date updateDate, create_date createDate from goods where goods_no = ?";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		HashMap<String, Object> m = new HashMap<>();
		if(rs.next()){
			
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("empId", rs.getString("empId"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsContent", rs.getString("goodsContent"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsAmount", rs.getInt("goodsAmount"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
		}
		
		return m;
	}


	
	//goodsOne.jsp
	public static HashMap<String, Object> goodsOne (int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT goods_no goodsNo, category,"
				+ " emp_id empId, goods_title goodsTitle,"
				+ " filename, goods_content goodsContent,"
				+ " goods_price goodsPrice,"
				+ " goods_amount goodsAmount"
				+ " FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		System.out.println("empOneDAO stmt --> "+stmt);
		rs = stmt.executeQuery();
		
		
		HashMap<String, Object> resultMap = null;
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("goodsNo", rs.getString("goodsNo"));
			resultMap.put("category", rs.getString("category"));
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("goodsTitle", rs.getString("goodsTitle"));
			resultMap.put("filename", rs.getString("filename"));
			resultMap.put("goodsContent", rs.getString("goodsContent"));
			resultMap.put("goodsPrice", rs.getString("goodsPrice"));
			resultMap.put("goodsAmount", rs.getString("goodsAmount"));
			
		}
		
		conn.close();
		return resultMap;
	}
	
	
	// 고객 로그인 후 상품목록 페이지
	// /customer/goodsList.jsp
	// param : void 
	// return : Goods (일부 속성)의 배열 -> ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectGoodsList(
			String category, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		//conn
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;
		if(category != null ) { // category가 정해졌을 때
			sql = 	"select"
					+ " goods_no goodsNo,"
					+ " category,"
					+ " goods_title goodsTitle,"
					+ " filename,"
					+ " goods_price goodsPrice"
					+ " from goods"
					+ " where category = ?"
					+ " order by goods_no desc"
					+ " limit ?, ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,category);
			stmt.setInt(2,startRow);
			stmt.setInt(3,rowPerPage);
			System.out.println("GoodsDAO stmt --> "+stmt);
			System.out.println("category --> "+category);
			System.out.println("startRow --> "+startRow);
			System.out.println("rowPerPage --> "+rowPerPage);
		} else { // category가 정해지지 않았을 때
			
			String sql1= "select"
					+ " goods_no goodsNo,"
					+ " category,"
					+ " goods_title goodsTitle,"
					+ " filename,"
					+ " goods_price goodsPrice"
					+ " from goods"
					+ " order by goods_no desc"
					+ " limit ?, ?";
			stmt = conn.prepareStatement(sql1);
			stmt.setInt(1,startRow);
			stmt.setInt(2,rowPerPage);
			System.out.println("GoodsDAO stmt --> "+stmt);
			System.out.println("startRow --> "+startRow);
			System.out.println("rowPerPage --> "+rowPerPage);
			
			
		}
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	
	
	//전체 cnt 가져오는 sql
	public static int totalCnt () throws Exception {
		int resultMap = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "select"
				+ " count(*) cnt"
				+ " from goods";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMap = rs.getInt("cnt");
			System.out.println("GoodsDAO cnt --> "+resultMap);
		}
		return resultMap;
	}
	
	
	//글쎄 일단 cnt 전체 가져올려고 하는뎁쇼
	public static  ArrayList<HashMap<String, Object>> categoryList () throws Exception{
		HashMap<String, Object> resultMap = null;
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		
		//DB접근
		Connection conn = DBHelper.getConnection();
		String sql = "select"
				+ " category, count(*) cnt"
				+ " from goods"
				+ " group by category"
				+ " order by category asc";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("category", rs.getString("category"));
			resultMap.put("cnt", rs.getInt("cnt"));
			categoryList.add(resultMap);
		}
		
		conn.close();
		
		return categoryList;
		
	}
	
	public static ArrayList<String> selcetCategoryList() throws Exception {
		String sql = null;
		sql = "select category from goods group by category";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		ArrayList<String> categoryList = new ArrayList<String>();
		
		while(rs.next()){
			categoryList.add(rs.getString("category"));
		}
		
		return categoryList;
	}
	
	
	
	public static int cagory(String category) throws Exception {
		int row = 0;
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "insert into category (category) values (?)";;
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,category);
		
	
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	
	public static ArrayList<HashMap<String, Object>> list (String category) throws Exception{
		HashMap<String, Object> resultMap = null;
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		//DB접근
		Connection conn = DBHelper.getConnection();
		String sql = "select goods_no goodsNo, category, goods_title goodsTitle, "
				+ "filename, goods_price goodsPrice, goods_amount goodsAmount "
				+ "from goods where category = ?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,category);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("goodsNo", rs.getInt("goodsNo"));
			resultMap.put("category", rs.getString("category"));
			resultMap.put("goodsTitle", rs.getString("goodsTitle"));
			resultMap.put("filename", rs.getString("filename"));
			resultMap.put("goodsPrice", rs.getInt("goodsPrice"));
			resultMap.put("goodsAmount", rs.getInt("goodsAmount"));
			list.add(resultMap);
		}
		
		return list;
	}
	
	
	
	public static ArrayList<HashMap<String, Object>> alList () throws Exception{
		
		
		ArrayList<HashMap<String, Object>> alList = new ArrayList<HashMap<String, Object>>();
		
		//DB접근
		Connection conn = DBHelper.getConnection();
		String sql = "select goods_no goodsNo, category, goods_title goodsTitle,"
				+ "filename, goods_price goodsPrice, goods_amount goodsAmount from goods";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		System.out.println("GoodsDAO stmt --> " + stmt);
		System.out.println("GoodsDAO rs --> " + rs);
		
		
		while(rs.next()) {
			HashMap<String, Object> resultMap = null;
			resultMap = new HashMap<String, Object>();
			resultMap.put("goodsNo", rs.getInt("goodsNo"));
			resultMap.put("category", rs.getString("category"));
			resultMap.put("goodsTitle", rs.getString("goodsTitle"));
			resultMap.put("filename", rs.getString("filename"));
			resultMap.put("goodsPrice", rs.getInt("goodsPrice"));
			resultMap.put("goodsAmount", rs.getInt("goodsAmount"));
			alList.add(resultMap);
			
		}
		
		conn.close();
		return alList;
	}
	
	// 호출 : addGoodsAction.jsp
	// param : category, empId goodsTitle filename goodsContent goodsPrice goodsAmount
	// reuturn : 
	public static int insertGoods(String category, String empId, 
			String goodsTitle, String filename,
			String goodsContent, int goodsPrice, int goodsAmount) 
			throws Exception {
		
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "insert into goods (category, emp_id, goods_title,"
				+ "filename, goods_content, goods_price,"
				+ " goods_amount,"
				+ "update_date, create_date) values(?, ?, ?, ?, ?, ?, ?, now(), now())";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setString(2, empId);
		stmt.setString(3, goodsTitle);
		stmt.setString(4, filename);
		stmt.setString(5, goodsContent);
		stmt.setInt(6, goodsPrice);
		stmt.setInt(7, goodsAmount);
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	
	
	//디버깅
	public static void main(String args[]) throws Exception {
		System.out.println("insertGoods --> "+GoodsDAO.insertGoods("원펀맨", "admin", "원펀맨모바일","default.jpg", "원펀맨 모바일", 10000, 12));
		System.out.println("cnt --> "+GoodsDAO.totalCnt());
	}
}
