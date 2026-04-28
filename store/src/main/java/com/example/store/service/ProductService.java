package com.example.store.service;

import com.example.store.model.Product;
import com.example.store.repository.ProductRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Product addProduct(String name, Double price, Integer quantity) {
        Product product = new Product(name, price, quantity);
        return productRepository.save(product);
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    public Product updateProduct(Long id, String name, Double price, Integer quantity) {
        Product product = getProductById(id);
        if (product != null) {
            product.setName(name);
            product.setPrice(price);
            product.setQuantity(quantity);
            return productRepository.save(product);
        }
        return null;
    }

    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }
}
