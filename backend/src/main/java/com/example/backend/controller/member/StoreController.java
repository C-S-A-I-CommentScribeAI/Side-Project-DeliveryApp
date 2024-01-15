package com.example.backend.controller.member;

import com.example.backend.model.member.dto.StoreCreateRequest;
import com.example.backend.model.member.dto.StoreCreateResponse;
import com.example.backend.model.member.dto.StoreRetrieveResponse;
import com.example.backend.model.member.entity.Store;
import com.example.backend.model.member.enums.StoreState;
import com.example.backend.service.StoreService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/store")
public class StoreController {
    private final StoreService storeService;

    @GetMapping("/{storeId}")
    public ResponseEntity<StoreRetrieveResponse> retrieveStore(@PathVariable Long storeId) {
        StoreRetrieveResponse storeRetrieveResponse = storeService.retrieveStore(storeId);
        return new ResponseEntity<>(storeRetrieveResponse, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<StoreCreateResponse> createStore(@RequestBody StoreCreateRequest storeCreateRequest) {
        StoreCreateResponse storeCreateResponse = storeService.createStore(storeCreateRequest);
        return new ResponseEntity<>(storeCreateResponse, HttpStatus.CREATED);
    }

    @PutMapping("/{storeId}")
    public ResponseEntity<Store> updateStore(@PathVariable Long storeId, @RequestBody StoreCreateRequest storeCreateRequest) {
        Store updatedStore = storeService.updateStore(storeId, storeCreateRequest);
        return new ResponseEntity<>(updatedStore, HttpStatus.OK);
    }

    @DeleteMapping("/{storeId}")
    public ResponseEntity<Void> deleteStore(@PathVariable Long storeId) {
        storeService.deleteStore(storeId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
