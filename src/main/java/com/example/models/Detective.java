package com.example.models;

import java.io.Serializable;

public class Detective implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String number;
    private int level;
    private String imageUrl; 
    private boolean hideImage; 

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }

    public int getLevel() { return level; }
    public void setLevel(int level) { this.level = level; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public boolean isHideImage() { return hideImage; }
    public void setHideImage(boolean hideImage) { this.hideImage = hideImage; }
}