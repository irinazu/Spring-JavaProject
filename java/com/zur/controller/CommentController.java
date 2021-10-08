package com.zur.controller;

import com.zur.entity.Newcomment;

import com.zur.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CommentController {

    @Autowired
    CommentService commentService;

    //вывод отзывов конкретного пользователя
    @GetMapping("/mycomments")
    public String  myComments(Model model) {
        List<Newcomment> newcommentList=commentService.findCommentsByUser();

        model.addAttribute("allMyComments",commentService.findCommentsByUser());

        return "mycomments";
    }

}
