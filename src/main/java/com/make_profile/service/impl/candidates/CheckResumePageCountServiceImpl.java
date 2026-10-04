package com.make_profile.service.impl.candidates;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.templates.TemplatePagesDto;
import com.make_profile.exception.MakeProfileException;
import com.make_profile.repository.candidates.CandidatesRepository;
import com.make_profile.repository.master.CreditsRepository;
import com.make_profile.repository.user.UserRepository;
import com.make_profile.service.candidates.CheckResumePageCountService;
import com.make_profile.utility.CommonConstants;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

@Service
public class CheckResumePageCountServiceImpl implements CheckResumePageCountService {

    private static final Logger logger = LoggerFactory.getLogger(CheckResumePageCountServiceImpl.class);

    private static final double MIN_LINE_HEIGHT = 1.0;

    private static final float A4_HEIGHT = 842f;
    private static final float A4_WIDTH = 595f;

    @Autowired
    CandidatesRepository candidatesRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    CreditsRepository creditsRepository;

    @Autowired
    ModelMapper mapper;

    @Autowired
    Configuration configuration;

    @Override
    public String getResumeHtmlCode(String resume, CandidateDto candidateDto, String username, String templateName) throws MakeProfileException {
        logger.debug("Service :: getResumeHtmlCode :: Entered");

        String addSpaceString = null;
        String removeSpaceString = null;
        String heightDecrement = null;
        String heightIncreament = null;
        String removeSectionByTitle = null;
        int pdfPageCount = 0;
        int reCheckPageCount = 0;
        int filledPercent = 0;


        try {

            if (getPageSize(templateName).equals("1")) {
                pdfPageCount = getPdfPageCount(resume);

                if (pdfPageCount == 1) {
                    addSpaceString = addOnePageSpace(resume);

                    reCheckPageCount = getPdfPageCount(addSpaceString);

                    if (reCheckPageCount == 2) {
                        removeSpaceString = removeOnePageSpace(addSpaceString);

                        if (!templateName.equals("Mars")) {
                            filledPercent = getFilledPercent(removeSpaceString, "left-column");
                        } else {
                            filledPercent = getFilledPercent(removeSpaceString, "center-column");
                        }

                        if (filledPercent < 100) {
                            // Try adding personal details
                            String withDetails = addPersonalDetails(removeSpaceString, candidateDto);
                            int detailsPageCount = getPdfPageCount(withDetails);

                            if (detailsPageCount > 1) {
                                String trimPersonalDetailsUntilSinglePage = trimPersonalDetailsUntilSinglePage(withDetails);
                                if (getPdfPageCount(trimPersonalDetailsUntilSinglePage) == 1) {
                                    return trimPersonalDetailsUntilSinglePage;
                                } else {
//                                    throw new MakeProfileException(CommonConstants.MP_0009);

                                    String removeSummary = removeSectionContentByTitle(trimPersonalDetailsUntilSinglePage, "summary");
                                    pdfPageCount = getPdfPageCount(removeSummary);
                                    if (pdfPageCount == 1) {
                                        return removeSummary;
                                    } else if (pdfPageCount == 2) {
                                        String removeObjective = removeSectionContentByTitle(removeSummary, "objective");
                                        pdfPageCount = getPdfPageCount(removeObjective);
                                        if (pdfPageCount == 1) {
                                            return removeObjective;
                                        } else if (pdfPageCount == 2) {
                                            String softSkills = removeSoftSkillsSection(removeObjective, "soft skills");

                                            if (getPdfPageCount(softSkills) == 1) {
                                                return softSkills;
                                            } else {
                                                throw new MakeProfileException(CommonConstants.MP_0009);
                                            }
                                        }
                                    } else {
                                        throw new MakeProfileException(CommonConstants.MP_0009);
                                    }
                                }
                            } else {
                                return withDetails;
                            }
                        }

                        addSpaceString = null;
                        removeSectionByTitle = null;
                        heightDecrement = null;
                        heightIncreament = null;

                        return removeSpaceString;
                    } else if (reCheckPageCount == 1) {

                        double lineHeight = 0;
                        for (int i = 1; i < 6; i++) {
                            lineHeight = lineHeight + 0.1;
                            heightDecrement = adjustLineHeight(resume, lineHeight);
                            heightIncreament = adjustLineHeight(resume, Double.valueOf("0.") + lineHeight);
                            reCheckPageCount = getPdfPageCount(heightIncreament);

                            if (reCheckPageCount == 1) {
                                addSpaceString = addOnePageSpace(heightDecrement);
                                reCheckPageCount = getPdfPageCount(addSpaceString);

                                if (reCheckPageCount == 2) {
                                    removeSpaceString = removeOnePageSpace(addSpaceString);

                                    if (!templateName.equals("Mars")) {
                                        filledPercent = getFilledPercent(removeSpaceString, "left-column");
                                    } else {
                                        filledPercent = getFilledPercent(removeSpaceString, "center-column");
                                    }

                                    if (filledPercent < 100) {

                                        String withDetails = addPersonalDetails(removeSpaceString, candidateDto);
                                        int detailsPageCount = getPdfPageCount(withDetails);

                                        if (detailsPageCount > 1) {
                                            String trimPersonalDetailsUntilSinglePage = trimPersonalDetailsUntilSinglePage(withDetails);
                                            if (getPdfPageCount(trimPersonalDetailsUntilSinglePage) == 1) {
                                                return trimPersonalDetailsUntilSinglePage;
                                            } else {

//                                                throw new MakeProfileException(CommonConstants.MP_0009);

                                                String removeSummary = removeSectionContentByTitle(trimPersonalDetailsUntilSinglePage, "summary");
                                                pdfPageCount = getPdfPageCount(removeSummary);

                                                if (pdfPageCount == 1) {
                                                    return removeSummary;
                                                } else if (pdfPageCount == 2) {
                                                    String removeObjective = removeSectionContentByTitle(removeSummary, "objective");
                                                    pdfPageCount = getPdfPageCount(removeObjective);
                                                    if (pdfPageCount == 1) {
                                                        return removeObjective;
                                                    } else if (pdfPageCount == 2) {
                                                        String softSkills = removeSoftSkillsSection(removeObjective, "soft skills");

                                                        if (getPdfPageCount(softSkills) == 1) {
                                                            return softSkills;
                                                        } else {
                                                            throw new MakeProfileException(CommonConstants.MP_0009);
                                                        }
                                                    }
                                                } else {
                                                    throw new MakeProfileException(CommonConstants.MP_0009);
                                                }
                                            }
                                        } else {
                                            return withDetails;
                                        }
                                    }

                                    return removeSpaceString;
                                }
                            }
                        }

                        throw new MakeProfileException(CommonConstants.MP_0008);

                    }
                } else if (pdfPageCount == 2) {

                    String html = removeSectionContentByTitle(resume, "summary");

                    pdfPageCount = getPdfPageCount(html);
                    if (pdfPageCount == 1) {
                        return html;
                    } else if (pdfPageCount == 2) {
                        String removeObjective = removeSectionContentByTitle(resume, "objective");

                        pdfPageCount =   getPdfPageCount(html);
                        if (pdfPageCount == 1) {
                            return removeObjective;
                        } else if (pdfPageCount == 2) {
                            String softSkills = removeSoftSkillsSection(html, "soft skills");

                            if (getPdfPageCount(softSkills) == 1) {
                                return softSkills;
                            } else {
                                throw new MakeProfileException(CommonConstants.MP_0009);
                            }
                        }
                    } else {
                        throw new MakeProfileException(CommonConstants.MP_0009);
                    }

                } else {
                    throw new MakeProfileException(CommonConstants.MP_0009);
                }
            } else {
                return checkTwoPageResume(resume, candidateDto, username, templateName);
            }
        } catch (MakeProfileException e) {
            logger.error("Service :: getResumeHtmlCode :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: getResumeHtmlCode :: Exception" + e.getMessage());
        }
        logger.debug("Service :: getResumeHtmlCode :: Entered");
        return null;
    }

