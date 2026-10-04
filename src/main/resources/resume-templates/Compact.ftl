<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="utf-8"/>
<@fonts.loadFonts />



<style>

  @page:first {
    margin-top: 10px;
  }
  @page {
    size: A4;
    margin-top: 40px;
    margin-bottom: 10px;
    margin-left: 20px;
    margin-right: 20px;
  }

  html, body {
    margin: 0;
    padding: 0;
    width: 210mm;
    font-family: ${(style.primaryFont)!'PT Serif'};
    font-size: ${(style.bodySize)!'12pt'};
    line-height: ${(style.lineSpacing)!'1.4'};
    color: ${(style.bodyColor)!'#000000'};
    background: white;
  }

  .container {
    width: 210mm;
    padding: 5mm;
    margin: auto;
    box-sizing: border-box;
    position: relative;
    overflow-wrap:break-word;
  }

  .resume-header {
    margin-bottom: 12px;
    display:flex;
    align-items:center;
    gap:12px;
  }

  .profile-pic {
    width:72px;
    height:72px;
    object-fit:cover;
    border-radius:50%;
    border:2px solid #e6e6e6;
  }

  .header-right { flex:1; }

  .name {

    font-size: ${(style.nameSize)!'26pt'};
    font-weight: ${(style.fontWeightname)!'700'};
    color: ${(style.nameColor)!'#000000'};
    margin:0;
    line-height:1;
  }

  .contact {
    margin-top:6px;
  }
  .contact span { margin-right:8px; }

  .section {
    margin-top: 14px;
    margin-bottom: 14px;
  }

  .section-title {
    font-size: ${(style.sectionTitleSize)!'14pt'};
    font-weight: ${(style.fontWeightHeading)!'600'};
    color: ${(style.headingColor)!'#000000'};
    margin-top:20px;
    margin-bottom:10px;
    text-transform:uppercase;
    border-bottom:1px solid #1d1d1f;
    padding-bottom:6px;
  }

  .job-title {
   margin-top:7px;
   margin-bottom:7px;
    font-weight:600;
  }

  .bullets { margin-left:18px; margin-top:6px; }
  .bullets li { margin-bottom:4px; }


  .tags { display:flex; flex-wrap:wrap; gap:6px; margin-top:6px; }
  .tag {
    display:inline-block;
    padding:4px 8px;
    border-radius: 3px;
    background:#f0f0f0;
    font-size: 12pt;
  }

  .projectsection {
    margin-top:8px;
	margin-bottom:8px;
    padding-left:6px;
	line-height:1.5;

  }

   .educationsection {
    margin-top:8px;
	margin-bottom:8px;

	line-height:1.5;

  }

  .org-location{
    display:flex;
    justify-content:space-between;

    margin-bottom:4px;
  }

  .bullets {
    margin-left:18px;
    margin-top:6px;
  }

  .detail-item {
  margin-bottom:6px;
  }
  .experience-row{
    border-bottom:1px dashed #1d1d1f;
  }

    .project-subheading{
       font-weight:700;
       margin:3px 0px;
    }

</style>
</head>

<body>

 <#function extractDobYear input>
            <#if input?is_date>
              <#return input?string("MMM yyyy")>
            <#elseif input?? && input?has_content>
              <#attempt>

                <#local parsedDate = input?date("dd/MM/yyyy")>
                <#return parsedDate?string("dd/MM/yyyy")>
              <#recover>
                <#attempt>

                  <#local parsedDate = input?date("yyyy-MM-dd")>
                  <#return parsedDate?string("dd/MM/yyyy")>
                <#recover>
                  <#return "">
                </#attempt>
              </#recover>
            <#else>
              <#return "">
            </#if>
          </#function>

  <#function extractmonth input>
  <#if input?is_date>
    <#return input?string("MMM yyyy")>
  <#elseif input?? && input?has_content>
    <#attempt>
      <#-- Try dd/MM/yyyy -->
      <#local parsedDate = input?date("dd/MM/yyyy")>
      <#return parsedDate?string("MMM yyyy")>
    <#recover>
      <#attempt>
        <#-- Try yyyy-MM-dd -->
        <#local parsedDate = input?date("yyyy-MM-dd")>
        <#return parsedDate?string("MMM yyyy")>
      <#recover>
        <#return "">
      </#attempt>
    </#recover>
  <#else>
    <#return "">
  </#if>
