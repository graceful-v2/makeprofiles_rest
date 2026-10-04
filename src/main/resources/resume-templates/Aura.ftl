
<!DOCTYPE html>
<html>
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

        margin: 0;
        padding: 0;
        background: #fff;

       font-family: ${(style.primaryFont)!'"Georgia", "Times New Roman", serif'};
      color: ${(style.bodyColor)!'#222'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.4'};
      }
      .container {
        max-width: 210mm;
        width: 100%;
        padding: 10px;
        background: #fcfcfc;
        overflow-wrap:break-word;
        word-break:break-word;

      }
      h1,
      h2,
      h3 {
        text-align: center;
        font-weight: bold;
        letter-spacing: 2px;
        margin: 0 0 8px 0;
      }
      h1 {
        font-size: ${(style.nameSize)!'20pt'};
       font-weight: ${(style.fontWeightname)!'800'};
        color: ${(style.nameColor)!'#222'};
      }
      .subtitle {
        text-align: center;

        margin-bottom: 12px;
      }
      .small {

        color: #444;
        line-height: 1.5;
      }
      .divider {
        border-top: 2px solid #bbb;
        margin: 20px 0 15px 0;
      }
      .section-title {


        font-size: ${(style.sectionTitleSize)!'14pt'};
        font-weight: ${(style.fontWeightHeading)!'700'};
         color: ${(style.headingColor)!'#222'};

        background: #ececec;
        padding: 4px 12px;


        letter-spacing: 1.5px;
        margin-top: 20px;
        margin-bottom: 7px;
        border-radius: 2px;
        text-align: left;
      }
      ul {
        margin: 7px 18px;
        padding: 0;
      }
      li {
        margin-bottom: 6px;

      }
      .flex-row {
        flex-wrap: wrap;
        line-height: 1.5;
        padding-bottom: 5px;
      }
      .left {
        font-weight: bold;
      }
      .right {
        color: #181818;
        font-style: italic;
      }
      .contact-block {
        text-align: center;
        margin: 8px 0 18px 0;
      }
      .contact-block span {
        display: block;
      }
      .skills-table {
        width: 100%;
        border-spacing: 0;
        margin-bottom: 8px;
      }
      .skills-table tr {
        /* No need for flex here; tables handle column layout naturally */
      }
      .skills-table td {
        padding: 4px 11px;

        width: 50%; /* Ensures each cell takes half the row */
      }

      .exp-section {
        margin-top: 7px;
        padding-bottom: 10px;
        border-bottom: 1px solid rgb(143, 126, 126);
      }

      .achievement-section {
        margin-top: 7px;
        padding-bottom: 10px;
      }
      .academic-heading {
        color: #181818;
        font-style: italic;
        padding-bottom: 10px;
        margin-top: 10px;
      }
      ṇ .project-section {
        margin-bottom: 10px;
        padding-bottom: 10px;
        border-bottom: 1px solid rgb(87, 78, 78);
      }

      .project-heading {

        font-weight: bold;
        font-style: italic;
        text-decoration: underline;
        text-underline-offset: 5px;
      }
      .project-role {
        color: #181818;
        font-style: italic;
        padding-bottom: 10px;
      }
      .project-desc {
        margin-bottom: 10px;

        color: #444;
        line-height: 1.5;
        padding-bottom: 10px;
        margin-top: 5px;
      }

      .project {
        margin-left: 15px;
        margin-top: 10px;
        margin-bottom: 10px;
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


  <div class="container">
    <#if name?? && name?has_content>
      <h1>${name}</h1>
    </#if>

    <div class="contact-block">


         <span>
          <#if phone?? && phone?has_content> <span>${phone}</span></#if>
          <#if email?? && email?has_content>
            <span><a href="mailto:${email}">${email}</a></span>
          </#if>
          <#if linkedin?? && linkedin?has_content>
             ${linkedin}
          </#if>
        </span>

    </div>

    <#if summary?? && summary?has_content>
      <div class="section-title">SUMMARY</div>
      <div class="small">${summary}</div>
    </#if>

    <#if objective?? && objective?has_content>
      <div class="section-title">OBJECTIVE</div>
      <div class="small">${objective}</div>
    </#if>

    <#if experiences?? && experiences?size gt 0>
      <div class="section-title">EMPLOYMENT HISTORY</div>
      <#list experiences as exp>
        <div class="exp-section">
          <div class="flex-row">
            <div class="left">
              <#if exp.role?has_content>${exp.role}</#if>
              <#if exp.companyName?? && exp.companyName?has_content>
                , ${exp.companyName}
              </#if>
            </div>
            <div class="right">
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
            <strong>Roles &amp; Responsibilities</strong>
            <div class="project-desc">${exp.responsibilities}</div>
          </#if>

          <#if exp.projects?? && exp.projects?size gt 0>
            <div class="project">
              <#list exp.projects as proj>
                <div class="project-section">
                  <#if proj.projectName?? && proj.projectName?has_content>
                    <div class="project-heading">Project:</div>
                    <div class="academic-heading">${proj.projectName}</div>
                  </#if>

                  <#if proj.projectRole?? && proj.projectRole?has_content>
                    <div class="project-role">${proj.projectRole}</div>
                  </#if>

                  <#if proj.projectDescription?? && proj.projectDescription?has_content>
                    <strong>Description:</strong>
                    <div class="project-desc">${proj.projectDescription}</div>
                  </#if>

                  <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
                    <strong>Skills:</strong>
                    <ul>
                      <#list proj.projectSkills?split(",") as skill>
                        <#if skill?has_content><li>${skill?trim}</li></#if>
                      </#list>
                    </ul>
                  </#if>
                </div>
              </#list>
            </div>
          </#if>
        </div>
      </#list>
    </#if>

    <#if collegeProject?? && collegeProject?size gt 0>
      <div class="section-title">ACADEMIC PROJECT</div>
      <#list collegeProject as proj>
        <div class="exp-section">
          <#if proj.collegeProjectName?? && proj.collegeProjectName?has_content>
            <div class="academic-heading">${proj.collegeProjectName}</div>
          </#if>

          <#if proj.collegeProjectDescription?? && proj.collegeProjectDescription?trim?length gt 0>
            <strong>Description:</strong>
            <div class="project-desc">${proj.collegeProjectDescription}</div>
          </#if>

          <#if proj.collegeProjectSkills?? && proj.collegeProjectSkills?trim?length gt 0>
            <strong>Skills:</strong>
            <ul>
              <#list proj.collegeProjectSkills?split(",") as skill>
                <#if skill?has_content><li>${skill?trim}</li></#if>
              </#list>
            </ul>
          </#if>
        </div>
      </#list>
    </#if>

	    <#if skills?? && skills?trim?length gt 0>
      <div class="section-title">SKILLS</div>
      <table class="skills-table">
        <#list skills?split(",")?chunk(2) as row>
          <tr>
            <#list row as skill>
              <td>${skill?trim}</td>
            </#list>
          </tr>
        </#list>
      </table>
    </#if>

    <#if education?? && education?size gt 0>
      <div class="section-title">EDUCATION</div>
      <#list education as edu>
        <div class="exp-section">
          <div class="flex-row">
            <div class="left">
              <#if edu.institutionName?? && edu.institutionName?has_content>${edu.institutionName}
              </#if>

                <#if edu.percentage?? && edu.percentage?has_content> &#8208; ${edu.percentage}%
                </#if>
            </div>
            <div class="right">
              <#if edu.department?? && edu.department?has_content>${edu.department}</#if>
              <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content> | ${edu.fieldOfStudy}</#if>
              <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                <br />${extractmonth(edu.qualificationStartYear)}
                <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                  &#8208; ${extractmonth(edu.qualificationEndYear)}
                <#else>
                  &#8208; Present
                </#if>
              </#if>
            </div>
          </div>
        </div>
      </#list>
    </#if>

    <#if certificates?? && certificates?size gt 0>
      <div class="section-title">CERTIFICATIONS</div>
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
    </#if>

    <#if achievements?? && achievements?size gt 0>
      <div class="section-title">ACHIEVEMENTS</div>
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
    </#if>



    <#if softSkills?? && softSkills?trim?length gt 0>
      <div class="section-title">SOFT SKILLS</div>
      <table class="skills-table">
        <#list softSkills?split(",")?chunk(2) as row>
          <tr>
            <#list row as skill>
              <td>${skill?trim}</td>
            </#list>
          </tr>
        </#list>
      </table>
    </#if>

    <#if competencies?? && competencies?trim?length gt 0>
      <div class="section-title">CORE COMPETENCIES</div>
      <table class="skills-table">
        <#list competencies?split(",")?chunk(2) as row>
          <tr>
            <#list row as comp>
              <td>${comp?trim}</td>
            </#list>
          </tr>
        </#list>
      </table>
    </#if>

     <#if goals?? && goals?trim?length gt 0>
          <div class="section-title">GOALS</div>
          <table class="skills-table">
            <#list goals?split(",")?chunk(2) as row>
              <tr>
                <#list row as skill>
                  <td>${skill?trim}</td>
                </#list>
              </tr>
            </#list>
          </table>
        </#if>


         <#if strengths?? && strengths?trim?length gt 0>
              <div class="section-title">STRENGTH</div>
              <table class="skills-table">
                <#list strengths?split(",")?chunk(2) as row>
                  <tr>
                    <#list row as skill>
                      <td>${skill?trim}</td>
                    </#list>
                  </tr>
                </#list>
              </table>
            </#if>



             <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                  <div class="section-title">EXTRACURRICULAR ACTIVITIES</div>
                  <table class="skills-table">
                    <#list extraCurricularActivities?split(",")?chunk(2) as row>
                      <tr>
                        <#list row as skill>
                          <td>${skill?trim}</td>
                        </#list>
                      </tr>
                    </#list>
                  </table>
                </#if>



            <#if addAdditionalDetails>


                  <div class="section-title">PERSONAL DETAILS</div>
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
