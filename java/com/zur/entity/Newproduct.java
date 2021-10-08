package com.zur.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.Comparator;
import java.util.Set;

@Entity
@Table(name = "newproduct")
@Data
public class Newproduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String description;
    private int count;
    private String src_image;
    private int price;
    private String category;
    private String brand;

    @OneToMany(mappedBy = "product")
    Set<Neworder> orders;


    @OneToMany(mappedBy = "product")
    Set<Newcomment> comments;

    @OneToMany(mappedBy = "product")
    Set<Newcart> carts;

    @OneToMany(mappedBy = "product")
    Set<Like> likes;

    public Set<Like> getLikes() {
        return likes;
    }

    public void setLikes(Set<Like> likes) {
        this.likes = likes;
    }

    public Set<Newcart> getCarts() {
        return carts;
    }

    public void setCarts(Set<Newcart> carts) {
        this.carts.addAll(carts);
    }


    public Set<Newcomment> getComments() {
        return comments;
    }

    public void setComments(Set<Newcomment> comments) {
        this.comments = comments;
    }

    public Set<Neworder> getOrders() {
        return orders;
    }


    public void setOrders(Set<Neworder> orders) {
        this.orders = orders;
    }


    public static final Comparator<Newproduct> COMPARE_BY_COUNT = new Comparator<Newproduct>() {
        @Override
        public int compare(Newproduct lhs, Newproduct rhs) {
            return (int) (lhs.getId() - rhs.getId());
        }
    };
}
