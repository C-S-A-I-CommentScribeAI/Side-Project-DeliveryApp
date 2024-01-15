package com.example.backend.controller.member;


import com.example.backend.model.member.dto.MemberCreateRequest;
import com.example.backend.model.member.dto.MemberCreateResponse;
import com.example.backend.model.member.entity.Member;
import com.example.backend.service.LoginService;
import com.example.backend.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/members")
public class MemberController {
    private final MemberService memberService;
    private final LoginService loginService;


    @GetMapping(value = "/members/{memberId}")
    public ResponseEntity<Member> getMembers(@PathVariable(value = "memberId") Long memberId) {
        Member member = memberService.getMember(memberId);
        return new ResponseEntity<>(member, HttpStatus.OK);
    }

    // 모든 회원 조회
    @GetMapping
    public ResponseEntity<List<Member>> getAllMembers() {
        List<Member> member = memberService.getAllMembers();
        return new ResponseEntity<>(member, HttpStatus.OK);
    }

    // 회원 저장
    @PostMapping
    public ResponseEntity<MemberCreateResponse> createMember(@RequestBody MemberCreateRequest memberCreateRequest) {
        log.info("회원 가입 정보 = {}", memberCreateRequest);
        MemberCreateResponse memberCreateResponse = memberService.createMember(memberCreateRequest);
        return new ResponseEntity<>(memberCreateResponse, HttpStatus.OK);
    }
    // 로그인
    @PostMapping(value="/login")
    public ResponseEntity<Member> login(Member member){
        return ResponseEntity.ok(loginService.login(member));
    }
}
