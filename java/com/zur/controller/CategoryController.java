package com.zur.controller;

import com.zur.entity.Newproduct;
import com.zur.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class CategoryController {
    @Autowired
    ProductService productService;

    //вывод товаров по категорияем(первоначальный)
    @GetMapping("/category/{i}")
    public String productListPagination(Model model, @PathVariable("i") String currentCategory) {
       return productListPaginationCategory(model,1,currentCategory);
    }

    //вывод товаров по категорияем по страницам
    @GetMapping("/category/{i}/{numberPage}")
    public String productListPaginationCategory(Model model,
                                                @PathVariable("numberPage") int currentPage,
                                                @PathVariable("i") String currentCategory) {

        Page<Newproduct> page=productService.allProductForCategory(currentPage,currentCategory);
        List<Newproduct> productList=page.getContent();
        long totalItems=page.getTotalElements();
        int totalPages=page.getTotalPages();

        model.addAttribute("currentCategory", currentCategory);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("allProduct", productList);
        return "category";
    }
}
