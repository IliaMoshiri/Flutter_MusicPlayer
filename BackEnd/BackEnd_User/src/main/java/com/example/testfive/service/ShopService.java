package com.example.testfive.service;

import com.example.testfive.entity.*;
import com.example.testfive.repository.*;
import com.example.testfive.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service @RequiredArgsConstructor
public class ShopService {

    private final ShopSongRepository shopSongRepo;
    private final SongLikeRepository songLikeRepo;
    private final CommentRepository commentRepo;
    private final CommentVoteRepository commentVoteRepo;
    private final DownloadRepository downloadRepo;
    private final UserRepository UserRepository;


    @Transactional
    public LikeSummaryDto likeSong(String songId, Long userId, SongLike.VoteType type){
        var existing = songLikeRepo.findBySongIdAndUserId(songId, userId);
        if(existing.isPresent()){
            var sl = existing.get();
            if(sl.getType()==type){
                songLikeRepo.delete(sl);
            } else {
                sl.setType(type);
                songLikeRepo.save(sl);
            }
        }else{
            songLikeRepo.save(SongLike.builder().songId(songId).userId(userId).type(type).build());
        }
        return summary(songId);
    }

    public LikeSummaryDto summary(String songId){
        return LikeSummaryDto.builder()
                .likes(songLikeRepo.countBySongIdAndType(songId, SongLike.VoteType.LIKE))
                .dislikes(songLikeRepo.countBySongIdAndType(songId, SongLike.VoteType.DISLIKE))
                .build();
    }


    @Transactional
    public Comment addComment(String songId, Long userId, String text) {
        var user = UserRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Comment c = new Comment();
        c.setSongId(songId);
        c.setText(text);
        c.setUser(user);
        return commentRepo.save(c);
    }



    public List<Comment> listComments(String songId){
        return commentRepo.findBySongId(songId);
    }

    @Transactional
    public void deleteComment(Long commentId, Long userId, boolean isAdmin){
        var c = commentRepo.findById(commentId).orElseThrow();
        if (!isAdmin && !c.getUser().getId().equals(userId)) {
            throw new RuntimeException("Not allowed");
        }
        commentRepo.delete(c);
    }

    @Transactional
    public Comment voteComment(Long commentId, Long userId, CommentVote.VoteType type){
        var existing = commentVoteRepo.findByCommentIdAndUserId(commentId, userId);
        if(existing.isPresent()){
            var v = existing.get();
            if(v.getType()==type){
                commentVoteRepo.delete(v);
            } else {
                v.setType(type);
                commentVoteRepo.save(v);
            }
        }else{
            commentVoteRepo.save(CommentVote.builder()
                    .commentId(commentId).userId(userId).type(type).build());
        }

        var likes = commentVoteRepo.countByCommentIdAndType(commentId, CommentVote.VoteType.LIKE);
        var dislikes = commentVoteRepo.countByCommentIdAndType(commentId, CommentVote.VoteType.DISLIKE);
        var c = commentRepo.findById(commentId).orElseThrow();
        c.setLikes((int)likes);
        c.setDislikes((int)dislikes);
        return commentRepo.save(c);
    }

    @Transactional
    public void addDownload(String songId, Long userId){
        if(!downloadRepo.existsBySongIdAndUserId(songId, userId)){
            downloadRepo.save(Download.builder().songId(songId).userId(userId).build());
        }
    }

    @Transactional
    public void removeDownload(String songId, Long userId){
        downloadRepo.deleteBySongIdAndUserId(songId, userId);
    }
}
