

<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="UTF-8">

<@fonts.loadFonts />
<style>



   @page:first { margin-top: 10px; }

  @page {
    size: A4;
    margin-top: 40px;
    margin-bottom: 10px;
    margin-left: 20px;
    margin-right: 20px;
  }


html, body {
 width: 210mm;
  margin: 0 auto;
  padding: 0;
font-family: ${(style.primaryFont)!'Calibri, Arial, sans-serif'};
font-size: ${(style.bodySize)!'13pt'};
color: ${(style.bodyColor)!'#222'};

line-height: ${(style.lineHeight)!'1.3'};
}


    .container {
    width: 210mm;
    padding: 10mm;
    margin:0;
    box-sizing: border-box;
    position: relative;
    overflow-wrap:break-word;
    word-break:break-word;
  }


.name {
    font-size: ${(style.nameSize)!'28pt'};
    font-weight: ${(style.fontWeightname)!'800'};
    color: ${(style.nameColor)!'#0a4fa3'};
    margin-bottom: 2px;
}

.role {
    color: #444;
    margin-bottom: 4px;
}

.contact-line {
    color: #444;
    margin-bottom: 16px;
}

.section {
    margin-top: 22px;
}

.section-title {
    font-size: ${(style.sectionTitleSize)!'15pt'};
    font-weight: ${(style.fontWeightHeading)!'700'};
    color: ${(style.headingColor)!'#0a4fa3'};
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 8px;

}

.blue-line {
    height: 2px;
    width: 100%;
    background: #0a4fa3;
    margin-bottom: 10px;
}

.exp-job {
    font-weight: 700;
    font-size: 12pt;
}

.exp-company {
    font-size: 12pt;
	margin-top:5px;
    margin-bottom: 5px;
}

.exp-dates {
    float: right;
    color: #0a4fa3;
    font-weight: 600;

}

.bullets {
    margin-left: 18px;
}

.bullets li {
    margin-bottom: 4px;
}


.project-title {
  font-size:12pt;
    margin-top: 6px;
	margin-bottom: 6px;
    font-weight: 700;
}

.project-item {
 margin-bottom: 5px;
}

.project-block{
    margin-left: 10px;
	 margin-bottom: 10px;
	  border-bottom:0.5px dashed  #0a4fa3;

}

 .edu-item {
    margin-bottom: 10px;
	line-height:1.5;
}

.edu-degree {
    font-weight: 700;
}

.edu-school {
    font-size: 12pt;
}

.edu-years {
    float: right;
    color: #0a4fa3;
    font-weight: 600;
}

 .skills-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    row-gap: 4px;
    column-gap: 10px;

}

 .detail-item {
    margin-bottom: 5px;
}

.exp-item{
 margin-top: 6px;
 margin-bottom: 10px;
 border-bottom:1px dashed  #0a4fa3;


}

