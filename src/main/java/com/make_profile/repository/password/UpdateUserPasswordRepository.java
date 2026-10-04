package com.make_profile.repository.password;

import com.make_profile.entity.password.PasswordResetTokenEntity;
import com.make_profile.entity.password.UpdateUserPasswordEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface UpdateUserPasswordRepository extends JpaRepository<UpdateUserPasswordEntity, Long> {


    @Query(value = "select * from update_user_password where user_id = :userId ", nativeQuery = true)
    UpdateUserPasswordEntity findUpdatePasswordByUserId(@Param("userId") Long userId);
}
