package com.example.testfive.service;

import org.springframework.beans.factory.annotation.Autowired;
import com.example.testfive.entity.*;
import com.example.testfive.repository.*;
import com.example.testfive.dto.*;
import java.util.List;
import com.example.testfive.controller.*;


import org.springframework.stereotype.Service;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public Comment saveComment(Comment comment) {
        return commentRepository.save(comment);
    }

    public List<Comment> getCommentsBySong(String songId) {
        return commentRepository.findBySongId(songId);
    }
}