.achievement-section{

margin:5px 0px
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


  <#if name?? && name?has_content>
  <div class="name">${name}</div>
  </#if>

  <!-- ROLE -->
  <#if role?? && role?has_content>
  <div class="role">${role}</div>
  </#if>

  <!-- CONTACT -->
  <div class="contact-line">


    <#if phone?? && phone?has_content>
     ${phone}
    </#if>

    <#if email?? && email?has_content>
      &#9679; ${email}
    </#if>
	<#if linkedin?? && linkedin?has_content>
      &#9679; ${linkedin}
    </#if>
	<#if location?? && location?has_content>
       &#9679; ${location}
    </#if>
  </div>

  <#if summary?? && summary?has_content>
  <div class="section">
    <div class="section-title">Summary</div>
    <div class="blue-line"></div>
    <div>${summary}</div>
  </div>
  </#if>

   <#if objective?? && objective?has_content>
  <div class="section">
    <div class="section-title">Objective</div>
    <div class="blue-line"></div>
    <div>${objective}</div>
  </div>
  </#if>



  <!-- ================= TECHNICAL SKILLS ================= -->
  <#if skills?? && skills?trim?length gt 0>
  <div class="section">
    <div class="section-title">Technical Skills</div>
    <div class="blue-line"></div>

    <div class="skills-grid">
      <#list skills?split(",") as skill>
        <#if skill?? && skill?has_content>
        <div>${skill?trim}</div>
        </#if>
      </#list>
    </div>
  </div>
  </#if>


  <!-- ================= EXPERIENCE ================= -->
  <#if experiences?? && experiences?size gt 0>
  <div class="section">
    <div class="section-title">Professional Experience</div>
    <div class="blue-line"></div>

    <#list experiences as exp>
    <div class="exp-item">

      <#if exp.role?? && exp.role?has_content>
      <div class="exp-job">
        ${exp.role}
      </div>
      </#if>

      <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
      <span class="exp-dates">
        ${extractmonth(exp.experienceYearStartDate)}
        <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
        &#8208; ${extractmonth(exp.experienceYearEndDate)}
        <#else>
        &#8208; Present
        </#if>
      </span>
      </#if>

      <#if exp.companyName?? && exp.companyName?has_content>
      <div class="exp-company">${exp.companyName}</div>
      </#if>

      <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
      <ul class="bullets">
        <#list exp.responsibilities?split(",") as res>
          <#if res?has_content>
          <li>${res?trim}</li>
          </#if>
        </#list>
      </ul>
      </#if>


      <!-- EXPERIENCE PROJECTS -->
      <#if exp.projects?? && exp.projects?size gt 0>
      <div class="project-title">Projects:</div>

      <#list exp.projects as prj>
      <div class="project-block">

        <#if prj.projectName?? && prj.projectName?has_content>
        <div class="project-item"><b>Name:</b> ${prj.projectName}</div>
        </#if>

        <#if prj.projectRole?? && prj.projectRole?has_content>
        <div class="project-item"><b>Role:</b> ${prj.projectRole}</div>
        </#if>

        <#if prj.projectSkills?? && prj.projectSkills?trim?length gt 0>
        <div class="project-item"><b>Skills:</b></div>
        <ul class="bullets">
          <#list prj.projectSkills?split(",") as ps>
            <#if ps?has_content>
            <li>${ps?trim}</li>
            </#if>
          </#list>
        </ul>
        </#if>

        <#if prj.projectDescription?? && prj.projectDescription?has_content>
        <div class="project-item"><b>Description:</b> ${prj.projectDescription}</div>
        </#if>

      </div>
      </#list>

      </#if>

    </div>
    </#list>
  </div>
  </#if>


  <!-- ================= EDUCATION ================= -->
  <#if education?? && education?size gt 0>
  <div class="section">
    <div class="section-title">Education</div>
    <div class="blue-line"></div>

    <#list education as edu>
    <div class="edu-item">

      <#if edu.department?? && edu.department?has_content>
      <span class="edu-degree">${edu.department}</span>
      </#if>

      <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
      <span class="edu-years">
        ${extractmonth(edu.qualificationStartYear)}
        <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
          &#8208; ${extractmonth(edu.qualificationEndYear)}
        <#else>
          &#8208; Present
        </#if>
      </span>
      </#if>
      <br/>

      <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
      <span class="edu-school">${edu.fieldOfStudy}

	  <#if edu.percentage?? && edu.percentage?has_content>
              &#8211; ${edu.percentage}%

        </#if>
	  </span><br/>
      </#if>



      <#if edu.institutionName?? && edu.institutionName?has_content>
      <span class="edu-school">${edu.institutionName}</span>
      </#if>

    </div>
    </#list>

  </div>
  </#if>


   <#if collegeProject?? && collegeProject?size gt 0>
  <div class="section">
    <div class="section-title">Academic Projects</div>
    <div class="blue-line"></div>

    <#list collegeProject as cp>

      <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
      <div class="project-item"><b>Name:</b> ${cp.collegeProjectName}</div>
      </#if>

      <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
      <div class="project-item"><b>Skills:</b>
        <#list cp.collegeProjectSkills?split(",") as cs>
          ${cs?trim}<#if cs_has_next>, </#if>
        </#list>
      </div>
      </#if>

      <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?trim?length gt 0>
      <div class="project-item"><b>Description:</b> ${cp.collegeProjectDescription}</div>
      </#if>

    </#list>
  </div>
  </#if>


  <!-- ================= EXTRA SKILLS ================= -->
  <#if extraSkills?? && extraSkills?trim?length gt 0>
  <div class="section">
    <div class="section-title">Skills</div>
    <div class="line"></div>
    <#list extraSkills?split(",") as es>
      <#if es?? && es?has_content>
      <div class="skill-item">• ${es?trim}</div>
      </#if>
    </#list>
  </div>
  </#if>


  <!-- ================= CORE COMPETENCIES ================= -->
  <#if competencies?? && competencies?trim?length gt 0>
  <div class="section">
    <div class="section-title">Core Compentencies</div>
    <div class="blue-line"></div>

    <div class="skills-grid">
      <#list competencies?split(",") as c>
        <#if c?? && c?has_content>
        <div>${c?trim}</div>
        </#if>
      </#list>
    </div>
  </div>
  </#if>


  <!-- ================= GOALS ================= -->
  <#if goals?? && goals?trim?length gt 0>
  <div class="section">
    <div class="section-title">Goals</div>
    <div class="blue-line"></div>
    <ul class="bullets">
      <#list goals?split(",") as g>
        <#if g?? && g?has_content>
        <li>${g?trim}</li>
        </#if>
      </#list>
    </ul>
  </div>
  </#if>


  <!-- ================= STRENGTHS ================= -->
  <#if strengths?? && strengths?trim?length gt 0>
  <div class="section">
    <div class="section-title">Strenghts</div>
    <div class="blue-line"></div>
    <ul class="bullets">
      <#list strengths?split(",") as st>
        <#if st?? && st?has_content>
        <li>${st?trim}</li>
        </#if>
      </#list>
    </ul>
  </div>
  </#if>


  <!-- ================= EXTRA CIRCULAR ACTIVITIES ================= -->
  <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
  <div class="section">
    <div class="section-title">Extracurricular Activites</div>
    <div class="blue-line"></div>
    <ul class="bullets">
      <#list extraCurricularActivities?split(",") as e>
        <#if e?? && e?has_content>
        <li>${e?trim}</li>
        </#if>
      </#list>
    </ul>
  </div>
  </#if>


  <!-- ================= HOBBIES ================= -->
  <#if hobbies?? && hobbies?trim?length gt 0>
  <div class="section">
    <div class="section-title">Hobbies</div>
    <div class="blue-line"></div>
    <ul class="bullets">
      <#list hobbies?split(",") as hb>
        <#if hb?? && hb?has_content>
        <li>${hb?trim}</li>
        </#if>
      </#list>
    </ul>
  </div>
  </#if>

   <#if certificates?? && certificates?size gt 0>
    <div class="section">
        <div class="section-title">CERTIFICATIONS</div>
        <div class="blue-line"></div>
        <#list certificates as certi>
            <#if certi.courseName?? && certi.courseName?has_content>
          <div class="achievement-section">
            <div class="flex-row">
              <div class="left">${certi.courseName}</div>
              <div class="right">
                <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                  ${extractmonth(certi.courseStartDate)}
                  <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                    &#8208; ${extractmonth(certi.courseEndDate)}
                  </#if>
                </#if>
              </div>
            </div>
          </div>
          </#if>
        </#list>

              </div>
      </#if>

      <#if achievements?? && achievements?size gt 0>
       <div class="section">
        <div class="section-title">ACHIEVEMENTS</div>
        <div class="blue-line"></div>
        <#list achievements as achieve>
          <div class="achievement-section">
            <div class="flex-row">
              <div class="left">${achieve.achievementsName}</div>
              <div class="right">
                <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                  ${extractmonth(achieve.achievementsDate)}
                </#if>
              </div>
            </div>
          </div>
        </#list>
          </div>
      </#if>



  <!-- ================= ADDITIONAL INFORMATION ================= -->
  <#if addAdditionalDetails?? && addAdditionalDetails>
  <div class="section">
    <div class="section-title">Additional Information</div>
    <div class="blue-line"></div>

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
