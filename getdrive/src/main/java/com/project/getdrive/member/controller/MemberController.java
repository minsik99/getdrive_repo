package com.project.getdrive.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.project.getdrive.member.model.service.MemberService;
import com.project.getdrive.member.model.vo.Member;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	
	
	//메인 이동
	@RequestMapping(value="mainPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String moveMainPage() {
		return "common/main";
	}
	//약관페이지 이동
	@RequestMapping(value="contractPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String moveContractPage() {
		return "member/contract";
	}
	
	//회원가입페이지 이동
	@RequestMapping(value="registerPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String moveRegisterPage() {
		return "member/register";
	}
	
	/*
	 * //회원가입완료페이지 이동
	 * 
	 * @RequestMapping(value="registerCompletePage.do", method= {RequestMethod.GET,
	 * RequestMethod.POST}) public String moveRegisterCompletePage() { return
	 * "member/registerComplete"; }
	 */
	
	//로그인
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, SessionStatus status, Model model) {
		logger.info("login.do : " + member.toString());
		
		boolean isLogin = memberService.loginCheck(member);
		
		if(isLogin) {
			session.setAttribute("loginMember", member);
			status.setComplete();
			return "team/teamMain"; 
		} else {
			model.addAttribute("message", "로그인 실패! 아이디나 암호를 다시 확인하세요. 또는 로그인 제한된 회원입니다. 관리자에게 문의하세요.");
			return "common/main";
		}
		
	}
	//회원가입 처리
	@RequestMapping(value="register.do", method= {RequestMethod.POST})
	public String register(Member member, Model model) {
		logger.info("register.do : " + member);
		
		if(memberService.register(member) > 0) {
			return "member/registerComplete"; 
		}else {
			model.addAttribute("message","입력 정보를 다시한번 확인해주세요.");
			return "commom/error";
			
		}
		
	}
	
	
	
	//로그인시 아이디 비밀번호 일치여부 확인
	@RequestMapping(value="accountchk.do", method=RequestMethod.POST)
	public void accountCheck(@RequestParam("email") String email, @RequestParam("pwd") String password, HttpServletResponse response) throws IOException {
	    Member member = new Member();
	    member.setEmail(email);
	    member.setPwd(password);

	    boolean AccountValid = memberService.accountCheck(member);

	    String returnStr = AccountValid ? "ok" : "dup";
	    response.setContentType("text/html; charset=utf-8");
	    PrintWriter out = response.getWriter();
	    out.append(returnStr);
	    out.flush();
	    out.close();
	}
	
	//이메일 중복확인처리용
	@RequestMapping(value="idchk.do", method=RequestMethod.POST)
	public void dupCheckEmailMethod(@RequestParam("email") String email, 
			HttpServletResponse response) throws IOException {
		//메소드 매개변수 영역에서 사용하는 어노테이션 중에
		//@RequestParam("전송온이름")  자료형 값저장변수명
		//자료형 값저장변수명 = request.getParameter("전송온이름");  코드와 같음
		
		int idCount = memberService.selectCheckEmail(email);
		
		String returnStr = null;
		if(idCount == 0) {
			returnStr = "ok";
		}else {
			returnStr = "dup";
		}
		
		//response 를 이용해서 클라이언트와 출력스트림을 열어서 문자열값 내보냄
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();
	}
	
}
