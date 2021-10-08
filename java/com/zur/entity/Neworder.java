package com.zur.entity;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "neworder")
@Data
public class Neworder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Newproduct product;

    @ManyToOne
    @JoinColumn(name="specificOrder_id")
    private SpecificOrder specificOrder;

}
