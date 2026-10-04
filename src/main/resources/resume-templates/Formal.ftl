
<!DOCTYPE html>
<html lang="en">

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="utf-8" />
  <@fonts.loadFonts />



  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">

  <style>
    @page: first {
      margin-top: 30px;
    }

    @page {
      size: A4;
      margin-top: 40px;
      margin-bottom: 10px;
      margin-left: 20px;
      margin-right: 20px;
    }

    html,
    body {
      margin: 0;
      padding: 0;
      font-family: ${(style.primaryFont)!'Poppins, Arial, sans-serif'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.45'};
      color: ${(style.bodyColor)!'#333'};
      background: #ffffff;
      width: 210mm;

    }

    .container {
      width: 210mm;
      box-sizing: border-box;
      position: relative;
      margin-left:20px;
      padding-left:15px;
      overflow-wrap:break-word;
      word-break:break-word;
    }

    /* Header */
    .header {
      margin-bottom: 14px;
    }

    .name {
      font-size: ${(style.nameSize)!'30px'};
      font-weight: ${(style.fontWeightname)!'800'};
      color: ${(style.nameColor)!'#8b2d1b'};
      /* brick/maroon similar to image */
      margin: 0 0 4px 0;
      letter-spacing: 0.2px;
    }

    .title {
      font-size: 14px;
      font-weight: 600;
      color: #666;
      margin: 0 0 6px 0;
    }

    .contact-line {

      color: #121212;
      margin-top: 6px;
    }

    .contact-line span {
      margin-right: 12px;
    }

    /* Section wrapper */
    .section {
      margin-top: 20px;
      margin-bottom: 6px;

    }

    .section-title {
      font-size: ${(style.sectionTitleSize)!'15px'};
      font-weight: ${(style.fontWeightHeading)!'700'};
        color: ${(style.headingColor)!'#0b6fa8'};
      /* blue heading */
      text-transform: uppercase;
      letter-spacing: 0.6px;
      margin-bottom: 8px;
    }

    .divider {
      height: 2px;
      background: #e6eef6;
      margin-bottom: 12px;
      border-radius: 2px;
    }

    /* Experience layout */
    .exp-item {
      margin-bottom: 18px;
      padding-bottom: 10px;
      border-bottom: 1px solid #f0f0f0;
    }

    .exp-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      gap: 12px;
    }

    .exp-left {
      max-width: 78%;
    }

    .exp-title {
      font-weight: 700;
      color: #222;
      font-size: 12.5pt;
      margin: 0 0 2px 0;
    }

    .exp-company {

      font-weight: 500;
      color: #111010;
      margin-bottom: 8px;
      font-style: normal;
    }

    .exp-dates {

      color: #0b6fa8;
      font-weight: 600;
      white-space: nowrap;
    }

    .exp-desc {
      margin: 6px 0 8px 0;
      color: #444;

    }

    .bullets {
      margin-left: 18px;
      margin-top: 6px;
    }

    .bullets li {
      margin-bottom: 6px;
    }

    /* Project block inside experience */
    .project-block {
      margin-top: 8px;
      padding-top: 6px;
      border-top: 1px dashed #e6eef6;
    }

    .project-title {
      font-weight: 700;
      font-size: 13pt;
      margin-bottom: 4px;
    }

    .project-desc {
      margin-left: 12px;
      margin: 7px 0px;
    }

    /* Education */
    .edu-item {
      margin-bottom: 10px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      gap: 10px;
    }

    .edu-left {
      max-width: 78%;
    }

    .edu-degree {
      font-weight: 700;
      color: #222;
    }

    .edu-school {
      color: #666;

      margin-top: 4px;
    }

    .edu-year {
      color: #0b6fa8;
      font-weight: 600;
      white-space: nowrap;
    }

    /* Academic projects simple list */
    .academic-item {
      margin-bottom: 8px;
      font-size: 12pt;
    }

    /* Certification list with blue bullets */
    .cert-list {
      margin-left: 18px;
    }

    .cert-list li {
      margin-bottom: 8px;
      list-style: none;
      position: relative;
      padding-left: 18px;

    }

    .cert-list li:before {
      content: "";
      width: 10px;
      height: 10px;
      background: #0b6fa8;
      display: inline-block;
      border-radius: 50%;
      position: absolute;
      left: 0;
      top: 6px;
    }




    .footer-note {
      margin-top: 20px;

      color: #999;
      text-align: center;
    }

    .muted {

      font-style: italic;
    }

    .strong {
      font-weight: 700;
      color: #222;
    }

    .project-heading {
      font-weight: 700;
      margin-left: 12px;
      margin: 5px 0px;
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

    <!-- HEADER -->
    <div class="header">

      <#if name?? && name?has_content>
      <div class="name">${name}</div>
      </#if>


      <div class="contact-line">

        <#if phone?? && phone?has_content>
        <span>${phone}</span>
        </#if>

        <#if email?? && email?has_content>
        <span>&#8226</span>
        <span>${email}</span>
        </#if>

        <#if linkedin?? && linkedin?has_content>

        <span><span>&#8226</span><a href="${linkedin}" target="_blank">${linkedin}</a></span>
        </#if>

      </div>
    </div>


    <!-- SUMMARY -->
    <#if summary?? && summary?has_content>
    <div class="section">
      <div class="section-title">Summary</div>
      <div class="divider"></div>
      <p>${summary}</p>
    </div>
    </#if>


    <!-- SKILLS -->
    <#if skills?? && skills?trim?length gt 0>
    <div class="section">
      <div class="section-title">Skills</div>
      <div class="divider"></div>
      <div class="skills">
        <#list skills?split(",") as sk>
          <#if sk?has_content>
          <div>${sk?trim}</div>
          </#if>
        </#list>
      </div>
    </div>
    </#if>


    <!-- WORK EXPERIENCE -->
    <#if experiences?? && experiences?size gt 0>
    <div class="section">
      <div class="section-title">Work Experience</div>
      <div class="divider"></div>

      <#list experiences as exp>
      <div class="exp-item">
        <div class="exp-header">
          <div class="exp-left">

            <#if exp.role?? && exp.role?has_content>
            <div class="exp-title">${exp.role}</div>
            </#if>

            <#if exp.companyName?? && exp.companyName?has_content>
            <div class="exp-company">${exp.companyName}</div>
            </#if>

            <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
            <div class="muted">
              <#list exp.responsibilities?split(",") as rs>
                <#if rs?has_content>
                  ${rs?trim}<#if rs_has_next>, </#if>
                </#if>
              </#list>
            </div>
            </#if>

          </div>

          <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
          <div class="exp-dates">
            ${extractmonth(exp.experienceYearStartDate)}
            <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
             &#8211; ${extractmonth(exp.experienceYearEndDate)}
            <#else>
             &#8211; Present
            </#if>
          </div>
          </#if>
        </div>


        <!-- BULLET POINTS -->
        <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
        <ul class="bullets">
          <#list exp.responsibilities?split(",") as res>
            <#if res?has_content>
            <li>${res?trim}</li>
            </#if>
          </#list>
        </ul>
        </#if>


        <!-- PROJECTS -->
        <#if exp.projects?? && exp.projects?size gt 0>
        <div class="project-title">Projects:</div>

        <#list exp.projects as prj>
        <div class="project-block">

          <#if prj.projectName?? && prj.projectName?has_content>
          <div class="project-desc"><strong>Name</strong> &#8208; ${prj.projectName}</div>
          </#if>

          <#if prj.projectRole?? && prj.projectRole?has_content>
          <div class="project-desc"><strong>Role</strong> &#8208; ${prj.projectRole}</div>
          </#if>

          <#if prj.projectSkills?? && prj.projectSkills?trim?length gt 0>
          <div class="project-desc">
            <strong>Skills</strong> &#8208;
            <#list prj.projectSkills?split(",") as prsk>
              ${prsk?trim}<#if prsk_has_next>, </#if>
            </#list>
          </div>
          </#if>

          <#if prj.projectDescription?? && prj.projectDescription?has_content>
          <div class="project-desc"><strong>Description</strong> &#8208; ${prj.projectDescription}</div>
          </#if>

        </div>
        </#list>
        </#if>

      </div>
      </#list>

    </div>
    </#if>


    <!-- EDUCATION -->
    <#if education?? && education?size gt 0>
    <div class="section">
      <div class="section-title">Education</div>
      <div class="divider"></div>

      <#list education as edu>
      <div class="edu-item">

        <div class="edu-left">

          <#if edu.institutionName?? && edu.institutionName?has_content>
          <div class="edu-degree">${edu.institutionName}</div>
          </#if>

		  <#if edu.department?? && edu.department?has_content>
          <div class="edu-school">${edu.department}</div>
          </#if>

          <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
          <div class="edu-school">${edu.fieldOfStudy}

	       <#if edu.percentage?? && edu.percentage?has_content>
	       &#8208; {edu.percentage}%
	        </#if>

		  </div>
          </#if>

        </div>

        <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
        <div class="edu-year">
          ${extractmonth(edu.qualificationStartYear)}
          <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
           &#8211; ${extractmonth(edu.qualificationEndYear)}
          <#else>
           &#8211; Present
          </#if>
        </div>
        </#if>

      </div>
      </#list>

    </div>
    </#if>


    <!-- ACADEMIC PROJECTS -->
    <#if collegeProject?? && collegeProject?size gt 0>
    <div class="section">
      <div class="section-title">Academic Projects</div>
      <div class="divider"></div>

      <#list collegeProject as cp>
      <div class="project-block">

        <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
        <div class="academic-item"><strong>Name</strong> &#8208; ${cp.collegeProjectName}</div>
        </#if>

        <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
        <div class="academic-item"><strong>Skills</strong> &#8208;
          <#list cp.collegeProjectSkills?split(",") as csl>
            ${csl?trim}<#if csl_has_next>, </#if>
          </#list>
        </div>
        </#if>

        <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
        <div class="academic-item"><strong>Description</strong> &#8208; ${cp.collegeProjectDescription}</div>
        </#if>

      </div>
      </#list>

    </div>
    </#if>


    <!-- CERTIFICATIONS -->
    <#if certificates?? && certificates?size gt 0>
    <div class="section">
      <div class="section-title">Certifications</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list certificates as ct>
          <#if ct.courseName?? && ct.courseName?has_content>
          <li>
            ${ct.courseName}
            <#if ct.courseStartDate?? && ct.courseStartDate?has_content>
              ( ${extractmonth(ct.courseStartDate)}
              <#if ct.courseEndDate?? && ct.courseEndDate?has_content>
                 &#8211; ${extractmonth(ct.courseEndDate)}
              </#if>
              )
            </#if>
          </li>
          </#if>
        </#list>
      </ul>

    </div>
    </#if>


    <!-- ACHIEVEMENTS & AWARDS -->
    <#if achievements?? && achievements?size gt 0>
    <div class="section">
      <div class="section-title">Achievements & Awards</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list achievements as ac>
          <#if ac.achievementsName?? && ac.achievementsName?has_content>
          <li>
            ${ac.achievementsName}
            <#if ac.achievementsDate?? && ac.achievementsDate?has_content>
              &#8208; ${extractmonth(ac.achievementsDate)}
            </#if>
          </li>
          </#if>
        </#list>
      </ul>

    </div>
    </#if>


    <!-- SOFT SKILLS -->
    <#if softSkills?? && softSkills?trim?length gt 0>
    <div class="section">
      <div class="section-title">Soft Skills</div>
      <div class="divider"></div>

      <div class="skills">
        <#list softSkills?split(",") as ss>
          <#if ss?has_content>
          <div>${ss?trim}</div>
          </#if>
        </#list>
      </div>

    </div>
    </#if>


    <!-- CORE COMPETENCIES -->
    <#if competencies?? && competencies?trim?length gt 0>
    <div class="section">
      <div class="section-title">Core Competencies</div>
      <div class="divider"></div>

      <div class="skills">
        <#list competencies?split(",") as c>
          <#if c?has_content>
          <div>${c?trim}</div>
          </#if>
        </#list>
      </div>

    </div>
    </#if>


    <!-- STRENGTHS -->
    <#if strengths?? && strengths?trim?length gt 0>
    <div class="section">
      <div class="section-title">Strength</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list strengths?split(",") as st>
          <#if st?has_content>
          <li>${st?trim}</li>
          </#if>
        </#list>
      </ul>

    </div>
    </#if>


    <!-- GOALS -->
    <#if goals?? && goals?trim?length gt 0>
    <div class="section">
      <div class="section-title">Goals</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list goals?split(",") as g>
          <#if g?has_content>
          <li>${g?trim}</li>
          </#if>
        </#list>
      </ul>

    </div>
    </#if>


    <!-- HOBBIES -->
    <#if hobbies?? && hobbies?trim?length gt 0>
    <div class="section">
      <div class="section-title">Hobbies</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list hobbies?split(",") as hb>
          <#if hb?has_content>
          <li>${hb?trim}</li>
          </#if>
        </#list>
      </ul>

    </div>
    </#if>


    <!-- EXTRA CURRICULAR ACTIVITIES -->
    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
    <div class="section">
      <div class="section-title">Extra Curricular Activities</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list extraCurricularActivities?split(",") as ex>
          <#if ex?has_content>
          <li>${ex?trim}</li>
          </#if>
        </#list>
      </ul>

    </div>
    </#if>


    <!-- PERSONAL DETAILS -->
    <#if addAdditionalDetails?? && addAdditionalDetails>
    <div class="section">
      <div class="section-title">Personal Details</div>
      <div class="divider"></div>

      <#if fatherName?? && fatherName?has_content>
      <div class="academic-item"><strong>Father Name</strong> &#8208; ${fatherName}</div>
      </#if>

      <#if dob?? && dob?has_content>
      <div class="academic-item"><strong>DOB</strong> &#8208; ${extractDobYear(dob)}</div>
      </#if>

	  <#if gender?? && gender?has_content>
      <div class="academic-item"><strong>Gender</strong> &#8208; ${gender}</div>
      </#if>

	    <#if maritalStatus?? && maritalStatus?has_content>
      <div class="academic-item"><strong>Martial Status</strong> &#8208; ${maritalStatus}</div>
      </#if>

	   <#if address?? && address?has_content>
      <div class="academic-item"><strong>Address</strong> &#8208; ${address}</div>
      </#if>

      <#if nationality?? && nationality?has_content>
      <div class="academic-item"><strong>Nationality</strong> &#8208; ${nationality}</div>
      </#if>

      <#if languagesKnown?? && languagesKnown?has_content>
      <div class="academic-item"><strong>Language Known</strong> &#8208; ${languagesKnown?replace(",", ", ")}</div>
      </#if>

    </div>
    </#if>


  </div>
</body>
