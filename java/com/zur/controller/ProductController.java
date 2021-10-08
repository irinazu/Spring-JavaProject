package com.zur.controller;

import com.zur.entity.*;
import com.zur.repository.NewCartRepository;
import com.zur.repository.NewOrderRepository;
import com.zur.repository.NewProductRepository;
import com.zur.service.CartService;
import com.zur.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.Validator;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Controller
public class ProductController {

    @Autowired
    private CartService cartService;

    @Autowired
    private NewCartRepository newCartRepository;

    @Autowired
    private ProductService productService;

    @Autowired
    private NewProductRepository newProductRepository;

    @Autowired
    NewOrderRepository orderRepository;
    //вывод товаров на главную(первоначальный)
    @GetMapping("")
    public String productList(Model model) {

        return productListPagination(model,1);
    }

    //вывод товаров на главную(по страницам)
    @GetMapping("/page/{numberPage}")
    public String productListPagination(Model model, @PathVariable("numberPage") int currentPage) {

        Page<Newproduct> page=productService.allProduct(currentPage);
        List<Newproduct> productList=page.getContent();
        long totalItems=page.getTotalElements();
        int totalPages=page.getTotalPages();

        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("allProduct", productList);
        return "index";
    }

    //сохраниение товаров в корзину
    @PostMapping("")
    public String  buyProduct(@RequestParam(required = true, defaultValue = "" ) Long productId,
                              Model model) {

        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();


        if(!newCartRepository.existsByUserAndAndProduct(user,newProductRepository.findById(productId).get())){
            productService.saveProductInCart(productId);
        }
        List<Newproduct> productList=productService.getProductByUserId();
        Collections.sort(productList,Newproduct.COMPARE_BY_COUNT);
        List<Newcart> cartList=cartService.getCartByUser();
        Collections.sort(cartList,Newcart.COMPARE_BY_COUNT);

        model.addAttribute("productForUser",productList);
        model.addAttribute("carts",cartList);

        return "cart";
    }

    //вывод сохраниененных товаров
    @GetMapping("/cart")
    public String cart(Model model) {
        //List<Newproduct> productList=productService.getProductByUserId();
        //Collections.sort(productList,Newproduct.COMPARE_BY_COUNT);
        List<Newcart> cartList=cartService.getCartByUser();
        Collections.sort(cartList,Newcart.COMPARE_BY_COUNT);
        //model.addAttribute("productForUser",productList);
        model.addAttribute("carts",cartList);

        return "cart";
    }

    //Действия с товарами в корзине(удаление, прибавление, уменьшение)
    @PostMapping("/cart")
    public String  buyProductOrDelete(@RequestParam(required = true, defaultValue = "" ) Long id,
                                      @RequestParam(required = true, defaultValue = "" ) String action,

                              Model model) {
        if (action.equals("delete")){
            productService.deleteProductFromCart(id);
        }else if (action.equals("plus")){
            productService.plusProd(id);
        }else if (action.equals("minus")){
            productService.minusProd(id);
        }else{

            return "/order";
        }

        return "redirect:/cart";
    }

    //Вывод страницы заказов
    @GetMapping("/order")
    public String orderGet(Model model) {
        model.addAttribute("sporder",new SpecificOrder());
        return "order";
    }

    @Autowired
    private Validator personValidator;

    //Покупка-сохранение в таблицу заказов и удаление из таблицы корзины
    @PostMapping("/order")
    public String orderPost(@ModelAttribute("sporder") SpecificOrder sporder
                            ) {

            productService.saveProductInOrder(sporder);
            return "cart";



    }
}
