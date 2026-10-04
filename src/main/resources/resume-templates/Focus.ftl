
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />

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
      font-family: ${(style.primaryFont)!'"Segoe UI", Arial, sans-serif'};
      color: ${(style.bodyColor)!'#222'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.4'};

        background: #ffffff;
        margin: 0;
        padding: 0;

      }
      .container {
       max-width: 210mm;
       width: 100%;
       overflow-wrap:break-word;
       word-break:break-word;
      }
      .header {
        border-bottom: 2px solid #e3ecf6;
      }
      .name {

         font-size: ${(style.nameSize)!'24pt'};
       font-weight: ${(style.fontWeightname)!'800'};
        color: ${(style.nameColor)!'#255985'};
      }
      .subtitle {

        color: #6dbbe6;
        margin-bottom: 8px;
      }
      .contact-info {

        color: #6f8ca3;
        margin-bottom: 8px;
        line-height: 1.5;
      }
      .info-icons {

        color: #4896c8;
      }
      .main-content {
        display: flex;
        gap: 20px;

      }
      .left,
      .right {
        flex: 1;
        min-width: 320px;
      }
      .section-title {

      font-size: ${(style.sectionTitleSize)!'14pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
       color: ${(style.headingColor)!'#4896c8'};


        margin-top: 10px;
        margin-bottom: 9px;

        border-bottom: 1px solid #e3ecf6;
        letter-spacing: 0.6px;
      }
      .job-role,
      .org {

        font-weight: bold;
        color: #255985;
        margin-bottom: 2px;
      }
      .org {
        color: #6dbbe6;
        font-weight: 500;
      }
      .job-date-loc {

        color: #5f86a3;
        margin-bottom: 7px;
      }
      .job-description {

        color: #4d6584;
        margin-bottom: 7px;
        line-height: 1.3;
      }
      .skills-list {
        margin-top: 11px;
        margin-bottom: 8px;
      }
      .skill {
        display: inline-block;
        background: #e3ecf6;
        color: #255985;
        padding: 5px 16px;
        border-radius: 16px;
        margin: 4px 9px 4px 0;

      }
      .lang-skill-bar {
        background: #e3ecf6;
        border-radius: 18px;
        width: 200px;
        height: 18px;
        margin-right: 10px;
        display: inline-block;
      }
      .lang-fill {
        background: #4896c8;
        height: 100%;
        border-radius: 18px;
      }
      .achievements-list {
        margin-top: 7px;
        margin-bottom: 8px;
      }
      .achievement {
        margin-bottom: 8px;

        color: #255985;
      }
      .course-list,
      .passion-list {
        margin-top: 7px;
        margin-bottom: 8px;
      }
      .course,
      .passion {
        margin-bottom: 7px;
        color: #4d6584;

      }
      .summary {
        color: #255985;
        margin-bottom: 14px;

      }

      .project {
        margin-left: 10px;
        margin-top: 10px;
      }
      .project-heading {
        margin-top: 5px;

        text-decoration: underline;
        text-underline-offset: 4px;
        font-weight: bold;
        color: #4896c8;
        margin-bottom: 10px;
      }

      .project-section {
        color: #255985;
        margin-bottom: 10px;
        border-bottom: 1px solid rgb(143, 143, 212);
      }
      .pro-skills {

        margin-top: 5px;
        margin-bottom: 3px;
        font-weight: bold;
      }
      .aca-skills {
        list-style: none;
        margin: 0;
        padding: 0;

        gap: 8px;
        flex-direction: column;
        display: inline-block;
        margin-top: 10px;
      }
      .aca-skills li {
        padding: 6px 10px;
        border-radius: 20px;
        background: #f2f4f7;

        line-height: 1;
        box-shadow: 0 1px 0 rgba(0, 0, 0, 0.03);
        margin-bottom: 10px;
      }

      .softskills-list {
        margin-top: 5px;
        margin-bottom: 8px;
        display: inline-block;
        line-height: 1.5;
      }
      .softskill {
        background: #e3ecf6;
        color: #255985;
        padding: 5px 16px;
        border-radius: 16px;
        margin: 4px 9px 4px 0;

        display: block;
      }
      .skills{

      }
     .detail-item{
     margin:5px 0px;
     }

     .educatoin-details{
     border-bottom:1px dashed #6f8ca3;
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
    <#if name?? && name?has_content>
      <div class="name">${name}</div>
    </#if>

    <div class="contact-info">
      <#if phone?? && phone?has_content>
        <span>&#9742; ${phone}</span>
      </#if>
      <#if email?? && email?has_content>
        &nbsp; | &nbsp;<span>&#9993; ${email}</span>
      </#if>
      <#if linkedin?? && linkedin?has_content>
        <br /><span>&#128100; ${linkedin}</span>
      </#if>
    </div>
  </div>



      <#if summary?? && summary?has_content>
        <div class="section-title">Summary</div>
        <div class="summary">${summary}</div>
      </#if>

      <#if objective?? && objective?has_content>
          <div class="section-title">Objective</div>
          <div class="summary">${objective}</div>
        </#if>


         <#if skills?? && skills?trim?length gt 0>
              <div class="section-title">Skills</div>
              <div class="skills-list">
                <#list skills?split(",") as skill>
                  <#if skill?has_content><span class="skill">${skill?trim}</span></#if>
                </#list>
              </div>
            </#if>


      <#if experiences?? && experiences?size gt 0>
        <div class="section-title">Experience</div>
        <#list experiences as exp>
          <div class="job-role">
            <#if exp.role?? && exp.role?has_content>${exp.role}</#if>
          </div>
          <#if exp.companyName?? && exp.companyName?has_content>
            <div class="org">${exp.companyName}</div>
          </#if>

          <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
            <div class="job-date-loc">
              ${extractmonth(exp.experienceYearStartDate)}
              <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                &#8208; ${extractmonth(exp.experienceYearEndDate)}
              <#else>
                &#8208; Present
              </#if>
            </div>
          </#if>

          <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
            <div class="job-description">
             ${exp.responsibilities}

            </div>
          </#if>

          <#if exp.projects?? && exp.projects?size gt 0>
            <div class="project">
              <div class="project-heading">Project</div>
              <#list exp.projects as proj>
                <div class="project-section">
                  <#if proj.projectName?? && proj.projectName?has_content>
                    <div class="job-role">${proj.projectName}</div>
                  </#if>
                  <#if proj.projectRole?? && proj.projectRole?has_content>
                    <div class="org">${proj.projectRole}</div>
                  </#if>
                  <#if proj.projectSkills?? && proj.projectSkills?has_content>
                    <div class="pro-skills">Skills:</div>
                      <div class="achievements-list">
                      <#list proj.projectSkills?split(",") as skill>
						 <div class="achievement">&#9733; ${skill}</div>
                      </#list>
                    </div>
                  </#if>
                  <#if proj.projectDescription?? && proj.projectDescription?has_content>
                    <div class="pro-skills">Description:</div>
                    <div class="job-description">${proj.projectDescription}</div>
                  </#if>
                </div>
              </#list>
            </div>
          </#if>
        </#list>
      </#if>

      <#if collegeProject?? && collegeProject?size gt 0>
        <div class="section-title">Academic Project</div>
        <#list collegeProject as project>
          <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
            <div class="job-role">${project.collegeProjectName}</div>
          </#if>

          <#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
            <div class="pro-skills">Skills:</div>
            <div class="achievements-list">
              <#list project.collegeProjectSkills?split(",") as item>
                <#if item?has_content>
                  <div class="achievement">&#9733; ${item?trim}</div>
                </#if>
              </#list>
            </div>
          </#if>

          <#if project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>
            <div class="pro-skills">Description:</div>
            <div class="job-description">${project.collegeProjectDescription}</div>
          </#if>
        </#list>
      </#if>

      <#if education?? && education?size gt 0>
        <div class="section-title">Education</div>
        <#list education as edu>
          <div class="educatoin-details">
            <#if edu.department?? && edu.department?has_content>
              <div class="job-role">${edu.department}

                <#if edu.percentage?? && edu.percentage?has_content> &#8208; ${edu.percentage}%
                                            </#if>
                                            </div>


            </#if>
            <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
               <div class="job-role">${edu.fieldOfStudy}</div>

            </#if>

            <#if edu.institutionName?? && edu.institutionName?has_content>
              <div class="org">${edu.institutionName}</div>
            </#if>
            <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
              <div class="job-date-loc">
                ${extractmonth(edu.qualificationStartYear)}
                <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                  &#8208; ${extractmonth(edu.qualificationEndYear)}
                <#else>
                  &#8208; Present
                </#if>
              </div>
            </#if>
          </div>
        </#list>
      </#if>



      <#if certificates?? && certificates?size gt 0>
        <div class="section-title">Certification</div>
        <div class="course-list">
          <#list certificates as cert>
            <div class="course">
			  <#if cert.courseName?? && cert.courseName?has_content>
              ${cert.courseName}<br/>
			  </#if>
              <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
                ${extractmonth(cert.courseStartDate)}
                <#if cert.courseEndDate?? && cert.courseEndDate?has_content>
                  &#8208; ${extractmonth(cert.courseEndDate)}
                </#if>
              </#if>
            </div>
          </#list>
        </div>
      </#if>



      <#if achievements?? && achievements?size gt 0>
        <div class="section-title">Achievements</div>
        <div class="course-list">
          <#list achievements as achieve>
            <div class="course">
			  <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
              ${achieve.achievementsName}
			  </#if>

              <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                <br/>${extractmonth(achieve.achievementsDate)}
              </#if>
            </div>
          </#list>
        </div>
      </#if>

      <#if softSkills?? && softSkills?trim?length gt 0>
        <div class="section-title">Soft Skills</div>
        <div class="skills-list">
         <#list softSkills?split(",") as skill>
           <#if skill?has_content><span class="skill">${skill?trim}</span></#if>
         </#list>
       </div>
      </#if>

      <#if competencies?? && competencies?trim?length gt 0>
        <div class="section-title">Core Competencies</div>
        <div class="skills-list">
         <#list competencies?split(",") as skill>
           <#if skill?has_content><span class="skill">${skill?trim}</span></#if>
         </#list>
       </div>
      </#if>

      <#if goals?? && goals?trim?length gt 0>
          <div class="section-title">Goals</div>
         <div class="skills-list">
                  <#list goals?split(",") as skill>
                    <#if skill?has_content><span class="skill">${skill?trim}</span></#if>
                  </#list>
                </div>
        </#if>


        <#if strengths?? && strengths?trim?length gt 0>
            <div class="section-title">Strength</div>
            <div class="skills-list">
                     <#list strengths?split(",") as skill>
                       <#if skill?has_content><span class="skill">${skill?trim}</span></#if>
                     </#list>
                   </div>
          </#if>



      <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
          <div class="section-title">ExtraCurricular Activities</div>
          <div class="skills-list">
                   <#list extraCurricularActivities?split(",") as skill>
                     <#if skill?has_content><span class="skill">${skill?trim}</span></#if>
                   </#list>
                 </div>
        </#if>


         <#if addAdditionalDetails>

                                   <div class="section-title">Personal Details</div>


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



                        </#if>

</div>
</body>
</html>
