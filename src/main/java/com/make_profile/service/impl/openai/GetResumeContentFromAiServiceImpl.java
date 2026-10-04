package com.make_profile.service.impl.openai;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.make_profile.dto.candidates.AiResponseDto;
import com.make_profile.dto.candidates.CandidateDto;
import com.make_profile.dto.master.AiResponsibilityDto;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.make_profile.dto.candidates.ResumeContentDto;
import com.make_profile.dto.candidates.SummaryResponseDto;
import com.make_profile.dto.openai.ChatCompleitonResponse;
import com.make_profile.dto.openai.ChatCompletionRequest;
import com.make_profile.service.openai.GetResumeContentFromAiService;

@Service
public class GetResumeContentFromAiServiceImpl implements GetResumeContentFromAiService {

    private static final Logger logger = LoggerFactory.getLogger(GetResumeContentFromAiServiceImpl.class);

    @Autowired
    RestTemplate restTemplate;

    @Override
    public ResumeContentDto getResumeContent(String name) {
        logger.debug("Service :: getResumeContent :: Entered ");

        ResumeContentDto resumeContentDto = new ResumeContentDto();

        try {
            String contentDto = """
                    {
                      resumeContent : ""
                    
                    }
                    """;

            String constantMessage = "Give me the " + name + " content that should adapt for both fresher and experience persons and then Attach that with the below Dto in resumeContent";

            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", constantMessage + contentDto);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getResumeContent :: Exited ");

            resumeContentDto.setResumeContent(convertResponseString(response.getChoices().get(0).getMessage().getContent()));
        } catch (Exception e) {
            logger.error("Service :: getResumeContent :: Exception " + e.getMessage());
        }
        return resumeContentDto;

    }

    private String convertResponseString(String response) {
        logger.debug("Service :: convertResponseString :: Entered ");

        JsonObject jsonObject = null;
        String value = null;
        try {
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
            }
            JSONObject jSONObject = new JSONObject(jsonObject.toString());

            value = getValue("resumeContent", jSONObject);

        } catch (Exception e) {
            logger.error("Service :: convertResponseString :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertResponseString :: Exited ");
        return value;

    }

