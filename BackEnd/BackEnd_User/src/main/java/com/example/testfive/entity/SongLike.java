package com.example.testfive.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity @Table(name = "song_like",
        uniqueConstraints=@UniqueConstraint(columnNames = {"song_id","user_id"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SongLike {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="song_id", length=255)
    private String songId;

    @Column(name="user_id")
    private Long userId;

    @Enumerated(EnumType.STRING)
    private VoteType type;

    public enum VoteType { LIKE, DISLIKE }
}
