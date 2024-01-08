package com.example.backend.domain;

import com.example.backend.domain.store.Store;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

import static javax.persistence.FetchType.LAZY;

@Entity
@Getter @Setter
public class StoreCategory {

    @Id @GeneratedValue
    @Column(name = "category_id")
    private Long id;

    private String name;

    @ManyToMany
    @JoinTable(name = "category_store",
            joinColumns = @JoinColumn(name = "category_id"),
            inverseJoinColumns = @JoinColumn(name = "store_id"))
    private List<Store> stores = new ArrayList<>();

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "parent_id")
    private StoreCategory parent;

    @OneToMany(mappedBy = "parent")
    private List<StoreCategory> child = new ArrayList<>();

    //==연관관계 메서드==//
    public void addChildCategory(StoreCategory child) {
        this.child.add(child);
        child.setParent(this);
    }

}
