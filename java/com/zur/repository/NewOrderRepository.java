package com.zur.repository;

import com.zur.entity.Neworder;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewOrderRepository extends JpaRepository<Neworder,Long> {

    /*@Transactional
    List<Neworder> findAllByUser(User user);*/

    /*@Query("SELECT orderNumber FROM Neworder WHERE orderNumber = (SELECT MAX(orderNumber) FROM Neworder)")
    Neworder findBynum();*/

   /* @Transactional
    //Neworder find
    Neworder findFirstByOrderByOrderNumberDesc();*/

   /* @Transactional
    @Query("SELECT DISTINCT p.specificOrder FROM Neworder p where p.user = :user")
    List<Neworder> fi(@Param(value = "user") User user);*/
}
