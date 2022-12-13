package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import database.DBConnection;

public class TextSearchDB {
	
	public void TextSearchdb(HttpServletRequest req) {		
		String search =req.getParameter("search");
		Connection con=null;
		String sql=null;
		PreparedStatement pstmt=null;
		try {
			con= DBConnection.getconn();
			sql="insert into search(text,id,ip) values(?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, getId(req));
			pstmt.setString(3, getClientIP(req));
			pstmt.executeUpdate();
			System.out.println("searchDB:"+search);
		}catch (Exception e) {
			System.out.println("검색어 등록");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch (Exception e) {

			}
		}
		
	}
	static String getId(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = null;
		try {
				id=(String)session.getAttribute("id");
			if(id==null) {
				id="noId";
			}else {
				id=(String)session.getAttribute("id");
			}			
		}catch (Exception e) {

		}		
		return id;	
	}
	
	public static String getClientIP(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");    
	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");	    
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");	    
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");	    
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");	    
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();	    
	    } 
	    System.out.println(ip);
	    return ip;
	}	
}