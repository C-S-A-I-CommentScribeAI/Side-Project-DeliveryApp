package com.example.backend.service;

import com.example.backend.domain.store.Store;
import com.example.backend.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class StoreService {

    private final StoreRepository storeRepository;

    @Transactional
    public void saveStore(Store store) {
        storeRepository.save(store);
    }

    @Transactional
    public void updateStore(Long storeId, String name, String phone, String address, String openStatus, String introduction,
                            Timestamp openAt, Timestamp closeAt, String photo) {
        Store store = storeRepository.findOne(storeId);
        store.setName(name);
        store.setPhone(phone);
        store.setAddress(address);
        store.setOpenStatus(openStatus);
        store.setIntroduction(introduction);
        store.setOpenAt(openAt);
        store.setCloseAt(closeAt);
        store.setPhoto(photo);
        store.setUpdatedAt(new Timestamp(System.currentTimeMillis())); // 현재 시간으로 업데이트
    }

    public List<Store> findStore() {
        return storeRepository.findAll();
    }

    public Store findOne(Long storeId) {
        return storeRepository.findOne(storeId);
    }
}
