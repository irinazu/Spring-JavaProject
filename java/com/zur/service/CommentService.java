package com.zur.service;

import com.zur.entity.Newcomment;
import com.zur.entity.User;
import com.zur.repository.NewCommentRepository;
import com.zur.repository.NewProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class CommentService {

    @Autowired
    NewCommentRepository newCommentRepository;

    @Autowired
    NewProductRepository newProductRepository;

    //Сохранение комментария
    public void saveComment(Long id,String comment,String path){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        Newcomment comment1=new Newcomment();
        DateFormat dateFormat=new SimpleDateFormat("yyy/MM/dd HH:mm:ss");
        Date date=new Date();
        String s=dateFormat.format(date);
        comment1.setDate(s);
        comment1.setSrc_img_user(path);
        comment1.setComment(comment);

        comment1.setProduct(newProductRepository.findById(id).get());
        comment1.setUser(user);
        comment1.setUsername(user.getUsername());

        newCommentRepository.save(comment1);
    }

    //Нахождение комментариев по пользователю
    public List<Newcomment> findCommentsByUser(){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        return newCommentRepository.findByUser(user);

    }
}
