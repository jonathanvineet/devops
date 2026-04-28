package com.example.store.controller;

import com.example.store.model.Product;
import com.example.store.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping({"/", "/products"})
    public String listProducts(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "product-list";
    }

    @GetMapping("/add")
    public String addForm() {
        return "add-product";
    }

    @PostMapping("/add")
    public String addProduct(@RequestParam String name,
                             @RequestParam Double price,
                             @RequestParam Integer quantity) {
        productService.addProduct(name, price, quantity);
        return "redirect:/products";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "edit-product";
    }

    @PostMapping("/update/{id}")
    public String updateProduct(@PathVariable Long id,
                                @RequestParam String name,
                                @RequestParam Double price,
                                @RequestParam Integer quantity) {
        productService.updateProduct(id, name, price, quantity);
        return "redirect:/products";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/products";
    }
}
