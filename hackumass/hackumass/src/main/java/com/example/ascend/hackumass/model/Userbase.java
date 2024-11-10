package com.example.ascend.hackumass.model;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.LinkedList;
import java.util.Queue;


public class Userbase {
    private HashMap<String, User> users;
    private HashMap<String, HashSet<Route>> requests;


    // Constructor to initialize the HashMap
    public Userbase() {
        users = new HashMap<>();
        requests = new HashMap<>();
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

    public String requestRoute(String username, Route route){
        // Check if the username exists in the map
        if (!requests.containsKey(username)) {
            // If not, initialize a new Set for this username
            requests.put(username, new HashSet<>());
        }
        requests.get(username).add(route);
        return "Successfully Added Request";
    }

    public int getElo(String username){
        return users.get(username).getElo();
    }

    public int requestRank(String username) {
        List<Map.Entry<String, User>> userList = new ArrayList<>(users.entrySet());

        userList.sort((a, b) -> Integer.compare(b.getValue().getElo(), a.getValue().getElo()));

        for (int rank = 0; rank < userList.size(); rank++) {
            if (userList.get(rank).getKey().equals(username)) {
                return rank + 1; // Ranks are typically 1-based
            }
        }
        return -1;
    }

    public User[] top3() {
        // If there are less than 3 users, return as many as available
        int topSize = Math.min(3, users.size());
        User[] topUsers = new User[topSize];
    
        // Create a list of users sorted by Elo in descending order
        List<Map.Entry<String, User>> userList = new ArrayList<>(users.entrySet());
        userList.sort((a, b) -> Integer.compare(b.getValue().getElo(), a.getValue().getElo()));
    
        // Copy the top 3 (or less if fewer users) into the array
        for (int i = 0; i < topSize; i++) {
            topUsers[i] = userList.get(i).getValue();
        }
    
        return topUsers;
    }
    
    public String approveRoute(String username, String routeName){
        if (!requests.containsKey(username) || requests.get(username).isEmpty()) {
            return "No request from username";
        }
        for (Route route : requests.get(username)) {
            if (route.getRouteName() == routeName){
                //Increasing ELo
                int prevElo = users.get(username).getElo();
                users.get(username).setElo( prevElo + route.getPoints());
                //Update History
                // users.get(username).addClimbHistory(route);
                return "Route Successfully Approved";
            }
        }
        return "Route not found";
    }
}