    public static int getPdfPageCount(String html) throws Exception {
        logger.debug("Service :: getPdfPageCount :: Entered");

//		logger.debug("Service :: getPdfPageCount :: Html: " + html);

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {

            PdfRendererBuilder builder = new PdfRendererBuilder();

            builder.useDefaultPageSize(210, 297, PdfRendererBuilder.PageSizeUnits.MM);
            builder.withHtmlContent(html, new File(".").toURI().toString());
            builder.toStream(baos);
            builder.run();

            logger.debug("Service :: getPdfPageCount :: Exited");

            try (PDDocument document = PDDocument.load(baos.toByteArray())) {
                return document.getNumberOfPages();
            }
        } catch (Exception e) {
            logger.error("Service :: getPdfPageCount :: Exception :: " + e.getMessage());
            return 0;
        }
    }

    public static String adjustLineHeight(String html, double increment) {
        logger.debug("Service :: adjustLineHeight :: Entered");

        try {
            Pattern pattern = Pattern.compile("line-height\\s*:\\s*([0-9]*\\.?[0-9]+)");
            Matcher matcher = pattern.matcher(html);

            StringBuffer result = new StringBuffer();

            while (matcher.find()) {
                double original = Double.parseDouble(matcher.group(1));

                if (2.2 > original && 1.0 < original) {

                    double updated = original + increment;

                    if (updated > MIN_LINE_HEIGHT) {
                        // updated = MIN_LINE_HEIGHT;
                        matcher.appendReplacement(result, "line-height: " + String.format("%.2f", updated));

                    }
                }
            }
            matcher.appendTail(result);

            logger.debug("Service :: adjustLineHeight :: Exited");

            return result.toString();
        } catch (Exception e) {
            logger.error("Service :: adjustLineHeight :: Exception :: " + e.getMessage());
            return null;
        }
    }

