package com.make_profile.dto.master;

import java.time.LocalDateTime;

import com.make_profile.dto.BaseDto;

public class CreditHistoryDto extends BaseDto {

	private Long id;

	private Long userId;

	private String templateName;

	private Long creditId;

	private Double usedCredit;

	private String usedType;

	public LocalDateTime createdDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public Long getCreditId() {
		return creditId;
	}

	public void setCreditId(Long creditId) {
		this.creditId = creditId;
	}

	public String getUsedType() {
		return usedType;
	}

	public void setUsedType(String usedType) {
		this.usedType = usedType;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public Double getUsedCredit() {
		return usedCredit;
	}

	public void setUsedCredit(Double usedCredit) {
		this.usedCredit = usedCredit;
	}

}
