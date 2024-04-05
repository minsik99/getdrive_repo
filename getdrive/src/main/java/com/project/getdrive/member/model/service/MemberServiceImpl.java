package com.project.getdrive.member.model.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.getdrive.member.model.dao.MemberDao;
import com.project.getdrive.member.model.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired 
	private MemberDao memberDao;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override
	public int register(Member member) {
		
		member.setPwd(bcryptPasswordEncoder.encode(member.getPwd()));
		
		logger.info("after encode : " + member.getPwd());
		logger.info("pwd length : " + member.getPwd().length());
		
		return memberDao.register(member);
	}
	
	@Override
	public boolean loginCheck(Member member) {
		
		Member loginMember = memberDao.selectMember(member.getEmail());
		
		boolean isLogin = false;
		
		if(loginMember != null && this.bcryptPasswordEncoder.matches(
				member.getPwd(), loginMember.getPwd())) {
			isLogin = true;
		}
		
		return isLogin;
	}

	@Override
	public Member login(Member member) {
		return memberDao.login(member);
	}

	@Override
	public int selectCheckEmail(String email) {
		return memberDao.selectCheckEmail(email);
	}

	@Override
	public boolean accountCheck(Member member) {

		member.setPwd(bcryptPasswordEncoder.encode(member.getPwd()));
		
		logger.info("after encode : " + member.getPwd());
		logger.info("pwd length : " + member.getPwd().length());
		
		return memberDao.accountCheck(member);
	}

	



}
