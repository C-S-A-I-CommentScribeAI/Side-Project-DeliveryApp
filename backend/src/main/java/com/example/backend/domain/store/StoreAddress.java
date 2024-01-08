package com.example.backend.domain.store;

import lombok.Getter;

import javax.persistence.Embeddable;

@Embeddable
@Getter
public class StoreAddress {
    private String city;
    private String street;
    private String zipcode;

    protected StoreAddress() {
    }

    public StoreAddress(String city, String street, String zipcode) {
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
    }
}