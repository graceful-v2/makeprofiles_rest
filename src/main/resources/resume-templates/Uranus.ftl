<!DOCTYPE html>
<html lang="en">
  <head>
<#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
    <@fonts.loadFonts />
    <style>
      @page {
        size: A4;
         margin: 10mm 10mm;
      }

      body {
        margin: 0;
        padding: 0;
        background: #ffffff;
         font-family: ${(style.primaryFont)!'Arial, Helvetica, sans-serif'};
        font-size: ${(style.bodySize)!'12pt'};
        line-height: ${(style.lineSpacing)!'1.2'};
        color: ${(style.bodyColor)!'#1a1f36'};
      }

      .header {
        background: #0f4c5c;
        color: #fff;
        padding: 28px 36px 22px;
        border-bottom: 6px solid #0b3b47;
      }

      .meta span {
        margin-right: 20px;
        display: inline-block;
      }

      .header h1 {
        margin: 0 0 6px;
         font-size: ${(style.nameSize)!'28pt'};
          font-weight: ${(style.fontWeightname)!'800'};
         color: ${(style.nameColor)!'#ffffff'};
      }

      .header .title {
        font-size: 15px;
        font-weight: bold;
        margin: 0 0 10px;
      }

      .header .meta {
        font-size: 12pt;
      }

      .container {
        padding-top: 22px;
        overflow-wrap:break-word;
        word-break:break-word;
      }

      .section {
        padding-top: 10px;
        margin-top: 14px;
      }

      .section:first-child {
        border-top: none;
      }

      .section h2 {
        margin: 0 0 8px;
        text-transform: uppercase;
        font-size: ${(style.sectionTitleSize)!'14pt'};
        font-weight: ${(style.fontWeightHeading)!'700'};
        color: ${(style.headingColor)!'#0f4c5c'};
      }

      .section p,
      .section li {
        font-size: 13pt;
        margin: 0 0 6px;
        color: #1a1f36;
      }

      ul {
        margin: 4px 0 8px 18px;
        padding: 0;
      }

      .tags span {
        display: inline-block;
        border: 1px solid #e6e9ef;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 12pt;
        margin: 2px;
      }

      .two-col {
        width: 100%;
      }

      .two-col td {
        width: 50%;
        vertical-align: top;
      }

      .experience h3 {
        font-size: 13pt;
        margin: 0;
        font-weight: bold;
      }

      .experience .meta {
        font-size: 12pt;
        color: #555;
        margin-bottom: 4px;
      }

      .experience .role {
        font-weight: bold;
        color: #007acc;
        margin-bottom: 6px;
      }

      .footer {
        text-align: center;

        color: #5b6476;

      }

      @bottom-center {
        content: "Page " counter(page) " of " counter(pages);

      }

       .experience-item {
     		  margin-bottom: 7px;
     		  padding-bottom: 7px;
     		  border-bottom: 1px dashed #2d2a2a;
     		}

        .detail-item {
             margin-top: 7px;
         }

         p{
         line-height:1.3;
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


    <div class="page">
      <header class="headerheader">
        <h1 class="name">${name}</h1>
        <div class="meta">
          <#if email?has_content>
            <span>${email}</span>
          </#if>

          <#if phone?has_content>
            <span>${phone}</span>
          </#if>

          <#if linkedin?has_content>
            <span>${linkedin}</span>
          </#if>
        </div>
      </header>

      <main class="container">
        <div class="grid">
          <#if objective?has_content>
            <section class="section">
              <h2>Objectives</h2>
              <p>${objective}</p>
            </section>
          </#if>

          <#if summary?has_content>
            <section class="section">
              <h2>Summary</h2>
              <p>${summary}</p>
            </section>
          </#if>

          <#if skills?? && skills?trim?length gt 0>
            <section class="section">
              <h2>Skills</h2>
              <div class="tags">
                <#list skills?split(",") as skill>
                  <#if skill?? && skill?has_content>
                    <span>${skill?trim}</span>
                  </#if>
                </#list>
              </div>
            </section>
          </#if>

          <#if experiences?? && experiences?size gt 0>
            <section class="section">
              <h2>Work Experience</h2>
              <div class="experience">
                <#list experiences as experience>
                <div class="experience-item">
                  <#if experience.companyName?has_content>
                    <h3>${experience.companyName}</h3>
                  </#if>

                  <#if experience.experienceYearStartDate?? && experience.experienceYearStartDate?has_content>
                    <div class="meta">
                      (
                      ${extractmonth(experience.experienceYearStartDate)}
                      <#if experience.experienceYearEndDate?? && experience.experienceYearEndDate?has_content>
                        &#8211; ${extractmonth(experience.experienceYearEndDate)} )
                      <#else>
                        &#8211; Present )
                      </#if>
                    </div>
                  </#if>

                  <#if experience.role?has_content>
                    <div class="role">${experience.role}</div>
                  </#if>

                  <#if experience.responsibilities?? && experience.responsibilities?trim?length gt 0>
                    <p>Roles and Responsibilities</p>
                    <ul>
                      <#list experience.responsibilities?split(",") as item>
                        <#if item?has_content>
                          <li>${item?trim}</li>
                        </#if>
                      </#list>
                    </ul>
                  </#if>


                 <#if experience.projects?? && experience.projects?size gt 0>
                              <section class="section">
                                <h2>Project Experience</h2>
                                    <#list experience.projects as proj>
                                      <#if proj?? && proj.projectName?has_content>
                                        <p><strong>Name:</strong> ${proj.projectName}</p>
                                      </#if>

                                      <#if proj?? && proj.projectRole?has_content>
                                        <p><strong>Role:</strong> ${proj.projectRole}</p>
                                      </#if>



                                      <#if proj?? && proj.projectDescription?has_content>
                                        <p><strong>Description:</strong> ${proj.projectDescription}</p>
                                      </#if>

                                       <#if proj.projectSkills?? && proj.projectSkills?has_content>
                                            <div class="tags">
                                              <strong>Skills:</strong>
                                              <#list proj.projectSkills?split(",") as skill>
                                                ${skill?trim}<#if skill_has_next>, </#if>
                                              </#list>
                                            </div>
                                     </#if>

                                    </#list>
                              </section>
                      </#if>

                       </div>
                </#list>
              </div>
            </section>
          </#if>

          <#if education?? && education?size gt 0>
			  <section class="section">
			    <h2>Education</h2>
			    <#list education as edu>
			      <p>
			        <#if edu.department?? && edu.department?has_content>
			          <strong> ${edu.department}</strong>
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
			          (
			          ${extractmonth(edu.qualificationStartYear)}
			          <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
			            &#8211; ${extractmonth(edu.qualificationEndYear)} )
			          <#else>
			            &#8211; Present )
			          </#if>
			        </#if>
			       </p>
			    </#list>
			  </section>
			</#if>


          <#if certificates?? && certificates?size gt 0>
            <section class="section">
              <h2>Certifications &amp; Training</h2>
              <ul>
                <#list certificates as certi>
                  <li>
                    <strong>${certi.courseName}</strong>
                    <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                      &#8211; (
                      ${extractmonth(certi.courseStartDate)}
                      <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                        &#8211; ${extractmonth(certi.courseEndDate)} )
                      <#else>
                        &#8211; )
                      </#if>
                    </#if>
                  </li>
                </#list>
              </ul>
            </section>
          </#if>

    <#if achievements?? && achievements?size gt 0> 
          <section class="section">
            <h2>Achievements &amp; Awards</h2>
            <ul>
              <#list achievements as achieve>
                <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                  <li>
                    <strong>${achieve.achievementsName}</strong>
                    <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                      - ${extractmonth(achieve.achievementsDate)}
                    </#if>
                  </li>
                </#if>
              </#list>
            </ul>
          </section>
     </#if>     
 
 <#assign hasProjects = false>
			<#if experiences?? && experiences?size gt 0>
			    <#list experiences as exp>
			        <#if exp.projects?? && exp.projects?size gt 0>
			            <#list exp.projects as proj>
			                <#if (proj.projectName?? && proj.projectName?has_content) 
			                   || (proj.projectRole?? && proj.projectRole?has_content) 
			                   || (proj.projectDescription?? && proj.projectDescription?has_content)>
			                       <#assign hasProjects = true>
			                       <#break>
			                </#if>
			            </#list>
			        </#if>
			        <#if hasProjects>
			            <#break>
			        </#if>
			    </#list>
			</#if>
 



          <#if collegeProject?? && collegeProject?size gt 0>
            <section class="section">
              <h2>Academic Project</h2>
              <#list collegeProject as project>
                <#if project?? && project.collegeProjectName?has_content>
                  <p><strong>Name:</strong> ${project.collegeProjectName}</p>
                </#if>

                <#if project.collegeProjectSkills?has_content>
                  <#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
                    <p><strong>Skills:</strong></p>
                    <br />
                    <ul>
                      <#list project.collegeProjectSkills?split(",") as item>
                        <#if item?has_content>
                          <li>${item?trim}</li>
                        </#if>
                      </#list>
                    </ul>
                  </#if>
                </#if>

                <#if project.collegeProjectDescription?has_content>
                  <p><strong>Description:</strong> ${project.collegeProjectDescription}</p>
                </#if>
              </#list>
            </section>
          </#if>
          
            
          <#if softSkills?? && softSkills?trim?length gt 0>
            <section class="section">
              <h2>Soft Skills</h2>
              <ul>
                <#list softSkills?split(",") as skill>
                  <#if skill?? && skill?has_content>
                    <li>${skill?trim}</li>
                  </#if>
                </#list>
              </ul>
            </section>
          </#if>

          <#if competencies?? && competencies?trim?length gt 0>
            <section class="section">
              <h2>Core Competencies</h2>
              <ul>
                <#list competencies?split(",") as comp>
                  <#if comp?? && comp?has_content>
                    <li>${comp?trim}</li>
                  </#if>
                </#list>
              </ul>
            </section>
          </#if>

         <#if strengths?? && strengths?trim?length gt 0>
             <section class="section">
                 <h2>Strength</h2>
                 <#list strengths?split(",") as skill>
                     <#if skill?? && skill?has_content>
                         <div class="detail-item">${skill?trim}</div>
                     </#if>
                 </#list>
             </section>
         </#if>


         <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
             <section class="section">
                 <h2>Extracurricular Activities</h2>
                 <#list extraCurricularActivities?split(",") as skill>
                     <#if skill?? && skill?has_content>
                         <div class="detail-item">${skill?trim}</div>
                     </#if>   <!-- fixed here -->
                 </#list>
             </section>
         </#if>


         <#if goals?? && goals?trim?length gt 0>
             <section class="section">
                 <h2>Goals</h2>
                 <#list goals?split(",") as skill>
                     <#if skill?? && skill?has_content>
                         <div class="detail-item">${skill?trim}</div>
                     </#if>   <!-- fixed here -->
                 </#list>
             </section>
         </#if>


         <#if addAdditionalDetails>
             <section class="section">
                 <h2>Personal Details</h2>

                 <#if fatherName?? && fatherName?has_content>
                     <div class="detail-item">
                         <strong>Father's Name:</strong> ${fatherName}
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
                         <strong>DOB:</strong> ${extractDobYear(dob)}
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

             </section>
         </#if>


        </div>
      </main>

    </div>
  </body>
</html>
