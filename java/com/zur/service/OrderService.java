package com.zur.service;

import com.zur.entity.SpecificOrder;
import com.zur.entity.User;
import com.zur.repository.SpecificOrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    SpecificOrderRepository specificOrderRepository;

    //Нахождение заказов по пользователю
    public List<SpecificOrder> getOrdersByUser(){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        return specificOrderRepository.findAllByUser(user);

    }


}
