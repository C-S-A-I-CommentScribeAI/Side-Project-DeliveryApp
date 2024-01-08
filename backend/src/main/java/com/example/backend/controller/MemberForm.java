package com.example.backend.controller;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

@Getter @Setter
public class MemberForm {
    @NotEmpty(message = "회원 이름은 필수 입니다")
    private String name;

    @Email(message = "유효한 이메일 주소를 입력해 주세요")
    @NotEmpty(message = "이메일은 필수 입니다")
    private String email;

    @Size(min = 8, message = "비밀번호는 최소 8자 이상이어야 합니다")
    @NotEmpty(message = "비밀번호는 필수 입니다")
    private String password;

    @NotEmpty(message = "전화번호는 필수 입니다")
    private String phone;

    @NotEmpty(message = "level은 필수 입니다")
    private String level;

    @NotEmpty(message = "주소지는 필수 입니다")
    private String city;

    @NotEmpty(message = "주소지는 필수 입니다")
    private String street;

    @NotEmpty(message = "주소지는 필수 입니다")
    private String zipcode;
}
