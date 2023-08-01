package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.Comment;
import model.CommentMybatisDao;
import model.Member;
import model.MemberMyBatisDao;
import model.Point;
import model.Reservation;
import model.ReservationMybatisDao;

@WebServlet(urlPatterns = { "/member/*" }, initParams = { @WebInitParam(name = "view", value = "/view/") })
public class MemberController extends MskimRequestMapping {
	private MemberMyBatisDao dao = new MemberMyBatisDao();

	public String loginIdCheck(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String id = request.getParameter("id");
		String login = (String) request.getSession().getAttribute("login");
		if(login == null) {
			request.setAttribute("msg","ꉂ (๑¯ਊ¯)σ  로그인이 필요한 서비스입니다.");
			request.setAttribute("url","loginForm");
			return "alert";
		} else if (!login.equals("admin") && !id.equals(login)) {
			request.setAttribute("msg","*관리자*만 가능합니다. (´∇ﾉ｀*)ノ");
			request.setAttribute("url","main");
			return "alert";
		} 
		return null;
	}

	@RequestMapping("main")
	public String main(HttpServletRequest request, HttpServletResponse response) {
		// request.getSession() : session 객체
		String login = (String) request.getSession().getAttribute("login");
		return "member/main"; // /view/member/main.jsp.페이지로 forward됨
	}

