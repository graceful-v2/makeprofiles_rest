
<!DOCTYPE html>
<html lang="en">
  <head>

   <#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
    <@fonts.loadFonts />

    <style>


      @page: first {
        margin-top: 10px;
      }

      @page {
        size: A4;
        margin-top: 40px;
        margin-bottom: 10px;

        margin-left: 20px;
        margin-right: 20px;
      }

      html,body {

        margin: 0;
        font-family: ${(style.primaryFont)!'"Georgia", serif'};
        color: ${(style.bodyColor)!'#395832'};
        font-size: ${(style.bodySize)!'12pt'};
        line-height: ${(style.lineSpacing)!'1.4'};
      }


      .header {
        display: flex;
        gap: 20px;
      }
      .name-block{
        flex: 1.2;
        max-width: 70%;
        min-width: 50%;
        word-break: break-word;
        overflow-wrap: break-word;
      }

      .name-block h1 {
          padding:0;
          margin: 0;
          font-weight: 400;
          letter-spacing: 2px;
          text-transform: uppercase;
          font-size: ${(style.nameSize)!'22pt'};
          font-weight: ${(style.fontWeightname)!'700'};
       }

    .name-block h2 {
      margin: -10px 0 0 0;
      font-weight: 400;
      letter-spacing: 2px;
    }
      .photo {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        flex-shrink: 0;
      }

      .position {
        color: #9b9285;
        margin: 16px 0;
      }
      .contact {
        padding:10px;
        color: #6d7969;
        top: 40px;
        word-break: break-word;
        overflow-wrap: break-word;
        white-space: normal;
      }
      .summary {

        color: #3b4e30;
        margin: 24px 0 10px 0;
        line-height: 1.4;
      }
      .divider {
        border: none;
        border-top: 6px solid #395832;
        margin: 4px 0 5px 0;
        width: 100%;
      }
      .section-row {
        display: flex;
        margin-bottom: 20px;
        align-items: flex-start;
      }
      .section-label {
        width: 240px;
        min-width: 180px;
        font-size: ${(style.sectionTitleSize)!'17pt'};
        font-weight: ${(style.fontWeightHeading)!'700'};
        color: ${(style.headingColor)!'#395832'};
        padding-top: 2px;
        letter-spacing: 1px;
      }
      .section-content {
        flex: 1;
        color: #3b4e30;
        line-height: 1.5;
      }
      .section-content ul {
        margin: 0 0 0 26px;
        padding: 0;
      }
      .section-content li {
        margin: 4px 0;
      }
      .education {
      }
      .skills-list {
        margin-top: 2px;
        padding-left: 26px;
      }
      .skills-list li {
        color: #395832;
      }

      .container {
        max-width: 210mm;
        width: 100%;

        padding: 0px;
        overflow-wrap:break-word;
        word-break:break-word;
      }
      .summary-section {
      font-size: ${(style.sectionTitleSize)!'17pt'};
     font-weight: ${(style.fontWeightHeading)!'700'};
     color: ${(style.headingColor)!'#395832'};

        padding-top: 2px;
        letter-spacing: 1px;
      }
      .objective {

        color: #3b4e30;
        margin: 14px 0 10px 0;

      }
      .project-section {

        color: #395832;
        font-family: "Georgia", serif;
        font-weight: 500;
        padding-top: 2px;
        letter-spacing: 1px;

        text-decoration: underline;
        text-underline-offset: 5px;
        font-style: italic;
      }
      .project {
        margin-left: 15px;
      }

      .education-item{
       border-bottom:1px solid 395832;
       margin:4px 0px;
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

                <#local parsedDate = input?date("dd/MM/yyyy")>
                <#return parsedDate?string("MMM yyyy")>
              <#recover>
                <#attempt>

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
    <div class="header">


      <div class="name-block">
        <#if name?? && name?has_content>
          <h1>${name}</h1>
        </#if>
      </div>

      <div class="contact">
        <#if email?? && email?has_content>
          ${email}<br />
        </#if>
        <#if phone?? && phone?has_content>
          ${phone} <br />
        </#if>
		 <#if linkedin?? && linkedin?has_content>
          ${linkedin}<br />
        </#if>
      </div>
    </div>

    <#if summary?has_content>
      <br />
      <div class="summary-section">Summary</div>
      <div class="objective">
        <p>${summary}</p>
      </div>
    </#if>


     <#if objective?has_content>

          <div class="summary-section">Objectives</div>
          <div class="objective">
            <p>${objective}</p>
          </div>
        </#if>

    <#if experiences?? && experiences?size gt 0>
      <div class="section-row">
             <div class="section-label">Professional Experience</div>
       <div class="section-content">
      <#list experiences as exp>
         <div class="education-item">

            <#if exp.role?? && exp.role?has_content>
            <strong>${exp.role}</strong> <br />
            </#if>



            <#if  exp.companyName?? && exp.companyName?has_content>
              <strong>${exp.companyName}</strong><br />
            </#if>


            <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
              ${extractmonth(exp.experienceYearStartDate)}
              <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                &#8208; ${extractmonth(exp.experienceYearEndDate)}
              <#else>
                &#8208; Present
              </#if>
              <br />
            </#if>

            <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
              <ul>
                  <li>${exp.responsibilities}</li>
              </ul>
            </#if>

            <#if exp.projects?? && exp.projects?size gt 0>
              <div class="project">
                <div class="project-section">Projects</div>
                <#list exp.projects as proj>

				<#if proj.projectRole?? && proj.projectRole?has_content>
				<div class="section-label">
					${proj.projectRole}
				  </div>
				  </#if>

                  <#if proj.projectName?? && proj.projectName?has_content>
                      ${proj.projectName}<br />
                  </#if>

                  <#if proj.projectSkills?? && proj.projectSkills?has_content>
                    <strong>Skills:</strong>
                    <#list proj.projectSkills?split(",") as skill>
                      ${skill?trim}<#if skill_has_next>, </#if>
                    </#list><br />
                  </#if>

                  <#if proj.projectDescription?? && proj.projectDescription?has_content>
                    <strong>Description:</strong>
                    <ul>
                      <li>${proj.projectDescription}</li>
                    </ul>
                  </#if>
                </#list>
              </div>
            </#if>

        </div>
      </#list>
      </div>
       </div>
    </#if>

    <#if collegeProject?? && collegeProject?size gt 0>
      <div class="section-row">
        <div class="section-label">Academic Project</div>
        <div class="section-content">
          <#list collegeProject as proj>
            <#if proj.collegeProjectName?? && proj.collegeProjectName?has_content>
               ${proj.collegeProjectName}<br />
            </#if>

            <#if proj.collegeProjectSkills?? && proj.collegeProjectSkills?has_content>
              <strong>Skills:</strong>
              <ul>
                <#list proj.collegeProjectSkills?split(",") as skill>
                  <#if skill?has_content><li>${skill?trim}</li></#if>
                </#list>
              </ul>
            </#if>

            <#if proj.collegeProjectDescription?? && proj.collegeProjectDescription?has_content>
             <br /> <strong>Description:</strong>
              <p>${proj.collegeProjectDescription}</p>
            </#if>
          </#list>
        </div>
      </div>
    </#if>

    <#if education?? && education?size gt 0>
      <div class="section-row">
        <div class="section-label">Education</div>
        <div class="section-content education">
          <#list education as edu>
          <div class="education-item">
            <#if edu.department?? && edu.department?has_content>
              <strong>${edu.department}</strong><br />
            </#if>
             <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                  ${edu.fieldOfStudy}
                  <#if edu.percentage?has_content>
                                 |  ${edu.percentage}%
                              </#if><br/>
                   <#else>
                     <#if edu.percentage?has_content>
                        ${edu.percentage}%<br/>

                       </#if>

              </#if>
            <#if edu.institutionName?? && edu.institutionName?has_content>
              ${edu.institutionName}<br />
            </#if>
            <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
              ${extractmonth(edu.qualificationStartYear)}
              <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                &#8208; ${extractmonth(edu.qualificationEndYear)}
              <#else>
                &#8208; Present
              </#if>
            </#if>
            <br />
            </div>
          </#list>
        </div>
      </div>
    </#if>

    <#if skills?? && skills?trim?length gt 0>
      <div class="section-row">
        <div class="section-label">Key Skills</div>
        <div class="section-content">
          <ul class="skills-list">
            <#list skills?split(",") as skill>
              <#if skill?has_content>
                <li>${skill?trim}</li>
              </#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>

    <#if softSkills?? && softSkills?trim?length gt 0>
      <div class="section-row">
        <div class="section-label">Soft Skills</div>
        <div class="section-content">
          <ul class="skills-list">
            <#list softSkills?split(",") as s>
              <#if s?has_content><li>${s?trim}</li></#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>

    <#if competencies?? && competencies?trim?length gt 0>
      <div class="section-row">
        <div class="section-label">Core Competencies</div>
        <div class="section-content">
          <ul class="skills-list">
            <#list competencies?split(",") as comp>
              <#if comp?has_content><li>${comp?trim}</li></#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>

   <#if goals?? && goals?trim?length gt 0>
         <div class="section-row">
           <div class="section-label">Goals</div>
           <div class="section-content">
             <ul class="skills-list">
               <#list goals?split(",") as s>
                 <#if s?has_content><li>${s?trim}</li></#if>
               </#list>
             </ul>
           </div>
         </div>
       </#if>

     <#if strengths?? && strengths?trim?length gt 0>
           <div class="section-row">
             <div class="section-label">Strength</div>
             <div class="section-content">
               <ul class="skills-list">
                 <#list strengths?split(",") as s>
                   <#if s?has_content><li>${s?trim}</li></#if>
                 </#list>
               </ul>
             </div>
           </div>
         </#if>

      <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
            <div class="section-row">
              <div class="section-label">ExtraCurricular Activities</div>
              <div class="section-content">
                <ul class="skills-list">
                  <#list extraCurricularActivities?split(",") as s>
                    <#if s?has_content><li>${s?trim}</li></#if>
                  </#list>
                </ul>
              </div>
            </div>
          </#if>

    <#if certificates?? && certificates?size gt 0>
      <div class="section-row">
        <div class="section-label">Certifications</div>
        <div class="section-content education">
          <#list certificates as certi>
            <#if certi.courseName?? && certi.courseName?has_content>
              <strong>${certi.courseName}</strong><br />
              <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                ${extractmonth(certi.courseStartDate)}
                <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                  &#8208; ${extractmonth(certi.courseEndDate)}
                <#else>)
                </#if>
              </#if>
            </#if>
            <br />
          </#list>
        </div>
      </div>
    </#if>

    <#if achievements?? && achievements?size gt 0>
      <div class="section-row">
        <div class="section-label">Achievements</div>
        <div class="section-content education">
          <#list achievements as achieve>
            <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
              <strong>${achieve.achievementsName}</strong>
              <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                &#8208; ${extractmonth(achieve.achievementsDate)}
              </#if><br />
            </#if>
          </#list>
        </div>
      </div>
    </#if>

     <#if addAdditionalDetails>
                      <div class="section-row">
                         <div class="section-label">Personal Details</div>

<div class="section-content education">
                         <#if fatherName?? && fatherName?has_content>
                             <div class="detail-item">
                                 <strong>Father Name:</strong> ${fatherName}
                             </div>
                         </#if>

                         <#if maritalStatus?? && maritalStatus?has_content>
                             <div class="detail-item">
                                 <strong>Marital Status:</strong> ${maritalStatus}
                             </div>
                         </#if>

                         <#if gender?? && gender?has_content>
                             <div class="detail-item">
                                 <strong>Gender:</strong> ${gender}
                             </div>
                         </#if>

                         <#if dob?? && dob?has_content>
                             <div class="detail-item">
                                 <strong>Dob:</strong> ${extractDobYear(dob)}
                             </div>
                         </#if>

                         <#if languagesKnown?? && languagesKnown?has_content>
                             <div class="detail-item">
                                 <strong>Language Known:</strong> ${languagesKnown?replace(",", ", ")}
                             </div>
                         </#if>

                         <#if nationality?? && nationality?has_content>
                             <div class="detail-item">
                                 <strong>Nationality:</strong> ${nationality}
                             </div>
                         </#if>

                         <#if address?? && address?has_content>
                             <div class="detail-item">
                                 <strong>Address:</strong> ${address}
                             </div>
                         </#if>

                     </div>
                   </div>
                </#if>

  </div>
</body>
</html>
