package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.Reply;
import com.project.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	

	@Autowired
    private ReplyMapper mapper;

    @Override
    public void register(Reply reply) throws Exception {
        mapper.create(reply);
    }

    @Override
    public List<Reply> list(int noticeNo) throws Exception {
        return mapper.list(noticeNo);
    }

    @Transactional
    @Override
    public void modify(Reply reply) throws Exception {
        mapper.update(reply);
    }

    @Transactional
    @Override
    public void remove(int replyNo) throws Exception {
        mapper.delete(replyNo);
    }

	

}