	@RequestMapping("join")
	public String join(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		Point p = new Point();
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setGender(Integer.parseInt(request.getParameter("gender")));
		mem.setBir(
				request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day"));
		mem.setTel(request.getParameter("tel"));
		mem.setEmail(request.getParameter("email"));

		if (dao.insert(mem) && dao.pointinsert(request.getParameter("id"))) {
			request.setAttribute("msg", mem.getName() + "님 회원 가입이 완료되었습니다 가입 선물 30만 포인트 증정");
			request.setAttribute("url", "loginForm");
		} else {
			request.setAttribute("msg", mem.getName() + "님 회원가입시 오류가 발생되었습니다.");
			request.setAttribute("url", "joinForm");
		}

		return "alert";
	}

	   @RequestMapping("idchk")
	   public String idchk(HttpServletRequest request, HttpServletResponse response) {
	      String id = request.getParameter("id");   
	      Member dbMem = dao.selectOne(id);
	      String msg = null;
	      boolean able = true;
//	      if(id.equals(dbMem.getId())) { null인 경우는 비교 자체를 못 하니까
	      if(dbMem != null) {
	         msg = "이미 사용 중인 아이디입니다.";
	         able = true;
	      } else {
	         msg = "사용 가능한 아이디입니다.";
	         able = false;
	      }
	      request.setAttribute("msg", msg);
	      request.setAttribute("able", able); //속성값 넣어줘야함
	      return "member/idchk";
	   }
	   
	@RequestMapping("joinForm")
	   public String joinForm(HttpServletRequest request, HttpServletResponse response) {
	      String id = request.getParameter("id");
	      String login = (String)request.getSession().getAttribute("login");
	      if(login != null) {
	         request.getSession().invalidate();
	      }
	      String content = "null";
	      try{
	         content = request.getParameter("content");
	      }catch(NullPointerException e) {}
	      if(content == null) {
	         content = "null";
	      }
	      String ms = "1";
	      try {
	         ms = request.getParameter("ms");
	      } catch (Exception e) {}
	      if(ms == null) {
	         ms = "1";
	      }
	      request.setAttribute("content", content);
	      request.setAttribute("ms", ms);
	      return "member/joinForm";
	    }

	@RequestMapping("loginForm")
	public String loginForm(HttpServletRequest request, HttpServletResponse response) {
		String login = (String) request.getSession().getAttribute("login");
		if (login != null) {
			request.getSession().invalidate();
		}
		return "member/loginForm";
	}

	@RequestMapping("login")
	public String login(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		Member mem = dao.selectOne(id);
		String msg = null;
		String url = null;
		if (mem == null) {
			msg = "아이디를 확인하세요";
			url = "loginForm";
		} else if (!pass.equals(mem.getPass())) {
			msg = "비밀번호가 틀립니다.";
			url = "loginForm";
		} else {
			request.getSession().setAttribute("login", id);
			msg = "반갑습니다." + mem.getName() + "님";
			url = "main";
		}

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}

	@RequestMapping("deleteForm")
	@MSLogin("loginIdCheck")
	public String deleteForm(HttpServletRequest request, HttpServletResponse response) {
		return "member/deleteForm";
	}

	@RequestMapping("delete")
	@MSLogin("loginIdCheck")
	public String delete(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String login = (String) request.getSession().getAttribute("login");
		String msg = null;
		String url = null;
		if (id.equals("admin")) { //
			request.setAttribute("msg", "관리자는 탈퇴 못합니다.");
			request.setAttribute("url", "updateForm?id=" + id);
			return "alert";
		}
		Member dbMem = dao.selectOne(login); // 로그인된 사용자의 비밀번호로 검증
		if (!pass.equals(dbMem.getPass())) {
			request.setAttribute("msg", "비밀번호 오류");
			request.setAttribute("url", "deleteForm?id=" + id);
			return "alert";
		}
		// 비밀번호 일치=>고객정보삭제
		if (dao.delete(id)) { // 삭제 성공
			msg = id + "고객님 탈퇴성공";
			if (login.equals("admin"))
				url = "../admin/memListForm";
			else { // 일반사용자
				request.getSession().invalidate(); // 로그아웃
				url = "loginForm";
			}
		} else { // 삭제 실패
			msg = id + "고객님 탈퇴시 오류 발생. 탈퇴 실패";
			if (login.equals("admin"))
				url = "../admin/memListForm";
			else
				url = "updateForm?id=" + id;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}

	@RequestMapping("infoForm")
	public String infoForm(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String id = request.getParameter("id");
		//멤버정보
		Member mem = dao.selectOne(id);
		//멤버의 포인트
		Point p = dao.pointselect(id);
		//예매내역
		ReservationMybatisDao rdao = new ReservationMybatisDao();
		List<Reservation> res = rdao.reslist(id);
		//댓글내역
		CommentMybatisDao cdao = new CommentMybatisDao();
		List<Comment> comlist = cdao.comlist(id);
		request.setAttribute("comlist", comlist);
		request.setAttribute("p", p);
		request.setAttribute("mem", mem);
		request.setAttribute("reslist", res);
		return "member/infoForm";
	}

	@RequestMapping("updateForm")
	@MSLogin("loginIdCheck")
	public String updateForm(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		Member mem = dao.selectOne(id);
		request.setAttribute("mem", mem);
		return "member/updateForm";
	}

	@RequestMapping("logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();
		return "redirect:loginForm";
	}

	// 김유승
	@RequestMapping("tel")
	public String tel(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Member mem = new Member();
		mem.setTel(request.getParameter("tel"));
		String login = (String) request.getSession().getAttribute("login");
		mem.setId(login);
		String msg = "현재 사용중인 전화번호입니다.";
		String url = "updateForm?id=" + login;
		if (dao.telupdate(mem)) {
			msg = "회원 정보 수정 완료";
		} else {
			url = "telForm?id=" + login;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}

	@RequestMapping("emailForm")
	   public String emailForm(HttpServletRequest request, HttpServletResponse response) {
	      try {
	         request.setCharacterEncoding("UTF-8");
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }
	      String content = "null";
	      try{
	         content = request.getParameter("content");
	      }catch(NullPointerException e) {}
	      if(content == null) {
	         content = "null";
	      }
	      request.setAttribute("content", content);
	      return "member/emailForm";
	   }
	
	@RequestMapping("email")
	public String email(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Member mem = new Member();
		mem.setEmail(request.getParameter("email"));
		String login = (String) request.getSession().getAttribute("login");
		mem.setId(login);
		String msg = "현재 사용중인 이메일입니다.";
		String url = "updateForm?id=" + login;
		if (dao.emailupdate(mem)) {
			msg = "회원 정보 수정 완료";
		} else {
			url = "emailForm?id=" + login;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}

	@RequestMapping("picture")
	public String picture(HttpServletRequest request, HttpServletResponse response) {
		// request.getServletContext() : application 객체
		// request.getServletContext().getRealPath("/")
		// : 실제 웹어플리케이션 경로.
		String path = request.getServletContext().getRealPath("") + "/img/";
		String fname = null;
		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		} // 업로드 폴더가 없는 경우 폴더 생성
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "utf-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		String login = (String) request.getSession().getAttribute("login");
		Member mem = new Member();
		mem.setId(login);
		mem.setCon(multi.getFilesystemName("con"));
		if (dao.conupdate(mem)) {
			request.setAttribute("msg", "사진변경완료");
			request.setAttribute("url", "infoForm?id=" + login);
		} else {
			request.setAttribute("msg", "사진변경실패");
			request.setAttribute("url", "infoForm?id=" + login);
		}
		return "alert";
	}
	// -------------김유승--------------------

	@RequestMapping("id")
	public String id(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String id = dao.idSearch(email, tel);
		if (id != null) {
			String showId = id.substring(0, id.length() - 2);
			request.setAttribute("id", showId);
			return "member/id";
		} else {
			request.setAttribute("msg", "아이디를 찾을 수 없습니다.");
			request.setAttribute("url", "idForm");
			return "alert";
		}
	}
	
	@RequestMapping("pw")
	public String pw(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		String pw = dao.pwSearch(id, email, tel);
		if (pw != null) {
			String showPw = pw.substring(0, pw.length() - 2);
			request.setAttribute("pw", "회원 비밀번호 :" + showPw);
			return "member/pw";
		} else {
			request.setAttribute("msg", "비밀번호를 찾을 수 없습니다.");
			request.setAttribute("url", "pwForm");
			return "alert";
		}
	}

	@RequestMapping("pointForm")
	public String pointForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		List<Point> list = dao.pointboard(id);
		request.setAttribute("id", id);
		request.setAttribute("list", list);
		return "member/pointForm";
	}
	@RequestMapping("point2")
    public String point2(HttpServletRequest request, 
          HttpServletResponse response) throws Exception {
       request.setCharacterEncoding("utf-8");
       String id = request.getParameter("id");
       int p = Integer.parseInt(request.getParameter("p"));
        if(dao.pointadd(id,p)) {
             request.setAttribute("msg", "충전성공.");
             request.setAttribute("p", p);
             return "member/point2";
        }
          request.setAttribute("msg", "충전실패.");
          return "member/point2";
    }
	@RequestMapping("reserdel")
	public String reserDel(HttpServletRequest request, HttpServletResponse response) {
		int rno = Integer.parseInt(request.getParameter("rno"));
		String login = (String) request.getSession().getAttribute("login");
		if(dao.resdel(rno)) {
			request.setAttribute("msg", "예매 삭제 완료");
		}else {
			request.setAttribute("msg", "예매 삭제 실패");
		}
		request.setAttribute("url", "infoForm?id="+login);
		return "alert";
	}
	
	@RequestMapping("mailSend")
    public String mailSend(HttpServletRequest request,
          HttpServletResponse response) throws Exception {
       request.setCharacterEncoding("utf-8");
       String email = request.getParameter("email");
       String com = request.getParameter("com");
       System.out.println(email+com);
       String sender = "ans4649";
       String pass = "7dltmfql7!@";
       String recipient = email+"@"+com;
       String title = "이메일 인증";
       int con1 = (int)(Math.random()*10);
       int con2 = (int)(Math.random()*10);
       int con3 = (int)(Math.random()*10);
       int con4 = (int)(Math.random()*10);
       System.out.println(""+(int)(Math.random()*10));
       System.out.println(con1 +""+con2 +""+ con3 +""+ con4);
       String content = con1 +""+con2 +""+ con3 +""+ con4 ;
       String mtype = "HTML";
       /*
        * Properties 클래스 : Hashtable(Map구현 클래스)의 하위클래스
        *             (key(String),value(String))
        *             => 제네릭표현안함<>
        * prop : 메일 전송을 위한 환경설정 객체
        */
       Properties prop = new Properties();
       try {
          String file = request.getServletContext().getRealPath("/") + "file/mail.properties";
//          FileInputStream fis = 
//             new FileInputStream("C:/java/workspace/project/project/mail.properties");
          FileInputStream fis =new FileInputStream(file);            
          prop.load(fis); // key = value 으로 읽어서 Map객체로 저장
          prop.put("mail.stmp.user", sender);
          System.out.println(prop);
       } catch (Exception e) {
          e.printStackTrace();
       }
       //메일 전송 전에 인증객체 생성=> 네이버인증
       MyAuthenticator auth = new MyAuthenticator(sender,pass); //인증객체
       // 메일전송을 위한 연결 객체
       Session session = Session.getInstance(prop,auth);
       //Message 객체 준비 : 메일의 내용을 저장하는 객체
       MimeMessage msg = new MimeMessage(session);
       
       String address = recipient;
          
          // 보내는사람 이메일 주소 설정
       InternetAddress from = new InternetAddress(sender+"@naver.com");
       //보내는 사람 이메일 주소
       msg.setFrom(from);  
          //받는사람 이메일 주소 설정
       msg.setRecipients(Message.RecipientType.TO, address);
          // 메일 제목
       msg.setSubject(title);
          // 전송 시간
       msg.setSentDate(new Date());
          // 메일 내용
       msg.setText(content);

       MimeBodyPart body = new MimeBodyPart();
       body.setContent(content, mtype);
       Transport.send(msg); // 메일전송
       //메일전송
       request.setAttribute("content", content);
       String ff = request.getParameter("f");
       if(ff.equals("1")) {
          return "member/joinForm";
       }else {
          return "member/emailForm";
       }
    }
    
    public final class MyAuthenticator extends Authenticator{
       private String id;
       private String pw;
       public MyAuthenticator(String id, String pw) {
          this.id = id;
          this.pw = pw;
       }
       protected PasswordAuthentication getPasswordAuthentication() {
          return new PasswordAuthentication(id,pw);
       }
    }
    
    
}