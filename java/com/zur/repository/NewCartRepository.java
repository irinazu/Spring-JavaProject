package com.zur.repository;

import com.zur.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;

public interface NewCartRepository extends JpaRepository<Newcart, Long> {
    @Transactional
    void deleteByProduct(Newproduct product);

    List<Newcart> findByUser(User user);

    @Transactional
    long deleteByUser(User user);

    @Transactional
    Newcart findByProductAndUser(Newproduct product, User usr);

    @Transactional
    boolean existsByUserAndAndProduct(User user,Newproduct newproduct);
}
