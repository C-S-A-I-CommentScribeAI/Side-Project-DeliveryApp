package com.example.backend.dto;

import com.example.backend.domain.UserAccount;
import com.example.backend.domain.UserAddress;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserAccountResponseDto {
    private String email;
    private String nickname;
    private String phone;
    private String userRole;
    private List<UserAddress> userAddressList;

    public static UserAccountResponseDto of(UserAccount userAccount){
        return UserAccountResponseDto.builder()
                .email(userAccount.getEmail())
                .nickname(userAccount.getNickname())
                .phone(userAccount.getPhone())
                .userRole(userAccount.getUserRole().toString())
                .build();
    }
}
