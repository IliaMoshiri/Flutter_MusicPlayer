package com.example.testfive.controller;

import com.example.testfive.entity.Comment;
import com.example.testfive.model.User;
import com.example.testfive.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.testfive.repository.UserRepository;
import com.example.testfive.dto.CommentRequest;
import com.example.testfive.dto.CommentResponse;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/comments")
@CrossOrigin(origins = "*")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserRepository userRepository;

    private Long userIdFromHeader(String uid) {
        if (uid == null) throw new RuntimeException("Missing user id");
        return Long.parseLong(uid);
    }

    @PostMapping
    public ResponseEntity<CommentResponse> addComment(@RequestBody CommentRequest request,
                                                      @RequestHeader(value = "X-User-Id", required = false) String uid) {
        Long userId = userIdFromHeader(uid);
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Comment comment = new Comment();
        comment.setSongId(request.getSongId());
        comment.setText(request.getText());
        comment.setUser(user);

        Comment saved = commentService.saveComment(comment);

        CommentResponse response = new CommentResponse(
                saved.getId(),
                saved.getUser().getEmail(),
                saved.getText(),
                saved.getCreatedAt() != null ? saved.getCreatedAt().toString() : null,
                saved.getLikes(),
                saved.getDislikes()
        );

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{songId}")
    public ResponseEntity<List<CommentResponse>> getComments(@PathVariable String songId) {
        List<Comment> comments = commentService.getCommentsBySong(songId);

        List<CommentResponse> response = comments.stream().map(c -> new CommentResponse(
                c.getId(),
                c.getUser().getEmail(),
                c.getText(),
                c.getCreatedAt() != null ? c.getCreatedAt().toString() : null,
                c.getLikes(),
                c.getDislikes()
        )).collect(Collectors.toList());

        return ResponseEntity.ok(response);
    }
}