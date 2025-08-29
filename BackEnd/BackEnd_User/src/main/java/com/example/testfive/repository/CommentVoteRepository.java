package com.example.testfive.repository;

import com.example.testfive.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface CommentVoteRepository extends JpaRepository<CommentVote, Long> {
    Optional<CommentVote> findByCommentIdAndUserId(Long commentId, Long userId);
    long countByCommentIdAndType(Long commentId, CommentVote.VoteType type);
}