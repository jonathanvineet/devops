package com.example.login.service;

import com.example.login.model.User;
import com.example.login.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    private final UserRepository userRepository;

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean authenticate(String username, String password) {
        Optional<User> u = userRepository.findByUsername(username);
        return u.map(user -> user.getPassword().equals(password)).orElse(false);
    }

    public User register(String username, String password) {
        User user = new User(username, password);
        return userRepository.save(user);
    }
}
