package com.zur.controller;

import com.zur.entity.Newproduct;
import com.zur.entity.SpecificOrder;
import com.zur.repository.NewCommentRepository;
import com.zur.repository.NewProductRepository;
import com.zur.repository.SpecificOrderRepository;
import com.zur.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Controller
public class AdminController {
    @Autowired
    private UserService userService;

    @Autowired
    private NewProductRepository newProductRepository;

    @Autowired
    private SpecificOrderRepository specificOrderRepository;

    @Autowired
    private NewCommentRepository newCommentRepository;

    //добавление всех пользователей на страницу
    @GetMapping("/admin")
    public String userList(Model model) {
        model.addAttribute("allUsers", userService.allUsers());
        return "admin";
    }

    //принятие запроса на удаление
    @PostMapping("/admin")
    public String  deleteUser(@RequestParam(required = true, defaultValue = "" ) Long userId,
                              @RequestParam(required = true, defaultValue = "" ) String action,
                              Model model) {
        if (action.equals("delete")){
            userService.deleteUser(userId);
        }
        return "redirect:/admin";
    }


   /* @GetMapping("/admin/gt/{userId}")
    public String  gtUser(@PathVariable("userId") Long userId, Model model) {
        model.addAttribute("allUsers", userService.usergtList(userId));
        return "admin";
    }*/

    //обновление характеристик товара(передача на страницу его полей)
    @GetMapping("/update")
    public String  updateGet(@RequestParam(required = true, defaultValue = "" ) Long productId,
                              @RequestParam(required = true, defaultValue = "" ) String action,
                              Model model) {
        if(action.equals("update")){
            Optional<Newproduct> product=newProductRepository.findById(productId);

            model.addAttribute("product",product.get());
        }

        return "update";
    }

    //обновление характеристик товара(считывание данных)
    @PostMapping("/update")
    public String  updatePost(@ModelAttribute("product") Newproduct newproduct,
                              @RequestParam("file") MultipartFile file) {


        if(!file.isEmpty()){
            String uuid= UUID.randomUUID().toString();
            File file2 = new File("src/main/webapp/resources/images/"+uuid+file.getOriginalFilename());
            String path="/resources/images/"+uuid+file.getOriginalFilename();

            newproduct.setSrc_image(path);
            newProductRepository.save(newproduct);
            try (OutputStream os = new FileOutputStream(file2)) {
                os.write(file.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{

            newProductRepository.save(newproduct);
        }

        return "redirect:/";
    }

    //создание нового товара(вывод пустых полей)
    @GetMapping("/create")
    public String  createGet(Model model) {
        model.addAttribute("newproduct",new Newproduct());
        return "create";
    }

    //создание нового товара(считывание информации)
    @PostMapping("/create")
    public String  createPost(@ModelAttribute("newproduct") Newproduct product,
                              @RequestParam("file") MultipartFile file) {
        //сохраняем картинку товара, причем для безопасности меняем название добавляя случайную строку
        if(!file.isEmpty()){
            String uuid= UUID.randomUUID().toString();
            File file2 = new File("src/main/webapp/resources/images/"+uuid+file.getOriginalFilename());
            String path="/resources/images/"+uuid+file.getOriginalFilename();

            try (OutputStream os = new FileOutputStream(file2)) {
                os.write(file.getBytes());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            product.setSrc_image(path);
            newProductRepository.save(product);

        }
        return "redirect:/";
    }

    //вывод заказов, для администратора, без статуса "Получено"
    @GetMapping("/orderStatus")
    public String  orderStatusGet(Model model) {
        List<SpecificOrder> orders=specificOrderRepository.findAll();

        List<SpecificOrder> specificOrders=new ArrayList<>();
        for (SpecificOrder order : orders){
            if(!order.getStep().equals("Получено")){
                specificOrders.add(order);
            }
        }

        model.addAttribute("orders",specificOrders);
        return "orderStatus";
    }

    //Изменение-обновление статуса заказа администратором
    @PostMapping("/orderStatus")
    public String  orderStatusPost(@RequestParam(required = true, defaultValue = "" ) String step,
                                   @RequestParam(required = true, defaultValue = "" ) Long id,
                                   Model model) {
       SpecificOrder order=specificOrderRepository.findById(id).get();
       order.setStep(step);
       specificOrderRepository.save(order);

        return "redirect:/orderStatus";
    }

    //Поиск заказа(ов) по ключевым словам
    @GetMapping("/searchOrders")
    public String  searchOrdersGet(@RequestParam(required = true, defaultValue = "" ) String currentKeyOrder,
                                   Model model) {


        model.addAttribute("orders",specificOrderRepository.findAll(currentKeyOrder));
        return "orderStatus";
    }


    @GetMapping("/searchOrdersId")
    public String  searchOrdersGetId(@RequestParam(required = true, defaultValue = "" ) Long currentKeyOrderId,
                                   Model model) {

        SpecificOrder order  = specificOrderRepository.findById(currentKeyOrderId).get();
        List<SpecificOrder> specificOrders=new ArrayList<>();
        specificOrders.add(order);
        model.addAttribute("orders",specificOrders);
        return "orderStatus";
    }

}
