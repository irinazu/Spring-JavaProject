package com.zur.service;

import com.zur.entity.Newcart;
import com.zur.entity.User;
import com.zur.repository.NewCartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    @Autowired
    NewCartRepository cartRepository;

    //Нахождение козины по пользователю
    public List<Newcart> getCartByUser(){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        return cartRepository.findByUser(user);
    }
}
