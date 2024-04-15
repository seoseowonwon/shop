package shop.dao;

import java.io.FileReader;
import java.sql.*;
import java.util.Properties;

public class DBHelper {
	
	public static Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 로컬 PC의 Properties파일 읽어 오기 filereader 외부파일을 읽어올때 씀
		FileReader fr = new FileReader("C:\\dev\\auth\\mariadb.properties");
		Properties prop = new Properties();
		prop.load(fr);
		
		//디버깅
		System.out.println("DBHelper id -->"+prop.getProperty("id"));
		System.out.println("DBHelper pw -->"+prop.getProperty("pw"));
		
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		Connection conn =  DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop",id,pw);
		return conn;
	}
	
}