//    private String getValue(String key, JSONObject jsonObject) {
//        logger.debug("Service :: getValue :: Entered ");
//
//        String value = "";
//        try {
//
//            if (jsonObject.has(keyFromJson(jsonObject, key))) {
//                Object values = getValueFromJson(jsonObject, keyFromJson(jsonObject, key));
//                // Object values = jsonObject.getString(keyFromJson(jsonObject, key));
//
//                if (values instanceof String) {
//                    return (String) values;
//                } else if (values instanceof String[]) {
//                    toString();
//                    value = (Arrays.asList(values)).stream().map(a -> String.valueOf(a))
//                            .collect(Collectors.joining(","));
//
//                } else if (values instanceof JSONArray) {
//                    JSONArray jsonArray = (JSONArray) values;
//                    if (jsonArray.length() > 0 && jsonArray.get(0) instanceof JSONObject) {
//                        getValue(key, jsonArray.getJSONObject(0));
//                    } else if (jsonArray.length() > 0 && jsonArray.get(0) instanceof String) {
//                        toString();
//                        value = (Arrays.asList(jsonArray)).stream().map(a -> String.valueOf(a))
//                                .collect(Collectors.joining(","));
//                        // .replace("[", "").replace("]", "");
//                    }
//                }
//
//            }
//        } catch (Exception e) {
//            logger.error("Service :: getValue :: Exception :: " + e.getMessage());
//        }
//        logger.debug("Service :: getValue :: Exited ");
//        return value;
//    }

    private String getValue(String key, JSONObject jsonObject) {

        String value = "";

        try {
            if (jsonObject.has(keyFromJson(jsonObject, key))) {
                Object values = getValueFromJson(jsonObject, keyFromJson(jsonObject, key));

                if (values instanceof String) {
                    return (String) values;

                } else if (values instanceof String[]) {

                    value = String.join(",", (String[]) values);

                } else if (values instanceof JSONArray) {
                    JSONArray jsonArray = (JSONArray) values;

                    if (jsonArray.length() > 0 && jsonArray.get(0) instanceof JSONObject) {

                        String nestedValue = getValue(key, jsonArray.getJSONObject(0));
                        if (nestedValue != null && !nestedValue.isEmpty()) {
                            value = nestedValue;
                        }

                    } else if (jsonArray.length() > 0 && jsonArray.get(0) instanceof String) {

                        List<String> list = new ArrayList<>();
                        for (int i = 0; i < jsonArray.length(); i++) {
                            list.add(jsonArray.getString(i));
                        }
                        value = String.join(",", list);
                    }
                }

            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return value;
    }


    private String keyFromJson(JSONObject jsonObject, String expectedKey) {
        logger.debug("Service :: keyFromJson :: Entered ");

        Iterator<String> keys = jsonObject.keys();
        String key = "";

        try {
            while (keys.hasNext()) {
                String key_s = keys.next();
                if (key_s.toLowerCase().startsWith(expectedKey.toLowerCase())) {

                    key = key_s;
                    break;
                } else {
                    if (key_s.toLowerCase().endsWith(expectedKey.toLowerCase())) {
                        key = key_s;
                        break;
                    }
                }
            }

            return key;
        } catch (Exception e) {
            logger.error("Service :: keyFromJson :: Exception :: " + e.getMessage());
            return null;
        }
    }

    private static Object getValueFromJson(JSONObject jsonObject, String key) {
        logger.debug("Service :: getValueFromJson :: Entered ");

        try {
            Object value = jsonObject.opt(key);
            if (value instanceof String) {
                return value;
            } else if (value instanceof JSONArray) {
                return value;
            } else if (value instanceof String[]) {
                return value;
            }
        } catch (Exception e) {
            logger.error("Service :: getValueFromJson :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: getValueFromJson :: Exited ");

        return null;
    }

    @Override
    public SummaryResponseDto getSummaryContent() {
        logger.debug("Service :: getSummaryContent :: Entered ");

        SummaryResponseDto responseDto = new SummaryResponseDto();
        try {
            String summaryResponseDto = """
                    
                    {
                      "summary": "<Generated Summary Here>",
                      "careerObjective": "<Generated Career Objective Here>"
                    }
                    
                    """;

            String constantMessage = """
                    
                    Generate a professional Summary (100–140 words) and a Career Objective (100–140 words) that are versatile enough to
                    suit both freshers and experienced professionals.The tone should be formal, career-focused, and adaptable across industries.
                                    Attach that into below DTO
                    
                    
                    """;
            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", constantMessage + summaryResponseDto);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getSummaryContent :: Exited ");

            return convertSummaryResponseString(response.getChoices().get(0).getMessage().getContent());

        } catch (Exception e) {
            logger.error("Service :: getSummaryContent :: Exception :: " + e.getMessage());
            return null;
        }

    }


    private SummaryResponseDto convertSummaryResponseString(String response) {
        logger.debug("Service :: convertSummaryResponseString :: Entered ");

        JsonObject jsonObject = null;
        SummaryResponseDto summaryResponseDto = new SummaryResponseDto();
        try {
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
            }
            JSONObject jSONObject = new JSONObject(jsonObject.toString());

            String summary = getValue("summary", jSONObject);
            String objective = getValue("careerObjective", jSONObject);

            summaryResponseDto.setSummary(summary);
            summaryResponseDto.setCareerObjective(objective);

            summary = null;
            objective = null;
        } catch (Exception e) {
            logger.error("Service :: convertSummaryResponseString :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertSummaryResponseString :: Exited ");
        return summaryResponseDto;

    }


    @Override
    public SummaryResponseDto getAiContent(String content, String key, String operation) {
        logger.debug("Service :: getAiContent :: Entered ");

        SummaryResponseDto responseDto = new SummaryResponseDto();
        try {


            String actionText = operation.equalsIgnoreCase("increase") ? "Expand the content with more clarity, detail, and a strong professional tone." : "Shorten the content while preserving key meaning and maintaining a professional tone.";

            String constantMessage = """
                    You are given the below resume %s:
                    
                    %s
                    
                    Your task is to %s the length of this %s.
                    %s
                    
                    Rules:
                    1. Do not change the original meaning.
                    2. Keep it resume-appropriate.
                    3. Return only the updated text in the JSON format below.
                    
                    Return format:
                    {
                      "content": "<updated content here>"
                    }
                    """.formatted(key, content, operation, key, actionText);


            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", constantMessage);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getAiContent :: Exited ");

            return convertResponseToString(response.getChoices().get(0).getMessage().getContent());

        } catch (Exception e) {
            logger.error("Service :: getAiContent :: Exception :: " + e.getMessage());
            return null;
        }
    }


    private SummaryResponseDto convertResponseToString(String response) {
        logger.debug("Service :: convertResponseToString :: Entered ");

        JsonObject jsonObject = null;
        String summary = null;

        SummaryResponseDto summaryResponseDto = new SummaryResponseDto();


        try {
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
            }
            JSONObject jSONObject = new JSONObject(jsonObject.toString());

            summary = getValue("content", jSONObject);

            summaryResponseDto.setSummary(summary);

        } catch (Exception e) {
            logger.error("Service :: convertResponseToString :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertResponseToString :: Exited ");
        return summaryResponseDto;

    }


    @Override
    public SummaryResponseDto getProjectContentFromAi(String content, String operation) {
        logger.debug("Service :: getProjectContentFromAi :: Entered ");

        SummaryResponseDto responseDto = new SummaryResponseDto();
        try {

            String operationText = operation.equalsIgnoreCase("increase") ? "expand the content with more detail, clarity, and professional tone." : "shorten it while keeping key points meaningful and professional.";

            String prompt = """
                    i have  given a project description below.
                    
                    PROJECT DESCRIPTION:
                    %s
                    
                    Your task: %s the length of the project description.
                    %s
                    
                    Rules:
                    1. Do not change meaning.
                    2. Keep resume tone.
                    3. Return only the updated content in JSON format below. No extra text.
                    
                    Return format:
                    {
                      "content": "<updated project description here>"
                    }
                    """.formatted(content, operation, operationText);

            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", prompt);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getProjectContentFromAi :: Exited ");

            return convertResponseToString(response.getChoices().get(0).getMessage().getContent());

        } catch (Exception e) {
            logger.error("Service :: getProjectContentFromAi :: Exception :: " + e.getMessage());
            return null;
        }
    }


    @Override
    public SummaryResponseDto getExperienceContentFromAi(String content, String operation) {
        logger.debug("Service :: getExperienceContentFromAi :: Entered ");

        SummaryResponseDto responseDto = new SummaryResponseDto();
        try {

            String operationText = operation.equalsIgnoreCase("increase") ? "Expand the responsibilities with more detail, clarity, and strong professional tone. Use action verbs and make responsibilities achievement-focused." : "Shorten the responsibilities while keeping key meaning and impact. Remove fluff but keep professional tone.";

            String prompt = """
                    You are given resume responsibilities below.
                    
                    RESPONSIBILITIES:
                    %s
                    
                    Your task is to %s the length of the responsibilities for a resume.
                    %s
                    
                    Rules:
                    1. Do not change meaning.
                    2. Maintain professional resume tone.
                    3. Do not add unrelated responsibilities.
                    4. Return only the updated text in JSON format below. No extra text.
                    
                    Return format:
                    {
                      "content": "<updated responsibilities here, comma-separated>"
                    }
                    """.formatted(content, operation, operationText);

            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", prompt);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getExperienceContentFromAi :: Exited ");

            return convertResponseToString(response.getChoices().get(0).getMessage().getContent());

        } catch (Exception e) {
            logger.error("Service :: getExperienceContentFromAi :: Exception :: " + e.getMessage());
            return null;
        }
    }

    public String convertCandidateDtoIntoString(CandidateDto candidateDto) {
        logger.debug("Service :: convertCandidateDtoIntoString :: Extered");

        StringBuilder dtoString = new StringBuilder("CandidateDto: {");
        try {
            dtoString.append("hobbies=").append(candidateDto.getHobbies()).append(", ");
            dtoString.append("skills=").append(candidateDto.getSkills()).append(", ");
            dtoString.append("experiences=").append(candidateDto.getExperiences()).append(", ");
            dtoString.append("qualification=").append(candidateDto.getQualification()).append(", ");
            dtoString.append("certificates=").append(candidateDto.getCertificates()).append(", ");
            dtoString.append("achievements=").append(candidateDto.getAchievements()).append(", ");
            dtoString.append("softSkills=").append(candidateDto.getSoftSkills()).append(", ");
            dtoString.append("coreCompentencies=").append(candidateDto.getCoreCompentencies()).append(", ");
            dtoString.append("collegeProject=").append(candidateDto.getCollegeProject());

            dtoString.append("}");

        } catch (Exception e) {
            logger.error("Service :: convertCandidateDtoIntoString :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertCandidateDtoIntoString :: Exited");
        return dtoString.toString();

    }

    private List<String> getValueForSkills(String key, JSONObject jsonObject) {
        List<String> list = new ArrayList<>();
        try {
            if (jsonObject.has(keyFromJson(jsonObject, key))) {
                Object values = getValueFromJson(jsonObject, keyFromJson(jsonObject, key));

                if (values instanceof String) {
                    // Case 1: Comma-separated string
                    return Arrays.stream(((String) values).split(",")).filter(s -> !s.isEmpty()).collect(Collectors.toList());

                } else if (values instanceof String[]) {

                    return Arrays.asList((String[]) values);

                } else if (values instanceof JSONArray) {

                    JSONArray jsonArray = (JSONArray) values;

                    if (jsonArray.length() > 0) {
                        Object first = jsonArray.get(0);

                        if (first instanceof JSONObject) {
                            // If array contains nested JSONObject → recursive call
                            list = getValueForSkills(key, jsonArray.getJSONObject(0));
                            if (list != null && !list.isEmpty()) {
                                return list;
                            }

                        } else if (first instanceof String) {
                            // If array contains string values
                            for (int i = 0; i < jsonArray.length(); i++) {
                                list.add(jsonArray.getString(i));
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {

            return Collections.emptyList();
        }

        return list;
    }

    public AiResponseDto convertSkillsResponseToString(String response) {
        logger.debug("Service :: convertSkillsResponseToString :: Entered ");

        JsonObject jsonObject = null;
        String summary = null;

        AiResponseDto aiResponseDto = new AiResponseDto();
        try {
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
            }
            JSONObject jSONObject = new JSONObject(jsonObject.toString());

            aiResponseDto.setSkills(getValueForSkills("skills", jSONObject));
            aiResponseDto.setSoftSkills(getValueForSkills("softSkills", jSONObject));
            aiResponseDto.setCoreCompentencies(getValueForSkills("coreCompentencies", jSONObject));

        } catch (Exception e) {
            logger.error("Service :: convertSkillsResponseToString :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertSkillsResponseToString :: Exited ");
        return aiResponseDto;
    }


    @Override
    public AiResponseDto getSkillsFromAi(CandidateDto candidateDto) {
        logger.debug("Service :: getSkillsFromAi :: Entered ");

        SummaryResponseDto responseDto = new SummaryResponseDto();
        try {

            String candidateDetails = convertCandidateDtoIntoString(candidateDto);

            String prompt = """
                    You are an expert career analyst and resume intelligence assistant.
                    
                    You are given the following candidate details:
                    
                    Candidate Details:
                    %s
                    
                    Your task:
                    Analyze the candidate’s background, education, experience, and project descriptions to extract the most relevant:
                    1. Technical Skills (job-related hard skills) 
                    2. Soft Skills (interpersonal and behavioral traits)
                    3. Core Competencies (broader professional strengths or business capabilities)
                    
                    Rules:
                    1. Include only skills that are clearly relevant to the candidate’s field and profile.
                    2. Avoid duplicates or generic filler terms like “hardworking” or “motivated”.
                    3. Give me more than 10 skills for each 
                    3. Maintain professional capitalization and clear formatting.
                    4. Return the result **only** in the JSON format shown below — no explanations or extra text.
                    
                    Return format:
                    {
                      "skills": ["<list of related technical or job skills>"],
                      "softSkills": ["<list of related soft skills>"],
                      "coreCompentencies": ["<list of related core competencies>"]
                    }
                    """.formatted(candidateDetails);


            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", prompt);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getSkillsFromAi :: Exited ");

            return convertSkillsResponseToString(response.getChoices().get(0).getMessage().getContent());

        } catch (Exception e) {
            logger.error("Service :: getSkillsFromAi :: Exception :: " + e.getMessage());
            return null;
        }
    }

    @Override
    public AiResponseDto getSuggestedSkillsFromOpenAi(String skills) {
        logger.debug("Service :: getSuggestedSkillsFromOpenAi :: Entered ");

        SummaryResponseDto responseDto = new SummaryResponseDto();
        try {


            String prompt = """
                    You are an expert career-matching and resume intelligence assistant.
                    
                    You are given ONE candidate skill:
                    
                    SKILL:
                    %s
                    
                    Your task:
                    Based on this single skill, generate:
                    1. **Related Technical Skills** – at least 10 job-specific or domain-relevant hard skills.
                    2. **Soft Skills** – at least 10 interpersonal or behavioral strengths commonly associated with this skill.
                    3. **Core Competencies** – at least 10 broader professional capabilities connected to this skill.
                    
                    Rules:
                    1. All generated skills must be directly relevant to the given skill.
                    2. No generic filler terms such as "hardworking", "quick learner", "dedicated", etc.
                    3. No duplicates.
                    4. Use proper professional capitalization.
                    5. Return the output **only** in the following JSON format, with no additional explanations:
                    
                    {
                      "skills": ["<list of technical skills>"],
                      "softSkills": ["<list of soft skills>"],
                      "coreCompentencies": ["<list of core competencies>"]
                    }
                    """.formatted(skills);


            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", prompt);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getSuggestedSkillsFromOpenAi :: Exited ");

            return convertSkillsResponseToString(response.getChoices().get(0).getMessage().getContent());

        } catch (Exception e) {
            logger.error("Service :: getSuggestedSkillsFromOpenAi :: Exception :: " + e.getMessage());
            return null;
        }
    }

    @Override
    public AiResponsibilityDto getSuggestedResponsibilitiesFromOpenAi(AiResponsibilityDto aiResponsibilityDto) {
        logger.debug("Service :: getSuggestedResponsibilitiesFromOpenAi :: Entered ");


        try {


            String prompt = """
                    You are an expert career-matching and resume intelligence assistant.
                    
                          You are given ONE candidate job role:
                    
                          ROLE:
                          %s
                    
                          Your task:
                          Generate **Key Responsibilities** – at least 10 role-specific, actionable responsibilities.  
                          These responsibilities must be strictly based on the given job role and fully relevant to that role.
                    
                          Rules:
                          1. Responsibilities must be directly related to the provided job role.
                          2. No generic filler terms such as "hardworking", "quick learner", or "dedicated".
                          3. No duplicates.
                          4. Use proper professional capitalization.
                          5. Return the output ONLY in the following JSON format, with no additional text or explanation:
                    
                          {
                            "response": [
                        
                            ]
                          }
                    
                    
                    """.formatted(aiResponsibilityDto.getResponse().toString());


            ChatCompletionRequest chatRequest = new ChatCompletionRequest("gpt-4o-mini", prompt);

            ChatCompleitonResponse response = restTemplate.postForObject("https://api.openai.com/v1/chat/completions", chatRequest, ChatCompleitonResponse.class);

            logger.debug("Service :: getSuggestedResponsibilitiesFromOpenAi :: Exited ");

            return convertResponsibilitesResponseToString(response.getChoices().get(0).getMessage().getContent());

        } catch (Exception e) {
            logger.error("Service :: getSuggestedResponsibilitiesFromOpenAi :: Exception :: " + e.getMessage());
            return null;
        }
    }


    public AiResponsibilityDto convertResponsibilitesResponseToString (String response) {
        logger.debug("Service :: convertResponsibilitesResponseToString :: Entered ");

        JsonObject jsonObject = null;
        String summary = null;

        AiResponsibilityDto responseDto = new AiResponsibilityDto();
        try {
            String jsonString = response.substring(response.indexOf('{'), response.lastIndexOf('}'));
            JsonElement jsonElement = JsonParser.parseString(jsonString + "}");
            if (jsonElement.isJsonObject()) {
                jsonObject = jsonElement.getAsJsonObject();
            }
            JSONObject jSONObject = new JSONObject(jsonObject.toString());
            responseDto.setResponse(getValueForSkills("response", jSONObject));
        } catch (Exception e) {
            logger.error("Service :: convertResponsibilitesResponseToString :: Exception :: " + e.getMessage());
        }
        logger.debug("Service :: convertResponsibilitesResponseToString :: Exited ");
        return responseDto;
    }


}
