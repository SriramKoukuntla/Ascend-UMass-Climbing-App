package com.example.ascend.hackumass.controller;

import com.example.ascend.hackumass.model.User;
import com.example.ascend.hackumass.model.UserAuthentication;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class MasterController {

    @PostMapping("/login")
    public String login(@RequestBody User user) {
        return userAuthentication.login(user.getUsername(), user.getPassword());
    }

    @PostMapping("/signup")
    public String signup(@RequestBody User user) {
        return userAuthentication.signup(user.getUsername(), user.getPassword());
    }
}