package com.example.ascend.Tutorial.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class GreetingController {
    @RequestMapping(path = "/")
    public String getGreeting() {
        return "hello RAM";
    }

}