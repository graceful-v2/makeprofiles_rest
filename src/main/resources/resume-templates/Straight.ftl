
<!doctype html>
<html>

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="utf-8" />
   <@fonts.loadFonts />


  <style>
    @page: first {
      margin-top: 10px;
    }

    @page {
      size: A4;
      margin-top: 20px;
      margin-bottom: 10px;
      margin-left: 20px;
      margin-right: 20px;
    }


    html,
    body {
      margin: 0;
      padding: 0;
      font-family: ${(style.primaryFont)!'Poppins, Arial, sans-serif'};
      color: ${(style.bodyColor)!'#222'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.3'};
      background: #fff;
    }

    .container {
      width: 210mm;
      margin: 0;
      box-sizing: border-box;
      padding: 0;
    }


    .header {
      background: #6f5a86;
      color: #fff;
      padding: 28px 24px;
      text-align: center;
      box-sizing: border-box;
    }

    .header .title {
      font-size: ${(style.nameSize)!'32px'};
      font-weight: ${(style.fontWeightname)!'800'};
      color: ${(style.nameColor)!'#ffffff'};
      margin: 0 0 6px 0;
      letter-spacing: 1px;
    }

    .header .subtitle {
      font-size: 12.5pt;
      font-weight: 600;
      opacity: 0.95;
      margin: 0;
    }

    /* layout: two columns - left main + right right-section */
    .layout {
      display: grid;
      grid-template-columns: 64% 36%;
      gap: 20px;
      padding: 20px 18px;
      box-sizing: border-box;
    }

    /* RIGHT right-section (light gray) */
    .right-section {
      background: #f6f6f8;
      padding: 18px;
      box-sizing: border-box;
      border-left: 1px solid #e6e6ea;
      min-height: 200px;
      overflow-wrap:break-word;


    }

    .right-section .block {
      margin-bottom: 7px;
    }

    .right-section .block .block-title {
      font-weight: 700;
      color: #6f5a86;
      margin-bottom: 5px;
      font-size: 12.5pt;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .right-section .contact-item {

      margin-bottom: 8px;
      color: #333;
    }

    .right-section .edu-item {
      margin-bottom: 10px;
    }

    .right-section .skill-list {

      line-height: 1.6;
    }

    /* MAIN content */
    .main {
      padding-right: 6px;
      box-sizing: border-box;
    }

    .section {
      margin-bottom: 7px;
      overflow-wrap:break-word;
    }

    .section-title {
      display: flex;
      align-items: center;
      gap: 10px;

      text-transform: uppercase;
      letter-spacing: 0.6px;
      margin-bottom: 5px;
     font-size: ${(style.sectionTitleSize)!'13pt'};
     font-weight: ${(style.fontWeightHeading)!'700'};
     color: ${(style.headingColor)!'#6f5a86'};
    }

    .divider {
      height: 2px;
      background: #efe9f4;
      margin-bottom: 5px;
      border-radius: 2px;
    }

    /* Summary */
    .summary {

      color: #333;
      line-height: 1.5;
    }

    /* Experience */
    .exp-item {
      margin-bottom: 18px;
      padding-bottom: 12px;
      border-bottom: 1px solid #f0f0f3;
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

    .exp-role {
      font-weight: 700;
      font-size: 12.5pt;
      margin: 0 0 4px 0;
    }

    .exp-company {
      color: #333;
      font-style: italic;
      margin-bottom: 8px;
    }

    .exp-dates {
      color: #6f5a86;
      font-weight: 600;
      white-space: nowrap;
    }

    .exp-desc {
      margin: 6px 0;
      color: #444;

      line-height: 1.45;
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
      padding-top: 8px;
      border-top: 1px dashed #efe9f4;
    }

    .project-title {
      font-weight: 700;
      color: #6f5a86;
      margin-bottom: 6px;
      font-size: 12.5pt;
    }

    .project-desc {


      color: #333;
    }

    /* Education */
    .edu-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 12px;
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
      color: #6f5a86;
      font-weight: 600;
    }

    /* Other sections (achievements, awards, strengths, goals, extra-curricular) */
    .two-col {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px;
    }

    .list {
      margin-left: 18px;
    }

    .list li {
      margin-bottom: 4px;

      color: #333;
    }

    /* personal details block */
    .personal-details {

      color: #333;

    }

    .pd-row {
      margin-bottom: 4px;
    }


    .muted {
      color: #030303;
      font-style: italic;

    }

    .small {

      color: #ffffff;
    }


    .icon {
      font-size: 16px;
      line-height: 1;
    }

    .block {
      line-height: 1.5;
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


    <div class="header">

      <#if name?? && name?has_content>
        <div class="title">${name}</div>
      </#if>



        <div class="small muted">
          <#assign first = true>



          <#if phone?? && phone?has_content>
          <div> &#8226  ${phone}</div>

          </#if>

          <#if email?? && email?has_content>
             <div>    &#8226 ${email}</div>

          </#if>

          <#if linkedin?? && linkedin?has_content>
             <div>  &#8226  ${linkedin}</div>
          </#if>

		    <#if address?? && address?has_content>
              <div>   &#8226  ${address}</div>

          </#if>
        </div>

    </div>


    <div class="layout">


      <div class="main">


        <#if summary?? && summary?has_content>
        <div class="section">
          <div class="section-title">
        <#--     <span class="icon">📋</span> -->
            <div>Summary</div>
          </div>

          <div class="summary">
            ${summary}
          </div>
        </div>
        </#if>


        <#if objective?? && objective?has_content>
        <div class="section">
          <div class="section-title">
        <#--     <span class="icon">📋</span> -->
            <div>Objective</div>
          </div>

          <div class="summary">
            ${objective}
          </div>
        </div>
        </#if>

             <#if strengths?? && strengths?trim?length gt 0>
                <div class="section">
                  <div class="section-title">    Strengths</div>
                   <div class="skill-list">
                            <#list strengths?split(",") as hb>
                          <#if hb?has_content><div>${hb?trim}</div></#if>
                        </#list>
                    </div>
                </div>
                </#if>



                <#if hobbies?? && hobbies?trim?length gt 0>
                                <div class="section">
                                  <div class="section-title">  <#-- <span class="icon">💪</span> --> Hobbies</div>

                      <div class="skill-list">
                               <#list hobbies?split(",") as hb>
                             <#if hb?has_content><div>${hb?trim}</div></#if>
                           </#list>
                       </div>
                </div>
                </#if>




        <#if education?? && education?size gt 0>
        <div class="section">
          <div class="section-title">  <#-- <span class="icon">🎓</span> --> Education</div>

          <#list education as edu>
          <div class="edu-item">
            <div class="edu-left">


              <#if edu.department?? && edu.department?has_content>
                <div class="edu-degree">
                  ${edu.department}

                </div>
              </#if>

                 <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                     ${edu.fieldOfStudy}
                </#if>




              <#if edu.institutionName?? && edu.institutionName?has_content>
                <div class="edu-school muted">
                  ${edu.institutionName}
                  <#if edu.percentage?? && edu.percentage?has_content>
                     &#8211; ${edu.percentage}%
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


        <#if experiences?? && experiences?size gt 0>
        <div class="section">
          <div class="section-title">
          <#--   <span class="icon">💼</span>-->
            <div>Professional Experience</div>
          </div>


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
                ${extractmonth(exp.experienceYearStartDate)}
                <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                   &#8211; ${extractmonth(exp.experienceYearEndDate)}
                <#else>
                   &#8211; Present
                </#if>
              </div>
              </#if>
            </div>





            <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
            <ul class="bullets">
              <#list exp.responsibilities?split(",") as rs>
                <#if rs?has_content><li>${rs?trim}</li></#if>
              </#list>
            </ul>
            </#if>


            <#if exp.projects?? && exp.projects?size gt 0>
              <#list exp.projects as prj>
              <div class="project-block">

                <#if prj.projectName?? && prj.projectName?has_content>
                <div class="project-title">Project: ${prj.projectName}</div>
                </#if>

                <#if prj.projectRole?? && prj.projectRole?has_content>
                <div class="exp-company"><strong>Role: </strong>${prj.projectRole}</div>
                </#if>

                <#if prj.projectSkills?? && prj.projectSkills?trim?length gt 0>
                <strong>Skills:</strong>
                <ul class="bullets">
                  <#list prj.projectSkills?split(",") as skl>
                    <#if skl?has_content><li>${skl?trim}</li></#if>
                  </#list>
                </ul>
                </#if>

                <#if prj.projectDescription?? && prj.projectDescription?has_content>
                <div class="project-desc">
                  <strong>Description: </strong>${prj.projectDescription}
                </div>
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
          <div class="section-title">
           <#--  <span class="icon">📚</span> -->
            <div>Academic Projects</div>
          </div>
          <div class="divider"></div>

          <#list collegeProject as cp>
          <div class="project-block">

            <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
            <div class="exp-company"><strong>Name: </strong>${cp.collegeProjectName}</div>
            </#if>

            <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
            <strong>Skills:</strong>
            <ul class="bullets">
              <#list cp.collegeProjectSkills?split(",") as skl>
                <#if skl?has_content><li>${skl?trim}</li></#if>
              </#list>
            </ul>
            </#if>

            <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
            <div class="project-desc">
              <strong>Description: </strong>${cp.collegeProjectDescription}
            </div>
            </#if>

          </div>
          </#list>

        </div>
        </#if>


        <#if achievements?? && achievements?size gt 0>
        <div class="section">
          <div class="section-title">
           <#--  <span class="icon">🏆</span> -->
            <div>Achievements & Awards</div>
          </div>


          <ul class="list">
            <#list achievements as ac>
              <#if ac.achievementsName?? && ac.achievementsName?has_content>
              <li>
                <b>${ac.achievementsName}</b>
                <#if ac.achievementsDate?? && ac.achievementsDate?has_content>
                  — (${extractmonth(ac.achievementsDate)})
                </#if>
              </li>
              </#if>
            </#list>
          </ul>
        </div>
        </#if>


        <#if certificates?? && certificates?size gt 0>
        <div class="section">
          <div class="section-title">
          <#--   <span class="icon">🗂️</span> -->
            <div>Certificates</div>
          </div>
          <div class="divider"></div>


          <ul class="list">
            <#list certificates as ct>
              <#if ct.courseName?? && ct.courseName?has_content>
              <li>
                <b>${ct.courseName}</b>
                <#if ct.courseStartDate?? && ct.courseStartDate?has_content>
                   &ndash; (${extractmonth(ct.courseStartDate)}
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

    <#assign hasCollegeProjects = false>
                     <#if collegeProject?? && collegeProject?size gt 0>
                        <#list collegeProject as proj>
                              <#if proj.collegeProjectName?? && proj.collegeProjectName?has_content>
                                <#assign hasCollegeProjects = true>
                                               <#break>
                            </#if>
                            <#if hasCollegeProjects>
                                <#break>
                            </#if>
                        </#list>
                    </#if>




        <#if addAdditionalDetails?? && addAdditionalDetails && !hasCollegeProjects>
        <div class="section">
          <div class="section-title"> <#-- <span class="icon">🧑‍💼</span> --> Personal Details</div>

          <div class="personal-details">

            <#if fatherName?? && fatherName?has_content>
            <div class="pd-row"><strong>Father's Name:</strong> ${fatherName}</div>
            </#if>

            <#if maritalStatus?? && maritalStatus?has_content>
            <div class="pd-row"><strong>Marital Status:</strong> ${maritalStatus}</div>
            </#if>

            <#if dob?? && dob?has_content>
            <div class="pd-row"><strong>DOB:</strong> ${extractDobYear(dob)}</div>
            </#if>

            <#if nationality?? && nationality?has_content>
            <div class="pd-row"><strong>Nationality:</strong> ${nationality}</div>
            </#if>

			  <#if gender?? && gender?has_content>
            <div class="pd-row"><strong>Gender:</strong> ${gender}</div>
            </#if>


		  <#if languagesKnown?? && languagesKnown?has_content>
				<div class="pd-row"><strong>Languages Known:</strong>  ${languagesKnown?replace(",", ", ")}</div>
		   </#if>

		    <#if address?? && address?has_content>
            <div class="pd-row"><strong>Address:</strong> ${address}</div>
            </#if>





          </div>
        </div>
        </#if>

      </div> <!-- end .main -->


      <!-- ====================== RIGHT SECTION ====================== -->
      <div class="right-section">



                <#if skills?? && skills?trim?length gt 0>
                <div class="block">
                   <div class="block-title">   Relevant Skills</div>

                <div class="skill-list">
                            <#list skills?split(",") as gl>
                              <#if gl?has_content><div>${gl?trim}</div></#if>
                            </#list>
                          </div>
                </div>
                </#if>




        <!-- GOALS (same `goals`) -->
        <#if goals?? && goals?trim?length gt 0>
        <div class="block">
          <div class="block-title">
         <#--  <span class="icon">🎯</span> --> Goals</div>
          <div class="skill-list">
            <#list goals?split(",") as gl>
              <#if gl?has_content><div>${gl?trim}</div></#if>
            </#list>
          </div>
        </div>
        </#if>


        <#if competencies?? && competencies?trim?length gt 0>
        <div class="block">
          <div class="block-title">
          <#-- <span class="icon">⚙️</span> --> Core Competencies</div>
          <div class="skill-list">
            <#list competencies?split(",") as cp>
              <#if cp?has_content><div>${cp?trim}</div></#if>
            </#list>
          </div>
        </div>
        </#if>

        <!-- SOFT SKILLS (same `softSkills`) -->
        <#if softSkills?? && softSkills?trim?length gt 0>
        <div class="block">
          <div class="block-title">
           <#-- <span class="icon">⚙️</span> --> Soft Skills</div>
          <div class="skill-list">
            <#list softSkills?split(",") as ss>
              <#if ss?has_content><div>${ss?trim}</div></#if>
            </#list>
          </div>
        </div>
        </#if>

         <#if strengths?? && strengths?trim?length gt 0>
                 <div class="block">
                    <div class="block-title">    Strengths</div>

                      <div class="skill-list">
                                <#list extraCurricularActivities?split(",") as hb>
                              <#if hb?has_content><div>${hb?trim}</div></#if>
                            </#list>
                      </div>
                </div>
                </#if>



                <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                <div class="block">
               <div class="block-title">  Extra-curricular Activities</div>
                   <div class="skill-list">
                              <#list extraCurricularActivities?split(",") as hb>
                            <#if hb?has_content><div>${hb?trim}</div></#if>
                          </#list>
                      </div>
                </div>
                </#if>

                <#assign hasCollegeProjects = false>
                                     <#if collegeProject?? && collegeProject?size gt 0>
                                        <#list collegeProject as proj>
                                              <#if proj.collegeProjectName?? && proj.collegeProjectName?has_content>
                                                <#assign hasCollegeProjects = true>
                                                               <#break>
                                            </#if>
                                            <#if hasCollegeProjects>
                                                <#break>
                                            </#if>
                                        </#list>
                                    </#if>




                        <#if addAdditionalDetails?? && addAdditionalDetails && hasCollegeProjects>
                        <div class="block">
                          <div class="block-title"> <#-- <span class="icon">🧑‍💼</span> --> Personal Details</div>

                          <div class="personal-details">

                            <#if fatherName?? && fatherName?has_content>
                            <div class="pd-row"><strong>Father's Name:</strong> ${fatherName}</div>
                            </#if>

                            <#if maritalStatus?? && maritalStatus?has_content>
                            <div class="pd-row"><strong>Marital Status:</strong> ${maritalStatus}</div>
                            </#if>

                            <#if dob?? && dob?has_content>
                            <div class="pd-row"><strong>DOB:</strong> ${extractDobYear(dob)}</div>
                            </#if>

                            <#if nationality?? && nationality?has_content>
                            <div class="pd-row"><strong>Nationality:</strong> ${nationality}</div>
                            </#if>

                			  <#if gender?? && gender?has_content>
                            <div class="pd-row"><strong>Gender:</strong> ${gender}</div>
                            </#if>


                		  <#if languagesKnown?? && languagesKnown?has_content>
                				<div class="pd-row"><strong>Languages Known:</strong>  ${languagesKnown?replace(",", ", ")}</div>
                		   </#if>

                		    <#if address?? && address?has_content>
                            <div class="pd-row"><strong>Address:</strong> ${address}</div>
                            </#if>





                          </div>
                        </div>
                        </#if>



      </div>

    </div>

  </div>
</body>
</html>