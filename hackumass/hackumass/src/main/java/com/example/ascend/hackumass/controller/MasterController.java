package com.example.ascend.hackumass.controller;

import com.example.ascend.hackumass.model.User;
import com.example.ascend.hackumass.model.UserAuthentication;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.multipart.MultipartFile;

@RestController("/")
public class MasterController {

    private final UserAuthentication userAuthentication = new UserAuthentication();

    @PostMapping("/login")
    public String login(@RequestBody User user) {
        return userAuthentication.login(user.getUsername(), user.getPassword());
    }

    @PostMapping("/signup")
    public String signup(@RequestBody User user) {
        return userAuthentication.signup(user.getUsername(), user.getPassword());
    }


    //    @PostMapping("/addScore")
    //    public String login(@RequestBody User user, int score) {
    //        return leaderboard.addScore(user, score);
    //    }

    @PostMapping("/uploadImage")
    public ResponseEntity<?> uploadImage(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("File is empty.");
        }

        try {
            // Ensure the upload directory exists
            Path uploadPath = Paths.get("uploads/");
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Save the file
            Path filePath = uploadPath.resolve(file.getOriginalFilename());
            Files.write(filePath, file.getBytes());

            return ResponseEntity.ok("Image uploaded successfully: " + file.getOriginalFilename());
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload image.");
        }
    }
}