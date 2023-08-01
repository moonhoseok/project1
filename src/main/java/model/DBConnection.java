package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnection {
	private DBConnection() {}
	static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection
			("jdbc:mariadb://14.36.141.71:20000/gdudb5","gdu5","5555");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	} //getConnection 메서드 종료
	static void close(Connection conn, Statement stmt,ResultSet rs) {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	} //close 메서드 종료
} //class 종료