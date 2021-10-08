package com.zur.repository;

import com.zur.entity.Newcomment;
import com.zur.entity.Newproduct;
import com.zur.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NewCommentRepository extends JpaRepository<Newcomment,Long> {
    List<Newcomment> findByProduct(Newproduct newproduct);

    List<Newcomment> findByUser(User user);
}
