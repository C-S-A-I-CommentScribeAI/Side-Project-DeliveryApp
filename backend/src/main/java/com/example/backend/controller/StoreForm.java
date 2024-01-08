package com.example.backend.controller;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
@Getter @Setter
public class StoreForm {

    private Long id;

    private String name;
    private String phone;
    private String address;
    private String openStatus;
    private String introduction;
    private Timestamp openAt;
    private Timestamp closeAt;
    private String photo;

}
