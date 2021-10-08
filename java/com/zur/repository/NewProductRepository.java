package com.zur.repository;

import com.zur.entity.Newproduct;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;

public interface NewProductRepository extends PagingAndSortingRepository<Newproduct, Long> {
    @Transactional
    @Modifying(clearAutomatically = true)
    @Query("update Newproduct u set u.brand = :brand,u.category = :category,u.count = :count, u.description = :description,u.name = :name,u.src_image = :src_image,u.price = :price where u.id = :id")
    void setProductInfoById(@Param(value = "id") Long id, @Param(value = "brand") String brand, @Param(value = "category") String category, @Param(value = "count") Integer count, @Param(value = "description")  String description, @Param(value = "name") String name, @Param(value = "src_image") String src_image, @Param(value = "price") Integer price);

    //Page<Product> findBy(boolean published, Pageable pageable);

    Page<Newproduct> findAllByCategory(String category, Pageable pageable);

    @Query("select p from Newproduct p where "
            +"concat( p.name,p.description,p.brand) " +
            "like %?1%")
    Page<Newproduct> findAll(String key,Pageable pageable);

   /* @Query("select p from Product p where "
            +"concat( p.name,p.description,p.brand) " +
            "like %?1%"+
            "and p.price < :num"
    )
    Page<Product> findAll(String key,@Param(value = "num") int num,Pageable pageable);*/
}
