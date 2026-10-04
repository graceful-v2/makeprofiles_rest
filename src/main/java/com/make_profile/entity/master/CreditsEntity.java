package com.make_profile.entity.master;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "credits")
public class CreditsEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = true)
	private Double creditUsed;

	@Column(nullable = true)
	private Double creditAvailable;

	@Column(nullable = true)
	private Long userId;

	@Column(nullable = true)
	private LocalDate PaymentDate;

	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "credit_id")
	private List<ResumeTemplatesEntity> templates;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Double getCreditAvailable() {
		return creditAvailable;
	}

	public void setCreditAvailable(Double creditAvailable) {
		this.creditAvailable = creditAvailable;
	}

	public Double getCreditUsed() {
		return creditUsed;
	}

	public void setCreditUsed(Double creditUsed) {
		this.creditUsed = creditUsed;
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

	public List<ResumeTemplatesEntity> getTemplates() {
		return templates;
	}

	public void setTemplates(List<ResumeTemplatesEntity> templates) {
		this.templates = templates;
	}

}
