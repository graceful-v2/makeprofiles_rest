package com.make_profile.entity.master;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "job_category")
public class JobCategoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "category_name", nullable = false, length = 100)
    private String categoryName;


    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private List<JobSubCategoryEntity> subCategories;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<JobSubCategoryEntity> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<JobSubCategoryEntity> subCategories) {
        this.subCategories = subCategories;
    }
}
