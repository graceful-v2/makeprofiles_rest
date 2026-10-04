
<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="UTF-8"/>
<@fonts.loadFonts />

<style>

  @page:first {
    margin-top: 10px;
  }
  @page {
    size: A4;
    margin-top: 40px;
    margin-bottom: 8mm;
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
    padding:0;
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
    font-size: ${(style.nameSize)!'28pt'};
    font-weight: ${(style.fontWeightname)!'800'};
    color: ${(style.nameColor)!'#1f2933'};
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

    <#if name?? && name?has_content>
    <div class="header-right">
      <h1 class="name">${name}</h1>
    </div>
    </#if>

    <div class="contact">
      <#if phone?? && phone?has_content>
        <span>${phone}</span>
      </#if>

      <#if email?? && email?has_content>
        <span>| ${email}</span>
      </#if>

      <#if linkedin?? && linkedin?has_content>
        <span>| <a href="${linkedin}" target="_blank">${linkedin}</a></span>
      </#if>

	  <#if location?has_content>
          <#if phone?has_content || email?has_content || linkedin?has_content>|</#if>
          <span>${location}</span>
        </#if>
    </div>

  </div>


  <#if objective?? && objective?has_content>
  <div class="section">
    <div class="section-title">Objective</div>
    <p>${objective}</p>
  </div>
  </#if>


  <#if summary?? && summary?has_content>
  <div class="section">
    <div class="section-title">Summary</div>
    <p>${summary}</p>
  </div>
  </#if>


  <#if skills?? && skills?trim?length gt 0>
  <div class="section">
    <div class="section-title">Skills</div>
    <div class="tags">
      <#list skills?split(",") as skill>
        <#if skill?? && skill?has_content>
        <span class="tag">${skill?trim}</span>
        </#if>
      </#list>
    </div>
  </div>
  </#if>


  <#if experiences?? && experiences?size gt 0>
  <div class="section">
    <div class="section-title">Professional Experience</div>

    <#list experiences as exp>
    <div class="experience-row">

      <#if exp.role?? && exp.role?has_content>
      <div class="job-title">${exp.role}</div>
      </#if>

      <#if exp.companyName?? && exp.companyName?has_content>
      <div class="org-location">
        <span>${exp.companyName}</span>

        <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
          <span>
            ${extractmonth(exp.experienceYearStartDate)}
            <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
               &#8211; ${extractmonth(exp.experienceYearEndDate)}
            <#else>
               &#8211; Present
            </#if>
          </span>
        </#if>
      </div>
      </#if>


      <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
      <ul class="bullets">
        <#list exp.responsibilities?split(",") as r>
          <#if r?has_content>
            <li>${r?trim}</li>
          </#if>
        </#list>
      </ul>
      </#if>


      <#if exp.projects?? && exp.projects?size gt 0>
      <div class="project-subheading"></div>
        <#list exp.projects as prj>
        <div class="projectsection">

          <#if prj.projectName?? && prj.projectName?has_content>
          <div><strong>Name:</strong> ${prj.projectName}</div>
          </#if>

          <#if prj.projectSkills?? && prj.projectSkills?trim?length gt 0>
          <div><strong>Skills:</strong>
            <#list prj.projectSkills?split(",") as s>
              ${s?trim}<#if s_has_next>, </#if>
            </#list>
          </div>
          </#if>

          <#if prj.projectRole?? && prj.projectRole?has_content>
          <div><strong>Role:</strong> ${prj.projectRole}</div>
          </#if>

          <#if prj.projectDescription?? && prj.projectDescription?has_content>
          <div><strong>Description:</strong> ${prj.projectDescription}</div>
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
    <div class="section-title">Academic Project</div>

    <#list collegeProject as cp>
    <div class="projectsection">

      <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
      <div><strong>Project Title:</strong> ${cp.collegeProjectName}</div>
      </#if>

      <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
      <div><strong>Project Skills:</strong>
        <#list cp.collegeProjectSkills?split(",") as sk>
          ${sk?trim}<#if sk_has_next>, </#if>
        </#list>
      </div>
      </#if>

      <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
      <div><strong>Description:</strong> ${cp.collegeProjectDescription}</div>
      </#if>

    </div>
    </#list>

  </div>
  </#if>


  <#if education?? && education?size gt 0>
  <div class="section">
    <div class="section-title">Education</div>

    <#list education as edu>
    <div class="educationsection">
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
  </#if>


  <#if achievements?? && achievements?size gt 0>
  <div class="section">
    <div class="section-title">Achievements</div>
    <ul class="bullets">
      <#list achievements as ac>
        <#if ac.achievementsName?? && ac.achievementsName?has_content>
        <li>
          ${ac.achievementsName}
          <#if ac.achievementsDate?? && ac.achievementsDate?has_content>
             &#8211; ${extractmonth(ac.achievementsDate)}
          </#if>
        </li>
        </#if>
      </#list>
    </ul>
  </div>
  </#if>


  <#if certificates?? && certificates?size gt 0>
  <div class="section">
    <div class="section-title">Certificates</div>
    <ul class="bullets">
      <#list certificates as cr>
        <#if cr.courseName?? && cr.courseName?has_content>
        <li>
          ${cr.courseName}
          <#if cr.courseStartDate?? && cr.courseStartDate?has_content>
            ( ${extractmonth(cr.courseStartDate)}
              <#if cr.courseEndDate?? && cr.courseEndDate?has_content>
                 &#8211; ${extractmonth(cr.courseEndDate)} )
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


  <#if competencies?? && competencies?trim?length gt 0>
  <div class="section">
    <div class="section-title">Core Competencies</div>
    <div class="tags">
      <#list competencies?split(",") as c>
        <#if c?? && c?has_content>
        <span class="tag">${c?trim}</span>
        </#if>
      </#list>
    </div>
  </div>
  </#if>


  <#if softSkills?? && softSkills?trim?length gt 0>
  <div class="section">
    <div class="section-title">Soft Skills</div>
    <div class="tags">
      <#list softSkills?split(",") as ss>
        <#if ss?? && ss?has_content>
        <span class="tag">${ss?trim}</span>
        </#if>
      </#list>
    </div>
  </div>
  </#if>


  <#if strengths?? && strengths?trim?length gt 0>
  <div class="section">
    <div class="section-title">Strength</div>
    <#list strengths?split(",") as st>
      <#if st?? && st?has_content>
      <div class="detail-item">${st?trim}</div>
      </#if>
    </#list>
  </div>
  </#if>


  <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
  <div class="section">
    <div class="section-title">Extracurricular Activities</div>
    <#list extraCurricularActivities?split(",") as e>
      <#if e?? && e?has_content>
      <div class="detail-item">${e?trim}</div>
      </#if>
    </#list>
  </div>
  </#if>


  <#if goals?? && goals?trim?length gt 0>
  <div class="section">
    <div class="section-title">Goals</div>
    <#list goals?split(",") as g>
      <#if g?? && g?has_content>
      <div class="detail-item">${g?trim}</div>
      </#if>
    </#list>
  </div>
  </#if>


  <#if addAdditionalDetails?? && addAdditionalDetails>
  <div class="section">
    <div class="section-title">Personal Details</div>

    <#if fatherName?? && fatherName?has_content>
    <div class="detail-item"><strong>Father's Name:</strong> ${fatherName}</div>
    </#if>

    <#if maritalStatus?? && maritalStatus?has_content>
    <div class="detail-item"><strong>Marital Status:</strong> ${maritalStatus}</div>
    </#if>

    <#if gender?? && gender?has_content>
    <div class="detail-item"><strong>Gender:</strong> ${gender}</div>
    </#if>

    <#if dob?? && dob?has_content>
    <div class="detail-item"><strong>DOB:</strong> ${extractDobYear(dob)}</div>
    </#if>

    <#if languagesKnown?? && languagesKnown?has_content>
    <div class="detail-item"><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</div>
    </#if>

    <#if nationality?? && nationality?has_content>
    <div class="detail-item"><strong>Nationality:</strong> ${nationality}</div>
    </#if>

    <#if address?? && address?has_content>
    <div class="detail-item"><strong>Address:</strong> ${address}</div>
    </#if>

  </div>
  </#if>


</div>
</body>
</html>
