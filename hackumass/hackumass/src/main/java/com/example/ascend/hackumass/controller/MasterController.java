package com.example.ascend.hackumass.controller;

import com.example.ascend.hackumass.model.User;
import com.example.ascend.hackumass.model.UserAuthentication;
import com.example.ascend.hackumass.model.Forum;
import com.example.ascend.hackumass.model.Leaderboard;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class MasterController {

    private final UserAuthentication userAuthentication = new UserAuthentication();
    private final Leaderboard leaderboard = new Leaderboard();
    private final Forum  forum = new Forum ();

    //UserAuthentification
    @PostMapping("/signup")
    public String signup(@RequestBody User user) {
        return userAuthentication.signup(user.getUsername(), user.getPassword(), user.isStaff());
    }


    @PostMapping("/login")
    public String login(@RequestBody User user) {
        return userAuthentication.login(user.getUsername(), user.getPassword(), user.isStaff());
    }

    //History/Elo/Rank
   @PostMapping("/addScore")
   public void addScore(@RequestBody User user, int score) {
       leaderboard.addScore(user, score);
   }

   @PostMapping("/removeScore")
   public void removeScore(@RequestBody User user, int score) {
       leaderboard.removeScore(user);
   }

    @GetMapping("/top10")
    public List<Map.Entry<User, Integer>> getTop10Users() {
        return leaderboard.getTop10Users();
    }  

    // Endpoint to add a post to the forum
    @PostMapping("/add")
    public String addPost(@RequestBody String text) {
        forum.addPost(text);
        return "Post added successfully";
    }

    // Endpoint to get all posts from the forum
    @GetMapping("/posts")
    public List<String> getAllPosts() {
        return forum.getAllPosts();
    }

}