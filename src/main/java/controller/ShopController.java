package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import model.dao.CookieManager;
import model.dao.DAOShop;
import model.dto.DTOPage;
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
		if (command.equals("/SMain.pn")) {//shop메인			
			productAdminOrdercnt(req,6,"orderCnt desc");
			productAdminRegdate(req,6,"regDate desc");
			productAdminSale(req,6,"sale desc");
			getlastCookie(req);
			RequestDispatcher rd = req.getRequestDispatcher("/shop/SMain.jsp");
			rd.forward(req, resp);
		}else if (command.equals("/cart.pn")) {//cart 메인
			RequestDispatcher rd = req.getRequestDispatcher("/shop/cartMain.jsp");
			rd.forward(req, resp);
		}else if (command.equals("/order.pn")) {//order 메인
			RequestDispatcher rd = req.getRequestDispatcher("/shop/order.jsp");
			rd.forward(req, resp);
		}else if (command.equals("/Product.pn")) {//상품등록			
			RequestDispatcher rd = req.getRequestDispatcher("/shop/ShopAdmin/view/productInsert.jsp");
			rd.forward(req, resp);
		}else if(command.equals("/insertProduct.pn")) {//상품업로드 process
			System.out.println("상품 업로드");			
			insertProduct(req,resp);
			resp.sendRedirect("/productView.pn");
		}else if(command.equals("/productView.pn")) {//특정상품 보기		
			HttpSession session = req.getSession();
			addcookie(req,resp);
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
			productAdmin(req,10);
			RequestDispatcher rd = req.getRequestDispatcher("/shop/ShopAdmin/view/shopadminmain2.jsp");
			rd.forward(req, resp);			
		}else if(command.equals("/Productadmin.pn")) {//shopAdmin 상품관리
			productAdmin(req,2);
			RequestDispatcher rd = req.getRequestDispatcher("/shop/ShopAdmin/view/productList.jsp");
			rd.forward(req, resp);			
		}else if(command.equals("/AdminProductDelete.pn")) {//adminShop 상품삭제			
			deleteProducts(req);
			resp.sendRedirect("/Productadmin.pn");			
		}else if(command.equals("/ShopPage.pn")) {//shopPage main		
			shopPageLisgt(req);
			RequestDispatcher rd = req.getRequestDispatcher("/shop/shopPage.jsp");
			rd.forward(req, resp);	
		}
		else if(command.equals("/viewed.pn")) {//shopPage main		
			cookieview(req);
			RequestDispatcher rd = req.getRequestDispatcher("/shop/viewedProduct.jsp");
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
		s.setId((String)session.getAttribute("nicname"));
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
		/*for(DTOShop l : s) {
			System.out.println("상품:"+l.getpName()+"가격:"+l.getSum());
		}*/
		req.setAttribute("Chart", s);		
	}
	//상품관리 메인
	public void productAdmin(HttpServletRequest req,int amount) {
		DAOShop DAO = DAOShop.getInstence();
		ArrayList<DTOShop> pl =DAO.productAdminlist(req,Calp(req,getp(req),getshopAdminTotal(req),amount));
		req.setAttribute("productlist", pl);
	}
	//shop메인 판매량 순(인기순)
	public void productAdminOrdercnt(HttpServletRequest req,int amount,String ob) {
		DAOShop DAO = DAOShop.getInstence();
		ArrayList<DTOShop> plC =DAO.productAdminlist(req,Calp(req,getp(req),getshopAdminTotal(req),amount),ob);		
		req.setAttribute("plOrdercnt", plC);
	}
	//shop메인 (신상품) 순
	public void productAdminRegdate(HttpServletRequest req,int amount,String ob) {
		DAOShop DAO = DAOShop.getInstence();
		ArrayList<DTOShop> plD =DAO.productAdminlist(req,Calp(req,getp(req),getshopAdminTotal(req),amount),ob);
		req.setAttribute("plregDate", plD);
	}
	//shop메인 (세일) 순
	public void productAdminSale(HttpServletRequest req,int amount,String ob) {
		DAOShop DAO = DAOShop.getInstence();
		ArrayList<DTOShop> plS =DAO.productAdminlist(req,Calp(req,getp(req),getshopAdminTotal(req),amount),ob);
		req.setAttribute("plSale", plS);
	}
	//페이지 parameter
	public Integer getp(HttpServletRequest req) {
		int p = 1;
		try {
			String reqP = req.getParameter("p");
			//System.out.println("reqP:"+reqP);
			if(reqP==null) {
				p=1;
			}else {
				p=Integer.parseInt(reqP);
			}
			//System.out.println("Page_num:"+p);
			return p;
		}catch (Exception e) {
			System.out.println("쿼리 P 오류");
			e.printStackTrace();
		}		
		return null;
	}
	//shop관리자 상품리스트 전체 cnt
	public Integer getshopAdminTotal(HttpServletRequest req) {
		DAOShop dao = DAOShop.getInstence();				
		return dao.getshopAdminTotal(req);		
	}
	//페이지 서비스
	public ArrayList<DTOPage> Calp(HttpServletRequest req,int p,int total,int Amount) {
		
		ArrayList<DTOPage> page = new ArrayList<DTOPage>();
		DTOPage dtop =new DTOPage(p,total,Amount);	
		page.add(dtop);
		req.setAttribute("page", page);				
		return page;		
	}
	public void deleteProducts(HttpServletRequest req) {
		DAOShop dao = DAOShop.getInstence();
		dao.deleteProducts(req);
	}
	//ShopPage
	public void shopPageLisgt(HttpServletRequest req) {
		DAOShop dao = DAOShop.getInstence();
		System.out.println(req.getParameter("owner"));
		req.setAttribute("SList", dao.shopPageList(req)); 		
	}
	//최근 본 상품
	public void cookieview(HttpServletRequest req) {
		System.out.println("viewed page");
		DAOShop dao = new DAOShop();
		Cookie[] co = req.getCookies();
		ArrayList<DTOShop> list = new ArrayList<DTOShop>();
		for(int i=0;i<co.length;i++) {
			String value = co[i].getValue();
			//System.out.println("cookies Value:"+value);
			list.add(dao.cookieview(req,value));			
		}
		//for(DTOShop d :list) {
		//	System.out.println("cookies pname:"+d.getpName());
		//}
		req.setAttribute("cookies", list);		
	}	
	public void getlastCookie(HttpServletRequest req) {
		DAOShop dao = new DAOShop();	
		DTOShop d =  dao.cookie(req);
		if(d==null) {
			req.setAttribute("cookieNmae", "상품이 없습니다....");
		}else {
			req.setAttribute("cookieNmae", d.getpName());
			req.setAttribute("cookieimg", d.getpImg());		
		}			
	}
	//최근 본 상품 추가(쿠키)
	public void addcookie(HttpServletRequest req,HttpServletResponse resp) {
		int i = 0;
		while(true) {
			CookieManager co = new CookieManager();
			if(co.getCookieName(req, "pid"+i)!=null){//등록쿠키 확인)					
				co.getCookieValue(req, "pid"+i);
				i++;
			}else {
				co.setCookie(req, resp, "pid"+i, Querypid(req));//쿠키등록
				System.out.println("-------------------쿠키등록---------------------");
				co.getCookieName(req, "pid"+i);
				co.getCookieValue(req, "pid"+i);
				break;
			}				
		}
	}
	
}

