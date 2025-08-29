package com.example.testfive.repository;

import com.example.testfive.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface DownloadRepository extends JpaRepository<Download, Long> {
    boolean existsBySongIdAndUserId(String songId, Long userId);
    void deleteBySongIdAndUserId(String songId, Long userId);
    List<Download> findByUserId(Long userId);
}