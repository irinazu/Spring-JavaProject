package com.zur.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.Comparator;

@Entity
@Table(name = "newcart")
@Data
public class Newcart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Integer countforcart;
    private Integer priceincart;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Newproduct product;

    @PrePersist
    public void prePersist() {
        if(countforcart == null)
            countforcart = 1;
    }


    public void minusCountForCart() {
        --countforcart;
    }

    public void plusCountForCart() {
        ++countforcart;
    }

    public Newcart(){

    }


    public static final Comparator<Newcart> COMPARE_BY_COUNT = new Comparator<Newcart>() {
        @Override
        public int compare(Newcart lhs, Newcart rhs) {
            return (int) (lhs.getProduct().getId() - rhs.getProduct().getId());
        }
    };
}
