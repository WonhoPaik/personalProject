package boardone;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jdbc.DBPoolUtil;

//싱글톤 방식 객체 생성
public class BoardDAO {
	private static BoardDAO instance = null;

	private BoardDAO() {
	}

	public static BoardDAO getInstance() {
		if (instance == null) {
			synchronized (BoardDAO.class) {
				instance = new BoardDAO();
			}
		}
		return instance;
	}

	// 입력(새로운 글 입력, 답변 글 입력)
	public boolean insertArticle(BoardVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		int num = article.getNum();
		int ref = article.getRef();
		int step = article.getStep();
		int depth = article.getDepth();
		int number = 0;
		try {
			conn = DBPoolUtil.getConnection();
			// 가장 최근 num값을 가져온다 => nvl(max(num),0)+1
			pstmt = conn.prepareStatement("select nvl(max(num),0)+1 from board");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1);
			} else {
				number = 1;
			}
			// 답변글인지 새글인지 구분
			if (num != 0) {// 답글
				step = step + 1;
				depth = depth + 1;
				String sql = "update board set step=step+1 where ref = ? and step >= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();
			} else {// 새글
				ref = number;
				step = 0;
				depth = 0;
			}
			// 글저장
			String strQuery = "insert into board(num, writer, email, subject, pass,"
					+ " regdate, ref, step, depth, content, ip)" + "	values(board_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(strQuery);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPass());
			pstmt.setTimestamp(5, article.getRegdate());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, step);
			pstmt.setInt(8, depth);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
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
			pstmt = conn.prepareStatement("select count(*) from board");
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
	public List<BoardVO> getArticles(int start, int end) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVO> articleList = null;
		try {
			conn = DBPoolUtil.getConnection();
			/* 게시판 글을 참조순으로 내림차순 처리하고, step순으로 오름차순한 정렬 가상 테이블을 만든다. 이런순으로 rownum 임의로 만든다 */
			/* 이러한 순으로 페이지 정렬 할 수 있다. 7페이지 = 61 ~ 71 (page-1)*10+1 ~ page10 */
			String sql = "select * from (select rownum rnum, num, writer, email, subject, pass,"
					+ " regdate, readcount, ref, step, depth, content, ip from (select * from board"
					+ " order by ref desc, step asc)) where rnum>=? and rnum<=?";
			pstmt = conn.prepareStatement(sql);
			// 수정 <3>
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			// 수정<4>
			articleList = new ArrayList<BoardVO>(end-start+1);
			while (rs.next()) {
				BoardVO article = new BoardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPass(rs.getString("pass"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setDepth(rs.getInt("depth"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
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
	public BoardVO getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO article = null;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("update board set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from board where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new BoardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPass(rs.getString("pass"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setDepth(rs.getInt("depth"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return article;
	}

	// 하나의 글을 가져오기 (카운트를 증가시키지않는다)
	public BoardVO updateGetArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO article = null;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select * from board where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new BoardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPass(rs.getString("pass"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setDepth(rs.getInt("depth"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return article;
	}

	// 글 수정하기
	public int updateArticle(BoardVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		String sql = "";
		int result = -1;// 데이터베이스 오류
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select pass from board where num = ?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbpasswd = rs.getString("pass");// 비밀번호 비교
				if (dbpasswd.equals(article.getPass())) {
					sql = "update board set writer=?,email=?,subject=? ,content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					pstmt.executeUpdate();
					result = 1;// 수정성공
				} else {
					result = 0;// 암호가 틀리면 수정 불가능
				}
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
		String dbpasswd = "";
		int result = -1;
		try {
			conn = DBPoolUtil.getConnection();
			pstmt = conn.prepareStatement("select pass from board where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbpasswd = rs.getString("pass");
				if (dbpasswd.equals(pass)) {
					pstmt = conn.prepareStatement("delete from board where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					result = 1; // 글삭제 성공
				} else
					result = 0; // 비밀번호 틀림
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}
}
