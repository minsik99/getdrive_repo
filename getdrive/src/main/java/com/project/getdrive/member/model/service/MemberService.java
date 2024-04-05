package com.project.getdrive.member.model.service;

import com.project.getdrive.member.model.vo.Member;

public interface MemberService {

	int register(Member member);
	Member login(Member member);
	boolean loginCheck(Member member);
	int selectCheckEmail(String userId);
	boolean accountCheck(Member member);
	
}
