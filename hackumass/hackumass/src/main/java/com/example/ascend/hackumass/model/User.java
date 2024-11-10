package com.example.ascend.hackumass.model;

import java.util.List;

import org.springframework.util.RouteMatcher.Route;

public class User {
    private String username;
    private String password;
    private boolean staff;

    private String aboutMe;
    private List<Route> climbHistory;
    private int elo;

    // Getter and Setter for username
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
        this.elo = 0;
    }

    // Getter and Setter for password
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    // Getter and Setter for aboutMe
    public String getAboutMe() {
        return aboutMe;
    }
    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }

    // Getter and Setter for climbHistory
    public List<Route> getClimbHistory() {
        return climbHistory;
    }

    public void setClimbHistory(List<Route> climbHistory) {
        this.climbHistory = climbHistory;
    }

    public void addClimbHistory(Route route){
        this.climbHistory.add(route);
    }

    // Getter and Setter for rank
    public int getElo() {
        return elo;
    }
    public void setElo(int elo) {
        this.elo = elo;
    }

    // Getter and Setter for staff
    public boolean isStaff() {
        return staff;
    }
    public void setStaff(boolean staff) {
        this.staff = staff;
    }



}