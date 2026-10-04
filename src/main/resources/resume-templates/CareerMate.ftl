<!DOCTYPE html>
<html>

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="UTF-8" />
  <@fonts.loadFonts />


  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet">

  <style>

    @page {
      size: A4;
      margin-top: 30px;
      margin-bottom: 10px;
      margin-left: 10px;
      margin-right: 10px;
    }

    html,
    body {
      margin: 0;
      padding: 0;
      font-family: $ {(style.primaryFont) !'PT Serif'};
      font-size: $ {(style.bodySize)!'12pt'};
      line-height: $ {(style.lineSpacing)!'1.4'};
      color: $ {(style.bodyColor)!'#000000'};
      background: white;
    }

    .container {
      width: 210mm;
      padding: 7mm;
      margin: auto;
      box-sizing: border-box;
      position: relative;
      overflow-wrap:break-word;
      word-break:break-word;
    }
    .header {
      margin-bottom: 18px;
    }

    .name {
      font-size: $ {(style.nameSize)!'28pt'};
      font-weight: $ {(style.fontWeightname)!'800'};
      margin: 0 0 6px 0;
      color: $ {(style.nameColor)!'#1f2933'} ;
    }

    .subtitle {
      font-size: 14px ;
      color: #444;
      margin: 0 0 14px 0;
    }


    .contact-block {
      margin-bottom: 18px;
    }

    .contact-item {
      display: flex;
      align-items: flex-start;
      gap: 10px;
      margin-bottom: 8px;
      color: #333;


    }

    .contact-icon {
      width: 18px;
      height: 18px;
      min-width: 18px;
      display: inline-block;
      margin-top: 2px;
    }


    .section {
      margin-top: 22px;
    }


    .section-header {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 8px;
    }

    .section-icon-box {
      width: 34px;
      height: 34px;
      background: #2f3b45;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 4px;
      flex: 0 0 34px;
    }

    .section-icon-box svg {
      width: 18px;
      height: 18px;
      fill: #fff;
    }

    .section-title {
      font-size: $ {(style.sectionTitleSize)!'15pt'};
      font-weight: $ {(style.fontWeightHeading)!'600'} ;
      color: $ {(style.headingColor)!'#111827'} ;
      margin: 0;
      padding-bottom: 6px;
      border-bottom: 1px solid #d1d5db;
      width: 100%;
    }


    .experience-item {
      display: grid;
      grid-template-columns: 110px 1fr;
      gap: 16px;
      margin-top: 12px;
      align-items: start;
      border-bottom: 2px solid #d1d5db;
    }

    .exp-date {
      font-weight: 700;
      font-size: 15px;
      color: #1f2933;
      padding-top: 2px;
    }

    .job-block {}

    .job-title {
      font-weight: 700;
      font-size: 14px;
      margin: 0 0 4px 0;
      color: #111827;
    }

    .company {
      font-style: italic;
      margin-bottom: 8px;
      font-size: 14px;
    }


    .bullets {
      margin: 0 0 8px 18px;
      padding: 0;
      list-style: disc;
      color: #333;
    }

    .bullets li {
      margin-bottom: 6px;
    }


    .edu-item {
      display: grid;
      grid-template-columns: 130px 1fr;
      gap: 16px;
      margin-top: 12px;
      font-size: 12pt;
    }

    .edu-degree {

      margin-bottom: 6px;
      color: #111827;
    }

    .edu-details {

      color: #333;
    }


    .project-block {
      margin-top: 8px;
      margin-bottom: 8px;
      font-size: 12pt;
      color: #333;
      line-height: 1.3;
    }

    .education-details {
      line-height: 1.5;
    }


    .simple-list {
      margin-left: 18px;
    }


    .detail-item {
      margin-bottom: 6px;
      color: #333;
    }


    .muted {
      color: #6b7280;
      font-size: 12px;
    }




    .sub-section-title {
      font-size: 13pt;
      font-weight: 600;
      margin-top: 15px;
      text-decoration: underline;
      text-underline-offset: 3px;

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

    <!-- ================= HEADER ================= -->
    <div class="header">

        <#if name?? && name?has_content>
            <div class="name">${name}</div>
        </#if>

        <#if subtitle?? && subtitle?has_content>
            <div class="subtitle">${subtitle}</div>
        </#if>

        <div class="contact-block">

            <#if location?? && location?has_content>
                <div class="contact-item"><div><svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    style="vertical-align:middle; margin-right:6px;">
                                                 <path d="M12 2C8.1 2 5 5.1 5 9c0 5.2 7 13 7 13s7-7.8 7-13
                                                          c0-3.9-3.1-7-7-7zm0 9.5
                                                          c-1.4 0-2.5-1.1-2.5-2.5S10.6 6.5 12 6.5
                                                          14.5 7.6 14.5 9 13.4 11.5 12 11.5z"/>
                                               </svg>
                ${location}</div></div>
            </#if>

           <#if phone?? && phone?has_content>
             <div class="contact-item">
               <svg width="14" height="14"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                    style="vertical-align:middle; margin-right:6px;"
                    fill="#2F3136">
                 <path d="M6.6 10.8c1.5 3 4.1 5.6 7.1 7.1l2.4-2.4
                          c.3-.3.7-.4 1.1-.3 1.2.4 2.6.6 4 .6
                          .6 0 1 .4 1 1V21
                          c0 .6-.4 1-1 1
                          C10.5 22 2 13.5 2 3
                          c0-.6.4-1 1-1h4.1
                          c.6 0 1 .4 1 1
                          0 1.4.2 2.8.6 4
                          .1.4 0 .8-.3 1.1L6.6 10.8z"/>
               </svg>
               ${phone}
             </div>
           </#if>

            <#if email?? && email?has_content>
                <div class="contact-item"><div><svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"
                                                    xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle; margin-right:6px;">
                                                 <path d="M20 4H4c-1.1 0-2 .9-2 2v12
                                                          c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6
                                                          c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6
                                                          l8 5 8-5v2z"/>
                                               </svg>
 ${email}</div></div>
            </#if>

            <#if linkedin?? && linkedin?has_content>
                <div class="contact-item"><div><svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    style="vertical-align:middle; margin-right:6px;">
                                                 <path d="M4.98 3.5C4.98 4.88 3.88 6 2.5 6S0 4.88 0 3.5
                                                          1.12 1 2.5 1 4.98 2.12 4.98 3.5zM0 8h5v16H0V8zm7.5 0h4.8v2.2h.07
                                                          c.67-1.27 2.3-2.6 4.73-2.6C21.1 7.6 24 10.1 24 15.1V24h-5v-7.8
                                                          c0-1.9-.03-4.3-2.7-4.3-2.7 0-3.1 2.1-3.1 4.1V24h-5V8z"/>
                                               </svg>

 <a href="${linkedin}" target="_blank">${linkedin}</a></div></div>
            </#if>

        </div>
    </div>


    <!-- ================= SUMMARY ================= -->
    <#if summary?? && summary?has_content>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box">
                    <svg viewBox="0 0 24 24"><path d="M18 2H6a2 2 0 00-2 2v16l4-2 4 2 4-2 4 2V4a2 2 0 00-2-2z" /></svg>
                </div>
                <div class="section-title">Professional Summary</div>
            </div>
            <p>${summary}</p>
        </div>
    </#if>

     <#if objective?? && objective?has_content>
            <div class="section">
                <div class="section-header">
                    <div class="section-icon-box">
                        <svg viewBox="0 0 24 24"><path d="M18 2H6a2 2 0 00-2 2v16l4-2 4 2 4-2 4 2V4a2 2 0 00-2-2z" /></svg>
                    </div>
                    <div class="section-title">Objective</div>
                </div>
                <p>${objective}</p>
            </div>
        </#if>



    <!-- ================= EXPERIENCE ================= -->
    <#if experiences?? && experiences?size gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box">
                    <svg viewBox="0 0 24 24"><path d="M14 4V3a2 2 0 00-2-2h-4a2 2 0 00-2 2v1H3v16h18V4h-7z"/></svg>
                </div>
                <div class="section-title">Work Experience</div>
            </div>

            <#list experiences as exp>
                <div class="experience-item">

                    <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                        <div class="exp-date">
                            ${extractmonth(exp.experienceYearStartDate)}
                            <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                                 &#8211; ${extractmonth(exp.experienceYearEndDate)}
                            <#else>
                                 &#8211; Present
                            </#if>
                        </div>

                         <#else>
                         <div> &#8211; </div>
                    </#if>

                    <div class="job-block">
                        <#if exp.role?? && exp.role?has_content>
                            <div class="job-title">${exp.role}</div>
                        </#if>

                        <#if exp.companyName?? && exp.companyName?has_content>
                            <div class="company">${exp.companyName}</div>
                        </#if>

                        <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
                            <ul class="bullets">
                                <#list exp.responsibilities?split(",") as item>
                                    <#if item?trim?has_content><li>${item?trim}</li></#if>
                                </#list>
                            </ul>
                        </#if>

                        <#if exp.projects?? && exp.projects?size gt 0>
                            <div class="sub-section-title">Projects</div>

                            <#list exp.projects as proj>
                                <div class="project-block">

                                    <#if proj.projectName?? && proj.projectName?has_content>
                                        <div><strong>Name:</strong> ${proj.projectName}</div>
                                    </#if>

                                    <#if proj.projectSkills?? && proj.projectSkills?has_content>
                                        <div><strong>Skills:</strong>
                                            <#list proj.projectSkills?split(",") as s>${s?trim}<#if s_has_next>, </#if></#list>
                                        </div>
                                    </#if>

                                    <#if proj.projectRole?? && proj.projectRole?has_content>
                                        <div><strong>Role:</strong> ${proj.projectRole}</div>
                                    </#if>

                                    <#if proj.projectDescription?? && proj.projectDescription?has_content>
                                        <div><strong>Description:</strong> ${proj.projectDescription}</div>
                                    </#if>

                                </div>
                            </#list>
                        </#if>

                    </div>
                </div>
            </#list>
        </div>
    </#if>



    <!-- ================= COLLEGE / ACADEMIC PROJECT ================= -->
    <#if collegeProject?? && collegeProject?size gt 0>
           <div class="section">
               <div class="section-header">
                   <div class="section-icon-box">
                       <svg viewBox="0 0 24 24"><path d="M14 4V3a2 2 0 00-2-2h-4a2 2 0 00-2 2v1H3v16h18V4h-7z"/></svg>
                   </div>
                   <div class="section-title">Academic Project</div>
               </div>

               <#list collegeProject as cp>
                   <div class="experience-item">

                   <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
                                <div class="job-title">${cp.collegeProjectName}</div>
                           </#if>
                               <div class="job-block">


                            <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?has_content>
                                           <div class="company">
                                          <strong>Skills:</strong>
                                           <#list cp.collegeProjectSkills?split(",") as skill>
                                            ${skill?trim}<#if skill_has_next>,</#if>

                                            </#list>

                                            </div>
                                       </#if>

                           <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
                              <strong>Description:</strong>
                               <ul class="bullets">
                                   <#list cp.collegeProjectDescription?split(",") as p>
                                       <#if p?trim?has_content><li>${p?trim}</li></#if>
                                   </#list>
                               </ul>
                           </#if>

                        </div>
                   </div>
               </#list>
           </div>
       </#if>


    <!-- ================= EDUCATION ================= -->
    <#if education?? && education?size gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box">
                    <svg viewBox="0 0 24 24"><path d="M12 2L1 7l11 5 9-4.09V17h2V7z"/></svg>
                </div>
                <div class="section-title">Education</div>
            </div>

            <#list education as edu>
                <div class="edu-item">
                    <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                        <div class="exp-date">
                            ${extractmonth(edu.qualificationStartYear)}
                            <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                                 &#8211; ${extractmonth(edu.qualificationEndYear)}
                            </#if>
                        </div>

                        <#else>
                          <div> &#8211; </div>
                    </#if>

                    <div class="education-details">
                        <#if edu.department?has_content>
                            <div class="edu-degree"><strong>${edu.department}</strong></div>
                        </#if>

                        <#if edu.institutionName?? && edu.institutionName?has_content>
                            <div class="edu-school">${edu.institutionName}</div>
                        </#if>


                        <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                            <div class="edu-school">${edu.fieldOfStudy}</div>
                        </#if>

                        <#if edu.percentage?? && edu.percentage?has_content>
                            <div class="edu-details">${edu.percentage}%</div>
                        </#if>
                    </div>

                </div>
            </#list>
        </div>
    </#if>



    <!-- ================= SKILLS ================= -->
    <#if skills?? && skills?trim?length gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M4 10h4v2H4v-2zm0-6h16v2H4V4zm0 12h10v2H4v-2z"/></svg></div>
                <div class="section-title">Skills</div>
            </div>
            <ul class="bullets">
                <#list skills?split(",") as sk>
                    <#if sk?trim?has_content><li>${sk?trim}</li></#if>
                </#list>
            </ul>
        </div>
    </#if>


    <!-- ================= SOFT SKILLS ================= -->
    <#if softSkills?? && softSkills?trim?length gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M4 10h4v2H4v-2zm0-6h16v2H4V4zm0 12h10v2H4v-2z"/></svg></div>
                <div class="section-title">Soft Skills</div>
            </div>
            <ul class="bullets">
                <#list softSkills?split(",") as ss>
                    <#if ss?trim?has_content><li>${ss?trim}</li></#if>
                </#list>
            </ul>
        </div>
    </#if>


    <!-- ================= CORE COMPETENCIES ================= -->
    <#if competencies?? && competencies?trim?length gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M4 10h4v2H4v-2zm0-6h16v2H4V4zm0 12h10v2H4v-2z"/></svg></div>
                <div class="section-title">Core Competencies</div>
            </div>
            <ul class="bullets">
                <#list competencies?split(",") as c>
                    <#if c?trim?has_content><li>${c?trim}</li></#if>
                </#list>
            </ul>
        </div>
    </#if>



    <!-- ================= CERTIFICATIONS ================= -->
    <#if certificates?? && certificates?size gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M12 2L4 6v13a1 1 0 001 1h14a1 1 0 001-1V6l-8-4z"/></svg></div>
                <div class="section-title">Certifications</div>
            </div>

            <ul class="bullets">
                <#list certificates as certi>
                  <#if certi.courseName?? && certi.courseName?has_content>
                    <li>
                        ${certi.courseName}
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



    <!-- ================= ACHIEVEMENTS ================= -->
    <#if achievements?? && achievements?size gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M18 2h-3V1h-6v1H6a1 1 0 00-1 1v3a5 5 0 005 5h2a5 5 0 005-5V4a1 1 0 00-1-1z"/></svg></div>
                <div class="section-title">Achievements</div>
            </div>
            <ul class="bullets">
                <#list achievements as ach>
                    <li>
                        ${ach.achievementsName}
                        <#if ach.achievementsDate?? && ach.achievementsDate?has_content>
                             &#8211; ${extractmonth(ach.achievementsDate)}
                        </#if>
                    </li>
                </#list>
            </ul>
        </div>
    </#if>



    <!-- ================= EXTRA CURRICULAR ================= -->
    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M12 2l3 7h7l-5.5 4.5L20 22l-8-5-8 5 2.5-8.5L1 9h7z" /></svg></div>
                <div class="section-title">Extracurricular Activities</div>
            </div>
            <ul class="bullets">
                <#list extraCurricularActivities?split(",") as ex>
                    <#if ex?trim?has_content><li>${ex?trim}</li></#if>
                </#list>
            </ul>
        </div>
    </#if>



    <!-- ================= GOALS ================= -->
    <#if goals?? && goals?trim?length gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M12 2a10 10 0 100 20 10 10 0 000-20z"/></svg></div>
                <div class="section-title">Goals</div>
            </div>
            <ul class="bullets">
                <#list goals?split(",") as goal>
                    <#if goal?trim?has_content><li>${goal?trim}</li></#if>
                </#list>
            </ul>
        </div>
    </#if>



    <!-- ================= HOBBIES ================= -->
    <#if hobbies?? && hobbies?trim?length gt 0>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M12 2a10 10 0 100 20 10 10 0 000-20z"/></svg></div>
                <div class="section-title">Hobbies</div>
            </div>
            <ul class="bullets">
                <#list hobbies?split(",") as hb>
                    <#if hb?trim?has_content><li>${hb?trim}</li></#if>
                </#list>
            </ul>
        </div>
    </#if>



    <!-- ================= PERSONAL DETAILS ================= -->
    <#if addAdditionalDetails?? && addAdditionalDetails>
        <div class="section">
            <div class="section-header">
                <div class="section-icon-box"><svg viewBox="0 0 24 24"><path d="M12 12a5 5 0 000-10 5 5 0 000 10zm0 2c-5 0-9 2.5-9 5.5V22h18v-2.5c0-3-4-5.5-9-5.5z"/></svg></div>
                <div class="section-title">Personal Details</div>
            </div>

			<#if fatherName?? && fatherName?has_content>
                <div class="detail-item"><strong>Father Name:</strong> ${fatherName}</div>
            </#if>

            <#if dob?? && dob?has_content>
                <div class="detail-item"><strong>Date of Birth:</strong> ${extractDobYear(dob)}</div>
            </#if>

            <#if gender?? && gender?has_content>
                <div class="detail-item"><strong>Gender:</strong> ${gender}</div>
            </#if>

            <#if nationality?? && nationality?has_content>
                <div class="detail-item"><strong>Nationality:</strong> ${nationality}</div>
            </#if>

            <#if languagesKnown?? && languagesKnown?has_content>
                <div class="detail-item"><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</div>
            </#if>

            <#if address?? && address?has_content>
                <div class="detail-item"><strong>Address:</strong> ${address}</div>
            </#if>

			 <#if maritalStatus?? && maritalStatus?has_content>
                <div class="detail-item"><strong>Martial Status:</strong> ${maritalStatus}</div>
            </#if>

        </div>
    </#if>

</div>
</body>
</html>