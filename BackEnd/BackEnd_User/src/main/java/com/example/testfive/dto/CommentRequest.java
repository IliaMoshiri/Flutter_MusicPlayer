package com.example.testfive.dto;

import com.example.testfive.model.User;
import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder @Data
public class CommentRequest {
    private String songId;
    private String text;

//    public User getUser() {
//        return user;
//    }
//
//    public void setUser(User user) {
//        this.user = user;
//    }
}