    public String addSpace(String resume) {
        logger.debug("Service :: addSpace :: Entered");

        try {
            resume = resume.replace("</body>", "<div style=\"height: 60.1mm;\"></div></body>");
        } catch (Exception e) {
            logger.error("Service :: addSpace :: Exception" + e.getMessage());
        }
        logger.debug("Service :: addSpace :: Exited");
        return resume;
    }

    public String removeSpace(String resume) {
        logger.debug("Service :: removeSpace :: Entered");

        try {
            resume = resume.replace("<div style=\"height: 60.1mm;\"></div>", "");
        } catch (Exception e) {
            logger.error("Service :: removeSpace :: Exception" + e.getMessage());
        }
        logger.debug("Service :: removeSpace :: Exited");
        return resume;
    }

    public String removeSectionByTitle(String html, String sectionTitle) {
        logger.debug("Service :: removeSectionByTitle :: Entered");

        String modifiedHtml = null;
        try {
            Document doc = Jsoup.parse(html);
            Elements sections = doc.select("div.section");
            for (Element section : sections) {
                Element title = section.selectFirst("div.section-title");

                if (title != null && title.text().trim().equalsIgnoreCase(sectionTitle)) {
                    section.remove();
                    break;
                }
            }
            modifiedHtml = doc.outerHtml();
            modifiedHtml = modifiedHtml.replace("<!doctype html>", "<!DOCTYPE html>\n");
            modifiedHtml = modifiedHtml.replace("<meta charset=\"UTF-8\">", "<meta charset=\"UTF-8\" />");
            modifiedHtml = modifiedHtml.replace("class=\"profile-pic\">", "class=\"profile-pic\" />");

            modifiedHtml = modifiedHtml.replaceAll("<img([^>/]*?)>", "<img$1 />");
            modifiedHtml = modifiedHtml.replaceAll("<br([^>/]*?)>", "<br$1 />");

        } catch (Exception e) {
            logger.error("Service :: removeSectionByTitle :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: removeSectionByTitle :: Exited");
        return modifiedHtml;
    }

    private String getPageSize(String templateName) {
        logger.debug("Service :: getPageSize :: Entered");

        ObjectMapper objectMapper = new ObjectMapper();
        String pages = null;
        try {
            InputStream is = getClass().getClassLoader().getResourceAsStream("resume_pages/template.json");

            if (is == null) {
                throw new IllegalArgumentException("Template file not found in resources.");
            }
            List<TemplatePagesDto> templates;
            templates = objectMapper.readValue(is, new TypeReference<List<TemplatePagesDto>>() {
            });
            pages = templates.stream().filter(t -> t.getTemplateName().equalsIgnoreCase(templateName)).findFirst().get().getPages();
            objectMapper = null;

        } catch (Exception e) {
            logger.error("Service :: getPageSize :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getPageSize :: Exited");
        return pages;

    }

    @SuppressWarnings("unchecked")
    private String checkTwoPageResume(String resume, CandidateDto candidateDto, String username, String templateName) throws MakeProfileException {
        logger.debug("Service :: checkTwoPageResume :: Entered");

        String addSpaceString = null;
        String removeSpaceString = null;
        String heightDecrement = null;
        String heightIncreament = null;
        String removeSectionByTitle = null;
        int pdfPageCount = 0;
        int reCheckPageCount = 0;

        try {
            pdfPageCount = getPdfPageCount(resume);
            addSpaceString = addSpace(resume);
            reCheckPageCount = getPdfPageCount(addSpaceString);

            if (reCheckPageCount > 1) {
                removeSpaceString = removeSpace(addSpaceString);

                addSpaceString = null;
                removeSectionByTitle = null;
                heightDecrement = null;
                heightIncreament = null;

                if (isSecondPageMostlyEmpty(removeSpaceString)) {
                    String personalDetails = addPersonalDetailsForTwoPageResume(removeSpaceString, candidateDto);

                    if (checkHtmlContentContainsPersonalDetails(personalDetails)) {
                        return removeSpaceString.replaceAll("(?s)(</div>\\s*</body>)", personalDetails + " </div> </body>");
                    }
                }

                return removeSpaceString;
            } else if (reCheckPageCount == 1) {

                double lineHeight = 0;
                for (int i = 1; i < 6; i++) {
                    lineHeight = lineHeight + 0.1;
                    heightDecrement = adjustLineHeight(resume, lineHeight);
                    heightIncreament = adjustLineHeight(resume, Double.valueOf("0.") + lineHeight);
                    reCheckPageCount = getPdfPageCount(heightIncreament);

                    if (reCheckPageCount == 1) {
                        addSpaceString = addSpace(heightDecrement);
                        reCheckPageCount = getPdfPageCount(addSpaceString);

                        if (reCheckPageCount == 2) {
                            removeSpaceString = removeSpace(addSpaceString);

                            if (isSecondPageMostlyEmpty(removeSpaceString)) {
                                String personalDetails = addPersonalDetailsForTwoPageResume(removeSpaceString, candidateDto);

                                if (checkHtmlContentContainsPersonalDetails(personalDetails)) {
                                    return removeSpaceString.replaceAll("(?s)(</div>\\s*</body>)", personalDetails + " </div> </body>");
                                }
                            }

                            return removeSpaceString;
                        }
                    }
                }
                throw new MakeProfileException(CommonConstants.MP_0008);
            }
        } catch (MakeProfileException e) {
            logger.error("Service :: checkTwoPageResume :: MakeProfileException :: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Service :: checkTwoPageResume :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: checkTwoPageResume :: Exited");
        return null;

    }

    public String addOnePageSpace(String resume) {
        logger.debug("Service :: addOnePageSpace :: Entered");

        try {
            int lastDivIndex = resume.lastIndexOf("</div>");
            int bodyIndex = resume.indexOf("</body>");

            if (lastDivIndex != -1 && lastDivIndex < bodyIndex) {
                String before = resume.substring(0, lastDivIndex);
                String after = resume.substring(lastDivIndex);
                resume = before + "<div style=\"height: 60.1mm;\"></div>" + after;
            }
        } catch (Exception e) {
            logger.error("Service :: addOnePageSpace :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: addOnePageSpace :: Exited");
        return resume;
    }

    public String removeOnePageSpace(String resume) {
        logger.debug("Service :: removeOnePageSpace :: Entered");

        try {
            resume = resume.replace("<div style=\"height: 60.1mm;\"></div>", "");
        } catch (Exception e) {
            logger.error("Service :: removeOnePageSpace :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: removeOnePageSpace :: Exited");
        return resume;
    }

    public float getContentHeight(byte[] pdfBytes) throws Exception {
        try (PDDocument document = PDDocument.load(pdfBytes)) {
            if (document.getNumberOfPages() > 0) {
                var page = document.getPage(0);
                var cropBox = page.getCropBox();
                float pageHeight = cropBox.getHeight();

                // Use text stripper to find lowest Y position of text
                var stripper = new org.apache.pdfbox.text.PDFTextStripper() {
                    float minY = pageHeight;

                    @Override
                    protected void processTextPosition(org.apache.pdfbox.text.TextPosition text) {
                        super.processTextPosition(text);
                        if (text.getY() < minY) {
                            minY = text.getY();
                        }
                    }

                    float getLowestY() {
                        return minY;
                    }
                };

                stripper.setSortByPosition(true);
                stripper.setStartPage(1);
                stripper.setEndPage(1);
                stripper.getText(document);

                float usedHeight = pageHeight - stripper.getLowestY();
                return usedHeight;
            }
        }
        return 0f;
    }

    private String addPersonalDetails(String resume, CandidateDto candidate) {

        StringBuilder sb = new StringBuilder();

        String personalDetailsHtml = "<div class=\"section\">\n" + "    <h2>Personal Details</h2>\n";

        if (Objects.nonNull(candidate.getFatherName()) && !candidate.getFatherName().isEmpty()) {
            sb.append("<p><strong>Father's Name:</strong> " + candidate.getFatherName() + "</p> \n");

        }

        if (Objects.nonNull(candidate.getMaritalStatus()) && !candidate.getMaritalStatus().isEmpty()) {
            sb.append("  <p><strong>Marital Status:</strong> " + candidate.getMaritalStatus() + "</p>\n");

        }

        if (Objects.nonNull(candidate.getGender()) && !candidate.getGender().isEmpty()) {
            sb.append("   <p><strong>Gender:</strong> " + candidate.getGender() + "</p>\n");

        }

        if (Objects.nonNull(candidate.getLanguagesKnown()) && !candidate.getLanguagesKnown().isEmpty()) {
            sb.append("   <p><strong>Language Known:</strong> " + Stream.of(candidate.getLanguagesKnown().split(",")).map(String::trim).collect(Collectors.joining(", ")) + "</p>\n");
        }

        if (Objects.nonNull(candidate.getHobbies()) && !candidate.getHobbies().isEmpty()) {
            sb.append("  <p><strong>Hobbies:</strong> " + Stream.of(candidate.getHobbies().split(",")).map(String::trim).collect(Collectors.joining(", ")) + "</p>\n");

        }

        if (Objects.nonNull(candidate.getNationality()) && !candidate.getNationality().isEmpty()) {

            String nationality = candidate.getNationality();
            int firstIndex = nationality.indexOf("(");
            int lastIndex = nationality.indexOf(")");

            if (firstIndex != -1 && lastIndex != -1 && lastIndex > firstIndex) {
                sb.append("   <p><strong>Nationality:</strong> ")
                        .append(nationality.substring(firstIndex + 1, lastIndex))
                        .append("</p>\n");
            } else {
                // fallback – print full value safely
                sb.append("   <p><strong>Nationality:</strong> ")
                        .append(nationality)
                        .append("</p>\n");
            }
        }


        sb.append("</div> ");

        String process = personalDetailsHtml + sb.toString();

        // Insert before right-column starts (end of left-column)
        return resume.replaceAll("(?s)</div>\\s*<div class=\"right-column\">", process + " </div>  <div class=\"right-column\">");

    }

    public int getFilledPercent(String resumeHtml, String columnClass) {
        // Parse the HTML
        Document doc = Jsoup.parse(resumeHtml);

        Element column = doc.selectFirst("." + columnClass);
        if (column == null) return 0;

        // Get text content length
        String text = column.text();
        int contentLength = text.length();

        int maxCapacity = 1500;

        int percent = (int) (((double) contentLength / maxCapacity) * 100);

        // Limit 0-100
        return Math.min(percent, 100);
    }

    public String trimPersonalDetailsUntilSinglePage(String html) {
        try {
            Document doc = Jsoup.parse(html);

            // Find the section with h2 = PERSONAL DETAILS
            Element section = null;
            Elements sections = doc.select("div.section:has(h2)");
            for (Element sec : sections) {
                Element h2 = sec.selectFirst("h2");
                if (h2 != null && "PERSONAL DETAILS".equalsIgnoreCase(h2.text().trim())) {
                    section = sec;
                    break;
                }
            }

            doc.outputSettings().syntax(Document.OutputSettings.Syntax.xml).charset(StandardCharsets.UTF_8);

            if (section != null) {
                Elements pItems = section.select("p");

                // Remove <p> one by one until single page
                while (!pItems.isEmpty() && getPdfPageCount(doc.outerHtml()) > 1) {
                    pItems.last().remove();
                    pItems = section.select("p"); // refresh
                }
            }

            return doc.outerHtml();

        } catch (Exception e) {
            e.printStackTrace();
            return html; // fallback
        }
    }

    public boolean isSecondPageMostlyEmpty(String html) throws IOException {

        byte[] pdfBytes = convertHTmlToPDF(html);

        if (Objects.nonNull(pdfBytes)) {
            try (PDDocument document = PDDocument.load(pdfBytes)) {
                if (document.getNumberOfPages() < 2) {
                    return false; // no 2nd page
                }

                PDFTextStripper stripper = new PDFTextStripper();
                stripper.setStartPage(2);
                stripper.setEndPage(2);
                String page2Text = stripper.getText(document);

                // Approximation: assume 3000 chars = full page
                double fillRatio = (double) page2Text.trim().length() / 3000;

                return fillRatio < 0.1;
            }

        }
        return false;
    }


    public byte[] convertHTmlToPDF(String htmlContent) {
        logger.debug("Service :: convertHTmlToPDF :: Entered");

        try {
            ByteArrayOutputStream pdfOutput = new ByteArrayOutputStream();
            PdfRendererBuilder builder = new PdfRendererBuilder();
            builder.useFastMode();
            builder.withHtmlContent(htmlContent, null);
            builder.toStream(pdfOutput);
            builder.run();
            return pdfOutput.toByteArray();

        } catch (Exception e) {
            logger.error("Service :: convertHTmlToPDF :: Exception :: " + e.getMessage());
            return null;
        }
    }


    public String addPersonalDetailsForTwoPageResume(String htmlContent, CandidateDto candidateDto) {
        logger.debug("Service :: addPersonalDetailsForTwoPageResume :: Entered");

        Template template = null;
        String processTemplateIntoString = null;

        Map<String, Object> variables = new HashMap<>();
        try {

            if (Objects.nonNull(candidateDto.getFatherName())) {
                variables.put("fatherName", candidateDto.getFatherName());
            }

            if (Objects.nonNull(candidateDto.getGender())) {
                variables.put("gender", candidateDto.getGender());
            }

            if (Objects.nonNull(candidateDto.getMaritalStatus())) {
                variables.put("martialStatus", candidateDto.getMaritalStatus());
            }

            if (Objects.nonNull(candidateDto.getLanguagesKnown())) {
                variables.put("languageKnown", candidateDto.getLanguagesKnown());
            }

            if (Objects.nonNull(candidateDto.getHobbies())) {
                variables.put("hobbies", candidateDto.getHobbies());
            }

            if (Objects.nonNull(candidateDto.getAddress())) {
                variables.put("address", candidateDto.getAddress());
            }

            if (Objects.nonNull(candidateDto.getDob())) {
                variables.put("dob", candidateDto.getDob());
            }

            if (Objects.nonNull(candidateDto.getNationality())) {
                variables.put("nationality", candidateDto.getNationality());
            }

            template = configuration.getTemplate(candidateDto.getTemplateName().trim() + "Personal_Details.ftl");

            processTemplateIntoString = FreeMarkerTemplateUtils.processTemplateIntoString(template,
                    variables);

        } catch (Exception e) {
            logger.error("Service :: addPersonalDetailsForTwoPageResume :: Exception :: " + e.getMessage());
        }

        return processTemplateIntoString;
    }

    public boolean checkHtmlContentContainsPersonalDetails(String htmlContent) {

        if (htmlContent.contains("Father Name") || htmlContent.contains("Martial Status") || htmlContent.contains("Language Known") || htmlContent.contains("Gender")
                || htmlContent.contains("Hobbies") || htmlContent.contains("Dob") || htmlContent.contains("Nationality")
                || htmlContent.contains("Address")) {
            return true;
        }

        return false;
    }


    public String removeSectionContentByTitle(String html, String sectionTitle) {
        logger.debug("Service :: removeSectionContentByTitle :: Entered");

        String modifiedHtml = null;
        try {
            Document doc = Jsoup.parse(html);
            Elements sections = doc.select("div.section");

            for (Element section : sections) {
                // Look for a section with the given title (e.g., "Professional Summary")
                Element header = section.selectFirst("h1, h2, h3, div.section-title");
                if (header != null && header.text().toLowerCase().contains(sectionTitle)) {
                    Element paragraph = section.selectFirst("p");
                    if (paragraph != null) {
                        String text = paragraph.text().trim();

                        // Split into sentences
                        String[] parts = text.split("\\.\\s*");

                        if (parts.length > 2) {
                            // Remove last sentence
                            String[] remaining = Arrays.copyOf(parts, parts.length - 1);

                            // Join back with ". "
                            String newContent = String.join(". ", remaining).trim();

                            // Ensure it ends with "."
                            if (!newContent.endsWith(".")) {
                                newContent += ".";
                            }

                            // Update the paragraph with modified text
                            paragraph.text(newContent);
                        }
                    }
                    break; // stop after modifying the first matching section
                }
            }

            // Return the entire document with section updated
            modifiedHtml = doc.outerHtml();

            // Fix self-closing tags for XML/XHTML compliance
            modifiedHtml = modifiedHtml.replace("<!doctype html>", "<!DOCTYPE html>\n");
            modifiedHtml = modifiedHtml.replace("<meta charset=\"UTF-8\">", "<meta charset=\"UTF-8\" />");
            modifiedHtml = modifiedHtml.replace("class=\"profile-pic\">", "class=\"profile-pic\" />");
            modifiedHtml = modifiedHtml.replaceAll("<img([^>/]*?)>", "<img$1 />");
            modifiedHtml = modifiedHtml.replaceAll("<br([^>/]*?)>", "<br$1 />");

        } catch (Exception e) {
            logger.error("Service :: removeSectionContentByTitle :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: removeSectionContentByTitle :: Exited");
        return modifiedHtml;
    }



    public String removeSoftSkillsSection(String html, String sectionTitle) {
        logger.debug("Service :: removeSoftSkillsSection :: Entered");

        String modifiedHtml = null;
        try {
            Document doc = Jsoup.parse(html);
            Elements sections = doc.select("div.section");
            for (Element section : sections) {
                Element header = section.selectFirst("h1, h2, h3, div.section-title");

                if (header != null && header.text().toLowerCase().contains(sectionTitle)) {
                    section.remove();
                    break;
                }
            }
            modifiedHtml = doc.outerHtml();
            modifiedHtml = modifiedHtml.replace("<!doctype html>", "<!DOCTYPE html>\n");
            modifiedHtml = modifiedHtml.replace("<meta charset=\"UTF-8\">", "<meta charset=\"UTF-8\" />");
            modifiedHtml = modifiedHtml.replace("class=\"profile-pic\">", "class=\"profile-pic\" />");

            modifiedHtml = modifiedHtml.replaceAll("<img([^>/]*?)>", "<img$1 />");
            modifiedHtml = modifiedHtml.replaceAll("<br([^>/]*?)>", "<br$1 />");

        } catch (Exception e) {
            logger.error("Service :: removeSoftSkillsSection :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: removeSoftSkillsSection :: Exited");
        return modifiedHtml;
    }

}
