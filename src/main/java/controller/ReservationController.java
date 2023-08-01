package controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.Comment;
import model.CommentMybatisDao;
import model.Day;
import model.DayMybatisDao;
import model.Member;
import model.MemberMyBatisDao;
import model.Reservation;
import model.ReservationMybatisDao;

@WebServlet(urlPatterns= {"/reservation/*"}, initParams = {@WebInitParam(name="view", value="/view/")})
public class ReservationController extends MskimRequestMapping{
	private MemberMyBatisDao dao = new MemberMyBatisDao();
	private CommentMybatisDao cdao = new CommentMybatisDao();
	private DayMybatisDao ddao = new DayMybatisDao();
	ReservationMybatisDao rdao = new ReservationMybatisDao();

	@RequestMapping("reserInfoForm")
	public String reserInfoForm(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		int pageNum = 1;
	    try {
		   pageNum = Integer.parseInt(request.getParameter("pageNum"));
	    } catch (NumberFormatException e) {}
	    int limit = 10;
		int msno = Integer.parseInt(request.getParameter("msno"));
		List<Comment> clist = cdao.clist(msno,pageNum,limit);
		int ccount = cdao.listcount(msno);
		int csum = cdao.listsum(msno);
		double staravg = csum/(float)ccount;
		int maxpage = (int)((double)ccount/limit + 0.95);
	    int startpage=((int)(pageNum/10.0 + 0.9) - 1) * 10 + 1;
	    int endpage = startpage + 9; 
	    if(endpage > maxpage) endpage = maxpage;
	    if(Double.isNaN(staravg)) {
	    	staravg=0;
	    }
	    request.setAttribute("pageNum", pageNum);
	    request.setAttribute("startpage", startpage);
	    request.setAttribute("endpage", endpage);
	    request.setAttribute("maxpage", maxpage);
		request.setAttribute("staravg",String.format("%.2f", staravg));
		request.setAttribute("ccount", ccount);
		request.setAttribute("clist", clist);
		request.setAttribute("msno", msno);
		List<Day> tmlist = ddao.timelist(msno);
		request.setAttribute("tmlist", tmlist);
		return "reservation/reserInfoForm";
	}
	
	@RequestMapping("rewrite")
	public String rewrite(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String login = (String)request.getSession().getAttribute("login");
		int msno = Integer.parseInt(request.getParameter("msno"));
		if(login==null) {
			request.setAttribute("msg", "로그인한 사용자만 리뷰등록이 가능합니다");
			request.setAttribute("url", "reserInfoForm?msno="+msno);
			request.setAttribute("msno", msno);
			return "alert"; 
		}
		Comment com = new Comment();
		com.setMsno(Integer.parseInt(request.getParameter("msno")));
		com.setId(login);
		com.setCcontent(request.getParameter("content"));	
		com.setCstar(Integer.parseInt(request.getParameter("star")));
		String msg = null;
		String url= "reserInfoForm?msno="+msno;
		if(cdao.insert(com)) {
			msg = "리뷰등록 완료";
		}else {
			msg="리뷰등록 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", "reserInfoForm?msno="+msno);
		request.setAttribute("msno", msno);
		return "alert";
	}
	
