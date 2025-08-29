package com.example.testfive.service;

import org.springframework.beans.factory.annotation.Autowired;
import com.example.testfive.entity.*;
import com.example.testfive.repository.*;
import com.example.testfive.dto.*;
import java.util.List;
import com.example.testfive.controller.*;
import lombok.*;


import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CommentService {
    private final CommentRepository commentRepository;
    private final CommentVoteRepository commentVoteRepository;

    public Comment saveComment(Comment comment) {
        return commentRepository.save(comment);
    }

    public List<CommentResponse> getCommentsBySong(String songId) {
        List<Comment> comments = commentRepository.findBySongId(songId);

        return comments.stream().map(c -> {
            long likes = commentVoteRepository.countByCommentIdAndType(c.getId(), CommentVote.VoteType.LIKE);
            long dislikes = commentVoteRepository.countByCommentIdAndType(c.getId(), CommentVote.VoteType.DISLIKE);

            return CommentResponse.builder()
                    .id(c.getId())
                    .authorName(c.getUser().getName())
                    .text(c.getText())
                    .createdAt(c.getCreatedAt() != null ? c.getCreatedAt().toString() : null)
                    .likes((int) likes)
                    .dislikes((int) dislikes)
                    .build();
        }).toList();
    }
}
