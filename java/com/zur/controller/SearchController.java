package com.zur.controller;

import com.zur.entity.Newproduct;
import com.zur.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class SearchController {
    @Autowired
    ProductService productService;

    //вывод товаров по совпадение(первоначальный)
    @GetMapping("/search")
    public String productListPagination(Model model, @RequestParam(required = true) String currentKey) {
        return productListPaginationSearch(model,1,currentKey,currentKey);
    }

    //вывод товаров по совпадению по страницам
    @GetMapping("/search/{i}/{numberPage}")
    public String productListPaginationSearch(Model model,
                                                @PathVariable("numberPage") int currentPage,
                                              @PathVariable("i") String currentKeyPV,
                                                @RequestParam(required = false) String currentKey) {
        Page<Newproduct> page;

        if(currentKey==null){

            page=productService.allProductForSearch(currentPage,currentKeyPV);
            model.addAttribute("currentKey", currentKeyPV);
        }else{

            page=productService.allProductForSearch(currentPage,currentKey);
            model.addAttribute("currentKey", currentKey);
        }

        List<Newproduct> productList=page.getContent();

        long totalItems=page.getTotalElements();
        int totalPages=page.getTotalPages();


        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("allProduct", productList);
        return "search";
    }

}
