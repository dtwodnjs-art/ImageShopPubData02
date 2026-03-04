package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.project.domain.Reply;
import com.project.service.ReplyService;

@RestController 
@RequestMapping("/replies")
public class ReplyController {
	
    @Autowired
    private ReplyService service;

    
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody Reply reply) throws Exception {
        service.register(reply);
        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    
    @GetMapping("/list/{noticeNo}")
    public ResponseEntity<List<Reply>> list(@PathVariable("noticeNo") int noticeNo) throws Exception {
        return new ResponseEntity<>(service.list(noticeNo), HttpStatus.OK);
    }

  
    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.username == #reply.replyer")
    @DeleteMapping("/{replyNo}")
    public ResponseEntity<String> remove(@PathVariable("replyNo") int replyNo, @RequestBody Reply reply) throws Exception {
        service.remove(replyNo);
        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }
}