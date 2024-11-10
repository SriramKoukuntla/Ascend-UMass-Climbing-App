package com.example.ascend.hackumass.model;

import java.util.ArrayList;
import java.util.List;

public class Forum {
    private List<String> posts;

    // Constructor to initialize the list of posts
    public Forum() {
        this.posts = new ArrayList<>();
    }

    public void addPost(String text) {
        if (text != null && !text.trim().isEmpty()) {
            posts.add(text);
        } else {
            System.out.println("Post cannot be empty.");
        }
    }

    public List<String> getAllPosts() {
        return new ArrayList<>(posts);
    }

}