package com.example.testfive.dto;

import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class LikeSummaryDto {
    private long likes;
    private long dislikes;
}
