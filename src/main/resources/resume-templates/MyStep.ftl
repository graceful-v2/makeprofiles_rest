
<!DOCTYPE html>
<html>

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="UTF-8" />
<@fonts.loadFonts />
  <style>

  @page:first { margin-top: 10px; }
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
      font-family: ${(style.primaryFont)!'Inter, Helvetica, Arial, sans-serif'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.3'};
      color: ${(style.bodyColor)!'#222'};
      background: white;
    }

    /* ================= HEADER ================= */
    .header {
      padding: 30px 20px 18px 20px;
      width: 210mm;
      margin: auto;
      border-bottom: 2px solid #333;
    }

    .name {
      color: ${(style.nameColor)!'#1f2933'};
      font-size: ${(style.nameSize)!'28pt'};
      font-weight: ${(style.fontWeightname)!'800'};
      letter-spacing: 1px;
    }

    .name span.last {
      font-weight: 800;
      text-transform: uppercase;
      color:#222;
    }

    .job-title {
      font-size:13pt;
      margin-top: 4px;
      color: #555';
    }



    .contact-grid {
      display: flex;
       flex-direction: column;
      gap:10px;
      color:#1f2933;
      font-size:12p;
      font-weight:800;
    }




    .summary-title {
      text-align: center;
      font-size: ${(style.sectionTitleSize)!'14pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
      color: ${(style.headingColor)!'#0c3d73'};
      margin-top: 5px;
      margin-bottom: 5px;
      color: #0c3d73;
      letter-spacing: 1px;
    }



    .container {

      width: 210mm;
      margin: auto;
      padding: 5px 5px;
      display: grid;
      grid-template-columns: 40% 60%;
      column-gap: 25px;
      box-sizing: border-box;

    }

    .left-section {
      /* padding-right: 10px; */
    }

    .right-section {
      padding-left: 10px;
      border-left:
        1px solid #ccc;
    }



    .section-title {
      font-size: ${(style.sectionTitleSize)!'14pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
      color: ${(style.headingColor)!'#0c3d73'};

      letter-spacing: 0.5px;
      border-bottom: 1px solid #ddd;
      margin-bottom: 5px;
    }

    .section {
      padding-bottom: 3px;
      margin-top: 15px;
    }

    .sub-section-title {
      font-size: 12.5pt;
      font-weight: 700;

      color: #0c3d73;
    }

    .education-sub-details {
      line-height: 1.3;
    }

    .sub-project-section-title {
      font-size: 12pt;
      font-weight: 500;
      margin: 5px 0px;
      color: #0c3d73;

    }



    ul {
      padding-left: 18px;
      margin: 0;
    }

    ul li {
      margin-bottom:5px;
    }

    .edu-item,
    .cert-item,
    .skill-item {
      margin-bottom: 12px;
    }

    .exp-role {
      font-size: 12pt;
      font-weight: 700;
      margin-bottom: 4px;
    }

    .exp-line {
      font-size: 12pt;
      font-style: italic;
      margin-bottom: 6px;
    }

    .exp-item {
      margin-bottom: 12px;
      border-bottom: 1px solid #ddd;
    }

    .project-description {
      margin-top: 5px;
      margin-bottom: 5px;

    }

    .project-item {
      border-bottom: 1px solid #ddd;
      margin-bottom: 5px;
    }

    .icon {
         font-size: ${(style.bodySize)!'12pt'};
      }

       .contact-grid {
          margin-top: 14px;
          display: grid;
          grid-template-columns: 18px auto;
          row-gap: 6px;
          column-gap: 10px;

        }

        .certi-list{

       overflow-wrap: break-word;
       word-break:break-word;

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


   <div class="header">

       <#if name?? && name?has_content>
           <div class="name"><span class="last">${name}</span></div>
       </#if>

       <#if jobTitle?? && jobTitle?has_content>
           <div class="job-title">${jobTitle}</div>
       </#if>

       <div class="contact-grid">

           <#if phone?? && phone?has_content>
               <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                      fill="#E91E63"
                                      xmlns="http://www.w3.org/2000/svg"
                                      style="vertical-align:middle; margin-right:6px;">
                                   <path d="M6.6 10.8c1.5 3 4.1 5.6 7.1 7.1l2.4-2.4
                                            c.3-.3.7-.4 1.1-.3 1.2.4 2.6.6 4 .6
                                            .6 0 1 .4 1 1V21c0 .6-.4 1-1 1
                                            C10.5 22 2 13.5 2 3c0-.6.4-1 1-1h4.1
                                            c.6 0 1 .4 1 1 0 1.4.2 2.8.6 4
                                            .1.4 0 .8-.3 1.1L6.6 10.8z"/>
                                 </svg>
   </div><div>${phone}</div>
           </#if>

           <#if email?? && email?has_content>
               <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                      fill="#B39DDB"
                                      xmlns="http://www.w3.org/2000/svg"
                                      style="vertical-align:middle; margin-right:6px;">
                                   <path d="M20 4H4c-1.1 0-2 .9-2 2v12
                                            c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6
                                            c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6
                                            l8 5 8-5v2z"/>
                                 </svg>
   </div><div>${email}</div>
           </#if>

           <#if location?? && location?has_content>
               <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                      fill="#9E9E9E"
                                      xmlns="http://www.w3.org/2000/svg"
                                      style="vertical-align:middle; margin-right:6px;">
                                   <path d="M12 2C8.1 2 5 5.1 5 9
                                            c0 5.2 7 13 7 13s7-7.8 7-13
                                            c0-3.9-3.1-7-7-7zm0 9.5
                                            c-1.4 0-2.5-1.1-2.5-2.5
                                            S10.6 6.5 12 6.5
                                            14.5 7.6 14.5 9
                                            13.4 11.5 12 11.5z"/>
                                 </svg>
   </div><div>${location}</div>
           </#if>

           <#if linkedin?? && linkedin?has_content>
               <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                      fill="#9E9E9E"
                                      xmlns="http://www.w3.org/2000/svg"
                                      style="vertical-align:middle; margin-right:6px;">
                                   <path d="M10.6 13.4a4 4 0 0 1 0-5.7l2.1-2.1
                                            a4 4 0 1 1 5.7 5.7l-1 1-1.4-1.4
                                            1-1a2 2 0 1 0-2.8-2.8l-2.1 2.1
                                            a2 2 0 0 0 0 2.8l-1.5 1.4z"/>
                                   <path d="M13.4 10.6a4 4 0 0 1 0 5.7l-2.1 2.1
                                            a4 4 0 0 1-5.7-5.7l1-1 1.4 1.4
                                            -1 1a2 2 0 0 0 2.8 2.8l2.1-2.1
                                            a2 2 0 0 0 0-2.8l1.5-1.4z"/>
                                 </svg>
   </div><div>${linkedin}</div>
           </#if>
       </div>
   </div>

  <div class="container">

    <div class="left-section">

      <#if summary?? && summary?has_content>
      <div class="section">
        <div class="section-title">SUMMARY</div>
        <div class="summary-text">${summary}</div>
      </div>
      </#if>



      <#if skills?? && skills?trim?length gt 0>
      <div class="section">
        <div class="section-title">SKILLS</div>
        <ul>
          <#list skills?split(",") as skill>
            <#if skill?has_content>
              <li>${skill?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>

      <#if certificates?? && certificates?size gt 0>
      <div class="section">
        <div class="section-title">CERTIFICATIONS</div>
        <div class="certi-list">
            <ul>
              <#list certificates as cert>
                <#if cert.courseName?? && cert.courseName?has_content>
                  <li>${cert.courseName}
                  <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
                                             ${extractmonth(cert.courseStartDate)}
                                            <#if cert.courseEndDate?? && cert.courseEndDate?has_content>
                                            &#8211;  ${extractmonth(cert.courseEndDate)}
                                             </#if>
                  </#if>

                  </li>
                </#if>
              </#list>
            </ul>
         </div>
      </div>
      </#if>

      <#if softSkills?? && softSkills?trim?length gt 0>
      <div class="section">
        <div class="section-title">SOFT SKILLS</div>
        <ul>
          <#list softSkills?split(",") as skill>
            <#if skill?has_content>
              <li>${skill?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>

      <#if competencies?? && competencies?trim?length gt 0>
      <div class="section">
        <div class="section-title">CORE COMPETENCIES</div>
        <ul>
          <#list competencies?split(",") as comp>
            <#if comp?has_content>
              <li>${comp?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>

      <#if strengths?? && strengths?trim?length gt 0>
      <div class="section">
        <div class="section-title">STRENGTH</div>
        <ul>
          <#list strengths?split(",") as strength>
            <#if strength?has_content>
              <li>${strength?trim}</li>
            </#if>
          </#list>
        </ul>
      </div>
      </#if>



      <#if hobbies?? && hobbies?trim?length gt 0>
      <div class="section">
        <div class="section-title">HOBBIES</div>
        <ul>
          <#list hobbies?split(",") as hobby>
            <#if hobby?has_content>
              <li>${hobby?trim}</li>
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

            <#if addAdditionalDetails??  &&  addAdditionalDetails && hasCollegeProjects>
            <div class="section">
              <div class="section-title">PERSONAL DETAILS</div>

              <#if fatherName??><div>Father’s Name: ${fatherName}</div></#if>
              <#if gender??><div>Gender: ${gender}</div></#if>
              <#if dob??><div>Date of Birth: ${extractDobYear(dob)}</div></#if>
              <#if nationality??><div>Nationality: ${nationality}</div></#if>
      	   <#if languagesKnown?? && languagesKnown?has_content>
      	   <div>Languages Known:  ${languagesKnown?replace(",", ", ")}</div>
      	   </#if>
      	      <#if address?? && address?has_content><div>Address: ${address}</div></#if>
      		 <#if maritalStatus?? && maritalStatus?has_content><div>Marital Status: ${maritalStatus}</div></#if>
            </div>
            </#if>


    </div>

    <!-- ================= RIGHT SECTION ================= -->
    <div class="right-section">

      <#if objective?? && objective?has_content>
      <div class="section">
        <div class="section-title">OBJECTIVE</div>
        <div class="summary-text">${objective}</div>
      </div>
      </#if>

        <#if education?? && education?size gt 0>
            <div class="section">
              <div class="section-title">EDUCATION</div>

              <#list education as edu>
              <div class="edu-item">
                <#if edu.institutionName?? && edu.institutionName?has_content>
                  <div class="sub-section-title">${edu.institutionName}</div>
                </#if>

                <div class="education-sub-details">
                  <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                    <div>${edu.fieldOfStudy}

                    <#if edu.percentage?? && edu.percentage?has_content>
                                                              &#8211; ${edu.percentage}%
                                              </#if>

                    </div>

                      <#else>
                        <#if edu.percentage?? && edu.percentage?has_content>
                                          <div> ${edu.percentage}%</div>
                          </#if>
                  </#if>

                  <#if edu.department?? && edu.department?has_content>
                    <div>${edu.department} </div>

                   </#if>



                  <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                    <div>
                      (${extractmonth(edu.qualificationStartYear)}  &#8211;
                      <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                        ${extractmonth(edu.qualificationEndYear)}
                      <#else>
                        Present
                      </#if>)
                    </div>
                  </#if>
                </div>
              </div>
              </#list>
            </div>
            </#if>

      <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <div class="section-title">PROFESSIONAL EXPERIENCE</div>

        <#list experiences as exp>
        <div class="exp-item">

          <#if exp.role?? && exp.role?has_content>
            <div class="exp-role">${exp.role}</div>
          </#if>

          <#if exp.companyName?? && exp.companyName?has_content>
            <div class="exp-line">
              ${exp.companyName}
              <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                | ${extractmonth(exp.experienceYearStartDate)}  &#8211;
                <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                  ${extractmonth(exp.experienceYearEndDate)}
                <#else>
                  Present
                </#if>
              </#if>
            </div>
          </#if>

          <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
          <ul>
            <#list exp.responsibilities?split(",") as res>
              <#if res?has_content>
                <li>${res?trim}</li>
              </#if>
            </#list>
          </ul>
          </#if>

          <#if exp.projects?? && exp.projects?size gt 0>
          <div class="sub-project-section-title">PROJECTS</div>

          <#list exp.projects as proj>
            <#if proj.projectName?? && proj.projectName?has_content>
              <div class="exp-role">Name: ${proj.projectName}</div>
            </#if>

            <#if proj.projectRole?? && proj.projectRole?has_content>
              <div class="exp-line"><strong>Role:</strong> ${proj.projectRole}</div>
            </#if>

            <#if proj.projectSkills?? && proj.projectSkills?has_content>
              <ul>
                <#list proj.projectSkills?split(",") as skill>
                  <li>${skill?trim}</li>
                </#list>
              </ul>
            </#if>

            <#if proj.projectDescription?? && proj.projectDescription?has_content>
              <strong>Description</strong>
              <ul>
                <li>${proj.projectDescription}</li>
              </ul>
            </#if>
            <br/>
          </#list>
          </#if>

        </div>
        </#list>
      </div>
      </#if>

      <#if collegeProject?? && collegeProject?size gt 0>
      <div class="section">
        <div class="section-title">ACADEMIC PROJECTS</div>

        <#list collegeProject as project>
          <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
            <div class="sub-project-section-title">${project.collegeProjectName}</div>
          </#if>

          <#if project.collegeProjectSkills?? && project.collegeProjectSkills?has_content>
            <strong>Skills:</strong>
            <ul>
              <#list project.collegeProjectSkills?split(",") as skill>
                <li>${skill?trim}</li>
              </#list>
            </ul>
          </#if>

          <#if project.collegeProjectDescription?? && project.collegeProjectDescription?has_content>
            <strong>Description:</strong>
            <div class="project-description">${project.collegeProjectDescription}</div>
          </#if>
        </#list>
      </div>
      </#if>

      <#if achievements?? && achievements?size gt 0>
      <div class="section">
        <div class="section-title">ACHIEVEMENTS</div>
         <div class="certi-list">
        <ul>
          <#list achievements as ach>
            <#if ach.achievementsName?? && ach.achievementsName?has_content>
              <li>${ach.achievementsName}</li>
            </#if>
          </#list>
        </ul>
        </div>
      </div>
      </#if>

       <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
            <div class="section">
              <div class="section-title">ExtraCurricular Activities</div>
              <ul>
                <#list extraCurricularActivities?split(",") as hobby>
                  <#if hobby?has_content>
                    <li>${hobby?trim}</li>
                  </#if>
                </#list>
              </ul>
            </div>
            </#if>

             <#if goals?? && goals?trim?length gt 0>
                  <div class="section">
                    <div class="section-title">GOALS</div>
                    <ul>
                      <#list goals?split(",") as hobby>
                        <#if hobby?has_content>
                          <li>${hobby?trim}</li>
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

      <#if addAdditionalDetails??  &&  addAdditionalDetails && !hasCollegeProjects>
      <div class="section">
        <div class="section-title">PERSONAL DETAILS</div>

        <#if fatherName??><div>Father’s Name: ${fatherName}</div></#if>
        <#if gender??><div>Gender: ${gender}</div></#if>
        <#if dob??><div>Date of Birth: ${extractDobYear(dob)}</div></#if>
        <#if nationality??><div>Nationality: ${nationality}</div></#if>
	   <#if languagesKnown?? && languagesKnown?has_content>
	   <div>Languages Known:  ${languagesKnown?replace(",", ", ")}</div>
	   </#if>
	      <#if address?? && address?has_content><div>Address: ${address}</div></#if>
		 <#if maritalStatus?? && maritalStatus?has_content><div>Marital Status: ${maritalStatus}</div></#if>
      </div>
      </#if>

    </div>
  </div>

</body>

</html>
