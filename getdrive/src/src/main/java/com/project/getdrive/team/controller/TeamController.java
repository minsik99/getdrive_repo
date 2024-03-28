package com.project.getdrive.team.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TeamController {

	@RequestMapping("tmain.do")
	public String moveTeamMain() {
		return "team/teamMain";
	}
	
	@RequestMapping("tadmin.do")
	public String moveTeamAdmin() {
		return "team/teamAdmin";
	}
	
	@RequestMapping("tinfo.do")
	public String moveTeamInfo() {
		return "team/teamInfo";
	}
	
	@RequestMapping("tcreate.do")
	public String createTeam() {
		return "team/createTeam";
	}
}