package com.example.testfive.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.testfive.model.User;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}
