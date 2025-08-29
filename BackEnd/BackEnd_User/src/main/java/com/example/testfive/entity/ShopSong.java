package com.example.testfive.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity @Table(name = "shop_song")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ShopSong {
    @Id
    @Column(length = 255)
    private String id;

    private String title;
    private String artist;
    private String coverPath;
    private String price;
    private boolean active = true;
}
