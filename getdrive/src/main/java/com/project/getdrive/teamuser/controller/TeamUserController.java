package com.project.getdrive.teamuser.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.getdrive.member.model.vo.Member;
import com.project.getdrive.team.common.TeamCreator;
import com.project.getdrive.team.model.service.TeamService;
import com.project.getdrive.team.model.vo.Team;
import com.project.getdrive.teamuser.model.service.TeamUserService;
import com.project.getdrive.teamuser.model.vo.TeamUser;

@Controller
public class TeamUserController {
	private static final Logger logger = LoggerFactory.getLogger(TeamUserController.class);
	
	@Autowired
	private TeamService teamService;
	@Autowired
	private TeamUserService teamUserService;
	
	// 팀장용 팀원 정보 페이지
	@RequestMapping("tinfo.do")
	public String moveTeamInfo(@RequestParam("tNo") int tNo, Model model) {
		
		Team team = teamService.selectTeam(tNo);
		ArrayList<TeamUser> list = teamUserService.selectMembers(tNo);
		
		if(team != null && list != null) {
			model.addAttribute("team", team);
			model.addAttribute("teamUser", list);
			return "team/teamInfo";			
		} else {
			model.addAttribute("message", "팀원 정보 조회 실패");
			return "common/error";
		}
	}
	
	// 팀원용 팀원 정보 페이지
	@RequestMapping("tuinfo.do")
	public String moveTeamUserInfo(@RequestParam("tNo") int tNo, Model model) {
		
		Team team = teamService.selectTeam(tNo);
		ArrayList<TeamUser> list = teamUserService.selectMembers(tNo);
		
		if(team != null && list != null) {
			model.addAttribute("team", team);
			model.addAttribute("teamUser", list);
			return "team/teamUserInfo";			
		} else {
			model.addAttribute("message", "팀원 정보 조회 실패");
			return "common/error";
		}
	}

	// 팀원 추가 
	@RequestMapping(value="ituser.do", method=RequestMethod.POST)
	public String insertTeamUser(Model model,
			@RequestParam("tno") int tNo,
			@RequestParam("email") String email) {
		
		// 팀 고유번호와 이메일 값을 동시에 보내기 위해 team/common의 TeamCreator 객체를 사용
		TeamCreator teamCreator = new TeamCreator(tNo, email);
		
		int result = teamUserService.insertTeamUser(teamCreator);
		
		if(result > 0) {
			return "team/teamInfo";
		} else {
			model.addAttribute("message", "팀원 추가 실패");
			return "common/error";
		}
	}
	
	// 초대된 팀으로 팀원 가입
	@RequestMapping(value="itmember.do", method=RequestMethod.POST)
	public String enterTeam(Model model,
			@RequestParam("email") String email,
			@RequestParam("tno") int tNo,
			HttpServletRequest request) {
		
		Member member = (Member) request.getSession().getAttribute("loginMember");
		
		TeamUser teamUser = new TeamUser();
		teamUser.setTuMID(member.getAccountNo());
		teamUser.setTuEmail(email);
		teamUser.setTuTID(tNo);
		
		int result = teamUserService.updateInvitedTeams(teamUser);
		
		if(result > 0) {
			return "team/teamMain";
		} else {
			model.addAttribute("message", "팀원 추가 실패");
			return "common/error";
		}
	}
	
	// 팀원 탈퇴
	@RequestMapping(value="dtuser.do", method=RequestMethod.POST)
	public String removeTeam(HttpServletRequest request, Model model,
			@RequestParam("tno") int tNo) {
		
		Member member = (Member) request.getSession().getAttribute("loginMember");
		int tuMID = member.getAccountNo();
		
		Team team = new Team();
		team.settNo(tNo);
		team.settMID(tuMID);
		
		int result = teamUserService.deleteTeamUser(team);
		
		if(result > 0) {
			return "team/teamMain";
		} else {
			model.addAttribute("message", "팀원 탈퇴 실패");
			return "common/error";
		}
	}
	
	// 팀원 강퇴
		@RequestMapping(value="uexpel.do", method=RequestMethod.POST)
		public String removeTeamUser(@RequestParam("tuMID") int tuMID,
				Model model, @RequestParam("tno") int tNo) {
			
			Team team = new Team();
			team.settNo(tNo);
			team.settMID(tuMID);
			
			int result = teamUserService.deleteTeamUser(team);
			
			if(result > 0) {
				return "team/teamMain";
			} else {
				model.addAttribute("message", "팀원 강퇴 실패");
				return "common/error";
			}
		}
	
	// 팀장 권한 이양
		@RequestMapping(value="uauth.do", method=RequestMethod.POST)
		public String removeAuth(HttpServletRequest request, Model model,
				@RequestParam("tno") int tNo,
				@RequestParam("tuMID") int tuMID) {
			
			Member member = (Member) request.getSession().getAttribute("loginMember");
			int tMID = member.getAccountNo();
			
			// 팀장의 권한을 먼저 강등
			Team teamLeader = new Team();
			teamLeader.settNo(tNo);
			teamLeader.settMID(tMID);
			
			// 이후 팀원의 권한을 승급
			Team teamUser = new Team();
			teamUser.settNo(tNo);
			teamUser.settMID(tuMID);
			
			int result = teamUserService.removeAuth(teamLeader);
			
			if(result > 0 && teamUserService.upgradeAuth(teamUser) > 0) {
					return "team/teamMain";					
				} else {
					model.addAttribute("message", "팀장 권한 이양 실패");
					return "common/error";
			}
			 
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
