package com.example.backend.service;

import com.example.backend.exception.ServiceGuideException;
import com.example.backend.model.member.dto.StoreCreateRequest;
import com.example.backend.model.member.dto.StoreCreateResponse;
import com.example.backend.model.member.dto.StoreRetrieveResponse;
import com.example.backend.model.member.entity.Member;
import com.example.backend.model.member.entity.Store;
import com.example.backend.repository.MemberRepository;
import com.example.backend.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class StoreService {

    private final MemberRepository memberRepository;
    private final StoreRepository storeRepository;

    public StoreRetrieveResponse retrieveStore(Long storeId) {
        Optional<Store> storeOptional = storeRepository.findById(storeId);
        if (storeOptional.isPresent()) {
            Store store = storeOptional.get();
            return new StoreRetrieveResponse().EntityToDto(store);
        } else {
            // Store가 존재하지 않을 때 처리
            throw new ServiceGuideException("Store not found for ID: " + storeId);
        }
    }

    @Transactional
    public StoreCreateResponse createStore(StoreCreateRequest storeCreateRequest) {
        Optional<Member> memberOptional = memberRepository.findById(storeCreateRequest.getMemberId());
        if (memberOptional.isPresent()) {
            Member member = memberOptional.get();

            Store store = storeCreateRequest.DtoToEntity(); // 매개변수로 member 정보를 전달
            store.setMember(member);

            Store createdStore = storeRepository.save(store);

            return new StoreCreateResponse().EntityToDto(createdStore);
        } else {
            // Member가 존재하지 않을 때 처리
            throw new ServiceGuideException("Member not found for ID: " + storeCreateRequest.getMemberId());
        }
    }

    @Transactional
    public Store updateStore(Long storeId, StoreCreateRequest storeCreateRequest) {
        Optional<Store> storeOptional = storeRepository.findById(storeId);
        if (storeOptional.isPresent()) {
            Store existingStore = storeOptional.get();
            // 업데이트 로직을 구현하고, existingStore를 저장한 후 반환
            // 예: existingStore.setName(storeCreateRequest.getName());
            Store updatedStore = storeRepository.save(existingStore);
            return updatedStore;
        } else {
            // Store가 존재하지 않을 때 처리
            throw new ServiceGuideException("Store not found for ID: " + storeId);
        }
    }

    @Transactional
    public void deleteStore(Long storeId) {
        Optional<Store> storeOptional = storeRepository.findById(storeId);
        if (storeOptional.isPresent()) {
            storeRepository.deleteById(storeId);
        } else {
            // Store가 존재하지 않을 때 처리
            throw new ServiceGuideException("Store not found for ID: " + storeId);
        }
    }
}
