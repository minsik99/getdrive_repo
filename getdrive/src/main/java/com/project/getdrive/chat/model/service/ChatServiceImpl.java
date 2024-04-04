package com.project.getdrive.chat.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.getdrive.chat.model.dao.ChatDao;
import com.project.getdrive.chat.model.vo.Chat;
import com.project.getdrive.chatcontent.model.vo.ChatContent;
import com.project.getdrive.chatuser.model.vo.ChatUser;

@Service("chatService")
public class ChatServiceImpl implements ChatService {
	@Autowired
	private ChatDao chatDao;
	
	@Override
	public ArrayList<Chat> selectChatList(String page) {
		return chatDao.selectChatList(page);
	}
	
}
