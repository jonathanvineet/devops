package com.example.login.service;

import com.example.login.model.User;
import com.example.login.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class AuthServiceTest {

    @Autowired
    private AuthService authService;

    @Autowired
    private UserRepository userRepository;

    @Test
    void authenticateWithValidCredentials() {
        userRepository.deleteAll();
        User u = new User("alice", "password123");
        userRepository.save(u);

        boolean ok = authService.authenticate("alice", "password123");
        assertThat(ok).isTrue();
    }

    @Test
    void authenticateWithInvalidCredentials() {
        userRepository.deleteAll();
        User u = new User("bob", "secret");
        userRepository.save(u);

        boolean ok = authService.authenticate("bob", "wrong");
        assertThat(ok).isFalse();
    }
}
