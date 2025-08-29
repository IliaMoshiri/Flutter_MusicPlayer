package com.example.testfive.repository;

import com.example.testfive.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findBySongId(String songId);
}