</#function>


 <div class="container">

  <div class="resume-header">

    <#if profileImage?? && profileImage?has_content>
      <img src="${profileImage}" class="profile-pic" />
    </#if>

    <div class="header-right">

      <#if name?? && name?has_content>
        <h1 class="name">${name}</h1>
      </#if>

      <div class="contact">
        <#if phone?has_content>
          <span>${phone}</span>
        </#if>

        <#if email?has_content>
          <#if phone?has_content>|</#if>
          <span>${email}</span>
        </#if>

        <#if linkedin?? && linkedin?has_content>
          <#if phone?has_content || email?has_content>|</#if>
          <span><a href="${linkedin}" target="_blank">${linkedin}</a></span>
        </#if>

        <#if location?has_content>
          <#if phone?has_content || email?has_content || linkedin?has_content>|</#if>
          <span>${location}</span>
        </#if>
      </div>

    </div>
  </div>


  <#if objective?has_content>
    <div class="section">
      <div class="section-title">OBJECTIVE</div>
      <p>${objective}</p>
    </div>
  </#if>


  <#if summary?has_content>
    <div class="section">
      <div class="section-title">SUMMARY</div>
      <p>${summary}</p>
    </div>
  </#if>


  <#if skills?? && skills?trim?length gt 0>
    <div class="section">
      <div class="section-title">SKILLS</div>
      <div class="tags">
        <#list skills?split(",") as skill>
          <#if skill?has_content>
            <span class="tag">${skill?trim}</span>
          </#if>
        </#list>
      </div>
    </div>
  </#if>



  <#if experiences?? && experiences?size gt 0>
    <div class="section">
      <div class="section-title">PROFESSIONAL EXPERIENCE</div>

      <#list experiences as exp>
        <div class="experience-row">

          <#if exp.role?has_content>
            <div class="job-title">${exp.role}</div>
          </#if>

          <div class="org-location">
            <#if exp.companyName?has_content>
              <span>${exp.companyName}</span>
            </#if>

            <#if exp.experienceYearStartDate?has_content>
              <span> ${extractmonth(exp.experienceYearStartDate)}
                  <#if exp.experienceYearEndDate?has_content>
                     &#8211; ${extractmonth(exp.experienceYearEndDate)}
                  <#else>
                     &#8211; Present
                  </#if>
              </span>
            </#if>
          </div>

          <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
            <ul class="bullets">
              <#list exp.responsibilities?split(",") as resp>
                <#if resp?trim?has_content>
                  <li>${resp?trim}</li>
                </#if>
              </#list>
            </ul>
          </#if>

          <#if exp.projects?? && exp.projects?size gt 0>
           <div class="project-subheading">Project:</div>
            <#list exp.projects as proj>
              <div class="projectsection">
                <#if proj.projectName?has_content>
                  <div><strong>Name:</strong> ${proj.projectName}</div>
                </#if>

                <#if proj.projectSkills?has_content>
                  <div><strong>Skills:</strong>
                    <#list proj.projectSkills?split(",") as skill>
                      ${skill?trim}<#if skill_has_next>, </#if>
                    </#list>
                  </div>
                </#if>

                <#if proj.projectRole?has_content>
                  <div><strong>Role:</strong> ${proj.projectRole}</div>
                </#if>

                <#if proj.projectDescription?has_content>
                  <div><strong>Description:</strong> ${proj.projectDescription}</div>
                </#if>
              </div>
            </#list>
          </#if>

        </div>
      </#list>
    </div>
  </#if>




  <#if collegeProject?? && collegeProject?size gt 0>
    <div class="section">
      <div class="section-title">ACADEMIC PROJECT</div>

      <#list collegeProject as cproj>
        <div class="projectsection">
          <#if cproj.collegeProjectName?has_content>
            <div><strong>Project Title:</strong> ${cproj.collegeProjectName}</div>
          </#if>

          <#if cproj.collegeProjectSkills?has_content>
            <div><strong>Project Skills:</strong>
              <#list cproj.collegeProjectSkills?split(",") as skill>
                ${skill?trim}<#if skill_has_next>, </#if>
              </#list>
            </div>
          </#if>

          <#if cproj.collegeProjectDescription?has_content>
            <p><strong>Description:</strong> ${cproj.collegeProjectDescription}</p>
          </#if>
        </div>
      </#list>

    </div>
  </#if>



 <#if education?? && education?size gt 0>
  <div class="section">
    <div class="section-title">EDUCATION</div>
    <div class="educationsection">

      <#list education as edu>
        <div>
          <#if edu.department?? && edu.department?has_content>
            <strong>${edu.department}</strong>
          </#if>

          <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
             &#8211; ${edu.fieldOfStudy}
          </#if>

          <#if edu.percentage?? && edu.percentage?has_content>
             &#8211; ${edu.percentage}%
          </#if>

          <#if edu.institutionName?? && edu.institutionName?has_content>
             &#8211; ${edu.institutionName}
          </#if>

          <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
            ( ${extractmonth(edu.qualificationStartYear)}
            <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
               &#8211; ${extractmonth(edu.qualificationEndYear)} )
            <#else>
               &#8211; Present )
            </#if>
          </#if>

        </div>
      </#list>

    </div>
  </div>
</#if>




  <#if achievements?? && achievements?size gt 0>
    <div class="section">
      <div class="section-title">ACHIEVEMENTS</div>
      <ul class="bullets">
        <#list achievements as achieve>
          <#if achieve.achievementsName?has_content>
            <li>${achieve.achievementsName}
              <#if achieve.achievementsDate?has_content>
                 &#8211; ${extractmonth(achieve.achievementsDate)}
              </#if>
            </li>
          </#if>
        </#list>
      </ul>
    </div>
  </#if>



  <#if certificates?? && certificates?size gt 0>
    <div class="section">
      <div class="section-title">CERTIFICATES</div>
      <ul class="bullets">
        <#list certificates as certi>
          <#if certi.courseName?has_content>
            <li>${certi.courseName}
              <#if certi.courseStartDate?has_content>
                ( ${extractmonth(certi.courseStartDate)}
                <#if certi.courseEndDate?has_content>
                   &#8211; ${extractmonth(certi.courseEndDate)} )
                <#else>
                  )
                </#if>
              </#if>
            </li>
          </#if>
        </#list>
      </ul>
    </div>
  </#if>



  <#if competencies?has_content>
    <div class="section">
      <div class="section-title">CORE COMPETENCIES</div>
      <div class="tags">
        <#list competencies?split(",") as comp>
          <#if comp?has_content>
            <span class="tag">${comp?trim}</span>
          </#if>
        </#list>
      </div>
    </div>
  </#if>



  <#if softSkills?has_content>
    <div class="section">
      <div class="section-title">SOFT SKILLS</div>
      <div class="tags">
        <#list softSkills?split(",") as skill>
          <#if skill?has_content>
            <span class="tag">${skill?trim}</span>
          </#if>
        </#list>
      </div>
    </div>
  </#if>



  <#if strengths?has_content>
    <div class="section">
      <div class="section-title">STRENGTHS</div>
      <#list strengths?split(",") as skill>
        <#if skill?has_content>
          <div class="detail-item">${skill?trim}</div>
        </#if>
      </#list>
    </div>
  </#if>



  <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
    <div class="section">
      <div class="section-title">EXTRACURRICULAR ACTIVITIES</div>
      <#list extraCurricularActivities?split(",") as skill>
        <#if skill?has_content>
          <div class="detail-item">${skill?trim}</div>
        </#if>
      </#list>
    </div>
  </#if>



  <#if goals?has_content>
    <div class="section">
      <div class="section-title">GOALS</div>
      <#list goals?split(",") as skill>
        <#if skill?has_content>
          <div class="detail-item">${skill?trim}</div>
        </#if>
      </#list>
    </div>
  </#if>



  <#if addAdditionalDetails?? && addAdditionalDetails>
    <div class="section">
      <div class="section-title">PERSONAL DETAILS</div>

      <#if fatherName?has_content>
        <div class="detail-item"><strong>Father's Name:</strong> ${fatherName}</div>
      </#if>

      <#if maritalStatus?has_content>
        <div class="detail-item"><strong>Marital Status:</strong> ${maritalStatus}</div>
      </#if>

      <#if gender?has_content>
        <div class="detail-item"><strong>Gender:</strong> ${gender}</div>
      </#if>

      <#if dob?has_content>
        <div class="detail-item"><strong>DOB:</strong> ${extractDobYear(dob)}</div>
      </#if>

      <#if languagesKnown?has_content>
        <div class="detail-item"><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</div>
      </#if>

      <#if nationality?has_content>
        <div class="detail-item"><strong>Nationality:</strong> ${nationality}</div>
      </#if>

      <#if address?has_content>
        <div class="detail-item"><strong>Address:</strong> ${address}</div>
      </#if>
    </div>
  </#if>

</div>
</html>