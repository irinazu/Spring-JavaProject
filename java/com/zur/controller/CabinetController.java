package com.zur.controller;

import com.zur.entity.Newproduct;
import com.zur.entity.SpecificOrder;
import com.zur.repository.NewCommentRepository;
import com.zur.repository.NewProductRepository;
import com.zur.repository.SpecificOrderRepository;
import com.zur.service.CommentService;
import com.zur.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.*;

@Controller
public class CabinetController {
    @Autowired
    CommentService commentService;

    @Autowired
    OrderService orderService;

    @Autowired
    NewProductRepository newProductRepository;

    @Autowired
    NewCommentRepository newCommentRepository;

    @Autowired
    SpecificOrderRepository specificOrderRepository;

    //Вывод заказов в личный кабмнет
    @GetMapping("/cabinet")
    public String cabinetUser(Model model){

        List<SpecificOrder> orderList=orderService.getOrdersByUser();

        model.addAttribute("orders",orderList);
        return "cabinet";
    }

    //Вывод конкретного товара
    @GetMapping("/item")
    public String cabinetUser(Model model,
                              @RequestParam() Long productId){


        Optional<Newproduct> product=newProductRepository.findById(productId);
        model.addAttribute("product",product.get());
        model.addAttribute("productComments",newCommentRepository.findByProduct(product.get()));
        return "item";
    }

    @GetMapping("/deleteComment")
    public String  deleteComment(@RequestParam(required = true, defaultValue = "" ) Long commentId,
                               @RequestParam(required = true, defaultValue = "" ) Long productId,
                               Model model) {
        newCommentRepository.deleteById(commentId);
        System.out.println(commentId);
        System.out.println(productId);
        return cabinetUser(model,productId);
    }

    //Создание комментария, как с текстом , так и с картинкой
    @PostMapping("/createComment")
    public String createComment(Model model,
                                @RequestParam(required = true, defaultValue = "" ) String textComment,
                                @RequestParam(required = true, defaultValue = "" ) Long productId,
                                @RequestParam("file") MultipartFile file){

        if(!file.isEmpty()) {
            String uuid = UUID.randomUUID().toString();
            File file2 = new File("src/main/webapp/resources/images/users_images/" + uuid + file.getOriginalFilename());
            String path = "/resources/images/users_images/" + uuid + file.getOriginalFilename();
            commentService.saveComment(productId,textComment,path);

            try (OutputStream os = new FileOutputStream(file2)) {
                os.write(file.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            commentService.saveComment(productId,textComment,null);
        }

        return cabinetUser(model,productId);

    }

}
