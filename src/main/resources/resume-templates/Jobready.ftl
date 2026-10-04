
<!DOCTYPE html>
<html lang="en">

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="utf-8" />
<@fonts.loadFonts />

  <!-- load a web font for a close visual match -->
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

    }

    .container {
      padding: 0;
      width: 210mm;
      margin: 0 auto;
      box-sizing: border-box;
       overflow-wrap:break-word;

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
      font-size: 12px;
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
      font-size: ${(style.sectionTitleSize)!'14px'};
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
      font-size: 11pt;
      font-weight: 500;
      color: #111010;
      margin-bottom: 8px;
      font-style: normal;
    }

    .exp-dates {
      font-size: 11pt;
      color: #0b6fa8;
      font-weight: 600;
      white-space: nowrap;
    }

    .exp-desc {
      margin: 6px 0 8px 0;
      color: #444;
      font-size: 11pt;
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
      font-size: 11pt;
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
      font-size: 10pt;
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
  <div class="container">


    <div class="header">

      <#if name?? && name?has_content>
        <div class="name">${name}</div>
      </#if>

      <#if title?? && title?has_content>
        <div class="title">${title}</div>
      </#if>

      <div class="contact-line">

        <#if phone?? && phone?has_content>
          <span>${phone}</span>
        </#if>


        <#if email?? && email?has_content>
          <span>•${email}</span>
        </#if>


        <#if linkedin?? && linkedin?has_content>
          <span>•<a href="${linkedin}" target="_blank">${linkedin}</a></span>
        </#if>

      </div>
    </div>

     <#if summary?? && summary?has_content>
    <div class="section">
      <div class="section-title">Summary</div>
      <div class="divider"></div>

      <p>${summary}</p>
    </div>
    </#if>


    <#if skills?? && skills?trim?length gt 0>
    <div class="section">
      <div class="section-title">Skills</div>
      <div class="divider"></div>

      <div class="skills">
        <div>
          <#list skills?split(",") as skill>
            <#if skill?? && skill?has_content>
              ${skill?trim}<#if skill_has_next>, </#if>
            </#if>
          </#list>
        </div>
      </div>
    </div>
    </#if>


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
                <#list exp.responsibilities?split(",") as r>
                  ${r?trim}<#if r_has_next>, </#if>
                </#list>
              </div>
            </#if>

          </div>

          <div class="exp-dates">
            <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
              ${extractmonth(exp.experienceYearStartDate)}
              <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                 &#8211; ${extractmonth(exp.experienceYearEndDate)}
              <#else>
                 &#8211; Present
              </#if>
            </#if>
          </div>
        </div>




        <#if exp.projects?? && exp.projects?size gt 0>
        <div class="project-title">Projects:</div>

        <#list exp.projects as proj>
        <div class="project-block">

          <#if proj.projectName?? && proj.projectName?has_content>
            <div class="project-desc"><strong>Name</strong>  &#8211; ${proj.projectName}</div>
          </#if>

          <#if proj.projectRole?? && proj.projectRole?has_content>
            <div class="project-desc"><strong>Role</strong>  &#8211; ${proj.projectRole}</div>
          </#if>

          <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
            <div class="project-desc"><strong>Skills</strong>  &#8211;
              <#list proj.projectSkills?split(",") as sk>
                ${sk?trim}<#if sk_has_next>, </#if>
              </#list>
            </div>
          </#if>

          <#if proj.projectDescription?? && proj.projectDescription?has_content>
            <div class="project-desc"><strong>Description</strong>  &#8211; ${proj.projectDescription}</div>
          </#if>

        </div>
        </#list>
        </#if>

      </div>
      </#list>

    </div>
    </#if>


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
            <div class="edu-school">${edu.fieldOfStudy}  &#8209;

			  <#if edu.percentage?? && edu.percentage?has_content>
				< ${edu.percentage}
			  </#if>

			</div>
          </#if>

        </div>

        <div class="edu-year">
          <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
            ${extractmonth(edu.qualificationStartYear)}
            <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
               &#8211; ${extractmonth(edu.qualificationEndYear)}
            <#else>
               &#8211; Present
            </#if>
          </#if>
        </div>
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
          <div class="academic-item"><strong>Name</strong>  &#8211; ${cp.collegeProjectName}</div>
        </#if>

        <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
          <div class="academic-item"><strong>Skills</strong>  &#8211;
            <#list cp.collegeProjectSkills?split(",") as c>
              ${c?trim}<#if c_has_next>, </#if>
            </#list>
          </div>
        </#if>

        <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
          <div class="academic-item"><strong>Description</strong>  &#8211; ${cp.collegeProjectDescription}</div>
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
        <#list certificates as c>
          <#if c.courseName?? && c.courseName?has_content>
          <li>
            ${c.courseName}
            <#if c.courseStartDate?? && c.courseStartDate?has_content>
              ( ${extractmonth(c.courseStartDate)}
                <#if c.courseEndDate?? && c.courseEndDate?has_content>
                   &#8211; ${extractmonth(c.courseEndDate)} )
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

    <!-- ACHIEVEMENTS -->
    <#if achievements?? && achievements?size gt 0>
    <div class="section">
      <div class="section-title">Achievements & Awards</div>
      <div class="divider"></div>

      <ul class="cert-list">
      <#list achievements as a>
        <#if a.achievementsName?? && a.achievementsName?has_content>
          <li>
            ${a.achievementsName}
            <#if a.achievementsDate?? && a.achievementsDate?has_content>
               &#8211; ${extractmonth(a.achievementsDate)}
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
        <#list softSkills?split(",") as s>
          <#if s?? && s?has_content>
            ${s?trim}<#if s_has_next>, </#if>
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
          <#if c?? && c?has_content>
            ${c?trim}<#if c_has_next>, </#if>
          </#if>
        </#list>
      </div>
    </div>
    </#if>

    <!-- STRENGTHS -->
    <#if strengths?? && strengths?trim?length gt 0>
    <div class="section">
      <div class="section-title">Strengths</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list strengths?split(",") as st>
          <#if st?? && st?has_content>
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
          <#if g?? && g?has_content>
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
        <#list hobbies?split(",") as h>
          <#if h?? && h?has_content>
            <li>${h?trim}</li>
          </#if>
        </#list>
      </ul>

    </div>
    </#if>

    <!-- EXTRA CURRICULAR -->
    <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
    <div class="section">
      <div class="section-title">Extra Circular Activities</div>
      <div class="divider"></div>

      <ul class="cert-list">
        <#list extraCurricularActivities?split(",") as ex>
          <#if ex?? && ex?has_content>
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
        <div class="academic-item"><strong>Father Name</strong>  &#8211; ${fatherName}</div>
      </#if>

      <#if dob?? && dob?has_content>
        <div class="academic-item"><strong>DOB</strong>  &#8211; ${extractDobYear(dob)}</div>
      </#if>

      <#if nationality?? && nationality?has_content>
        <div class="academic-item"><strong>Nationality</strong>  &#8211; ${nationality}</div>
      </#if>

	    <#if gender?? && gender?has_content>
        <div class="academic-item"><strong>Gender</strong>  &#8211; ${gender}</div>
      </#if>


      <#if maritalStatus?? && maritalStatus?has_content>
        <div class="academic-item"><strong>Martial Status</strong>  &#8211; ${maritalStatus}</div>
      </#if>

     <#if address?? && address?has_content>
        <div class="academic-item"><strong>Address</strong>  &#8211; ${address}</div>
      </#if>


      <#if languagesKnown?? && languagesKnown?has_content>
        <div class="academic-item"><strong>Languages Known</strong>  &#8211; ${languagesKnown?replace(",", ", ")}</div>
      </#if>

    </div>
    </#if>

  </div>
</body>
</html>
