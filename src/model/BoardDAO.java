package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	// method for accessing to DB
	public void getCon() {
		// use of connection pool
		try {
			//외부에서 데이터를 읽어와야 하기에 
			Context initctx = new InitialContext();
			//톰캣 서버 내 정보를 담아 놓은 곳으로 이
			Context envctx = (Context) initctx.lookup("java:comp/env");
			//데이터 소스 객체를 선언 
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			//데이터 소스를 이용하여 연결 
			con = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertBoard(BoardBean bean) {
		getCon();
		int ref=0;
		int re_step=1;
		int re_level=1;
		
		
		try {
			String refsql = "select max(ref) from board";
			ps = con.prepareStatement(refsql);
			rs = ps.executeQuery();
			if(rs.next()) {
				ref = rs.getInt(1) + 1;
			}
			
			String sql = "insert into board (writer, email, subject, password, reg_date, ref, re_step, re_level, readcount, content) "
					+ "values (?,?,?,?,now(),?,?,?,0,?)";
			ps = con.prepareStatement(sql);
			
			System.out.println(bean.getWriter());
			System.out.println(bean.getEmail());
			System.out.println(bean.getSubject());
			System.out.println(bean.getPassword());
			System.out.println(bean.getReg_date());
			
			ps.setString(1, bean.getWriter());
			ps.setString(2, bean.getEmail());
			ps.setString(3, bean.getSubject());
			ps.setString(4, bean.getPassword());
			ps.setInt(5, ref);
			ps.setInt(6, re_step);
			ps.setInt(7, re_level);
			ps.setString(8, bean.getContent());
			
			ps.executeUpdate();
			
			con.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Vector<BoardBean> getAllBoard(int start, int end) {
		
		Vector<BoardBean> v = new Vector<>();
		getCon();
		
		try {
//			String sql = "select * from board order by ref desc, re_step asc, re_level asc";
			
			// 10개씩 끊어져서는 나오나 순서가 안 맞음.
//			String sql = "select board.*, @rownum := @rownum + 1 as no from board where (@rownum :=0) = 0 limit ?,?";
			String sql = "select board1.*, @rownum := @rownum + 1 as no from (select * from board order by ref desc, re_level asc, re_step asc) board1 where (@rownum :=0) = 0 limit ?,?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());			
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				
				v.add(bean);
			}
			con.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return v;
		
	}
	
	public BoardBean getOneBoard(int num) {
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			String readsql = "update board set readcount = readcount+1 where num=?";
			ps = con.prepareStatement(readsql);
			ps.setInt(1, num);
			ps.executeUpdate();
			
			
			String sql = "select * from board where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());			
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			con.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	public void rewriteBoard(BoardBean bean) {
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();
		
		getCon();
		
		try {
			String levelsql = "update board set re_level = re_level + 1 where ref=? and re_level > ?";
			ps = con.prepareStatement(levelsql);
			ps.setInt(1, ref);
			ps.setInt(2, re_level);
			ps.executeUpdate();
			
			String sql = "insert into board (writer, email, subject, password, reg_date, ref, re_step, re_level, readcount, content) "
					+ "values (?,?,?,?,now(),?,?,?,0,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, bean.getWriter());
			ps.setString(2, bean.getEmail());
			ps.setString(3, bean.getSubject());
			ps.setString(4, bean.getPassword());
			ps.setInt(5, ref);
			ps.setInt(6, re_step + 1); //re_step = re_step of parent's post + 1
			ps.setInt(7, re_level + 1); //re_level = re_level of parent's post + 1
			ps.setString(8, bean.getContent());
			ps.executeUpdate();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	
	}
	
	public BoardBean getOneBoardUpdated(int num) {
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			String sql = "select * from board where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());			
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				
			}
			
			con.close();
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return bean;
	}
	
	public String getPass(int num) {
		String pwd = "";
		getCon();
		
		try {
			String sql = "select password from board where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				pwd = rs.getString(1);
			}
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return pwd;
	}
	
	public void updateBoard(BoardBean bean) {
		
		getCon();
		
		try {
			String sql = "update board set subject=?, content=? where num=?";
			System.out.println(bean.getSubject());
			ps = con.prepareStatement(sql);
			
			System.out.println(bean.getSubject());
			System.out.println(bean.getContent());
			System.out.println(bean.getNum());
			
			ps.setString(1, bean.getSubject());
			ps.setString(2, bean.getContent());
			ps.setInt(3,  bean.getNum());	
			
			ps.executeUpdate();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteBoard(int num) {
		getCon();
		
		try {
			String sql = "delete from board where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.executeUpdate();
			
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getAllCount() {
		getCon();
		int count = 0;
		
		try {
			String sql = "select count(*) from board";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
