package com.example.ascend.hackumass.controller;

import com.example.ascend.hackumass.model.User;
import com.example.ascend.hackumass.model.UserAuthentication;
import com.example.ascend.hackumass.model.Userbase;

// import com.example.ascend.hackumass.model.Forum;
// import com.example.ascend.hackumass.model.Leaderboard;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class MasterController {

    private final Userbase userBase = new Userbase();
    private final UserAuthentication userAuthentication = new UserAuthentication();

    // private final Leaderboard leaderboard = new Leaderboard();
    // private final Forum  forum = new Forum ();

    //UserAuthentification
    @PostMapping("/signup")
    public String signup(@RequestBody User user) {
        return userBase.signup(user.getUsername(), user.getPassword(), user.isStaff());
    }


    @PostMapping("/login")
    public String login(@RequestBody User user) {
        return userBase.login(user.getUsername(), user.getPassword(), user.isStaff());
    }

    // History/Elo/Rank
    @PostMapping("/routeRequest")
    public String requestRoute(@RequestBody User user) {
        return userBase.login(user.getUsername(), );
    }

}