package controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.SimpleTimeZone;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.oreilly.servlet.MultipartRequest;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.DBConnection;
import model.Day;
import model.DayMybatisDao;
import model.Member;
import model.MemberMyBatisDao;
import model.Musical;
import model.MusicalMybatisDao;
import model.MybatisConnection;
import model.Reservation;
import model.ReservationMybatisDao;

@WebServlet(urlPatterns= {"/admin/*"}, initParams = {@WebInitParam(name="view", value="/view/")})
public class AdminController extends MskimRequestMapping{ 
	private MusicalMybatisDao dao = new MusicalMybatisDao();
	private DayMybatisDao ddao = new DayMybatisDao();
	private MemberMyBatisDao mdao = new MemberMyBatisDao();
	
	
	public String loginAdminCheck(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String login = (String)request.getSession().getAttribute("login");
		if(login == null) {
			request.setAttribute("msg","ꉂ (๑¯ਊ¯)σ  로그인이 필요한 서비스입니다.");
			request.setAttribute("url","../member/loginForm");
			return "alert";
		} else if (!login.equals("admin")) {
			request.setAttribute("msg","*관리자*만 가능합니다. (´∇ﾉ｀*)ノ");
			request.setAttribute("url","../member/main");
			return "alert";
		} 
		return null;
	}
	
	@RequestMapping("muInsertForm")
	public String muInsertForm(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		if(login == null || !login.equals("admin")) {
			request.setAttribute("msg","뮤지컬 등록 권한이 없습니다. 관리자만 가능합니다.");
			request.setAttribute("url","../member/main");
			return "alert";
		}
		return "admin/muInsertForm";
	}
	
	@MSLogin("loginAdminCheck")	
	@RequestMapping("muinsert")
	public String muinsert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String mvid = request.getParameter("vid");
		if(mvid.length()<100) {
			request.setAttribute("msg", "동영상 형식을 맞춰주세요");
			request.setAttribute("url", "muInsertForm");
			return "alert";
		}
		int idx = mvid.indexOf("https");
		int idx2 = mvid.indexOf("title");
		String mvidurl = mvid.substring(idx, idx2-2);
		Musical mu = new Musical();
		mu.setMtitle(request.getParameter("title"));
		mu.setMage(request.getParameter("age"));
		mu.setMdate(request.getParameter("date"));
		mu.setMtime(request.getParameter("time"));
		mu.setMcast(request.getParameter("cast"));
		mu.setMpd(request.getParameter("pd"));
		mu.setMpos(request.getParameter("poster"));
		mu.setMvid(mvidurl);
		
		int msno = dao.maxnum();
		
		if(msno == 0) {	
			mu.setMsno(1);
		} else {
			mu.setMsno(++msno);
		}
		if(mu.getMpos() == null) {	// 파일이 없는 경우 null이 들어가지 않게 빈 문자열로 만들어줌
			mu.setMpos("");
		}	
		if(dao.muinsert(mu)) {
			request.setAttribute("msg", "뮤지컬 정보가 등록 되었습니다.");
			request.setAttribute("url", "muListForm");
		} else {
			request.setAttribute("msg", "정보 등록 시 오류가 발생했습니다.");
			request.setAttribute("url", "muInsertForm");
		}
		
