package com.example.testfive.controller;

import com.example.testfive.dto.*;
import com.example.testfive.entity.*;
import com.example.testfive.service.*;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/songs")
public class SongController {

    private final SongService songService;

    public SongController(SongService songService) {
        this.songService = songService;
    }


    @PostMapping
    public Song addSong(@RequestBody SongRequest request) {
        return songService.addSong(request);
    }


    @GetMapping
    public List<Song> getAllSongs() {
        return songService.getAllSongs();
    }


    @PostMapping("/{id}/like")
    public Song likeSong(@PathVariable Long id) {
        return songService.likeSong(id);
    }


    @PostMapping("/{id}/dislike")
    public Song dislikeSong(@PathVariable Long id) {
        return songService.dislikeSong(id);
    }
}