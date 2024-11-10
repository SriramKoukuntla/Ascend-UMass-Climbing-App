package com.example.ascend.hackumass.model;

import java.util.*;
import java.util.stream.Collectors;

public class Leaderboard {
    // Map to store User and their corresponding scores
    private Map<User, Integer> scores;

    // Constructor
    public Leaderboard() {
        scores = new HashMap<>();
    }

    // Add score for a user (increment if the user already has a score)
    public void addScore(User user, int score) {
        scores.put(user, scores.getOrDefault(user, 0) + score);
    }

    // Remove score for a user
    public void removeScore(User user) {
        scores.remove(user);
    }

    // Get top 10 users with the highest scores
    public List<Map.Entry<User, Integer>> getTop10Users() {
        return scores.entrySet().stream()
                .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue())) // Sort by score in descending order
                .limit(10)
                .collect(Collectors.toList()); // Collect top 10 entries as a list
    }
}