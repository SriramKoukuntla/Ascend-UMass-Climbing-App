package com.example.ascend.hackumass.model;

public class Route {
    private String season;
    private int level;
    private String type;
    private int points;

    // Getter and Setter for season
    public String getSeason() {
        return season;
    }
    public void setSeason(String season) {
        this.season = season;
    }

    // Getter and Setter for level
    public int getLevel() {
        return level;
    }
    public void setLevel(int level) {
        this.level = level;
    }

    // Getter and Setter for type
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }

    // Getter and Setter for points
    public int getPoints() {
        return points;
    }
    public void setPoints(int points) {
        this.points = points;
    }
}