package com.example.ascend.hackumass;
import com.example.ascend.hackumass.model.UserAuthentication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class HackumassApplication {

    public static void main(String[] args) {
        SpringApplication.run(HackumassApplication.class, args);
        UserAuthentication userAuthentication = new UserAuthentication();
    }

}