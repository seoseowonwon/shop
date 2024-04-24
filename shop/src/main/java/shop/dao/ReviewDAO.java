package shop.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;


import shop.DBHelper;

public class ReviewDAO {
	
	public static void main(String[] args) throws Exception {
		//System.out.println(ReviewDAO.insertReview(1, 1, "테스트"));
	}
	
	// 리뷰 작성
	// 파라미터 : ordersNo, score, content
	// 파라미터 값들을 review테이블에 입력, 성공 1 실패 0 반환(int)
	public static int insertReview(int ordersNo, int score, String content) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "insert into comment(orders_no, score, content) values(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, score);
		stmt.setString(3, content);
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// 리뷰 목록
	// 파라미터 : goodsNo
	// goodsNo가 같은 orders들을 반환(ArrayList<HashMap<String, Object>>)
	/**
	 * @param goodsNo
	 * @return
	 * @throws Exception
	 */
	public static ArrayList<HashMap<String, Object>> selectReviewList(int goodsNo)throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "select c.score, c.content, o.goods_no goodsNo, o.orders_no ordersNo "
				+ "from comment c inner join orders o"
				+ " where c.orders_no = o.orders_no and o.goods_no = ? "; // 같은 상품이고 그 해당 물품의 제품번호
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		System.out.println("ReviewDAO selectReviewList stmt--> " + stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("score", rs.getInt("score"));
			m.put("content", rs.getString("content"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("ordersNo", rs.getInt("ordersNo"));
			
			list.add(m);
		}
		//디버깅
		for (HashMap<String, Object> m : list) {
			
			System.out.println("reviewdao selectReviewList score --> "+m.get("score"));
			System.out.println("reviewdao selectReviewList content --> "+m.get("content"));
			System.out.println("reviewdao selectReviewList goodsNo --> "+m.get("goodsNo"));
			System.out.println("reviewdao selectReviewList ordersNo --> "+m.get("ordersNo"));
			
		}
		
		conn.close();
		return list;
	}
	
	// 리뷰 검색
	// 파라미터 : ordesNo
	// ordersNo가 같은 review가 있는지 확인, 있으면 false, 없으면 true를 반환(boolean)
	public static boolean selectReview(int ordersNo) throws Exception {
		boolean reuslt = true;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "select score, content, orders_no from comment where orders_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			reuslt = false;
		}
		
		conn.close();
		return reuslt;
	}
	
	// 리뷰 삭제
	// 파라미터 : ordersNo
	// ordersNo가 같은 review를 삭제, 성공 1 실패 0 반환(int)
	public static int deleteReivew(int ordersNo) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "delete from review where orders_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
}