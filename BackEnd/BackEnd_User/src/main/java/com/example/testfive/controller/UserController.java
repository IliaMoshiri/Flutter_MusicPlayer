package com.example.testfive.controller;

import com.example.testfive.dto.LoginRequest;
import com.example.testfive.dto.SignUpRequest;
import com.example.testfive.dto.UserResponse;
import com.example.testfive.model.User;
import com.example.testfive.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody SignUpRequest req) {
        try {
            User saved = userService.register(req);
            return new ResponseEntity<>(new UserResponse(saved), HttpStatus.CREATED);
        } catch (RuntimeException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<UserResponse>> login(@RequestBody LoginRequest req) {
        return userService.login(req)
                .map(u -> ResponseEntity.ok(new ApiResponse<>(new UserResponse(u))))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(new ApiResponse<>("Invalid credentials")));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<UserResponse>> getUser(@PathVariable Long id) {
        return userService.findById(id)
                .map(u -> ResponseEntity.ok(new ApiResponse<>(new UserResponse(u))))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(new ApiResponse<>("User not found")));
    }


    @PostMapping("/{id}/wallet/add")
    public ResponseEntity<?> addToWallet(@PathVariable Long id, @RequestParam double amount) {
        try {
            User u = userService.addToWallet(id, amount);
            return ResponseEntity.ok(new UserResponse(u));
        } catch (RuntimeException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/{id}/wallet/withdraw")
    public ResponseEntity<?> withdrawFromWallet(@PathVariable Long id, @RequestParam double amount) {
        try {
            boolean ok = userService.withdrawFromWallet(id, amount);
            if (ok) return ResponseEntity.ok("Withdraw successful");
            else return new ResponseEntity<>("Insufficient funds", HttpStatus.BAD_REQUEST);
        } catch (RuntimeException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping("/{id}/profile")
    public ResponseEntity<?> updateProfile(@PathVariable Long id, @RequestBody UserResponse body) {
        try {
            User updated = userService.updateProfile(id, body.getName(), body.getEmail(), body.getPhoneNumber());
            return ResponseEntity.ok(new UserResponse(updated));
        } catch (RuntimeException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/{id}/change-password")
    public ResponseEntity<?> changePassword(@PathVariable Long id, @RequestParam String oldPass, @RequestParam String newPass) {
        try {
            boolean ok = userService.changePassword(id, oldPass, newPass);
            if (ok) return ResponseEntity.ok("Password changed");
            else return new ResponseEntity<>("Old password incorrect", HttpStatus.BAD_REQUEST);
        } catch (RuntimeException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
