package com.make_profile.entity.master;

import jakarta.persistence.*;

@Entity
@Table(name = "job_sub_subcategory")
public class JobSubSubCategoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "sub_subcategory_name", nullable = false, length = 150)
    private String subSubcategoryName;

    @ManyToOne()
    @JoinColumn(name = "subcategory_id", nullable = false)
    private JobSubCategoryEntity subCategory;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public JobSubCategoryEntity getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(JobSubCategoryEntity subCategory) {
        this.subCategory = subCategory;
    }

    public String getSubSubcategoryName() {
        return subSubcategoryName;
    }

    public void setSubSubcategoryName(String subSubcategoryName) {
        this.subSubcategoryName = subSubcategoryName;
    }
}
