package com.example.ascend.hackumass.controller;

import com.example.ascend.hackumass.model.Route;
import com.example.ascend.hackumass.model.User;
import com.example.ascend.hackumass.model.Userbase;
import com.example.ascend.hackumass.model.RouteRequest;

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
    @PostMapping("/requestRoute")
    public String requestRoute(@RequestBody RouteRequest routeRequest) {
        return userBase.requestRoute(routeRequest.getUsername(), routeRequest.getRoute());
    }

    @PostMapping("/getElo")
    public int getElo(@RequestBody User user) {
        return userBase.getElo(user.getUsername());
    }

    @PostMapping("/requestRank")
    public int requestRank(@RequestBody User user) {
        return userBase.requestRank(user.getUsername());
    }

    @GetMapping("/requestTop3")
    public User[] top3() {
        return userBase.top3();
    }

    @PostMapping("/approveRoute")
    public String approveRoute(@RequestBody RouteRequest routeRequest) {
        return userBase.approveRoute(routeRequest.getUsername(), routeRequest.getRoute().getRouteName());
    }

    @PostMapping("/rejectRoute")
    public String rejectRoute(@RequestBody RouteRequest routeRequest) {
        return userBase.rejectRoute(routeRequest.getUsername(), routeRequest.getRoute().getRouteName());
    }
}