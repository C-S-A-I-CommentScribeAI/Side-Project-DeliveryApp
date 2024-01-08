package com.example.backend.controller;

import com.example.backend.domain.store.Store;
import com.example.backend.service.StoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.sql.Timestamp;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;

    @GetMapping("/store/new")
    public String createForm(Model model) {
        model.addAttribute("form", new StoreForm());
        return "stores/createStoreForm";
    }

    @PostMapping("/stores/new")
    public String create(StoreForm form) {
        Store store = new Store();
        store.setName(form.getName());
        store.setPhone(form.getPhone());
        store.setAddress(form.getAddress());
        store.setOpenStatus(form.getOpenStatus());
        store.setIntroduction(form.getIntroduction());
        store.setOpenAt(form.getOpenAt());
        store.setCloseAt(form.getCloseAt());
        store.setPhoto(form.getPhoto());
        store.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        storeService.saveStore(store);
        return "redirect:/";
    }

    @GetMapping("/stores")
    public String list(Model model) {
        List<Store> stores = storeService.findStore(); // 메서드 이름 변경
        model.addAttribute("stores", stores);
        return "store/storeList";
    }

    @GetMapping("/stores/{storeId}/edit")
    public String updateItemForm(@PathVariable("storeId") Long storeId, Model model) {
        Store store = storeService.findOne(storeId);

        StoreForm form = new StoreForm();
        form.setId(store.getId());
        form.setName(store.getName());
        form.setPhone(store.getPhone());
        form.setAddress(store.getAddress());
        form.setOpenStatus(store.getOpenStatus());
        form.setIntroduction(store.getIntroduction());
        form.setOpenAt(store.getOpenAt());
        form.setCloseAt(store.getCloseAt());
        form.setPhoto(store.getPhoto());

        model.addAttribute("form", form);
        return "stores/updateStoreForm";
    }

    @PostMapping("/stores/{storeId}/edit")
    public String updateStore(@PathVariable Long storeId, @ModelAttribute("form") StoreForm form) {
        storeService.updateStore(storeId, form.getName(), form.getPhone(), form.getAddress(), form.getOpenStatus(), form.getIntroduction(),
                form.getOpenAt(), form.getCloseAt(), form.getPhoto());

        return "redirect:/stores";
    }
}
