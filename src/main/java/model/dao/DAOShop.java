package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.mysql.cj.x.protobuf.MysqlxCrud.Update;

import controller.LoggableStatement;
import database.DBConnection;
import model.dto.DTOPage;
import model.dto.DTOShop;

public class DAOShop {
	
	public static DAOShop instence;
	
	public DAOShop() {};
	
	public static DAOShop getInstence() {
		
		if(instence==null) {
			instence = new DAOShop();
		}
		return instence;
	}
	//상품등록
	public void insertProduct(DTOShop d) {
		PreparedStatement pstmt =null;
		Connection con = null;
		String sql = null;
		try {
			con = DBConnection.getconn();
			sql="insert into product(pID,id,pName,pPrice,sale,pInStrok,pContent,category,pImg) values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, d.getpId());
			pstmt.setString(2, d.getId());
			pstmt.setString(3, d.getpName());
			pstmt.setInt(4, d.getpPrice());
			pstmt.setInt(5, d.getSale());
			pstmt.setInt(6, d.getpInStork());
			pstmt.setString(7, d.getpContent());
			pstmt.setString(8, d.getCategory());
			pstmt.setString(9, d.getpImg());
			pstmt.executeUpdate();
			System.out.println("상품등록 성공 : "+d.getpId());
		}catch (Exception e) {
			System.out.println("상품등록 오류");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();
			}catch (Exception e) {
				
			}
		}
	}
	//특정상품 불러오기
	public ArrayList<DTOShop> viewProduct(HttpServletRequest req,String pid){
		PreparedStatement pstmt =null;
		Connection con = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<DTOShop> product = new ArrayList<DTOShop>();
		DTOShop d = new DTOShop();
		try {
		
			con = DBConnection.getconn();
			sql="select * from product where pID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pid);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				d.setpId(rs.getString("pID"));
				d.setpName(rs.getString("pName"));
				d.setpPrice(rs.getInt("pPrice"));
				d.setSale(rs.getInt("sale"));
				d.setId(rs.getString("id"));
				d.setpInStork(rs.getInt("pInStrok"));
				d.setpContent(rs.getString("pContent"));
				d.setOrderCnt(rs.getInt("orderCnt"));
				d.setCategory(rs.getString("category"));
				d.setRegDate(rs.getTimestamp("regDate"));
				d.setpImg(rs.getString("pImg"));
				System.out.println("img : "+rs.getString("pImg"));
				System.out.println("Pid : "+rs.getString("pID"));
				product.add(d);
			}
			System.out.println("viewProduct 성공");
			return product;
		}catch (Exception e) {
			System.out.println("viewProduct 오류");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();
				if(rs!=null)pstmt.close();
			}catch (Exception e) {
				
			}
		}
		return null;
	}
	//차트 값 불러오기
	public ArrayList<DTOShop> getchart(HttpServletRequest req) {
		HttpSession session = req.getSession();
		PreparedStatement pstmt =null;
		Connection con = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<DTOShop> chart = new ArrayList<DTOShop>();
		
		try {
			con=DBConnection.getconn();
			sql="select pName as pName, orderCnt*pPrice as sum from product where id=? order by sum desc limit 10";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, (String)session.getAttribute("id"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				DTOShop d = new DTOShop();
				d.setpName(rs.getString(1));
				System.out.println(d.getpName());
				//d.setSum(rs.getInt(2));
				//System.out.println(d.getSum());
				chart.add(d);				
			}			
			return chart;
		}catch (Exception e) {
			System.out.println("차트 불러오기 오류");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();
				if(rs!=null)pstmt.close();
			}catch (Exception e) {
				
			}
		}
		return null;
	}
	
	public String getProductImg(HttpServletRequest req) {
		PreparedStatement pstmt =null;
		Connection con = null;
		ResultSet rs=null;
		String sql = null;	
		String img = null;		
		try {
			con=DBConnection.getconn();
			sql="select*form product where pID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,req.getParameter("pid"));
			rs=pstmt.executeQuery();
			if(rs.next()) {
				img = rs.getString("pImg");
			}			
			System.out.println("img:"+img);
			return img;			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();
				if(rs!=null)pstmt.close();
			}catch (Exception e) {
				
			}
		}
		return null;
		
	}
	//상품리스트 불러오기
	public ArrayList<DTOShop> productAdminlist(HttpServletRequest req,ArrayList<DTOPage> page) {
		HttpSession session=req.getSession();
		String id = (String)session.getAttribute("nicname");
		PreparedStatement pstmt =null;
		Connection con = null;
		String sql = null;
		ResultSet rs = null;
		String ob = getOrderby(req);
		System.out.println("obResult:"+ob);
		int limitStatr=0;
		int limitEnd=0;
		for(DTOPage p : page) {
			limitEnd= p.getOffset();
			limitStatr = p.getLimit();			
		}
		System.out.println("limitStart:"+limitStatr);
		System.out.println("limitEnd:"+limitEnd);
		
		ArrayList<DTOShop> list = new ArrayList<DTOShop>();		
		try {
			con = DBConnection.getconn();
			sql ="select * from product where id = ? order by ? limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, ob);
			pstmt.setInt(3, limitStatr);
			pstmt.setInt(4, limitEnd);			
			rs=pstmt.executeQuery();
			int i =0;
			while(rs.next()) {
				DTOShop d = new DTOShop();
				d.setpId(rs.getString("pID"));
				d.setpName(rs.getString("pName"));
				d.setpPrice(rs.getInt("pPrice"));
				d.setOrderCnt(rs.getInt("orderCnt"));
				d.setSum(rs.getInt("orderCnt"), rs.getInt("pPrice"));			
				//System.out.println("총액:"+d.getSum()); 
				i++;
				list.add(d);
			}
			System.out.println("total:"+i);
			System.out.println(id);
			
			System.out.println("상품리스트 불러오기");
			return list;
		}catch (Exception e) {
			System.out.println("상품리스트 불러오기 오류");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();
				if(rs!=null)pstmt.close();
			}catch (Exception e) {
				
			}
		}
		return null;	
	}
	//상품리스트 불러오기 admin shop main
	public ArrayList<DTOShop> productAdminlist(HttpServletRequest req,ArrayList<DTOPage> page,String ob) {
		HttpSession session=req.getSession();
		String id = (String)session.getAttribute("nicname");
		PreparedStatement pstmt =null;
		Connection con = null;
		String sql = null;
		ResultSet rs = null;		
		int limitStatr=0;
		int limitEnd=0;
		for(DTOPage p : page) {
			limitEnd= p.getOffset();
			limitStatr = p.getLimit();			
		}
		//System.out.println("limitStart:"+limitStatr);
		//System.out.println("limitEnd:"+limitEnd);
		System.out.println("orderby:"+ob);				
		try {
			ArrayList<DTOShop> list = new ArrayList<DTOShop>();
			con = DBConnection.getconn();
			sql ="select * from product where id = ? order by "+ob+" limit ?,?";
			pstmt = new LoggableStatement(con,sql);
			pstmt.setString(1, id);		
			pstmt.setInt(2, limitStatr);
			pstmt.setInt(3, limitEnd);			
			rs=pstmt.executeQuery();
			System.out.println("Executing query: "+((LoggableStatement)pstmt).getQueryString());
			int i =0;
			while(rs.next()) {
				DTOShop d = new DTOShop();
				d.setpId(rs.getString("pID"));
				d.setpName(rs.getString("pName"));
				d.setpPrice(rs.getInt("pPrice"));
				d.setOrderCnt(rs.getInt("orderCnt"));
				d.setpImg(rs.getString("pImg"));	
				d.setSale(rs.getInt("sale"));
				d.setpContent(rs.getString("pContent"));
				if(d.getSale()!=0) {
					d.setRePrice(d.getpPrice(), d.getSale());
				}
				i++;
				list.add(d);
				System.out.println(d.getpId());
			}
			System.out.println("total:"+i);
			//System.out.println(id);
			
			System.out.println("상품리스트 불러오기");
			System.out.println("----------------------------------");
			return list;
		}catch (Exception e) {
			System.out.println("상품리스트 불러오기 오류");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();
				if(rs!=null)pstmt.close();
			}catch (Exception e) {
				
			}
		}
		return null;	
	}
	//shopAdminProduct cnt
	public Integer getshopAdminTotal(HttpServletRequest req) {
		HttpSession session=req.getSession();
		Connection con=null;
        PreparedStatement pstmt=null;
        String sql;
        ResultSet rs =null;
        try {
        	con = DBConnection.getconn();
        	sql="select count(*) from product where id=?";
        	pstmt=con.prepareStatement(sql);
        	pstmt.setString(1, (String)session.getAttribute("nicname"));
        	rs=pstmt.executeQuery();
        	while(rs.next()) {
        		System.out.println("전체 글:"+rs.getInt(1));
        		return rs.getInt(1);        		
        	}       	
        }catch (Exception e) {
				System.out.println("porductList get error");
				e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();
				if(rs!=null)pstmt.close();
			}catch (Exception e) {
				
			}
		}
		return null;
	}
	//admin 상품삭제
	public void deleteProducts(HttpServletRequest req) {
		String[] checkbox = req.getParameterValues("check");
		Connection con = null;
		PreparedStatement pstmt= null;
		String sql = null;
		try {
			con=DBConnection.getconn();
			sql="delete from product where pID=?";			
			for(String c : checkbox) {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, c);
				pstmt.executeUpdate();


				System.out.println("delete pID:"+c);
			}			
		}catch (Exception e) {
			System.out.println("admin product delete error");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)pstmt.close();			
			}catch (Exception e) {
				
			}			
		}		
	}
	
	public static String getOrderby(HttpServletRequest req) {
		String ob = null;
		try {
			ob = req.getParameter("ob");			
			if(ob==null) {
				ob = "orderCnt";
			}else {
				ob = req.getParameter("ob");
			}
			
		}catch (Exception e) {
			// TODO: handle exception
		}
				
		return ob;
	}
	

}
 