package com.example.testfive.service;

import com.example.testfive.dto.SongRequest;
import com.example.testfive.entity.Song;
import com.example.testfive.repository.SongRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SongService {

    private final SongRepository songRepository;

    public SongService(SongRepository songRepository) {
        this.songRepository = songRepository;
    }


    public Song addSong(SongRequest request) {
        Song song = new Song();
        song.setName(request.getName());
        song.setArtist(request.getArtist());
        song.setImageBase64(request.getImageBase64());
        song.setAudioBase64(request.getAudioBase64());
        song.setLikes(0);
        return songRepository.save(song);
    }


    public List<Song> getAllSongs() {
        return songRepository.findAll();
    }


    public Song likeSong(Long id) {
        Song song = songRepository.findById(id).orElseThrow();
        song.setLikes(song.getLikes() + 1);
        return songRepository.save(song);
    }


    public Song dislikeSong(Long id) {
        Song song = songRepository.findById(id).orElseThrow();
        if (song.getLikes() > 0) {
            song.setLikes(song.getLikes() - 1);
        }
        return songRepository.save(song);
    }
}