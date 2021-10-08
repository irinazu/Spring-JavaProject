package com.zur.entity;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "table_comment")
@Data
public class Newcomment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Newproduct product;

    private String comment;
    private String src_img_user;
    private String date;
    private String username;

    @PrePersist
    public void prePersist() {
        if(src_img_user == null)
            src_img_user = "no_img";
    }
}
