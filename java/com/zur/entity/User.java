package com.zur.entity;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Collection;
import java.util.Set;

@Entity
@Table(name = "t_user")
@Data
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Size(min=2, message = "Не меньше 5 знаков")
    private String username;
    @Size(min=2, message = "Не меньше 5 знаков")
    private String password;
    @Transient
    private String passwordConfirm;
    @ManyToMany(fetch = FetchType.EAGER)
    private Set<Role> roles;

    @OneToMany(mappedBy = "user")
    Set<Neworder> orders;

    @OneToMany(mappedBy = "user")
    Set<Newcomment> comments;

    @OneToMany(mappedBy = "user")
    Set<Newcart> carts;

    @OneToMany(mappedBy = "user")
    Set<Like> likes;

    @OneToMany(mappedBy = "user")
    Set<SpecificOrder> specificOrders;

    public Set<Like> getLikes() {
        return likes;
    }

    public void setLikes(Set<Like> likes) {
        this.likes = likes;
    }

    public Set<Newcomment> getComments() {
        return comments;
    }

    public Set<Neworder> getOrders() {
        return orders;
    }

    public Set<Newcart> getCarts() {
        return carts;
    }

    public void setComments(Set<Newcomment> comments) {
        this.comments = comments;
    }

    public void setOrders(Set<Neworder> orders) {
        this.orders = orders;
    }

    public void setCarts(Set<Newcart> carts) {
        this.carts = carts;
    }

    public User() {
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    @Override
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

}