		return "alert";
	}
	
	@MSLogin("loginAdminCheck")	
	@RequestMapping("poster")
	public String poster(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("") + "/poster/";
		String pname = null;
    	File f = new File(path);
    	if(!f.exists()) { 
    		f.mkdirs();
    	}
    	MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request,path,10*1024*1024,"UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
    	pname = multi.getFilesystemName("poster"); 
		request.setAttribute("pname", pname);
    	return "admin/poster";
	}
	
	@MSLogin("loginAdminCheck")	
	@RequestMapping("muListForm")
	public String muListForm (HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		int pageNum = 1;
	    try {
		   pageNum = Integer.parseInt(request.getParameter("pageNum"));
	    } catch (NumberFormatException e) {
	    	
	    }
	    String column = request.getParameter("column");	// 검색값
	    int limit = 2;  //한페이지에 보여질 게시물 건수
	    
		// int mucount = dao.muCount(); 
	
		List<Musical> mulist = null;	// 뮤지컬 리스트
		if(column==null || column.trim().equals("")) {
			column = null;
			mulist = dao.mulist(pageNum,limit);
			request.setAttribute("list", mulist);
		}else {
			mulist = dao.selectlist(pageNum,limit,column);
			request.setAttribute("list", mulist);
		}
		int mucount = dao.muCount(column);
	    int maxpage = (int)((double)mucount/limit + 0.95);
		int startpage=((int)(pageNum/10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9; 
		if(endpage > maxpage) endpage = maxpage;
		request.setAttribute("pageNum", pageNum);	    
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("maxpage", maxpage);

		return "admin/muListForm";
	}

	@RequestMapping("deleteForm")
	public String deleteForm(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		if(login==null || !login.equals("admin")) {
			 request.setAttribute("msg", "관리자만 삭제 가능합니다.");
			 request.setAttribute("url", "muListForm");
			 return "alert";
		 }
		 return "admin/deleteForm";
	 }

	@RequestMapping("mudelete")
	public String mudelete (HttpServletRequest request, HttpServletResponse response) {
		
		int msno = Integer.parseInt(request.getParameter("msno"));
		String pass = request.getParameter("pass");
		Musical mu = dao.selectOne(msno);
		String login = (String)request.getSession().getAttribute("login");
		
		if(!login.equals("admin") || login == null) {
			request.setAttribute("msg", "관리자만 삭제 가능합니다.");
			request.setAttribute("url", "member/main");
			return "alert";
			
		} else {	//삭제 가능한 상태
			if(dao.mudelete(msno)) {
				request.setAttribute("msg", "삭제 되었습니다.");
				request.setAttribute("url", "muListForm");
			}
		}
		return "alert";
	}
	
	@MSLogin("loginAdminCheck")	
	@RequestMapping("updateForm")
	public String updateForm(HttpServletRequest request, HttpServletResponse response) {
		int msno = Integer.parseInt(request.getParameter("msno"));
		Musical mu = dao.selectOne(msno);
		request.setAttribute("mu", mu);
		return "admin/updateForm";
	}
	
	@MSLogin("loginAdminCheck")	
	@RequestMapping("muupdate")
	public String muupdate(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		int msno = Integer.parseInt(request.getParameter("msno"));
		Musical mu = new Musical();
		mu.setMsno(msno);
		mu.setMtitle(request.getParameter("title"));
		mu.setMage(request.getParameter("age"));
		mu.setMdate(request.getParameter("date"));
		mu.setMtime(request.getParameter("time"));
		mu.setMcast(request.getParameter("cast"));
		mu.setMpd(request.getParameter("pd"));
		mu.setMpos(request.getParameter("poster"));
		if(mu.getMpos()==null || mu.getMpos().equals("")) {
   			mu.setMpos(request.getParameter("poster2"));
   		}
	
		if(dao.muupdate(mu)) {
			request.setAttribute("msg", "수정되었습니다.");
			request.setAttribute("url", "muListForm");
		} else {
			request.setAttribute("msg", "수정 시 오류 발생");
			request.setAttribute("url", "updateForm?msno="+msno);
		}
		return "alert";
	}
	
	// 시간 insertForm
	@MSLogin("loginAdminCheck")	
	@RequestMapping("timeInsertForm")
	public String timeInsertForm(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("msno", request.getParameter("msno"));
		return "admin/timeInsertForm";
	}
	
	// 시간 insert
	@MSLogin("loginAdminCheck")	
	@RequestMapping("timeInsert")
	public String timeInsert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String days[] = request.getParameterValues("days");
		int msno = Integer.parseInt(request.getParameter("msno"));
		String t1[] = request.getParameterValues("timetable1");
		String t2[] = request.getParameterValues("timetable2");
		String t3[] = request.getParameterValues("timetable3");
		
		//상영일을 가져와서 상영일1에 타임테이블1~
		for(int i =0; i<days.length; i++) {
			Day d = new Day();
			d.setMsno(msno);
			d.setDmd(days[i]);
			d.setTime1(t1[i]);
			d.setTime2(t2[i]);
			d.setTime3(t3[i]);
			
			if(t2[i] == null) {
				d.setTime2("");
			} 	
			if (t3[i] == null) {
				d.setTime3("");
			}
			if(ddao.timeInsert(d)) {
				request.setAttribute("msg", "상영 회차 정보가 등록 되었습니다.");
				request.setAttribute("url", "muListForm");
			} else {
				request.setAttribute("msg", "정보 등록 시 오류가 발생했습니다.");
				request.setAttribute("url", "timeInsertForm");
			}
		}
	
		return "alert";
	}
	
	// 시간 리스트
	@MSLogin("loginAdminCheck")	
	@RequestMapping("timeListForm")
	public String timeListForm (HttpServletRequest request, HttpServletResponse response) {
		int msno = Integer.parseInt(request.getParameter("msno"));
		Musical m = dao.selectOne(msno);
		request.setAttribute("m", m);
		List<Day> timelist = ddao.timelist(msno); // model에 list 있음
		request.setAttribute("timelist", timelist);
		return "admin/timeListForm";
	}
	
	// 시간 삭제
	@RequestMapping("timedelete")
	public String timedelete (HttpServletRequest request, HttpServletResponse response) {
		int msno = Integer.parseInt(request.getParameter("msno"));
		String dmd = request.getParameter("dmd");
		Day m = ddao.selectOne(msno,dmd);
		
		String login = (String)request.getSession().getAttribute("login");
		String pass = request.getParameter("pass");
		
		if(!login.equals("admin") || login == null) {
			request.setAttribute("msg", "관리자만 삭제 가능합니다.");
			request.setAttribute("url", "member/main");
			return "alert";
			
		} else {	//삭제 가능한 상태
			if(ddao.timedelete(msno, dmd)) {
				request.setAttribute("msg", "삭제 되었습니다.");
				request.setAttribute("url", "timeListForm?msno="+msno);
			} else {
				request.setAttribute("msg", "삭제 시 오류 발생");
				request.setAttribute("url", "timeListForm?msno="+msno);
			}
		}
		return "alert";
	}
	
	@MSLogin("loginAdminCheck")	
	@RequestMapping("timeUpdateForm")
	public String timeUpdateForm(HttpServletRequest request, HttpServletResponse response) {
		int msno = Integer.parseInt(request.getParameter("msno"));
		String dmd = request.getParameter("dmd");
		Day tu = ddao.selectOne(msno, dmd);
		request.setAttribute("tu", tu);
		return "admin/timeUpdateForm";
	}
	
	// 시간 수정
	@MSLogin("loginAdminCheck")	
	@RequestMapping("timeupdate")
	public String timeupdate (HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		int msno = Integer.parseInt(request.getParameter("msno"));
		String md = request.getParameter("dmd");
		Day d = new Day();
		d.setMsno(msno);
		d.setDmd(request.getParameter("days"));
		d.setTime1(request.getParameter("timetable1"));
		d.setTime2(request.getParameter("timetable2"));
		d.setTime3(request.getParameter("timetable3"));
		
		
		if(d.getTime2()==null || d.getTime2().equals("")) {
   			d.setTime2("");
   		}
		if(d.getTime3()==null || d.getTime3().equals("")) {
   			d.setTime3("");
   		}
		if(ddao.timeupdate(md, d)) {
			request.setAttribute("msg", "수정되었습니다.");
			request.setAttribute("url", "muListForm");
		} else {
			request.setAttribute("msg", "수정 시 오류 발생");
			request.setAttribute("url", "timeListForm?msno="+msno);
		}
		return "alert";
	}
	
	// 멤버 리스트
	@MSLogin("loginAdminCheck")	
	@RequestMapping("memListForm")
    public String memListForm(HttpServletRequest request, HttpServletResponse response) {
	    try {
	       request.setCharacterEncoding("UTF-8");
	    } catch (UnsupportedEncodingException e1) {
	       e1.printStackTrace();
	    }
	    int pageNum = 1;	//pageNum 초기값
	    try {
	       pageNum = Integer.parseInt(request.getParameter("pageNum"));	//파라미터로 pageNum 받아와서
	    } catch (NumberFormatException e) {
	    	 
	    }
	    String column = request.getParameter("column");	// 검색값
	    
	    int limit = 5; // 최대 5
	    
	    List<Member> list = null;	// 멤버리스트 
	    if(column==null || column.trim().equals("")) {	// 검색값이 null, 빈값
	    	column= null;
	    	list = mdao.list(pageNum,limit);
	    	request.setAttribute("list", list);
	    }else {											// 검색값이 있으면
	       list = mdao.slist(pageNum,limit,column);		// list  검색값
	       request.setAttribute("list", list);			// list 넣어서 보여주는
	    }
	    System.out.println(list);
	    int memcount = mdao.memCount(column);			// 컬럼값에 맞는 멤버 count
	    int maxpage = (int)((double)memcount/limit + 0.95);	
	     
	    int startpage=((int)(pageNum/10.0 + 0.9) - 1) * 10 + 1;
	    int endpage = startpage + 9; 
	    if(endpage > maxpage) endpage = maxpage;
	    request.setAttribute("pageNum", pageNum);       
	    request.setAttribute("startpage", startpage);
	    request.setAttribute("endpage", endpage);
	    request.setAttribute("maxpage", maxpage);
	    return "admin/memListForm";
	 }
	private ReservationMybatisDao rdao = new ReservationMybatisDao();
	@MSLogin("loginAdminCheck")   
	   @RequestMapping("muReserListForm")
	    public String muReserListForm(HttpServletRequest request, HttpServletResponse response) {
	      List<Reservation> rlist = rdao.reserlist(); // model에 list 있음
	      request.setAttribute("rlist", rlist);
	       return "admin/muReserListForm";
	    }
	   @RequestMapping("delete")
	    public String delete(HttpServletRequest request,
	          HttpServletResponse response) {
	          int rno = Integer.parseInt(request.getParameter("rno"));
	       String id = request.getParameter("id");
	       String msg ="";
	       String url ="";
	       
	       if(rdao.delete(rno,id)) {
	         msg = "예매내역 삭제 성공@@@";
	         url ="muReserListForm";
	      }else {
	         msg = "예매내역 삭제 실패!!!!";
	         url ="muReserListForm";
	      }
	      request.setAttribute("msg", msg);
	      request.setAttribute("url", url);
	      return "alert";
	 }
}
