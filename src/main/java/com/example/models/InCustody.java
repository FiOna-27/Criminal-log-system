package com.example.models;

import java.io.Serializable;

public class InCustody implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String name;
    private String charges;
    private String sentence;
    private String info;
    private String behavior;
    private String mentalState;
    
    public InCustody() {
    }
    
    public InCustody(String name, String charges, String sentence, 
                    String info, String behavior, String mentalState) {
        this.name = name;
        this.charges = charges;
        this.sentence = sentence;
        this.info = info;
        this.behavior = behavior;
        this.mentalState = mentalState;
    }
    
    public InCustody(int id, String name, String charges, String sentence,
                    String info, String behavior, String mentalState) {
        this.id = id;
        this.name = name;
        this.charges = charges;
        this.sentence = sentence;
        this.info = info;
        this.behavior = behavior;
        this.mentalState = mentalState;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCharges() { return charges; }
    public void setCharges(String charges) { this.charges = charges; }
    public String getSentence() { return sentence; }
    public void setSentence(String sentence) { this.sentence = sentence; }
    public String getInfo() { return info; }
    public void setInfo(String info) { this.info = info; }
    public String getBehavior() { return behavior; }
    public void setBehavior(String behavior) { this.behavior = behavior; }
    public String getMentalState() { return mentalState; }
    public void setMentalState(String mentalState) { this.mentalState = mentalState; }
}