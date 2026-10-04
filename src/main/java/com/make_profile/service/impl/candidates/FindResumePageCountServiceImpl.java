package com.make_profile.service.impl.candidates;

import com.make_profile.service.candidates.FindResumePageCountService;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Service
public class FindResumePageCountServiceImpl implements FindResumePageCountService {


    private static final Logger logger = LoggerFactory.getLogger(FindResumePageCountServiceImpl.class);

    private static final double MIN_LINE_HEIGHT = 1.0;


    @Override
    public String findResumePageCounts(String html) {
        logger.debug("Service :: findResumePageCounts :: Entered");

        double lineHeight = 0;
        String heightIncreament = null;
        int pdfPageCount = 0;
        float used = 0;
        float empty = 0;
        byte[] bytes;

        try {
            byte[] byteArray = generatePdf(html);
            pdfPageCount = getNumberOfPages(byteArray);

            if (pdfPageCount > 1) {
                return null;
            }

            used = calculatePageUsage(byteArray);
            empty = 100f - used;

            if (empty > 10f) {

                for (int i = 0; i < 10; i++) {
                    lineHeight = lineHeight + 0.1;
                    heightIncreament = adjustLineHeight(html, lineHeight);

                    bytes = generatePdf(heightIncreament);
                    pdfPageCount = getNumberOfPages(bytes);

                    while (pdfPageCount > 1) {
                        lineHeight =  0.1;
                        heightIncreament = adjustLineDecrementHeight(heightIncreament, lineHeight);

                        bytes = generatePdf(heightIncreament);
                         int  pageCount = getNumberOfPages(bytes);

                        if (pageCount == 1) {
                            break;
                        }
                    }
                    used = calculatePageUsage(bytes);
                    empty = 100f - used;
                    if (empty < 12f) {
                        break;
                    }
                }
            }

        } catch (Exception e) {
            logger.error("Service :: getResumeHtmlCode :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getResumeHtmlCode :: Exited");

        return heightIncreament;
    }

    public int getNumberOfPages(byte[] byteArray) {
        logger.debug("Service :: getNumberOfPages :: Entered");
        try {
            PDDocument document = PDDocument.load(byteArray);
            document.close();
            return document.getNumberOfPages();
        } catch (Exception e) {
            logger.error("Service :: getNumberOfPages :: Exception :: " + e.getMessage());
            return 0;
        }
    }


    private byte[] generatePdf(String html) throws Exception {

        try (ByteArrayOutputStream os = new ByteArrayOutputStream()) {
            PdfRendererBuilder builder = new PdfRendererBuilder();
            builder.useFastMode();
            builder.withHtmlContent(html, null);
            builder.toStream(os);
            builder.run();

            return os.toByteArray();
        }
    }


    public float calculatePageUsage(byte[] pdfBytes) throws Exception {

        try (PDDocument document = PDDocument.load(pdfBytes)) {

            PDFRenderer renderer = new PDFRenderer(document);

            // ✔ RENDER THE FIRST PAGE AS IMAGE (THIS LINE GOES HERE)
            BufferedImage image = renderer.renderImageWithDPI(0,              // page index = 0 (first page)
                    150,            // DPI
                    ImageType.RGB   // image type
            );

            // ✔ FIND BOTTOM CONTENT POSITION
            int contentBottom = findContentBottomY(image);
            int totalHeight = image.getHeight();

            // ✔ CALCULATE USED %
            float usedPercent = (contentBottom / (float) totalHeight) * 100f;

            return usedPercent;
        }
    }


    private int findContentBottomY(BufferedImage image) {
        int width = image.getWidth();
        int height = image.getHeight();

        for (int y = height - 1; y >= 0; y--) {
            for (int x = 0; x < width; x++) {

                int rgb = image.getRGB(x, y);

                // Convert pixel to grayscale (0 = black, 255 = white)
                int gray = (((rgb >> 16) & 0xFF)
                        + ((rgb >> 8) & 0xFF)
                        + (rgb & 0xFF)) / 3;

                // Ignore anti-aliased white-ish pixels (gray >= 250)
                if (gray < 250) {  // real content
                    return y;
                }

//                // Check if pixel is NOT white
//                if ((rgb & 0xFFFFFF) != 0xFFFFFF) {
//                    return y;
//                }
            }
        }
        return height; // fully blank page
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


    public static String adjustLineDecrementHeight(String html, double increment) {
        logger.debug("Service :: adjustLineDecrementHeight :: Entered");

        try {
            Pattern pattern = Pattern.compile("line-height\\s*:\\s*([0-9]*\\.?[0-9]+)");
            Matcher matcher = pattern.matcher(html);

            StringBuffer result = new StringBuffer();

            while (matcher.find()) {
                double original = Double.parseDouble(matcher.group(1));

                if (3.2 > original && 1.0 < original) {

                    double updated = original - increment;

                    if (updated > MIN_LINE_HEIGHT) {
                        // updated = MIN_LINE_HEIGHT;
                        matcher.appendReplacement(result, "line-height: " + String.format("%.2f", updated));

                    }
                }
            }
            matcher.appendTail(result);

            logger.debug("Service :: adjustLineDecrementHeight :: Exited");

            return result.toString();
        } catch (Exception e) {
            logger.error("Service :: adjustLineDecrementHeight :: Exception :: " + e.getMessage());
            return null;
        }
    }


}
