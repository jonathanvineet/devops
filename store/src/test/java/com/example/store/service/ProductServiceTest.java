package com.example.store.service;

import com.example.store.model.Product;
import com.example.store.repository.ProductRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class ProductServiceTest {

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductRepository productRepository;

    @Test
    void addProductTest() {
        productRepository.deleteAll();
        
        Product p = productService.addProduct("Laptop", 999.99, 5);
        
        assertThat(p).isNotNull();
        assertThat(p.getName()).isEqualTo("Laptop");
        assertThat(p.getPrice()).isEqualTo(999.99);
        assertThat(p.getQuantity()).isEqualTo(5);
    }

    @Test
    void getAllProductsTest() {
        productRepository.deleteAll();
        
        productService.addProduct("Mouse", 25.50, 10);
        productService.addProduct("Keyboard", 75.00, 8);
        
        var products = productService.getAllProducts();
        
        assertThat(products).hasSize(2);
    }

    @Test
    void getProductByIdTest() {
        productRepository.deleteAll();
        
        Product saved = productService.addProduct("Monitor", 350.00, 3);
        Product retrieved = productService.getProductById(saved.getId());
        
        assertThat(retrieved).isNotNull();
        assertThat(retrieved.getName()).isEqualTo("Monitor");
    }

    @Test
    void updateProductTest() {
        productRepository.deleteAll();
        
        Product p = productService.addProduct("Phone", 599.99, 2);
        Product updated = productService.updateProduct(p.getId(), "Phone Pro", 799.99, 5);
        
        assertThat(updated.getName()).isEqualTo("Phone Pro");
        assertThat(updated.getPrice()).isEqualTo(799.99);
        assertThat(updated.getQuantity()).isEqualTo(5);
    }

    @Test
    void deleteProductTest() {
        productRepository.deleteAll();
        
        Product p = productService.addProduct("Tablet", 450.00, 4);
        productService.deleteProduct(p.getId());
        
        Product deleted = productService.getProductById(p.getId());
        assertThat(deleted).isNull();
    }
}
