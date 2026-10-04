package com.make_profile.service.resume;

import com.make_profile.dto.master.ResponcePdfDto;
import com.make_profile.exception.MakeProfileException;

public interface GeneratePdfListernerResponseService {


    ResponcePdfDto generatePdfBytesByRabbitMQ(String jobId);

    ResponcePdfDto generateResumeUsingByte(String jobId,String templateName,Long userId) throws MakeProfileException;
}
