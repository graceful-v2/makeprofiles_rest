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
      font-family: ${(style.primaryFont)!'Poppins'}, Arial, sans-serif;
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.3'};
      color: ${(style.bodyColor)!'#222'};
      background: #fff;
    }

   .container {
     width: 100%;
     max-width: 210mm;
     margin: 0 auto;
     display: grid;
     grid-template-columns: 60% 40%;
     column-gap: 12px;
     box-sizing: border-box;
     overflow-wrap:break-word;
     word-break:break-word;
   }


     .right-section {
       background: #0f7d86;
       color: #ffffff;
       padding: 20px 18px;
       box-sizing: border-box;
       border-radius: 6px;
       display: flex;
       flex-direction: column;
       gap: 16px;
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
      font-size: ${(style.sectionTitleSize)!'14pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
      color: #eaf8fb;
      margin-bottom: 2px;
      gap: 8px;
    }

    .block-title{
    margin:5px 0px;
    }

    .right-section .contact-item {
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

     .main {
       padding: 12px 14px;
       box-sizing: border-box;
     }

    .header {
      margin-bottom: 8px;
    }

    .name {
    font-size: ${(style.nameSize)!'32px'};
    font-weight: ${(style.fontWeightname)!'800'};
    color: ${(style.nameColor)!'#163a3c'};
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
      text-transform: uppercase;
      font-size: ${(style.sectionTitleSize)!'14pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
      color: ${(style.headingColor)!'#0f7d86'};
    }

    .divider {
      height: 2px;
      background: #e6f2f3;
      margin: 4px 0 3px;
      border-radius: 2px;
    }

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


    .project-block {
      margin-top: 8px;
      padding-top: 8px;
      border-top: 1px dashed #e6f2f3;
    }

    .project-title {
      color: #0f7d86;
      font-weight: 700;
      margin-bottom: 6px;
      font-size: 12pt;
    }

    .project-desc {
      margin-left: 12px;
      margin-bottom: 6px;
    }

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


    .cert-list li {
      list-style: none;
      margin-bottom: 8px;
      padding-left: 20px;
      position: relative;
    }

    .cert-list li:before {
      content: "✓";
      position: absolute;
      left: 0;
      top: 0;
      color: #bcedf0;
      font-weight: 700;
    }


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

    .project-subheading{
     font-weight:700;
     margin-top:3px;
     text-decoration:underline;
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
          <#if name?? && name?has_content>
            <div class="name">${name}</div>
          </#if>

          <#if jobTitle?? && jobTitle?has_content>
            <div class="title">${jobTitle}</div>
          </#if>
           <#if phone?? && phone?has_content>
                      <div class="title">${phone}</div>
              </#if>

             <#if email?? && email?has_content>
                        <div class="title">${email}</div>
                      </#if>

            <#if linkedin?? && linkedin?has_content>
                      <div class="title">${linkedin}</div>
                    </#if>
        </div>


        <#if summary?? && summary?has_content>
        <div class="section">
          <div class="section-title"><svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                       <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                       <path fill="#FFFFFF"
                                             d="M12 12a4 4 0 1 0 0-8a4 4 0 0 0 0 8zm0 2
                                                c-3.3 0-6 1.7-6 4v1h12v-1
                                                c0-2.3-2.7-4-6-4z"/>
                                                 </svg>
             Summary</div>
                      <div class="divider"></div>
                      <div class="small">${summary}</div>
                    </div>
                    </#if>


        <#if objective?? && objective?has_content>
                <div class="section">
                  <div class="section-title"><svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                               <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                       <path fill="#FFFFFF"
                                             d="M12 7a4 4 0 0 0-2 7v2h4v-2
                                                a4 4 0 0 0-2-7zm-2 10h4v2h-4v-2z"/>
                                     </svg>
                     Objective</div>
                              <div class="divider"></div>
                              <div class="small">${objective}</div>
                            </div>
        </#if>



        <#if experiences?? && experiences?size gt 0>
        <div class="section">
          <div class="section-title"><svg width="16" height="16" viewBox="0 0 24 24"
                                          xmlns="http://www.w3.org/2000/svg"
                                          style="vertical-align:middle;margin-right:8px;">
                                       <!-- teal circle -->
                                       <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                       <!-- skills icon -->
                                       <path fill="#FFFFFF"
                                             d="M9 7h8v2H9V7zm0 4h8v2H9v-2zm0 4h8v2H9v-2zM6.5 8.5
                                                l-1 1l-1.5-1.5l1-1l.5.5l1-.5z"/>
                                     </svg>
                         Experience</div>
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
                              ${extractmonth(exp.experienceYearStartDate)}
                             &#8211;
                           <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                             ${extractmonth(exp.experienceYearEndDate)}
                           <#else>
                             Present
                           </#if>

                          </div>
                          </#if>
            </div>



            <#if exp.responsibilities?? && exp.responsibilities?has_content>
                <ul class="bullets">
                  <#list exp.responsibilities?split(",") as task>
                    <li>${task}</li>
                  </#list>
                </ul>
            </#if>


            <#if exp.projects?? && exp.projects?size gt 0>

            <div class="project-subheading">Project</div>
              <#list exp.projects as prj>
              <div class="project-block">
                <#if prj.projectName?? && prj.projectName?has_content>
                <div class="project-title">${prj.projectName}</div>
                </#if>

                <#if prj.projectRole?? && prj.projectRole?has_content>
                <div class="exp-company"><strong>Role:</strong> ${prj.projectRole}</div>
                </#if>

                <#if prj.projectSkills?? && prj.projectSkills?has_content>
                <strong>Skills:</strong>
                <ul class="bullets">
                  <#list prj.projectSkills?split(",") as skill>
                    <li>${skill}</li>
                  </#list>
                </ul>
                </#if>

                <#if prj.projectDescription?? && prj.projectDescription?has_content>
                <div class="project-desc"><strong>Description:</strong> ${prj.projectDescription}</div>
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
           <div class="section-title"><svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                       <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                       <path fill="#FFFFFF"
                                             d="M6 7h5v10H6V7zm7 0h5v10h-5V7z"/>
                                     </svg>
                 Academic Projects</div>
                          <div class="divider"></div>

                  <#list collegeProject as acp>
                  <div class="exp-item">

                    <#if acp.collegeProjectName?? && acp.collegeProjectName?has_content>
                    <div class="exp-role">${acp.collegeProjectName}</div>
                    </#if>

                    <#if acp.collegeProjectSkills?? && acp.collegeProjectSkills?has_content>
                    <strong>Skills:</strong>
                    <ul class="bullets">
                      <#list acp.collegeProjectSkills?split(",") as sk>
                        <li>${sk}</li>
                      </#list>
                    </ul>
                    </#if>

                    <#if acp.collegeProjectDescription?? && acp.collegeProjectDescription?has_content>
                    <div class="exp-desc muted"><strong>Description:</strong> ${acp.collegeProjectDescription}</div>
                    </#if>
                  </div>
                  </#list>
                </div>
        </#if>


      <#if education?? && education?size gt 0>
<div class="section">
  <div class="section-title"> <svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                <path fill="#FFFFFF"
                                      d="M12 5 3 9l9 4 9-4-9-4zm0 6.5L6 9.2v3.6
                                         c0 .9 2.7 2.2 6 2.2s6-1.3 6-2.2V9.2L12 11.5z"/>
                              </svg>
Education</div>
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

			  <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
				<div class="edu-school muted">${edu.fieldOfStudy}</div>
			  </#if>

			  <#if edu.percentage?? && edu.percentage?has_content>
				<div class="edu-school muted">${edu.percentage}%</div>

			  </#if>
			</div>

			<#if edu.qualificationStartYear?? || edu.qualificationEndYear??>
			<div class="edu-year">
			  <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
				&nbsp; ${extractmonth(edu.qualificationStartYear)}
			  </#if>
			   &#8211;
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
          <div class="section-title"><svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                       <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                       <path fill="#FFFFFF"
                                             d="M8 6h8v2a4 4 0 0 1-3 3.8V14h2v2H9v-2h2v-2.2
                                                A4 4 0 0 1 8 8V6z"/>
                                     </svg>

 Achievements</div>
          <div class="divider"></div>
          <ul class="list">
            <#list achievements as ach>
              <li>${ach.achievementsName}

              <#if ach.achievementsDate?? && ach.achievementsDate?has_content>
                                          &#8209; ${extractmonth(ach.achievementsDate)}
                                          </#if>

                                          </li>
            </#list>
          </ul>
        </div>
        </#if>



        <#if certificates?? && certificates?size gt 0>
        <div class="section">
          <div class="section-title">
 Certificates</div>
          <div class="divider"></div>
          <ul class="list">
            <#list certificates as cert>
             <#if cert.courseName?? && cert.courseName?has_content>
                        <li>${cert.courseName}
                        <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
            					  ( ${extractmonth(cert.courseStartDate)}
            						<#if cert.courseEndDate?? && cert.courseEndDate?has_content>
            							  &#8211; ${extractmonth(cert.courseEndDate)} )
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



        <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
        <div class="section">
          <div class="section-title">&#127895; Extra-Curricular Activities</div>
          <div class="divider"></div>
          <ul class="list">
            <#list extraCurricularActivities?split(",") as e>
              <li>${e}</li>
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
          <div class="section-title"> <svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                        <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                        <path fill="#FFFFFF"
                                              d="M7 8h10v8H7V8zm2 2h4v2H9v-2zm0 3h6v1.5H9V13z"/>
                                      </svg>
                Personal Details</div>
                          <div class="divider"></div>
                          <div class="details-item">
                            <#if fatherName?? && fatherName?has_content><div><strong>Father's Name:</strong> ${fatherName}</div></#if>
                            <#if maritalStatus?? && maritalStatus?has_content><div><strong>Marital Status:</strong> ${maritalStatus}</div></#if>
                            <#if nationality?? && nationality?has_content><div><strong>Nationality:</strong> ${nationality}</div></#if>
                            <#if dob?? && dob?has_content><div><strong>DOB:</strong> ${extractDobYear(dob)}</div></#if>
                            <#if address?? && address?has_content><div><strong>Address:</strong> ${address}</div></#if>
                            <#if gender?? && gender?has_content><div><strong>Gender:</strong> ${gender}</div></#if>
                             <#if languagesKnown?? && languagesKnown?has_content><div><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</div></#if>
                          </div>

                        </#if>

                      </div>


      <div class="right-section">

                <#if profileImage?? && profileImage?has_content>
                <img class="photo" src="${profileImage}" alt="profile photo" />
                </#if>


                <#if skills?? && skills?has_content>
                       <div>
                              <div class="block-title"><svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                                         <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                                         <path fill="#FFFFFF"
                                                               d="M8 7h8v2H8V7zm0 4h8v2H8v-2zm0 4h8v2H8v-2z"/>
                                                       </svg>

                                         Skills</div>
                                              <div>
                                                <#list skills?split(",") as sk>
                                                  <span class="skill-chip">${sk}</span>
                                                </#list>
                                              </div>
                        </div>
                </#if>







                                    <#if strengths?? && strengths?has_content>
                                            <div>
                                                      <div class="block-title">
                                                      Strength</div>
                                                     <div>
                                                         <#list strengths?split(",") as sk>
                                                           <span class="skill-chip">${sk}</span>
                                                         </#list>
                                                       </div>
                                            </div>
                                    </#if>



                               <#if goals?? && goals?has_content>
                                <div>
                                          <div class="block-title">Goals</div>
                                                   <div>
                                                       <#list goals?split(",") as sk>
                                                             <span class="skill-chip">${sk}</span>
                                                           </#list>
                                                    </div>

                                </div>
                               </#if>



                                <#if softSkills?? && softSkills?has_content>
                                   <div>
                                        <div class="block-title"><svg width="16" height="16" viewBox="0 0 24 24"
                                                              style="vertical-align:middle;margin-right:8px;">
                                                           <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                                           <path fill="#FFFFFF"
                                                                 d="M9 7a3 3 0 0 0-3 3v1
                                                                    a2 2 0 0 0 0 4v1
                                                                    a3 3 0 0 0 3 3h1V7H9zm6 0h-1v12h1
                                                                    a3 3 0 0 0 3-3v-1
                                                                    a2 2 0 0 0 0-4v-1
                                                                    a3 3 0 0 0-3-3z"/>
                                                         </svg>
                                                                Soft Skills</div>
                                                                             <div>
                                                                               <#list softSkills?split(",") as sk>
                                                                                 <span class="skill-chip">${sk}</span>
                                                                               </#list>
                                                                             </div>
                                                                   </div>
                                                                   </#if>




  <#if competencies?? && competencies?has_content>
                                   <div>
                                     <div class="block-title"><svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                                                 <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>

                                                                         <path fill="#FFFFFF"
                                                                               d="M12 6a6 6 0 1 0 0 12
                                                                                  a6 6 0 0 0 0-12zm0 3
                                                                                  a3 3 0 1 1 0 6
                                                                                  a3 3 0 0 1 0-6z"/>
                                                                       </svg>



                                                          Core Competencies</div>
                                                                     <div>
                                                                       <#list competencies?split(",") as sk>
                                                                         <span class="skill-chip">${sk}</span>
                                                                       </#list>
                                                                     </div>
                                                                   </div>
                                                                   </#if>




 <#if addAdditionalDetails?? && addAdditionalDetails && hasCollegeProjects>
          <div class="block-title"> <svg width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle;margin-right:8px;">
                                        <circle cx="12" cy="12" r="11" fill="#1BAFB2"/>
                                        <path fill="#FFFFFF"
                                              d="M7 8h10v8H7V8zm2 2h4v2H9v-2zm0 3h6v1.5H9V13z"/>
                                      </svg>
                Personal Details</div>

                          <div class="details-item">
                            <#if fatherName?? && fatherName?has_content><div><strong>Father's Name:</strong> ${fatherName}</div></#if>
                            <#if maritalStatus?? && maritalStatus?has_content><div><strong>Marital Status:</strong> ${maritalStatus}</div></#if>
                            <#if nationality?? && nationality?has_content><div><strong>Nationality:</strong> ${nationality}</div></#if>
                            <#if dob?? && dob?has_content><div><strong>DOB:</strong> ${extractDobYear(dob)}</div></#if>
                            <#if address?? && address?has_content><div><strong>Address:</strong> ${address}</div></#if>
                            <#if gender?? && gender?has_content><div><strong>Gender:</strong> ${gender}</div></#if>
                             <#if languagesKnown?? && languagesKnown?has_content><div><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</div></#if>
                          </div>

                        </#if>


              </div>

         </div>


</body>

</html>