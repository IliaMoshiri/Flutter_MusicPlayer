package com.example.testfive.dto;

public class SongRequest {
    private String name;
    private String artist;
    private String imageBase64;
    private String audioBase64;

    // --- Getters & Setters ---
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getArtist() {
        return artist;
    }
    public void setArtist(String artist) {
        this.artist = artist;
    }
    public String getImageBase64() {
        return imageBase64;
    }
    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
    }
    public String getAudioBase64() {
        return audioBase64;
    }
    public void setAudioBase64(String audioBase64) {
        this.audioBase64 = audioBase64;
    }
}