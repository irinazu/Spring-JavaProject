package com.zur.service;

import com.zur.entity.*;
import com.zur.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ProductService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    SpecificOrderRepository specificOrderRepository;

    @Autowired
    NewProductRepository productRepository;

    @Autowired
    UserRepository repository;

    @Autowired
    NewCartRepository cartRepository;

    @Autowired
    NewOrderRepository orderRepository;

    //Вывод всех товаров
    public Page<Newproduct> allProduct(int pageNamber) {
        Pageable pageable= PageRequest.of(pageNamber-1,3);
        return productRepository.findAll(pageable);
    }
    //Вывод всех товаров по категориям
    public Page<Newproduct> allProductForCategory(int pageNamber,String category) {
        Pageable pageable= PageRequest.of(pageNamber-1,3);
        return productRepository.findAllByCategory(category,pageable);
    }

    //Вывод всех товаров по поиску
    public Page<Newproduct> allProductForSearch(int pageNamber,String key) {
        Pageable pageable= PageRequest.of(pageNamber-1,3);
        return productRepository.findAll(key,pageable);
    }

    //Сохранение в корзину
    public boolean saveProductInCart(Long productId) {
        Optional<Newproduct> product=productRepository.findById(productId);

         User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();


        Newcart cart=new Newcart();
        cart.setProduct(product.get());
        cart.setUser(user);
        cart.setCountforcart(1);
        cart.setPriceincart(product.get().getPrice());
        cartRepository.save(cart);

        return true;
    }


    public List<Newproduct> getProductByUserId(){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        List<Newcart> allByUser_id=cartRepository.findByUser(user);
        List<Newproduct> productList=new ArrayList<>();

        for (Newcart c : allByUser_id){
            Optional <Newproduct> productFromDb = productRepository.findById(c.getProduct().getId());
            Newproduct product=productFromDb.get();
            productList.add(product);
        }
        return  productList;

    }

    //Удаление из корзины
    public void deleteProductFromCart(Long prodId) {
       cartRepository.deleteByProduct(productRepository.findById(prodId).get());

    }

    //Сохранение товаров в раздел заказов
    public boolean saveProductInOrder(SpecificOrder order) {
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        DateFormat dateFormat=new SimpleDateFormat("yyy/MM/dd HH:mm:ss");
        Date date=new Date();
        String s=dateFormat.format(date);
        order.setDate(s);

        order.setUser(user);

        order.setStep("Создано");
        Integer sum=0;

        specificOrderRepository.save(order);

        List<Newcart> carts=cartRepository.findByUser(user);
        for (Newcart c:carts) {
            Neworder neworder=new Neworder();

            neworder.setSpecificOrder(order);
            neworder.setProduct(c.getProduct());
            neworder.setUser(user);

            Optional<Newproduct> optionalProduct=productRepository.findById(c.getProduct().getId());
            Newproduct product=optionalProduct.get();
            sum+=product.getPrice()*c.getCountforcart();

            orderRepository.save(neworder);
        }

        order.setPrice(sum);
        specificOrderRepository.save(order);

        cartRepository.deleteByUser(user);
        return true;
    }

    //Изменение количества товара в корзине(+)
    public void plusProd(Long id){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId=user.getId();

        Optional<Newproduct> product=productRepository.findById(id);
        Newproduct product1=product.get();

        Newcart cart=cartRepository.findByProductAndUser(product1,user);

        if(product1.getCount()>=(cart.getCountforcart()+1)){

            cart.plusCountForCart();
            cart.setPriceincart(cart.getPriceincart()+product.get().getPrice());
            cartRepository.save(cart);
            product1.setCount(product1.getCount()-1);
            productRepository.save(product1);
        }

    }

    //Изменение количества товара в корзине(-)
    public void minusProd(Long id){
        User user=(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId=user.getId();

        Optional<Newproduct> product=productRepository.findById(id);
        Newproduct product1=product.get();

        Newcart cart=cartRepository.findByProductAndUser(product1,user);
        if(cart.getCountforcart()>1){

            cart.minusCountForCart();
            cart.setPriceincart(cart.getPriceincart()-product.get().getPrice());
            cartRepository.save(cart);
            product1.setCount(product1.getCount()+1);
            productRepository.save(product1);
        }

    }
}
