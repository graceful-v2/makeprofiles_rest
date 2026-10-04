package com.make_profile.repository.templates;

import com.make_profile.entity.templates.TemplateHeaderEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface TemplateHeaderRepository extends JpaRepository<TemplateHeaderEntity, Long> {
}
