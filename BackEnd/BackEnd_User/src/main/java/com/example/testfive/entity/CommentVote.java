package com.example.testfive.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity @Table(name = "comment_vote",
        uniqueConstraints=@UniqueConstraint(columnNames = {"comment_id","user_id"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class CommentVote {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="comment_id")
    private Long commentId;

    @Column(name="user_id")
    private Long userId;

    @Enumerated(EnumType.STRING)
    private VoteType type;

    public enum VoteType { LIKE, DISLIKE }
}
