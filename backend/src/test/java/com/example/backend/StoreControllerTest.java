package com.example.backend;

import com.example.backend.domain.store.Store; // Store 엔티티 임포트
import com.example.backend.repository.StoreRepository;
import com.fasterxml.jackson.databind.ObjectMapper; // ObjectMapper 임포트
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType; // MediaType 임포트
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post; // MockMvcRequestBuilders.post 임포트
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@SpringBootTest
@AutoConfigureMockMvc
public class StoreControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private StoreRepository storeRepository;

    @Test
    public void testCreateStore() throws Exception {
        Store store = new Store();
        store.setName("Test Store");
        // store의 다른 속성 설정...

        mockMvc.perform(post("/api/v1/store")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(asJsonString(store)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("Test Store"));
    }

    private static String asJsonString(final Object obj) {
        try {
            return new ObjectMapper().writeValueAsString(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
