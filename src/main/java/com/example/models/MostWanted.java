package com.example.models;

public class MostWanted {
    private int id;
    private String name;
    private String charges;
    private String lastSeen;
    private String info;
    
    public MostWanted() {
    }
    
    public MostWanted(String name, String charges, String lastSeen, String info) {
        this.name = name;
        this.charges = charges;
        this.lastSeen = lastSeen;
        this.info = info;
    }
    
    public MostWanted(int id, String name, String charges, String lastSeen, String info) {
        this.id = id;
        this.name = name;
        this.charges = charges;
        this.lastSeen = lastSeen;
        this.info = info;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCharges() { return charges; }
    public void setCharges(String charges) { this.charges = charges; }
    public String getLastSeen() { return lastSeen; }
    public void setLastSeen(String lastSeen) { this.lastSeen = lastSeen; }
    public String getInfo() { return info; }
    public void setInfo(String info) { this.info = info; }
}