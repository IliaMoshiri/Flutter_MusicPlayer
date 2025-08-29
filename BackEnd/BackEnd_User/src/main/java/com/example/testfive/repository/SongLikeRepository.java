package com.example.testfive.repository;

import com.example.testfive.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface SongLikeRepository extends JpaRepository<SongLike, Long> {
    Optional<SongLike> findBySongIdAndUserId(String songId, Long userId);
    long countBySongIdAndType(String songId, SongLike.VoteType type);
}