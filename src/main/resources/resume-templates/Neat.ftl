


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
        padding: 0 15px;
        font-family: ${(style.primaryFont)!'"Times New Roman", serif'};
        font-size: ${(style.bodySize)!'12pt'};
        line-height: ${(style.lineSpacing)!'1.6'};
        color: ${(style.bodyColor)!'#000'};
      }

      .resume {
        max-width: 210mm;
        width: 100%;
        background: #fff;
        overflow-wrap:break-word;

      }

      /* Header */
      .header {
        text-align: center;
        border-bottom: 1px solid #000;
        padding-bottom: 10px;
        margin-bottom: 15px;
      }

      .initials {
        width: 60px;
        height: 60px;
        border: 2px solid #000;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        font-weight: bold;
        margin: 0 auto 10px;
      }

      .header h1 {
        margin: 0;
        letter-spacing: 1px;
         font-size: ${(style.nameSize)!'25pt'};
          font-weight: ${(style.fontWeightname)!'800'};
           color: ${(style.nameColor)!'#222'};
      }

      .contact {
        font-size: 14px;
        margin-top: 5px;
      }

      /* Section */
      .section {
        margin-top: 15px;
      }

      .section h2 {
       font-size: ${(style.sectionTitleSize)!'14pt'};
       font-weight: ${(style.fontWeightHeading)!'800'};

        border-bottom: 1px solid #000;
        margin: 0 0 6px;
        padding-bottom: 2px;
        font-style: italic;
      }

      .experience {
        margin-bottom: 10px;
        border-bottom: 1px solid rgb(159, 142, 142);
      }

      .experience-header {
        display: flex;
        justify-content: space-between;
        font-size: 14px;
      }

      .company {
        font-weight: bold;
      }

      .role {
        font-style: italic;
        font-weight: bold;
      }

      .date {
        font-size: 12px;
      }

      ul {
        margin: 4px 0 8px 18px;
        padding: 0;
      }

      li {
        margin-bottom: 4px;
      }

      .skills {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 2px 20px;
        font-size: 14px;
      }

      .sub-heading {
        font-size: 17px;
        text-decoration: underline;
        font-style: italic;
        text-underline-offset: 4px;
        margin-bottom: 5px;
        font-weight: bold;
      }

      .project {
        margin-left: 10px;
      }
      .project-section {
        margin-bottom: 10px;
        border-bottom: 1px solid rgb(159, 142, 142);
      }

      .detail-item{
      margin:5px 0px;
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

  <div class="resume">
    <!-- Header -->
    <div class="header">
      <#if name?? && name?has_content>
        <h1>${name}</h1>
      </#if>

      <div class="contact">
        <#if email?has_content>
          ${email}
        </#if>
        <#if phone?has_content>
          | ${phone}<br />
        </#if>
        <#if linkedin?? && linkedin?has_content>
           ${linkedin}
        </#if>
      </div>
    </div>


    <#if summary?has_content>
      <div class="section">
        <h2>Professional Summary</h2>
        <p>${summary}</p>
      </div>
    </#if>

    <#if objective?has_content>
      <div class="section">
        <h2>Objective</h2>
        <p>${objective}</p>
      </div>
    </#if>

    <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <h2>Experience</h2>
        <#list experiences as exp>
          <div class="experience">
            <div class="experience-header">
              <div>
                <#if exp.companyName?has_content>
                  <span class="company">${exp.companyName}</span><br />
                </#if>
                <#if exp.role?has_content>
                  <span class="role">${exp.role}</span>
                </#if>
              </div>
              <div class="date">
                <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                  ${extractmonth(exp.experienceYearStartDate)}
                  <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                    &#8208; ${extractmonth(exp.experienceYearEndDate)}
                  <#else>
                    &#8208; Present
                  </#if>
                </#if>
              </div>
            </div>

            <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
              <p>${exp.responsibilities}</p>
            </#if>


            <#if exp.projects?? && exp.projects?size gt 0>
              <div class="project">
                <div class="sub-heading">Project</div>
                <#list exp.projects as proj>
                  <div class="project-section">
                    <#if proj.projectName?? && proj.projectName?has_content>
                    <strong>Name:</strong>    <span class="company">${proj.projectName}</span><br />
                    </#if>
                    <#if proj.projectRole?? && proj.projectRole?has_content>
                     <strong>Role:</strong>  <span class="role">${proj.projectRole}</span><br />
                    </#if>

                    <#if proj.projectDescription?? && proj.projectDescription?has_content>
                      <span>
                        <strong>Description :</strong>
                        ${proj.projectDescription}<br />
                      </span>
                    </#if>

                    <#if proj.projectSkills?? && proj.projectSkills?has_content>
                      <strong>Skills:</strong>
                      <ul>
                        <#list proj.projectSkills?split(",") as skill>
                          <#if skill?has_content>
                            <li>${skill?trim}</li>
                          </#if>
                        </#list>
                      </ul>
                    </#if>
                  </div>
                </#list>
              </div>
            </#if>
          </div>
        </#list>
      </div>
    </#if>

    <!-- Education -->
    <#if education?? && education?size gt 0>
      <div class="section">
        <h2>Education</h2>
        <#list education as edu>
          <p>
            <#if edu.institutionName?? && edu.institutionName?has_content>
              ${edu.institutionName}
            </#if>
            <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
              | ${extractmonth(edu.qualificationStartYear)}
              <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                - ${extractmonth(edu.qualificationEndYear)}
              <#else>
                - Present
              </#if>
            </#if><br />

            <#if edu.department?? && edu.department?has_content>
              <strong>${edu.department}</strong>
              <#if edu.percentage?? && edu.percentage?has_content>
                            | ${edu.percentage}%
                          </#if><br />
                   <#else>
                  <#if edu.percentage?? && edu.percentage?has_content>
                                ${edu.percentage}% <br />
                              </#if>

            </#if>
            <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
              ${edu.fieldOfStudy}
            </#if>

          </p>
        </#list>
      </div>
    </#if>

    <!-- Academic Project -->
    <#if collegeProject?? && collegeProject?size gt 0>
      <div class="section">
        <h2>Academic Project</h2>
        <#list collegeProject as project>
          <div class="experience">
            <div class="experience-header">
              <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
                <span class="company">${project.collegeProjectName}</span><br />
              </#if>
            </div>
            <#if project.collegeProjectDescription?? && project.collegeProjectDescription?has_content>
              <p>
                <strong>Description :</strong><br />
                ${project.collegeProjectDescription}
              </p>
            </#if>

            <#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
              <strong>Skills:</strong>
              <ul>
                <#list project.collegeProjectSkills?split(",") as skill>
                  <#if skill?has_content>
                    <li>${skill?trim}</li>
                  </#if>
                </#list>
              </ul>
            </#if>
          </div>
        </#list>
      </div>
    </#if>

    <!-- Skills -->
    <#if skills?? && skills?trim?length gt 0>
      <div class="section">
        <h2>Skills</h2>
        <div class="skills">
          <#list skills?split(",") as skill>
            <#if skill?has_content>
              <div>${skill?trim}</div>
            </#if>
          </#list>
        </div>
      </div>
    </#if>

    <!-- Certificates -->
    <#if certificates?? && certificates?size gt 0>
      <div class="section">
        <h2>Certification</h2>
        <#list certificates as certi>
          <#if certi.courseName?? && certi.courseName?has_content>
            <p>
              <strong>${certi.courseName}</strong><br />
              <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                ${extractmonth(certi.courseStartDate)}
                <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                  &#8208; ${extractmonth(certi.courseEndDate)}
                <#else>
                  &#8208; Present
                </#if>
              </#if>
            </p>
          </#if>
        </#list>
      </div>
    </#if>

    <!-- Achievements -->
    <#if achievements?? && achievements?size gt 0>
      <div class="section">
        <h2>Achievements</h2>
        <#list achievements as achieve>
          <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
            <p>
              <strong>${achieve.achievementsName}</strong><br />
              <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                ${extractmonth(achieve.achievementsDate)}
              </#if>
            </p>
          </#if>
        </#list>
      </div>
    </#if>


    <#if softSkills?? && softSkills?trim?length gt 0>
      <div class="section">
        <h2>Soft Skills</h2>
        <div class="skills">
          <#list softSkills?split(",") as skill>
            <#if skill?has_content>
              <div>${skill?trim}</div>
            </#if>
          </#list>
        </div>
      </div>
    </#if>

    <!-- Core Competencies -->
    <#if competencies?? && competencies?trim?length gt 0>
      <div class="section">
        <h2>Core Competencies</h2>
        <div class="skills">
          <#list competencies?split(",") as comp>
            <#if comp?has_content>
              <div>${comp?trim}</div>
            </#if>
          </#list>
        </div>
      </div>
    </#if>

       <#if goals?? && goals?trim?length gt 0>
          <div class="section">
            <h2>Goals</h2>
            <div class="skills">
              <#list goals?split(",") as skill>
                <#if skill?has_content>
                  <div>${skill?trim}</div>
                </#if>
              </#list>
            </div>
          </div>
        </#if>

       <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                <div class="section">
                  <h2>ExtraCurricular Activities</h2>
                  <div class="skills">
                    <#list extraCurricularActivities?split(",") as skill>
                      <#if skill?has_content>
                        <div>${skill?trim}</div>
                      </#if>
                    </#list>
                  </div>
                </div>
              </#if>

           <#if strengths?? && strengths?trim?length gt 0>
                         <div class="section">
                           <h2>Strength</h2>
                           <div class="skills">
                             <#list strengths?split(",") as skill>
                               <#if skill?has_content>
                                 <div>${skill?trim}</div>
                               </#if>
                             </#list>
                           </div>
                         </div>
                       </#if>

     <#if addAdditionalDetails>
                 <div class="section">
                     <h2>Personal Details</h2>

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

            </#if>

  </div>
</body>
</html>
