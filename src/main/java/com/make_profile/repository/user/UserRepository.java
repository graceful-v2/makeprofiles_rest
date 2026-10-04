package com.make_profile.repository.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.make_profile.entity.user.UserEntity;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

	@Query(value = "select * from user where email = :email ", nativeQuery = true)
	UserEntity findByEmail(@Param("email") String email);

	UserEntity findByMobileNumber(String number);
	
	@Query(value = "select count(id) from user where email = :email or mobile_number = :mobileNumber ", nativeQuery = true)
	int findByMobileNumberAndEmail(@Param("mobileNumber") String mobileNumber, @Param("email") String email);

	@Query(value = "select * from user where user_name = :name ", nativeQuery = true)
	UserEntity findByUserName(@Param("name") String name);

	@Query(value = "select * from user where name = :name ", nativeQuery = true)
	UserEntity findByName(@Param("name") String name);

	@Query(value = "select id from user where user_name = :userName ", nativeQuery = true)
	Long getUserId(@Param("userName") String userName);

	@Query(value = "select count(*) from user where mobile_number = :mobileNumber ", nativeQuery = true)
	int getUserByMobileNumber(@Param("mobileNumber") String mobileNumber);

	@Query(value = "select count(*) from user where email = :email ", nativeQuery = true)
	int getUserByEmail(@Param("email") String email);

}
