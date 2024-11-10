package com.example.ascend.hackumass.model;

public class Request {
    private String type;
    private Route route;

    // Constructor to initialize the properties
    public Request(String type, Route route) {
        this.type = type;
        this.route = route;
    }

    // Getter and Setter methods for 'type'
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    // Getter and Setter methods for 'route'
    public Route getRoute() {
        return this.route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }
}

