package shop.dao;

import java.sql.*;
import java.util.*;

// emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너 역할 
// 1. 메서드 사용하는 이유는 짧게 호출하기 위해 2. 반복되는 것을 호출할려고

public class EmpDAO {
	public static int insertEmp(String empId,String empPw, String empName, String empJob) throws Exception {
		int row = 0;
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "insert into emp (emp_id empId, emp_pw empPw, emp_name empName, emp_job empJob ) values ( ?, ?, ?, ? )";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		stmt.setString(3,empName);
		stmt.setString(4,empJob);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	// HashMap<String, Object> : null이면 로그인 실패, 아니면 성공
	// (String empId, String empPw) : 로그인 폼에서 사용자가 입력한 id/ pw
	public static HashMap<String, Object> empLogin (String empId, String empPw) throws Exception{
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "select emp_id empId, emp_name empName, grade from emp where active = 'ON' and emp_id =? and emp_pw = password(?)";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		System.out.println("empLoginAction stmt -->"+stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
		}
		
		conn.close();
		return resultMap;
	}
	
}
