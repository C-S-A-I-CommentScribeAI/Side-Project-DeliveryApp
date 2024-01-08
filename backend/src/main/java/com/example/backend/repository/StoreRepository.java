package com.example.backend.repository;


import com.example.backend.domain.store.Store;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class StoreRepository {

    private final EntityManager em;

    public void save(Store store) {
        if (store.getId() == null) {
            em.persist(store);
        } else {
            em.merge(store);
        }
    }

    public Store findOne(Long id) {
        return em.find(Store.class, id);
    }

    public List<Store> findAll() {
        return em.createQuery("select i from Store i", Store.class)
                .getResultList();
    }
}
