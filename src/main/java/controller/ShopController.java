package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.DAOShop;
import model.dto.DTOShop;

public class ShopController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	
		String RequestURI = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		resp.setContentType("text/html; charset=utf-8");
		//서블릿 호출 명령
		//블로그메인
		if (command.equals("/SMain.pn")) {//shop메인
			RequestDispatcher rd = req.getRequestDispatcher("/shop/SMain.jsp");
			rd.forward(req, resp);
		}else if (command.equals("/cart.pn")) {//cart 메인
			RequestDispatcher rd = req.getRequestDispatcher("/shop/cartMain.jsp");
			rd.forward(req, resp);
		}else if (command.equals("/order.pn")) {//order 메인
			RequestDispatcher rd = req.getRequestDispatcher("/shop/order.jsp");
			rd.forward(req, resp);
		}else if (command.equals("/Product.pn")) {//상품등록 메인			
			RequestDispatcher rd = req.getRequestDispatcher("/shop/ShopAdmin/view/productInsert.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/insertProduct.pn")) {
			System.out.println("상품 업로드");			
			insertProduct(req,resp);
			resp.sendRedirect("/productView.pn");
		}else if(command.equals("/productView.pn")) {//특정상품 보기
			System.out.println("상품보기");		
			productView(req,Querypid(req));			
			RequestDispatcher rd = req.getRequestDispatcher("/shop/productView.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/productUpdate.pn")) {//상품 업데이트
			productView(req,Querypid(req));
			RequestDispatcher rd = req.getRequestDispatcher("/shop/ShopAdmin/view/productUpdate.jsp");
			rd.forward(req, resp);			
		}else if(command.equals("/ShopadminPage.pn")) {//상품관리자 메인
			getchart(req);
			RequestDispatcher rd = req.getRequestDispatcher("/shop/ShopAdmin/view/shopadminmain.jsp");
			rd.forward(req, resp);			
		}else if(command.equals("/Productadmin.pn")) {
			productAdmin(req);
			RequestDispatcher rd = req.getRequestDispatcher("/shop/ShopAdmin/view/productList.jsp");
			rd.forward(req, resp);	
			
		}
		
	}
	public String Querypid(HttpServletRequest req) {
		HttpSession session = req.getSession(true);		
		String pid = null;		
		try {
			pid = req.getParameter("pid");
			if(pid==null) {				
				pid = (String)session.getAttribute("pid");				
			}			
		}catch (Exception e) {
			System.out.println("getquery 오류");
			e.printStackTrace();
		}
		System.out.println("pid:"+pid);
		return pid;	
	}
	//product insert
	public void insertProduct(HttpServletRequest req,HttpServletResponse resp){
		
		HttpSession session = req.getSession();
		System.out.println("level:"+session.getAttribute("level"));
		int level = Integer.parseInt((String) session.getAttribute("level"));
		if(session.getAttribute("id")==null) {
			System.out.println("<script>");
			System.out.println("alert('로그인 후 이용하세요');");
			System.out.println("history.back();");
			System.out.println("</script>");
			System.out.println("권한이 없습니다(id)");
			return;
		}
		if(level<9) {
			System.out.println("권한이 없습니다(level)");
			System.out.println("<script>");
			System.out.println("alert('권한이 없습니다');");
			System.out.println("history.back();");
			System.out.println("</script>");			
			return;
		}
		
		
		DAOShop dao = DAOShop.getInstence();
		String category = req.getParameter("category");
		String pName=req.getParameter("Pname");
		SimpleDateFormat pid1 = new SimpleDateFormat("yyyyMMddHHmmss");
		Date pday = new Date();
		String PidDay=pid1.format(pday);
		String pid=PidDay+category+pName;		
		System.out.println("insertProduct-pid:"+pid);
		int price = Integer.parseInt(req.getParameter("price"));		
		System.out.println(price);
		
		String file= req.getParameter("file");		
		String img = PidDay+file;
		System.out.println("changeImg:"+img);
		
		DTOShop s = new DTOShop();
		s.setId((String)session.getAttribute("id"));
		s.setpId(pid);
		s.setpName(pName);
		s.setpContent(req.getParameter("content"));
		s.setpImg(img);
		s.setpPrice(price);
		s.setCategory(category);
		s.setpInStork(Integer.parseInt(req.getParameter("instork")));
		s.setSale(0);
		dao.insertProduct(s);
		System.out.println("insertProduct pid:"+pid);
		session.setAttribute("pid", pid);		
	}
	
	//특정상품 보기
	public void productView(HttpServletRequest req,String pid) {
		DAOShop DAO = DAOShop.getInstence();
		ArrayList<DTOShop> Pview = DAO.viewProduct(req,pid);		
		req.setAttribute("Pview", Pview);		
	}
	
	//상품관리 메인 차트 값
	public void getchart(HttpServletRequest req) {
		DAOShop DAO = DAOShop.getInstence();
		ArrayList<DTOShop> s = DAO.getchart(req);
		for(DTOShop l : s) {
			System.out.println("상품:"+l.getpName()+"가격:"+l.getSum());
		}
		req.setAttribute("Chart", s);		
	}
	//상품관리 메인
	public void productAdmin(HttpServletRequest req) {
		DAOShop DAO = DAOShop.getInstence();
		ArrayList<DTOShop> pl =DAO.productAdminlist(req);
		req.setAttribute("productlist", pl);
	}
}

