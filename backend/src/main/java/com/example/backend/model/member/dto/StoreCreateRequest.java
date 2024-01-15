package com.example.backend.model.member.dto;

import com.example.backend.model.member.entity.Address;
import com.example.backend.model.member.entity.Member;
import com.example.backend.model.member.entity.Store;
import com.example.backend.model.member.enums.StoreState;
import com.example.backend.repository.MemberRepository;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Optional;

@Getter
@NoArgsConstructor
public class StoreCreateRequest {
    private Long memberId;
    private Address address;
    private String storeName;
    private StoreState storeState;
    private double storeGrade;
    private int pickCount;
    private LocalDateTime birth; //창업일
    private LocalDateTime businessStartHour;
    private LocalDateTime businessEndHour;
    private String email;
    private String mobile;
    private String storeMainComment;
    private String storeSubComment;
    private int averageDeliverTime;  //평균 배달 시간(분단위)
    private String storeImagePath;

    @Builder
    public StoreCreateRequest(Long memberId, Address address, String storeName, StoreState storeState, double storeGrade, int pickCount, LocalDateTime birth, LocalDateTime businessStartHour, LocalDateTime businessEndHour, String email, String mobile, String storeMainComment, String storeSubComment, int averageDeliverTime, String storeImagePath) {
        this.memberId = memberId;
        this.address = address;
        this.storeName = storeName;
        this.storeState = storeState;
        this.storeGrade = storeGrade;
        this.pickCount = pickCount;
        this.birth = birth;
        this.businessStartHour = businessStartHour;
        this.businessEndHour = businessEndHour;
        this.email = email;
        this.mobile = mobile;
        this.storeMainComment = storeMainComment;
        this.storeSubComment = storeSubComment;
        this.averageDeliverTime = averageDeliverTime;
        this.storeImagePath = storeImagePath;
    }

    public Store DtoToEntity() {
        return Store.builder()
                .address(this.address)
                .averageDeliverTime(this.averageDeliverTime)
                .birth(this.birth)
                .email(this.email)
                .storeName(this.storeName)
                .businessEndHour(this.businessEndHour)
                .businessStartHour(this.businessStartHour)
                .storeGrade(this.storeGrade)
                .storeImagePath(this.storeImagePath)
                .storeGrade(this.storeGrade)
                .storeState(this.storeState)
                .storeMainComment(this.storeMainComment)
                .storeSubComment(this.storeSubComment)
                .pickCount(0)
                .mobile(this.mobile)
                .build();
    }


}
