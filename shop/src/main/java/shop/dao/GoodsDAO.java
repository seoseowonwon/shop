package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	/*
	 * public static ArrayList<HashMap<String, Object>> selectGoodsList (int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select goods_no goodsNo, category "
				+ "from goods"
				+ "order by create_date desc"
				+ "limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2,  rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getString("goodsNo"));
			m.put("goodsNo", rs.getString("category"));
			list.add(m);
		}
		conn.close();
	}
	*/
	public static  ArrayList<HashMap<String, Object>> categoryList () throws Exception{
		HashMap<String, Object> resultMap = null;
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		
		//DB접근
		Connection conn = DBHelper.getConnection();
		String sql = "select category, count(*) cnt from goods "
				+ "group by category order by category asc";
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
		
		
		//디버깅
		for (HashMap all : alList) {
			System.out.println("GoodsDAO goodsNo --> "+ (Integer)(all.get("goodsNo")));
			System.out.println("GoodsDAO category --> "+ (String)(all.get("category")));
			System.out.println("GoodsDAO goodsTitle --> "+ (String)(all.get("goodsTitle")));
			System.out.println("GoodsDAO filename --> "+ (String)(all.get("filename")));
			System.out.println("GoodsDAO goodsPrice --> "+ (Integer)(all.get("goodsPrice")));
			System.out.println("GoodsDAO goodsAmount --> "+ (Integer)(all.get("goodsAmount")));
		}
		
		
		conn.close();
		return alList;
	}
	
	
	
}
