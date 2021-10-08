package com.zur.repository;

import com.zur.entity.Like;
import com.zur.entity.Newproduct;
import com.zur.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;

public interface LikeRepository extends JpaRepository<Like,Long> {

     List<Like> findByUser(User user);

     @Transactional
     void deleteByProduct(Newproduct newproduct);

     @Transactional
     boolean existsByUserAndAndProduct(User user,Newproduct newproduct);
}
