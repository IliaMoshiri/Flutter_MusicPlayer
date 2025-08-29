package com.example.testfive.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import com.example.testfive.dto.*;
import com.example.testfive.model.*;

@Entity
@Table(name = "comments")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String songId;

    private String text;

    private int likes = 0;
    private int dislikes = 0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime createdAt;
}
