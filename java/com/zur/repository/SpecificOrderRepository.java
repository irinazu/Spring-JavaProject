package com.zur.repository;

import com.zur.entity.SpecificOrder;
import com.zur.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SpecificOrderRepository extends JpaRepository<SpecificOrder,Long> {

    List<SpecificOrder> findAllByUser(User user);

    @Query("select p from SpecificOrder p where "
            +"concat( p.surname,p.date,p.step) " +
            "like %?1%")
    List<SpecificOrder> findAll(String key);
}
