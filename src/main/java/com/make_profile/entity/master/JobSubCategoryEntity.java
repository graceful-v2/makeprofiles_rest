package com.make_profile.entity.master;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "job_subcategory")
public class JobSubCategoryEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "subcategory_name", nullable = false, length = 150)
    private String subcategoryName;


    @ManyToOne()
    @JoinColumn(name = "category_id", nullable = false)
    private JobCategoryEntity category;

    @OneToMany(mappedBy = "subCategory", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<JobSubSubCategoryEntity> subSubCategories;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSubcategoryName() {
        return subcategoryName;
    }

    public void setSubcategoryName(String subcategoryName) {
        this.subcategoryName = subcategoryName;
    }

    public JobCategoryEntity getCategory() {
        return category;
    }

    public void setCategory(JobCategoryEntity category) {
        this.category = category;
    }

    public List<JobSubSubCategoryEntity> getSubSubCategories() {
        return subSubCategories;
    }

    public void setSubSubCategories(List<JobSubSubCategoryEntity> subSubCategories) {
        this.subSubCategories = subSubCategories;
    }
}
