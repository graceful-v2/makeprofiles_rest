

<!DOCTYPE html>
<html>

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="utf-8" />
     <@fonts.loadFonts />
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
      font-family: ${(style.primaryFont)!'Poppins'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.3'};
      color: ${(style.bodyColor)!'#222'};
      background: #fff;
    }

    .container {
      width: 210mm;
      margin: 0 auto;
      box-sizing: border-box;
      display: grid;
      grid-template-columns: 64% 36%;
      gap: 5px;
      overflow-wrap:break-word;
      word-break:break-word;

    }

    .right-section {
      background: #860f0f;
      color: #fff;
      padding: 22px 18px;
      box-sizing: border-box;
      border-radius: 4px;
      display: flex;
      flex-direction: column;
      gap: 18px;
       overflow-wrap:break-word;
            word-break:break-word;

    }

    .right-section .photo {
      width: 100%;
      height: 120px;
      object-fit: cover;
      border-radius: 4px;
      background: #e5f0f2;
    }

    .right-section .block-title {
      font-weight: 700;
      font-size: ${(style.bodySize)!'14pt'};
      color: #eaf8fb;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .right-section .contact-item{

      margin-bottom: 6px;
      color: #eaf8fb;
      display: flex;
      gap: 12px;
      align-items: center;

    }

    .right-section .skill-chip {
      display: inline-block;
      background: rgba(255, 255, 255, 0.12);
      color: #fff;
      padding: 3px 5px;
      border-radius: 12px;
      margin: 6px 6px 0 0;

    }

    /* MAIN CONTENT */
    .main {
      padding: 6px 7px;
      box-sizing: border-box;
    }

    .header {
      margin-bottom: 8px;
    }

    .name {
      font-size: ${(style.nameSize)!'32px'};
      font-weight: ${(style.fontWeightname)!'800'};
      color: ${(style.nameColor)!'#161616'};
      margin: 0 0 4px 0;
    }

    .title {
      font-size: 13pt;
      font-weight: 600;
      color: #3b7c7f;
      margin: 0 0 8px 0;
    }

    .contact-line {
      color: #121111;

      margin-bottom: 14px;
    }

    /* section */
    .section {
      margin-bottom: 18px;
    }

    .section-title {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: ${(style.sectionTitleSize)!'14pt'};
      font-weight: ${(style.fontWeightHeading)!'500'};
      color: ${(style.headingColor)!'#0a4180'};
      text-transform: uppercase;
    }

    .divider {
      height: 2px;
      background: #e6f2f3;
      margin: 8px 0 12px;
      border-radius: 2px;
    }

    /* experience */
    .exp-item {
      margin-bottom: 16px;
      padding-bottom: 10px;
      border-bottom: 1px solid #f0f3f3;
    }

    .exp-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      gap: 10px;
    }

    .exp-left {
      max-width: 72%;
    }

    .exp-role {
      font-weight: 700;
      font-size: 12.5pt;
      margin: 0 0 4px 0;
      color: #142b2b;
    }

    .exp-company {
      font-style: italic;

      margin-bottom: 6px;
    }

    .exp-dates {
      color: #0f7d86;
      font-weight: 600;
      white-space: nowrap;

    }

    .bullets {
      margin-left: 18px;
      margin-top: 6px;

    }

    .bullets li {
      margin-bottom: 6px;
    }

    /* project inside experience */
    .project-block {
      margin-top: 8px;
      padding-top: 8px;
      border-top: 1px dashed #e6f2f3;
    }

    .project-title {
      color: #0f7d86;
      font-weight: 700;
      margin-bottom: 6px;

    }

    .project-desc {
      margin-left: 12px;
      margin-bottom: 6px;

    }

    /* education */
    .edu-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
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
      color: #0f7d86;
      font-weight: 600;
    }

    /* smaller lists: achievements, awards, strengths, goals, extracurricular */
    .two-col {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px;
    }

    .list {
      margin-left: 18px;
    }

    .list li {
      margin-bottom: 6px;
      color: #333;
    }

    /* certificates in right-section style */
    .cert-list li {
      list-style: none;
      margin-bottom: 8px;
      padding-left: 20px;
      position: relative;
    }

    .cert-list li:before {
      content: "\2713";
      position: absolute;
      left: 0;
      top: 0;
      color: #bcedf0;
      font-weight: 700;
    }

    /* languages */
    .lang-pie {
      display: flex;
      gap: 6px;
      align-items: center;
      margin-top: 6px;
    }

    .lang-pill {
      width: 46px;
      height: 10px;
      background: rgba(255, 255, 255, 0.12);
      border-radius: 6px;
    }

    /* utilities */
    .muted {
      color: #181818;
      font-style: italic;
    }

    .small {
      color: #0f0e0e;
    }

    .details-item {
      line-height: 1.6;
    }

    .contact-item{
   word-break: break-word;
   overflow-wrap: break-word;

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


    <div class="main">

      <div class="header">
        <div class="name">
          <#if name?? && name?has_content>${name}</#if>
        </div>
        <div class="title">
          <#if jobTitle?? && jobTitle?has_content>${jobTitle}</#if>
        </div>
      </div>


      <#if summary?? && summary?has_content>
      <div class="section">
        <div class="section-title"> Summary</div>
        <div class="divider"></div>
        <div class="small">${summary}</div>
      </div>
      </#if>

      <!-- OBJECTIVE -->
      <#if objective?? && objective?has_content>
      <div class="section">
        <div class="section-title"> Objective</div>
        <div class="divider"></div>
        <div class="small">${objective}</div>
      </div>
      </#if>

      <!-- EXPERIENCE -->
      <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <div class="section-title">Experience</div>
        <div class="divider"></div>

        <#list experiences as exp>
        <div class="exp-item">
          <div class="exp-header">
            <div class="exp-left">
              <#if exp.role?? && exp.role?has_content>
                <div class="exp-role">${exp.role}</div>
              </#if>

              <#if exp.companyName?? && exp.companyName?has_content>
                <div class="exp-company">${exp.companyName}</div>
              </#if>
            </div>

             <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
            <div class="exp-dates">
              <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>${extractmonth(exp.experienceYearStartDate)}</#if>

             <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>  &#8211; ${extractmonth(exp.experienceYearEndDate)}<#else>  &#8211; Present</#if>
            </div>
            </#if>
          </div>



          <#if exp.responsibilities?? && exp.responsibilities?has_content>
          <ul class="bullets">
            <#list exp.responsibilities?split(",") as item>
              <li>${item}</li>
            </#list>
          </ul>
          </#if>


          <#if exp.projects?? && exp.projects?size gt 0>
            <#list exp.projects as p>
            <div class="project-block">
              <#if p.projectName?? && p.projectName?has_content>
                <div class="project-title">Project: ${p.projectName}</div>
              </#if>

              <#if p.projectRole?? && p.projectRole?has_content>
                <div class="exp-company"><strong>Role:</strong> ${p.projectRole}</div>
              </#if>

              <#if p.projectSkills?? && p.projectSkills?has_content>
                <strong>Skills:</strong>
                <ul class="bullets">
                  <#list p.projectSkills?split(",") as sk>
                    <li>${sk}</li>
                  </#list>
                </ul>
              </#if>

              <#if p.projectDescription?? && p.projectDescription?has_content>
                <div class="project-desc"><strong>Description:</strong> ${p.projectDescription}</div>
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
        <div class="section-title"> Academic Projects</div>
        <div class="divider"></div>

        <#list collegeProject as ap>
        <div class="exp-item">
          <#if ap.collegeProjectName?? && ap.collegeProjectName?has_content>
          <div class="exp-role">Name: ${ap.collegeProjectName}</div>
          </#if>

          <#if ap.collegeProjectSkills?? && ap.collegeProjectSkills?trim?has_content>
            <strong>Skills:</strong>
            <ul class="bullets">
              <#list ap.collegeProjectSkills?split(",") as sk>
                <li>${sk}</li>
              </#list>
            </ul>
          </#if>

          <#if ap.collegeProjectDescription?? &&  ap.collegeProjectDescription?has_content>
          <div class="exp-desc muted"><strong>Description:</strong> ${ap.collegeProjectDescription}</div>
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

             <div>
               <#if edu.department?? && edu.department?has_content>
                 <div class="edu-degree">${edu.department}</div>
               </#if>

               <#if edu.institutionName?? && edu.institutionName?has_content>
                 <div class="edu-school muted">${edu.institutionName}</div>
               </#if>

               <#if (edu.fieldOfStudy?? && edu.fieldOfStudy?has_content)
                   || (edu.percentage?? && edu.percentage?has_content)>
                 <div class="edu-school muted">
                   <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                     ${edu.fieldOfStudy}
                   </#if>

                   <#if edu.percentage?? && edu.percentage?has_content>
                     &#8209; ${edu.percentage}%
                   </#if>
                 </div>
               </#if>
             </div>

             <#if (edu.qualificationStartYear?? && edu.qualificationStartYear?has_content)
                || (edu.qualificationEndYear?? && edu.qualificationEndYear?has_content)>
               <div class="edu-year">
                 <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                   ${extractmonth(edu.qualificationStartYear)}
                 </#if>
                 &#8209;
                 <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                   ${extractmonth(edu.qualificationEndYear)}
                 <#else>
                   Present
                 </#if>
               </div>
             </#if>

           </div>
         </#list>

       </div>
     </#if>


      <#if achievements?? && achievements?size gt 0>
      <div class="section">
        <div class="section-title">Achievements</div>
        <div class="divider"></div>
        <ul class="list">
          <#list achievements as achieve>
            <li>${achieve.achievementsName}
             <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                       &#8209;     ${extractmonth(achieve.achievementsDate)}
                          </#if>


			</li>
          </#list>
        </ul>
      </div>
      </#if>

      <!-- CERTIFICATES -->
      <#if certificates?? && certificates?size gt 0>
      <div class="section">
        <div class="section-title">Certificates</div>
        <div class="divider"></div>
        <ul class="list">
          <#list certificates as c>
            <li>
             <#if c.courseName?? && c.courseName?has_content>
            ${c.courseName}

			<#if c.courseStartDate?? && c.courseStartDate?has_content>
                   &nbsp;   (${extractmonth(c.courseStartDate)}
                            <#if c.courseEndDate?? && c.courseEndDate?has_content>
                            &#8209; ${extractmonth(c.courseEndDate)}
                            </#if>
                        )
                        </#if>

						</li>

						 </#if>
          </#list>
        </ul>
      </div>
      </#if>


       <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
      <div class="section">
        <div class="section-title">&#127895; Extra-Curricular Activities</div>
        <div class="divider"></div>
        <ul class="list">
          <#list extraCurricularActivities?split(",") as ex>
            <li>${ex}</li>
          </#list>
        </ul>
      </div>
      </#if>


      <#if addAdditionalDetails?? && addAdditionalDetails>
      <div class="section">
        <div class="section-title"> Personal Details</div>
        <div class="divider"></div>

        <div class="details-item">
          <#if fatherName?? && fatherName?has_content>
            <div><strong>Father's Name:</strong> ${fatherName}</div>
          </#if>

          <#if maritalStatus?? && maritalStatus?has_content>
            <div><strong>Marital Status:</strong> ${maritalStatus}</div>
          </#if>

          <#if nationality?? && nationality?has_content>
            <div><strong>Nationality:</strong> ${nationality}</div>
          </#if>

          <#if dob?? && dob?has_content>
            <div><strong>DOB:</strong> ${extractDobYear(dob)}</div>
          </#if>

          <#if address?? && address?has_content>
            <div><strong>Address:</strong> ${address}</div>
          </#if>

		   <#if maritalStatus?? && maritalStatus?has_content>
            <div><strong>Address:</strong> ${maritalStatus}</div>
          </#if>

		  <#if languagesKnown?? && languagesKnown?has_content>
            <div><strong>Languages:</strong>${languagesKnown?replace(",", ", ")}</div>
          </#if>

        </div>
      </div>
      </#if>

    </div>


    <div class="right-section">

     <#if profileImage?? && profileImage?has_content>
      <img class="photo" src="${profileImage}" alt="profile photo" />
      </#if>


      <div>
        <div class="block-title">Contact</div>

        <#if email??><div class="contact-item"> ${email} </div></#if>
        <#if phone??><div class="contact-item">${phone}</div></#if>
		 <#if linkedin??><div class="contact-item"> ${linkedin}</div></#if>
        <#if location??><div class="contact-item"> ${location}</div></#if>

      </div>



      <#if skills?? && skills?has_content>
      <div>
        <div class="block-title">Skills</div>
        <div>
          <#list skills?split(",") as sk>
            <span class="skill-chip">${sk}</span>
          </#list>
        </div>
      </div>
      </#if>




      <!-- STRENGTHS -->
      <#if strengths?? && strengths?has_content>
      <div>
        <div class="block-title">Strengths</div>
        <ul class="cert-list">
          <#list strengths?split(",") as s>
            <li>${s}</li>
          </#list>
        </ul>
      </div>
      </#if>

      <!-- GOALS -->
      <#if goals?? && goals?has_content>
      <div>
        <div class="block-title">Goals</div>
        <ul class="cert-list">
          <#list goals?split(",") as g>
            <li>${g}</li>
          </#list>
        </ul>
      </div>
      </#if>


      <#if softSkills?? && softSkills?has_content>
      <div>
        <div class="block-title">Soft Skills</div>
        <div>
          <#list softSkills?split(",") as ss>
            <span class="skill-chip">${ss}</span>
          </#list>
        </div>
      </div>
      </#if>

      <!-- CORE COMPETENCIES -->
      <#if competencies?? && competencies?has_content>
      <div>
        <div class="block-title">Core Compentencies</div>
        <div>
          <#list competencies?split(",") as cc>
            <span class="skill-chip">${cc}</span>
          </#list>
        </div>
      </div>
      </#if>

    </div>
  </div>
</body>
</html>
