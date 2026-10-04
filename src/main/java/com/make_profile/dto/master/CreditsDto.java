package com.make_profile.dto.master;

import java.time.LocalDate;
import java.util.List;

import com.make_profile.dto.BaseDto;

public class CreditsDto extends BaseDto {

	private Long id;

	private Double creditUsed;

	private Double creditAvailable;

	private Long userId;

	private LocalDate PaymentDate;

	private List<ResumeTemplateDto> resume;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Double getCreditUsed() {
		return creditUsed;
	}

	public void setCreditUsed(Double creditUsed) {
		this.creditUsed = creditUsed;
	}

	public Double getCreditAvailable() {
		return creditAvailable;
	}

	public void setCreditAvailable(Double creditAvailable) {
		this.creditAvailable = creditAvailable;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public LocalDate getPaymentDate() {
		return PaymentDate;
	}

	public void setPaymentDate(LocalDate paymentDate) {
		PaymentDate = paymentDate;
	}

	public List<ResumeTemplateDto> getResume() {
		return resume;
	}

	public void setResume(List<ResumeTemplateDto> resume) {
		this.resume = resume;
	}

}
