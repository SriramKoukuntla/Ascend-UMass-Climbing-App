package com.example.ascend.hackumass.model;
import java.util.HashMap;

public class UserAuthentication {
    private HashMap<String, User> users;

    // Constructor to initialize the HashMap
    public UserAuthentication() {
        users = new HashMap<>();
    }

    // Signup method to add a new user
    public String signup(String username, String password) {
        // Check if the username already exists
        if (users.containsKey(username)) {
            return "Username already exists.";
        }

        // Create a new user and add to the HashMap
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        users.put(username, newUser);

        return "User registered successfully.";
    }

    // Login method to validate user credentials
    public String login(String username, String password) {
        // Check if the username exists
        if (!users.containsKey(username)) {
            return "Invalid username";
        }

        // Check if the password matches
        User user = users.get(username);
        if (!user.getPassword().equals(password)) {
            return "Invalid password";
        }

        return "Logged in";
    }
}
