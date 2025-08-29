package com.example.testfive.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity @Table(name = "download",
        uniqueConstraints=@UniqueConstraint(columnNames = {"song_id","user_id"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Download {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="song_id", length=255)
    private String songId;

    @Column(name="user_id")
    private Long userId;
}
