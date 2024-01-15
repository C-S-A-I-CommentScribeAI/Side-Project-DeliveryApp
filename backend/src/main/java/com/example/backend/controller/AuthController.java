package com.example.backend.controller;

import com.example.backend.dto.TokenDto;
import com.example.backend.dto.UserAccountRequestDto;
import com.example.backend.dto.UserAccountResponseDto;
import com.example.backend.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/signup")
    public ResponseEntity<UserAccountResponseDto> signup(@RequestBody UserAccountRequestDto requestDto) {
        return ResponseEntity.ok(authService.signup(requestDto));
    }

    @PostMapping("/login")
    public ResponseEntity<TokenDto> login(@RequestBody UserAccountRequestDto requestDto) {
        return ResponseEntity.ok(authService.login(requestDto));
    }
}
