package com.example.ascend.hackumass.model;
import java.util.HashMap;
import java.util.Map;

public class Userbase {
    private HashMap<String, User> users;
    


    // Constructor to initialize the HashMap
    public Userbase() {
        users = new HashMap<>();
    }

    // Signup method to add a new user
    public String signup(String username, String password, boolean isStaff) {
        // Check if the username already exists
        if (users.containsKey(username)) {
            return "Username already exists.";
        }

        // Create a new user and add to the HashMap
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setStaff(isStaff);
        users.put(username, newUser);

        //This should tell us whether we are validating staff or regular
        return isStaff ? "Staff registered successfully." : "Regular registered successfully";
    }

    // Login method to validate user credentials
    public String login(String username, String password, boolean isStaff) {
        // Check if the username exists
        if (!users.containsKey(username)) {
            return "Invalid username";
        }

        // Check if the password matches
        User user = users.get(username);
        if (!user.getPassword().equals(password)) {
            return "Invalid password";
        }

        if (user.isStaff() != isStaff){
            return "Wrong login portal";
        }

        return user.isStaff() ? "Staff logged in successfully" : "Regular logged in successfully";
    }

    public String request(String username, Route route){


    }



}