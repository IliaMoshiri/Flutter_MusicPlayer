package com.example.testfive.service;

import com.example.testfive.dto.LoginRequest;
import com.example.testfive.dto.SignUpRequest;
import com.example.testfive.model.User;
import com.example.testfive.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.example.testfive.model.*;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    public User register(SignUpRequest req) {
        if (req == null || req.getEmail() == null || req.getPassword() == null) {
            throw new IllegalArgumentException("Email and password are required");
        }
        if (userRepository.findByEmail(req.getEmail()).isPresent()) {
            throw new RuntimeException("Email already registered");
        }
        User u = new User();
        u.setName(req.getName());
        u.setEmail(req.getEmail());
        u.setPassword(encoder.encode(req.getPassword()));
        u.setPhoneNumber(req.getPhoneNumber());
        u.setWallet(0.0);
        return userRepository.save(u);
    }

    public Optional<User> login(LoginRequest req) {
        if (req == null || req.getEmail() == null || req.getPassword() == null) {
            return Optional.empty();
        }
        return userRepository.findByEmail(req.getEmail())
                .filter(u -> encoder.matches(req.getPassword(), u.getPassword()));
    }

    public Optional<User> findById(Long id) {
        return id == null ? Optional.empty() : userRepository.findById(id);
    }

    public User addToWallet(Long id, double amount) {
        User u = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        double walletValue = u.getWallet();
        u.setWallet(walletValue + amount);
        return userRepository.save(u);
    }

    public boolean withdrawFromWallet(Long id, double amount) {
        User u = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        double walletValue = u.getWallet();
        if (walletValue < amount) return false;
        u.setWallet(walletValue - amount);
        userRepository.save(u);
        return true;
    }

    public User updateProfile(Long id, String newName, String newEmail, String newPhone) {
        User u = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        if (newEmail != null && !newEmail.equals(u.getEmail())) {
            if (userRepository.findByEmail(newEmail).isPresent()) throw new RuntimeException("Email already used");
            u.setEmail(newEmail);
        }
        if (newName != null) u.setName(newName);
        if (newPhone != null) u.setPhoneNumber(newPhone);
        return userRepository.save(u);
    }

    public boolean changePassword(Long id, String oldPass, String newPass) {
        User u = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        if (!encoder.matches(oldPass, u.getPassword())) return false;
        u.setPassword(encoder.encode(newPass));
        userRepository.save(u);
        return true;
    }
}
