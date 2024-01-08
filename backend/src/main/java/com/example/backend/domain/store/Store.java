package com.example.backend.domain.store;

import com.example.backend.domain.Member;
import com.example.backend.domain.StoreCategory;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

import java.sql.Timestamp;

@Entity
@Table(name = "store")
@Getter
@Setter
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name; // 상점의 이름

    @Column(length = 100)
    private String phone; // 상점의 전화번호

    @Column(length = 100)
    private String address; // 상점의 주소

    @Column(length = 100)
    private String openStatus; // 상점의 영업 상태 (오픈, 클로즈 등)

    @Column(length = 500)
    private String introduction; // 상점의 소개

    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt; // 레코드가 생성된 시간

    @Column(name = "updated_at")
    private Timestamp updatedAt; // 레코드가 업데이트된 시간

    @Column(name = "deleted_at")
    private Timestamp deletedAt; // 레코드가 삭제된 시간

    @Column(name = "open_at")
    private Timestamp openAt; // 상점의 오픈 시간

    @Column(name = "close_at")
    private Timestamp closeAt; // 상점의 클로즈 시간

    @Column(name = "photo")
    private String photo; // 상점의 사진

    @ManyToOne
    @JoinColumn(name = "owner_id")
    private Member owner; // 상점 소유주와의 관계

    @ManyToOne
    @JoinColumn(name = "category_id")
    private StoreCategory category; // 상점 카테고리와의 관계
}
