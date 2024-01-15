package com.example.backend.controller;

import com.example.backend.dto.ChangePasswordRequestDto;
import com.example.backend.dto.UserAccountRequestDto;
import com.example.backend.dto.UserAccountResponseDto;
import com.example.backend.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
public class UserAccountController {

    private final UserAccountService userAccountService;

    @GetMapping("/info")
    public ResponseEntity<UserAccountResponseDto> getMyAccountInfo() {
        UserAccountResponseDto myInfoBySecurity = userAccountService.getMyInfoBySecurity();
        System.out.println(myInfoBySecurity.getNickname());
        return ResponseEntity.ok(myInfoBySecurity);
    }

    @PostMapping("/nickname")
    public ResponseEntity<UserAccountResponseDto> changeUserAccountNickname(@RequestBody UserAccountRequestDto requestDto) {
        return ResponseEntity.ok(userAccountService.changeUserAccountNickname(requestDto.getUserId(), requestDto.getNickname()));
    }

    @PostMapping("/password")
    public ResponseEntity<UserAccountResponseDto> changeUserAccountPassword(@RequestBody ChangePasswordRequestDto requestDto) {
        return ResponseEntity.ok(userAccountService.changeUserAccountPassword(requestDto.getUserId(), requestDto.getPassword(), requestDto.getNewPassword()));
    }
}
