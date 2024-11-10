package com.example.ascend.hackumass.model;

public class RouteRequest {
    private String username;
    private Route route;

    // Constructor
    public RouteRequest() {}

    // Getters and Setters for username
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Getters and Setters for route
    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }
}
