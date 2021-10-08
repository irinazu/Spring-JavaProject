package com.zur.controller;

import com.zur.entity.Like;
import com.zur.entity.Newproduct;
import com.zur.entity.User;
import com.zur.repository.LikeRepository;
import com.zur.repository.NewProductRepository;
import com.zur.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class LikeController {

    @Autowired
    NewProductRepository newProductRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    LikeRepository likeRepository;

    //Добавляем понравившиеся товары в таблицу Like
    @GetMapping("/like")
    public String like(@RequestParam(required = true, defaultValue = "" ) Long productId){

        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Like like=new Like();
        if(!likeRepository.existsByUserAndAndProduct(user,newProductRepository.findById(productId).get())){
            like.setProduct(newProductRepository.findById(productId).get());
            like.setUser(user);
            likeRepository.save(like);
        }

        return "redirect:/";

    }

    //Находим понравившиеся пользователю товары
    @GetMapping("/alllike")
    public  String allLike(Model model){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Like> likeList=likeRepository.findByUser(user);
        List<Newproduct> newproductList=new ArrayList<>();
        for (Like like : likeList){
            newproductList.add(like.getProduct());
        }
        model.addAttribute("allProduct",newproductList);
        return "alllike";
    }

    //Удаляем понравившиеся товары из таблицы Like
    @GetMapping("/deletelike")
    public String  deleteLike(@RequestParam(required = true, defaultValue = "" ) Long productId) {
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        likeRepository.deleteByProduct(newProductRepository.findById(productId).get());

        return "redirect:/alllike";
    }

}
