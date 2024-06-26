package com.project.getdrive.team.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.getdrive.team.common.TeamCreator;
import com.project.getdrive.team.model.vo.Team;

@Repository("teamDao")
public class TeamDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public ArrayList<Team> selectList() {
		List<Team> list = sqlSessionTemplate.selectList("teamMapper.selectList");
		return (ArrayList<Team>) list;
	}

	public int insertTeam(TeamCreator teamCreator) {
		return sqlSessionTemplate.insert("teamMapper.insertTeam", teamCreator);
	}

	public Team selectTeam(int tNo) {
		return sqlSessionTemplate.selectOne("teamMapper.selectTeam", tNo);
	}

	public int updateTeamName(TeamCreator teamCreator) {
		return sqlSessionTemplate.update("teamMapper.updateTeamName", teamCreator);
	}

	public int selectDuplicate(String tName) {
		return sqlSessionTemplate.selectOne("teamMapper.selectDuplicate", tName);
	}

	public int deleteTeam(int tNo) {
		return sqlSessionTemplate.delete("teamMapper.deleteTeam", tNo);
	}
}
