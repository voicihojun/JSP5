package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
