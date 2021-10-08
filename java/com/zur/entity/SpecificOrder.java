package com.zur.entity;


import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.Comparator;
import java.util.List;

@Entity
@Table(name = "specificOrder")
@Data
public class SpecificOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy="specificOrder")
    private List<Neworder> neworders;

    private int price;

    private String name;
    private String surname;
    private String phone;
    private String town;
    private String house;
    private String flat;
    private Integer index;
    private String date;

    private String step;

    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;


    public static final Comparator<SpecificOrder> COMPARE_BY_COUNT = new Comparator<SpecificOrder>() {
        @Override
        public int compare(SpecificOrder lhs, SpecificOrder rhs) {
            return (int) (lhs.getId() - rhs.getId());
        }
    };

}
