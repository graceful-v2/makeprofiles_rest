package com.make_profile.service.impl.master;

import java.io.ByteArrayOutputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.make_profile.service.master.ConvertFtlToImageService;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Service
public class ConvertFtlToHtmlServiceImpl implements ConvertFtlToImageService {

	private static final Logger logger = LoggerFactory.getLogger(ConvertFtlToHtmlServiceImpl.class);

	@Autowired
	private Configuration configuration;

	@Override
	public String convertFtlToImage(String ftlPath) {
		logger.debug("Service :: convertFtlToImage :: Entered");

		Map<String, Object> variables = new HashMap<>();
		Template template = null;
		String base64Image = null;
		try {

			// TODO get the file path name of the ftl
			template = configuration.getTemplate("");
			// StringWriter writer = new StringWriter();
			String processTemplateIntoString = FreeMarkerTemplateUtils.processTemplateIntoString(template, variables);
			 
			//TODO For updated version
//			PdfRendererBuilder builder = new PdfRendererBuilder();
//			builder.withHtmlContent(htmlContent, null);
//			builder.toStream(outputStream);
//			builder.run();

			//TODO Old versionS
//			Java2DRenderer renderer = new Java2DRenderer(
//					(Document) new ByteArrayInputStream(processTemplateIntoString.getBytes()), 800, 600);
//			BufferedImage image = renderer.getImage();

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			ImageIO.write(null, "png", outputStream);
			base64Image = Base64.getEncoder().encodeToString(outputStream.toByteArray());

		} catch (Exception e) {
			logger.error("Service :: convertFtlToImage :: Exception" + e.getMessage());
		}
		logger.debug("Service :: convertFtlToImage :: Exited");
		return String.valueOf("data:image/png;base64," + base64Image);
	}

}
