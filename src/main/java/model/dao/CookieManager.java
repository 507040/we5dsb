package model.dao;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager {	

	//쿠키 생성하기
	public void setCookie(HttpServletRequest req,HttpServletResponse resp,String coId,String value){
	    Cookie cookie = new Cookie(coId, value); // 쿠키 이름 지정하여 생성( key, value 개념)
	    cookie.setMaxAge(60*60*12); //쿠키 유효 기간: 하루로 설정(60초 * 60분 * 24시간)
	    cookie.setPath("/"); //모든 경로에서 접근 가능하도록 설정
	    resp.addCookie(cookie); //response에 Cookie 추가
	}
	//쿠키이름 가져오기
	public String getCookieName(HttpServletRequest req,String coId){
	    Cookie[] cookies=req.getCookies(); // 모든 쿠키 가져오기
	    if(cookies!=null){
	        for (Cookie c : cookies) {
	            String name = c.getName(); // 쿠키 이름 가져오기	            
	            if (name.equals(coId)) {	                
	                System.out.println("CookieName:"+name);
	                return name;
                }
	        }
	    }
	    return null;
	}
	//쿠키값 가져오기
	public String getCookieValue(HttpServletRequest req,String coId){
	    Cookie[] cookies=req.getCookies(); // 모든 쿠키 가져오기
	    if(cookies!=null){
	        for (Cookie c : cookies) {	            
	        	String name = c.getName(); // 쿠키 이름 가져오기	        
	            String value = c.getValue(); // 쿠키 값 가져오기
	            if (name.equals(coId)) {	                
	                System.out.println("CookieValue:"+value);
	                return value;
                }
	        }
	    }
	    return null;
	}
	//특정 쿠키 제거
	public void deleteCookie(HttpServletRequest req,HttpServletResponse resp,String coId){
	    Cookie cookie = new Cookie(coId, null); // 삭제할 쿠키에 대한 값을 null로 지정
	    cookie.setMaxAge(0); // 유효시간을 0으로 설정해서 바로 만료시킨다.
	    resp.addCookie(cookie); // 응답에 추가해서 없어지도록 함
	}
	//모든 쿠키 제거
	public void deleteAllCookies(HttpServletRequest req,HttpServletResponse resp) {
	    Cookie[] cookies = req.getCookies(); // 모든 쿠키의 정보를 cookies에 저장
	    if (cookies != null) { // 쿠키가 한개라도 있으면 실행
	        for (int i = 0; i < cookies.length; i++) {
	            cookies[i].setMaxAge(0); // 유효시간을 0으로 설정
	            resp.addCookie(cookies[i]); // 응답에 추가하여 만료시키기.
	        }
	    }
	}

}
