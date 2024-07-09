package membertwo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.DBPoolUtil;

public class CustomerDAO {
	public boolean idCheck(String id) {
		boolean result = true;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select * from register where userid = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (!rs.next())
				result = false;
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}

	public boolean memberInsert(CustomerVO vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			conn = DBPoolUtil.getConnection();
			String strQuery = "insert into register values(reg_seq.nextval, ?, ?, ?, ?, ?, 'Y', ?, ?, ?, ?,sysdate)";
			pstmt = conn.prepareStatement(strQuery);
			pstmt.setString(1, vo.getUserId());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getUserName());
			pstmt.setString(4, vo.getEmail());
			pstmt.setString(5, vo.getDomain());
			// pstmt.setString(6, getMail);
			pstmt.setInt(6, vo.getPostal());
			pstmt.setString(7, vo.getAddress1());
			pstmt.setString(8, vo.getAddress2());
			pstmt.setString(9, vo.getPhone());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return flag;
	}

	public int loginCheck(String id, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			conn = DBPoolUtil.getConnection();
			String strQuery = "select pwd from register where userid = ?";
			pstmt = conn.prepareStatement(strQuery);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbPass = rs.getString("pwd");
				if (pass.equals(dbPass))
					check = 1;
				else
					check = 0;
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return check;
	}

	public CustomerVO getMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CustomerVO vo = null;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select * from register where userid = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {// 해당 아이디에 대한 회원이 존재
				vo = new CustomerVO();
				vo.setUserId(rs.getString("userId"));
				vo.setPwd(rs.getString("pwd"));
				vo.setUserName(rs.getString("userName"));
				vo.setEmail(rs.getString("email"));
				vo.setDomain(rs.getString("domain"));
				vo.setGetMail(rs.getString("getMail"));
				vo.setPostal(rs.getInt("postal"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("Address2"));
				vo.setPhone(rs.getString("phone"));
				vo.setRegDate(rs.getString("regDate"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return vo;
	}

	public void updateMember(CustomerVO vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement(
					"update register set pwd=?, email=?, domain=?, postal=?, address1=?, address2=?, phone = ?where userid=?");
			pstmt.setString(1, vo.getPwd());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getDomain());
			pstmt.setInt(4, vo.getPostal());
			pstmt.setString(5, vo.getAddress1());
			pstmt.setString(6, vo.getAddress2());
			pstmt.setString(7, vo.getPhone());
			pstmt.setString(8, vo.getUserId());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(pstmt, conn);
		}
	}

	public int deleteMember(String id, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPass = "";// 데이터베이스에 실제 저장된 패스워드
		int result = -1;// 결과치
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select pwd from register where userId = ? ");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbPass = rs.getString("pwd");
				if (dbPass.equals(pass)) {// true - 본인 확인
					pstmt = conn.prepareStatement("delete from register where userId = ?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					result = 1;// 회원탈퇴 성공
				} else { // 본인확인 실패 - 비밀번호 오류
					result = 0;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}
}
