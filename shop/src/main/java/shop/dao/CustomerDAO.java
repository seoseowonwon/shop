package shop.dao;

import java.sql.Connection;	
import java.sql.PreparedStatement;
import java.util.*;

import shop.DBHelper;


public class CustomerDAO {

	public static int addCustomer(String mail, String pw, String name, String birth, String gender) throws Exception {
		int row = 0;
		String sql = null;
		sql = "insert into customer"
				+ " (mail, pw, name, birth, gender)"
				+ " values (?, ?, ?, ?, ?)";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		stmt.setString(3, name);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		System.out.println("DAO addCustomer --> "+stmt);
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
}
