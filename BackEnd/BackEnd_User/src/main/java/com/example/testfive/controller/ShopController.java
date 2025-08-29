package com.example.testfive.controller;

import com.example.testfive.dto.*;
import com.example.testfive.entity.*;
import com.example.testfive.model.*;
import com.example.testfive.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/shop")
@RequiredArgsConstructor
public class ShopController {

    private final ShopService shopService;

    private Long userIdFromHeader(@RequestHeader(value="X-User-Id", required=false) String uid){
        if(uid==null) throw new RuntimeException("Missing user id");
        return Long.parseLong(uid);
    }

    @PostMapping("/songs/{songId}/like")
    public LikeSummaryDto likeSong(@PathVariable String songId,
                                   @RequestHeader(value="X-User-Id", required=false) String uid){
        return shopService.likeSong(songId, userIdFromHeader(uid), SongLike.VoteType.LIKE);
    }

    @PostMapping("/songs/{songId}/dislike")
    public LikeSummaryDto dislikeSong(@PathVariable String songId,
                                      @RequestHeader(value="X-User-Id", required=false) String uid){
        return shopService.likeSong(songId, userIdFromHeader(uid), SongLike.VoteType.DISLIKE);
    }

    @GetMapping("/songs/{songId}/likes")
    public LikeSummaryDto likeSummary(@PathVariable String songId){
        return shopService.summary(songId);
    }

    @PostMapping("/songs/{songId}/comments")
    public CommentResponse addComment(@PathVariable String songId,
                                      @RequestBody CommentRequest req,
                                      @RequestHeader(value="X-User-Id", required=false) String uid){
        var c = shopService.addComment(songId, userIdFromHeader(uid), req.getText());
        return toDto(c.getId(), c.getUser().getId(), c.getText(), c.getLikes(), c.getDislikes());
    }

    @GetMapping("/songs/{songId}/comments")
    public java.util.List<CommentResponse> listComments(@PathVariable String songId){
        return shopService.listComments(songId).stream()
                .map(c -> toDto(c.getId(), c.getUser().getId(), c.getText(), c.getLikes(), c.getDislikes()))
                .collect(Collectors.toList());
    }

    @DeleteMapping("/comments/{commentId}")
    public void deleteComment(@PathVariable Long commentId,
                              @RequestHeader(value="X-User-Id", required=false) String uid){
        shopService.deleteComment(commentId, userIdFromHeader(uid), false);
    }

    @PostMapping("/comments/{commentId}/like")
    public CommentResponse likeComment(@PathVariable Long commentId,
                                       @RequestHeader(value="X-User-Id", required=false) String uid){
        var c = shopService.voteComment(commentId, userIdFromHeader(uid), CommentVote.VoteType.LIKE);
        return toDto(c.getId(), c.getUser().getId(), c.getText(), c.getLikes(), c.getDislikes());
    }

    @PostMapping("/comments/{commentId}/dislike")
    public CommentResponse dislikeComment(@PathVariable Long commentId,
                                          @RequestHeader(value="X-User-Id", required=false) String uid){
        var c = shopService.voteComment(commentId, userIdFromHeader(uid), CommentVote.VoteType.DISLIKE);
        return toDto(c.getId(), c.getUser().getId(), c.getText(), c.getLikes(), c.getDislikes());
    }

    @PostMapping("/songs/{songId}/download")
    public void addDownload(@PathVariable String songId,
                            @RequestHeader(value="X-User-Id", required=false) String uid){
        shopService.addDownload(songId, userIdFromHeader(uid));
    }

    @DeleteMapping("/songs/{songId}/download")
    public void removeDownload(@PathVariable String songId,
                               @RequestHeader(value="X-User-Id", required=false) String uid){
        shopService.removeDownload(songId, userIdFromHeader(uid));
    }

    private CommentResponse toDto(Long id, Long userId, String text, int likes, int dislikes){
        return CommentResponse.builder()
                .id(id)
                .authorName("User#" + userId)
                .text(text)
                .createdAt("")
                .likes(likes).dislikes(dislikes).build();
    }

    @PostMapping("/comments")
    public CommentResponse addCommentDirect(@RequestBody CommentRequest req,
                                            @RequestHeader(value="X-User-Id", required=false) String uid){
        if(req.getSongId() == null) throw new RuntimeException("Missing songId");
        var c = shopService.addComment(req.getSongId(), userIdFromHeader(uid), req.getText());
        return toDto(c.getId(), c.getUser().getId(), c.getText(), c.getLikes(), c.getDislikes());
    }


}
