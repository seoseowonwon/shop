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
		
		String sql = "insert into emp (emp_id empId, emp_pw empPw, "
				+ "emp_name empName, emp_job empJob ) "
				+ "values ( ?, ?, ?, ? )";
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
	
	// 호출 : empOne.jsp
	// param : empId
	// return HashMap
	public static HashMap<String, Object> empOne (String empId) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT emp_id empId, emp_name empName,"
				+ " emp_job empJob, hire_date hireDate, "
				+ "create_date createDate, update_date updateDate "
				+ "FROM emp WHERE emp_id = ?";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		stmt.setString(1,empId);
		System.out.println("empOneDAO stmt --> "+stmt);
		rs = stmt.executeQuery();
		
		
		HashMap<String, Object> resultMap = null;
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("empJob", rs.getString("empJob"));
			resultMap.put("hireDate", rs.getString("hireDate"));
			resultMap.put("createDate", rs.getString("createDate"));
			resultMap.put("updateDate", rs.getString("updateDate"));
		}
		
		conn.close();
		return resultMap;
	}
	
	
	// 호출 : empList
	// Param : x
	// return : ArrayList
	//empList의 전체 출력 empId	empName	empJob	hireDate	active등 출력
	public static ArrayList<HashMap<String, Object>> seeAll() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		String sql = "SELECT emp_id empId, emp_name empName, emp_job empJob, "
				+ "hire_date hireDate, active FROM emp";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		HashMap<String, Object> resultMap = null;
		while(rs.next()){
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empid"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("empJob", rs.getString("empJob"));
			resultMap.put("hireDate", rs.getString("hireDate"));
			resultMap.put("active", rs.getString("active"));
			list.add(resultMap);
		}
		
		return list;
	}
	
	
	
	// 디버깅용 메서드
	public static void main(String[] args) throws Exception {
		System.out.println( "EmpDAO empLogin의 resultMap값--> "+EmpDAO.empLogin("admin","1234"));
		System.out.println( "EmpDAO empOne의 resultMap값--> "+EmpDAO.empOne("admin"));
	}
	
}
