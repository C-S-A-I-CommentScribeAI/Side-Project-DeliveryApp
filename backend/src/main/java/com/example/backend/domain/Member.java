package com.example.backend.domain;

import com.example.backend.domain.store.Store;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

@Entity
@Getter @Setter
public class Member {

    @Id @GeneratedValue
    @Column(name = "member_id")
    private Long id;

    @Column(nullable = false, length = 100)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(length = 100)
    private String phone;

    @Embedded
    @Column(length = 100)
    private Address address;

    @Column(length = 50)
    private String level;

    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;

    @Column(name = "updated_at")
    private Timestamp updatedAt;

    @Column(name = "deleted_at")
    private Timestamp deletedAt;

    @Column(name = "signout")
    private Timestamp signout;

    @JsonIgnore
    @OneToMany(mappedBy = "member")
    private List<Store> stores = new ArrayList<>();

}
