package boardone;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jdbc.DBPoolUtil;

//싱글톤 방식 객체 생성
public class NoticeDAO {
	private static NoticeDAO instance = null;

	private NoticeDAO() {
	}

	public static NoticeDAO getInstance() {
		if (instance == null) {
			synchronized (NoticeDAO.class) {
				instance = new NoticeDAO();
			}
		}
		return instance;
	}

	// 입력(새로운 글 입력, 답변 글 입력)
	public boolean insertArticle(NoticeVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			conn = DBPoolUtil.getConnection();
			// 글저장
			String strQuery = "insert into notice(num, subject, regdate, content)"
					+ "	values(notice_seq.nextval,?,?,?)";
			pstmt = conn.prepareStatement(strQuery);
			pstmt.setString(1, article.getSubject());
			pstmt.setTimestamp(2, article.getRegdate());
			pstmt.setString(3, article.getContent());
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

	// 전체글 갯수 가져오기
	public int getArticleCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return x;

	}

	// 전체글을 가져오기
	public List<NoticeVO> getArticles(int start, int end) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeVO> articleList = null;
		try {
			conn = DBPoolUtil.getConnection();
			/* 게시판 글을 참조순으로 내림차순 처리하고, step순으로 오름차순한 정렬 가상 테이블을 만든다. 이런순으로 rownum 임의로 만든다 */
			/* 이러한 순으로 페이지 정렬 할 수 있다. 7페이지 = 61 ~ 71 (page-1)*10+1 ~ page10 */
			String sql = "select * from notice where rnum>=? and rnum<=?";
			pstmt = conn.prepareStatement(sql);
			// 수정 <3>
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			// 수정<4>
			articleList = new ArrayList<NoticeVO>(end - start + 1);
			while (rs.next()) {
				NoticeVO article = new NoticeVO();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
				articleList.add(article);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return articleList;
	}

	// 하나의 글을 가져오기 (카운트를 1 증가 시킨다)
	public NoticeVO getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeVO article = null;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("update notice set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from notice where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new NoticeVO();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return article;
	}

	// 하나의 글을 가져오기 (카운트를 증가시키지않는다)
	public NoticeVO updateGetArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeVO article = null;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select * from notice where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new NoticeVO();
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return article;
	}

	// 글 수정하기
	public int updateArticle(NoticeVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int result = -1;// 데이터베이스 오류
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select * from notice where num = ?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "update notice set subject=? ,content=? where num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getSubject());
				pstmt.setString(2, article.getContent());
				pstmt.setInt(3, article.getNum());
				pstmt.executeUpdate();
				result = 1;// 수정성공
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}

	// 글 삭제하기 (원글을 삭제할때에는 답변글 모두를 삭제해야된다.)
	public int deleteArticle(int num, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select * from notice where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pstmt = conn.prepareStatement("delete from notice where num=?");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				result = 1; // 글삭제 성공
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}
}