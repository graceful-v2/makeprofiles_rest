

<!DOCTYPE html>
<html lang="en">

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="UTF-8">
<@fonts.loadFonts />
  <style>
     @page: first {
      margin-top: 10px;
     }

    @page {
      size: A4;
      margin-top: 40px;
      margin-bottom: 20px;
      margin-left: 20px;
      margin-right: 20px;
    }

    .name {
    font-size: ${(style.nameSize)!'26pt'};
    font-weight: ${(style.fontWeightname)!'800'};
    color: ${(style.nameColor)!'#222'};
    }

    html,
    body {
      margin: 0;
      padding: 0;
      width: 210mm;
      background: #fff;
      font-family: ${(style.primaryFont)!'Calibri'};
      font-size: ${(style.bodySize)!'13pt'};
      line-height: ${(style.lineSpacing)!'1.35'};
      color: ${(style.bodyColor)!'#222'};
    }

    .container {
      width: 100%;
      height: 100%;
      display: grid;
      grid-template-columns: 65% 35%;
      padding: 0;
      margin: 0;
      box-sizing: border-box;
    }

    .left-section {
      background: #fff;
      padding: 15px 10px;
      box-sizing: border-box;
    }

    .right-section {
      padding: 15px 10px;
      box-sizing: border-box;
    }

    .profile-pic {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      background: #ddd;
      margin-bottom: 15px;
    }



    .section {
      margin-bottom: 10px;
    }

    .section-title {
      border-bottom: 2px solid #000;
      padding-bottom: 5px;
      margin-bottom: 10px;
      font-size: ${(style.sectionTitleSize)!'18pt'};
      font-weight: ${(style.fontWeightHeading)!'500'};
      color: ${(style.headingColor)!'#1039de'};
    }

    ul {
      padding-left: 18px;
    }

    .small-text {
      line-height: 1.4;
    }

    .contact-details div {
      margin-bottom: 5px;
      margin-top: 5px;
      overflow-wrap: break-word;

    }

    .exp-block {
      display: flex;
      justify-content: space-between;
    }

    .exp-dec {
      margin-bottom: 10px;
      margin-top: 5px;
    }

    .dates {
      font-size: 12pt;
    }

    .project-title {
      font-size: 14pt;
    }

    .project-block {
      margin-bottom: 10px;
      margin-top: 10px;
      border-bottom: 1px solid rgb(132, 132, 210);
    }

    .exp-item {
      margin-bottom: 10px;
    }

    .edu-block {
      margin-bottom: 10px;
    }

    .cert-list{
     overflow-wrap: break-word;
     word-break:break-word;
    }

    .fields-items {
      line-height: 1.4;
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


    <div class="left-section">

      <#if name?? && name?has_content>
        <div class="name">${name}</div>
      </#if>

      <#if title?? && title?has_content>
        <div style="margin-bottom:20px;">${title}</div>
      </#if>


      <#if summary?? && summary?has_content>
      <div class="section">
        <div class="section-title">Summary</div>
        <div class="small-text">
          ${summary}
        </div>
      </div>
      </#if>

	    <#if objective?? && objective?has_content>
      <div class="section">
        <div class="section-title">Objective</div>
        <div class="small-text">
          ${objective}
        </div>
      </div>
      </#if>

      <!-- EDUCATION -->
      <#if education?? && education?size gt 0>
      <div class="section">
        <div class="section-title">Education</div>

        <#list education as edu>
        <div class="edu-block">

          <#if edu.department?? && edu.department?has_content>
            <div><strong>${edu.department}
              <#if edu.percentage?? && edu.percentage?has_content>
                - ${edu.percentage}%
              </#if>
            </strong></div>
          </#if>

          <#if edu.institutionName?? && edu.institutionName?has_content>
            <div>${edu.institutionName}</div>
          </#if>

          <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
            <div>${edu.fieldOfStudy}</div>
          </#if>

          <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
            <div>
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
        <div class="section-title">Work Experience</div>

        <#list experiences as exp>
        <div class="exp-item">

          <div class="exp-block">
            <div>
              <#if exp.companyName?? && exp.companyName?has_content>
                ${exp.companyName}
              </#if>

              <#if exp.role?? && exp.role?has_content>
                <div>${exp.role}</div>
              </#if>
            </div>

            <div class="dates">
              <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                <strong>
                ${extractmonth(exp.experienceYearStartDate)}
                <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                   &#8211; ${extractmonth(exp.experienceYearEndDate)}
                <#else>
                   &#8211; Present
                </#if>
                </strong>
              </#if>
            </div>
          </div>



          <!-- EXPERIENCE SKILLS -->
          <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
            <strong>Responsibilities:</strong>
            <ul>
              <#list exp.responsibilities?split(",") as skill>
                <#if skill?has_content>
                  <li>${skill?trim}</li>
                </#if>
              </#list>
            </ul>
          </#if>

          <!-- EXPERIENCE PROJECTS -->
          <#if exp.projects?? && exp.projects?size gt 0>
          <div class="project-title"><strong>Projects</strong></div>

          <#list exp.projects as proj>
          <div class="project-block">

            <#if proj.projectName?? && proj.projectName?has_content>
              <div><strong>Name:</strong> ${proj.projectName}</div>
            </#if>

            <#if proj.projectRole?? && proj.projectRole?has_content>
              <div><strong>Role:</strong> ${proj.projectRole}</div>
            </#if>

            <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
              <div class="exp-dec">
                <strong>Skills: </strong>
                <#list proj.projectSkills?split(",") as s>
                  ${s?trim}<#if s_has_next>, </#if>
                </#list>
              </div>
            </#if>

            <#if proj.projectDescription?? && proj.projectDescription?has_content>
              <div class="exp-dec"><strong>Description:</strong>${proj.projectDescription}</div>
            </#if>

          </div>
          </#list>
          </#if>

        </div>
        </#list>

      </div>
      </#if>

      <!-- ACADEMIC PROJECT -->
      <#if collegeProject?? && collegeProject?size gt 0>
      <div class="section">
        <div class="section-title">Academic Project</div>

        <#list collegeProject as cp>
        <div class="exp-item">

          <div class="exp-block">
            <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
              <strong>${cp.collegeProjectName}</strong>
            </#if>
          </div>

          <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
          <div class="exp-dec"><strong>Description:</strong>${cp.collegeProjectDescription}</div>
          </#if>

          <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
            <strong>Skills:</strong>
            <ul>
              <#list cp.collegeProjectSkills?split(",") as skill>
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

      <!-- EXTRA-CURRICULAR -->
    <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
      <div class="section">
        <div class="section-title">Extra-Curricular Activities</div>
        <ul class="small-text">
          <#list extraCurricularActivities?split(",") as ex>
            <#if ex?has_content>
              <li>${ex?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>


      <#if strengths?? && strengths?trim?length gt 0>
      <div class="section">
        <div class="section-title">Strengths</div>
        <ul class="small-text">
          <#list strengths?split(",") as st>
            <#if st?has_content>
              <li>${st?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>

       <#if achievements?? && achievements?size gt 0>
              <div class="section">
                <div class="section-title">Achievements &amp; Awards</div>

                <ul class="small-text">
                  <#list achievements as achieve>
                            <#if achieve.achievementsName?has_content>
                              <li>${achieve.achievementsName}
                                <#if achieve.achievementsDate?has_content>
                                   &#8211; ${extractmonth(achieve.achievementsDate)}
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
              <div class="section-title">Personal Details</div>
              <div class="contact-details small-text">

                <#if fatherName?? && fatherName?has_content>
                  <div><strong>Father Name:</strong> ${fatherName}</div>
                </#if>

                <#if nationality?? && nationality?has_content>
                  <div><strong>Nationality:</strong> ${nationality}</div>
                </#if>

      		   <#if dob?? && dob?has_content>
      			<div><strong>DOB:</strong>  ${extractDobYear(dob)}</div>
      		  </#if>

                <#if maritalStatus?? && maritalStatus?has_content>
                  <div><strong>Marital Status:</strong> ${maritalStatus}</div>
                </#if>

                <#if gender?? && gender?has_content>
                  <div><strong>Gender:</strong> ${gender}</div>
                </#if>

      		  <#if languagesKnown?? && languagesKnown?has_content>
                  <div><strong>Languages Known:</strong>  ${languagesKnown?replace(",", ", ")}</div>
                </#if>


                <#if address?? && address?has_content>
                  <div><strong>Address:</strong> ${address}</div>
                </#if>

              </div>
            </div>
            </#if>

    </div>


    <!-- RIGHT SECTION -->
    <div class="right-section">

      <#if profileImage?? && profileImage?has_content>

        <img src="${profileImage}" class="profile-pic" />

      </#if>

      <!-- CONTACT DETAILS -->

      <div class="section">
        <div class="section-title">Contact Details</div>

        <div small-text">

          <#if email?? && email?has_content>
            <div class="contact-details"><div>${email}</div></div>
          </#if>

          <#if phone?? && phone?has_content>
            <div class="contact-details"> <div>${phone}</div></div>
          </#if>

          <#if linkedin?? && linkedin?has_content>
            <div class="contact-details"> <div>${linkedin}</div></div>
          </#if>

          <#if location?? && location?has_content>
            <div class="contact-details"> <div>${location}</div></div>
          </#if>

        </div>
      </div>


      <!-- SKILLS -->
      <#if skills?? && skills?trim?length gt 0>
      <div class="section">
        <div class="section-title">Skills</div>
        <ul class="small-text">
          <#list skills?split(",") as s>
            <#if s?has_content>
              <li>${s?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>

      <!-- CORE COMPETENCIES -->
      <#if competencies?? && competencies?trim?length gt 0>
      <div class="section">
        <div class="section-title">Core Competencies</div>
        <ul class="small-text">
          <#list competencies?split(",") as c>
            <#if c?has_content>
              <li>${c?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>

      <!-- SOFT SKILLS -->
      <#if softSkills?? && softSkills?trim?length gt 0>
      <div class="section">
        <div class="section-title">Soft Skills</div>
        <ul class="small-text">
          <#list softSkills?split(",") as ss>
            <#if ss?has_content>
              <li>${ss?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>

      <!-- GOALS -->
      <#if goals?? && goals?trim?length gt 0>
      <div class="section">
        <div class="section-title">Goals</div>
        <div class="fields-items">
          <#list goals?split(",") as g>
            <#if g?has_content>
              <div>${g?trim}</div>
            </#if>
          </#list>
        </div>
      </div>
      </#if>

       <#if certificates?? && certificates?size gt 0>
              <div class="section">
               <div class="section-title">Courses &amp; Training</div>

                <ul class="cert-list">
                 <#list certificates as certi>
                                      <#if certi.courseName?? && certi.courseName?has_content>
                                         <li>${certi.courseName}
                                           <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                                                          ( ${extractmonth(certi.courseStartDate)}
                                                            <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                                                              &#8211; ${extractmonth(certi.courseEndDate)} )
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
      <div class="section">
        <div class="section-title">Personal Details</div>
        <div class="contact-details small-text">

          <#if fatherName?? && fatherName?has_content>
            <div><strong>Father Name:</strong> ${fatherName}</div>
          </#if>

          <#if nationality?? && nationality?has_content>
            <div><strong>Nationality:</strong> ${nationality}</div>
          </#if>

		   <#if dob?? && dob?has_content>
			<div><strong>DOB:</strong>  ${extractDobYear(dob)}</div>
		  </#if>

          <#if maritalStatus?? && maritalStatus?has_content>
            <div><strong>Marital Status:</strong> ${maritalStatus}</div>
          </#if>

          <#if gender?? && gender?has_content>
            <div><strong>Gender:</strong> ${gender}</div>
          </#if>

		  <#if languagesKnown?? && languagesKnown?has_content>
            <div><strong>Languages Known:</strong>  ${languagesKnown?replace(",", ", ")}</div>
          </#if>


          <#if address?? && address?has_content>
            <div><strong>Address:</strong> ${address}</div>
          </#if>

        </div>
      </div>
      </#if>

    </div>

  </div>
</body>
