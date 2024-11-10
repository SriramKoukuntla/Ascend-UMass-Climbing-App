package com.example.ascend.hackumass.controller;

import com.example.ascend.hackumass.model.User;
import com.example.ascend.hackumass.model.UserAuthentication;
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


    @PostMapping("/login")
    public String login(@RequestBody User user) {
        return userAuthentication.login(user.getUsername(), user.getPassword());
    }

    @PostMapping("/signup")
    public String signup(@RequestBody User user) {
        return userAuthentication.signup(user.getUsername(), user.getPassword());
    }

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

    
    
}