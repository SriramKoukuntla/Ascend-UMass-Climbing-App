package com.example.ascend.hackumass.controller;

import com.example.ascend.hackumass.model.User;


import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class MasterController {
    @RequestMapping(path = "/")
    public String getGreeting() {
        return "hello RAM";
    }

    @PostMapping("/login")
    public String login(@RequestBody User user) {
        return "Login: received username: " + user.getUsername() + " and password: " + user.getPassword();
    }

    @PostMapping("/signup")
    public String signup(@RequestBody User user) {
        return "Signup: received username: " + user.getUsername() + " and password: " + user.getPassword();
    }
}