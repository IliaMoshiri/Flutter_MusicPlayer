package com.example.testfive.dto;

import com.example.testfive.model.User;

public class UserResponse {
    private Long id;
    private String name;
    private String email;
    private String phoneNumber;
    private double wallet;
    private boolean premium;

    public UserResponse() {}

    public UserResponse(User u) {
        this.id = u.getId();
        this.name = u.getName();
        this.email = u.getEmail();
        this.phoneNumber = u.getPhoneNumber();
        this.wallet = u.getWallet();
        this.premium = u.isPremium();
    }

    public Long getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhoneNumber() { return phoneNumber; }
    public double getWallet() { return wallet; }
    public boolean isPremium() { return premium; }
}
