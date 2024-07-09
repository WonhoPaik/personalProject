package jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBPoolUtil {
	public static Connection getConnection() {
		ConnectionPool pool = ConnectionPool.getInstance();
		// 데이타베이스 오라클 객체참조변수
		Connection con = null;
		try {
			con = pool.getConnection();
			System.out.println("데이타베이스 접속 성공");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("데이타베이스 연결 실패");
		}
		return con;
	}

	public static void dbReleaseClose(ResultSet rs, Statement stmt, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException ex) {}
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException ex) {}
		try {
			if (conn != null) {
				ConnectionPool pool = ConnectionPool.getInstance();
				pool.releaseConnection(conn);
			}
		} catch (SQLException ex) {}
	}
	public static void dbReleaseClose(Statement stmt, Connection conn) {
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException ex) {}
		try {
			if (conn != null) {
				ConnectionPool pool = ConnectionPool.getInstance();
				pool.releaseConnection(conn);
			}
		} catch (SQLException ex) {}
	}
}