	@RequestMapping("commdel")
	public String commdel(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String login = (String)request.getSession().getAttribute("login");
		String id = (String)request.getParameter("id");
		Member mem = dao.selectOne(login);
		int msno = Integer.parseInt(request.getParameter("msno"));
		String msg= "";
		String url ="reserInfoForm?msno="+msno;
		if(mem.getId().equals(id)||login.equals("admin")) {
			if(cdao.delete(id)) {
				msg="리뷰 삭제 성공";	
			}else {
				msg="리뷰 삭제 실패";
			}
		}else {
			msg="본인 리뷰만 삭제 가능합니다";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	   @RequestMapping("calendar")
	   public String calendar(HttpServletRequest request, HttpServletResponse response) {
	      int msno = Integer.parseInt(request.getParameter("msno"));
	      String dmd = (String) request.getParameter("dmd");
	      List<Day> callist = ddao.callist(dmd,msno);
	      request.setAttribute("c", callist);
	      return "reservation/calendar";
	   }
	   
	   @RequestMapping("seatForm")
	      public String seatForm(HttpServletRequest request,  HttpServletResponse response) {
	         int msno = Integer.parseInt(request.getParameter("msno"));
	         String dmd = request.getParameter("dmd");
	         String time = request.getParameter("time");
	
	         // 해당 회차 시간 list
	         List<Day> timelist = ddao.callist(dmd, msno);
	         List<String> times = new ArrayList<>();
	         for(Day t : timelist) {
	        	 times.add(t.getTime1());
	        	 times.add(t.getTime2());
	        	 times.add(t.getTime3());
	         }
	       
	         // 해당 좌석 list 가져와서 배열에 저장
	         List<Reservation> selist = rdao.selist(msno,dmd,time);
	         List<String> totse = new ArrayList<>();
	         for(Reservation r : selist) {
	        	 totse.add(r.getRseat1());
	        	 totse.add(r.getRseat2());
	        	 totse.add(r.getRseat3());
	         }
	       
	        //해당 시간 list가져와서 배열에 저장
	        List<Day> daylist = ddao.daylist(msno);
	        List<String> totday = new ArrayList<>();
	        for(Day d : daylist) {
	        	totday.add(d.getDmd());
	        }
	        System.out.println("변경 times: "+times);
	        request.setAttribute("timelist", times);
	        request.setAttribute("daylist", totday);
	    
	         return "reservation/seatForm";
	     }
	   @RequestMapping("day")
	      public String day(HttpServletRequest request,
	            HttpServletResponse response) {
		   int msno = Integer.parseInt(request.getParameter("msno"));
		      String dmd = (String) request.getParameter("dmd");
		      List<Day> callist = ddao.callist(dmd,msno);
		      request.setAttribute("c", callist);
		      System.out.println(callist);
		      return "reservation/day";
	   }
	   @RequestMapping("seat")
	      public String seat(HttpServletRequest request, HttpServletResponse response) {
		   	 int msno = Integer.parseInt(request.getParameter("msno"));
	         String dmd = request.getParameter("dmd");
	         String time = request.getParameter("time");
	         System.out.println("msno:"+msno+", dmd:"+dmd+", time"+time);
	         // 해당 좌석 list 가져와서 배열에 저장
	         List<Reservation> selist = rdao.selist(msno,dmd,time);
	         List<String> totse = new ArrayList<>();
	         for(Reservation r : selist) {
	        	 totse.add(r.getRseat1());
	        	 totse.add(r.getRseat2());
	        	 totse.add(r.getRseat3());
	         }
	         System.out.println("totse======"+totse);
	         request.setAttribute("totse", totse);
	         return "reservation/seat";
	   }
	   @RequestMapping("paymentForm")
	   public String paymentForm(HttpServletRequest request, HttpServletResponse response) {
		   int msno = Integer.parseInt(request.getParameter("msno"));
		   String dmd = request.getParameter("dmd");
		   String time = request.getParameter("time");
		   String seat = request.getParameter("reseat");
		   System.out.println("msno: "+msno+", dmd: "+dmd+", time: "+time+", seat: "+seat);
		   String sarr[] = seat.split(",");

		   int sum =0;
		   for(int i = 0; i<sarr.length; i++) {
			   if(Integer.parseInt(sarr[i])<=5) {
				   sum += 150000;
			   } else if(Integer.parseInt(sarr[i])<=10) {
				   sum += 130000;
			   } else if(Integer.parseInt(sarr[i])<=15) {
				   sum += 100000;
			   } else if(Integer.parseInt(sarr[i])<=20) {
				   sum += 70000;
			   }
		   
		   }
		   System.out.println(sum);
		   int num = rdao.maxnum();
		   System.out.println(num);
		   request.setAttribute("dmd", dmd);
		   request.setAttribute("time",time);
		   request.setAttribute("seat", seat);
		   request.setAttribute("sum", sum);
		   request.setAttribute("num", num);
	        return "reservation/paymentForm";
	     }

			@RequestMapping("payment")
			public String payment(HttpServletRequest request, HttpServletResponse response) {
				int msno = Integer.parseInt(request.getParameter("msno"));
				String id = (String) request.getSession().getAttribute("login");
				String title = request.getParameter("title");
				String dmd = request.getParameter("dmd");
				String time = request.getParameter("time");
				String seat = request.getParameter("seat");
				int sum = Integer.parseInt(request.getParameter("sum"));
				String sarr[] = seat.split(",");
				System.out.println(id);
				Reservation r = new Reservation();
				r.setId(id);
				r.setRmtitle(title);
				r.setRmsno(msno);
				r.setRmd(dmd);
				r.setRtime(time);
				r.setRtprice(sum);
				for (int i = 0; i < sarr.length; i++) {
					if (i == 0) {
						r.setRseat1(sarr[i]);
					}
					if (i == 1) {
						r.setRseat2(sarr[i]);
					}
					if (i == 2) {
						r.setRseat3(sarr[i]);
					}
				}
				int point = dao.topoint(id);
				if(point<sum) {
					request.setAttribute("msg", "포인트가 부족합니다");
					request.setAttribute("url", "../member/main");
				}else {
					if(rdao.insert(r)) {
						if(dao.pointadd(id, -sum)) {
							request.setAttribute("msg", "예매 완료"+sum+"포인트 차감");
							request.setAttribute("url", "../member/main");
						}else {
							request.setAttribute("msg", "예매 완료 포인트 차감 안됌");
							request.setAttribute("url", "../member/main");
						}
					}else {
						request.setAttribute("msg", "예매 실패");
						request.setAttribute("url", "reserInfoForm");
					}
				}
				return "alert";
			}
}
