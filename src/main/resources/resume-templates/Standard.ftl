
<!DOCTYPE html>
<html>

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


        html,
        body {
            margin: 0;
            padding: 0;
            font-family: ${(style.primaryFont)!'Poppins'};
            font-size: ${((style.bodySize))!'12pt'};
            line-height: ${(style.lineSpacing)!'1.2'};
            color: ${(style.bodyColor)!'#333'};
        }


        .container {
            margin: 0 auto;
            padding: 0;
            width: 210mm;
            display: grid;
            grid-template-columns: 34% 66%;
        }


        .left-section {
            background: lightblue;
            padding: 0;
            position: relative;
        }

        /* TOP IMAGE FIX */
        .profile-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background: #d9d9d9;
            display: block;
        }

        /* NAME BLOCK FIX */
        .name-block {
            background: rgba(0, 0, 0, 0.25);
            padding: 10px 10px;
        }

        .name {
            font-size: ${(style.nameSize)!'23pt'};
            font-weight: ${((style.fontWeightname))!'800'};
           color: ${(style.nameColor)!'#111'};
            line-height: 1.1;
            margin-bottom: 4px;
        }

        .role {
            font-size: 12pt;
            opacity: 0.9;
        }


        .sidebar-section {
            padding: 2px 5px;
            margin-top: 4px;

        }

        .sidebar-title {
           font-size: ${(style.sectionTitleSize)!'14pt'};
            font-weight: ${(style.fontWeightHeading)!'700'};
            color: ${(style.headingColor)!'#0e7ac4'};
            text-transform: uppercase;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }

        .sidebar-text {

            margin-bottom: 8px;

        }

        .skill-line {
            display: flex;
            align-items: center;
            margin-bottom: 5px;

        }

        .skill-square {
            width: 5px;
            height: 5px;
            background: black;
            margin-right: 6px;
            border-radius: 50px;
        }

        /* =========================================================
   RIGHT SECTION
========================================================= */

        .right-section {
            padding: 30px 26px;
        }

        .section {
            margin-bottom: 26px;
        }

        .section-title {
            font-size: 13pt;
            font-weight: 700;
            color: #0e7ac4;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .line {
            height: 2px;
            background: #0e7ac4;
            margin-bottom: 5px;
        }

        .years {

            color: #0e7ac4;
        }

        /* ===== EXPERIENCE ===== */
        .exp-item {
            margin-bottom: 18px;
            border-bottom: 1px solid lightblue;
        }

        .exp-role {
            font-weight: 700;
            font-size: 12pt;
        }

        .exp-company {
            font-size: 11pt;
            margin-bottom: 4px;
        }

        .exp-dates {
            float: right;
            font-weight: 600;
            color: #0e7ac4;
        }

        .bullets {
            margin-left: 18px;
        }

        .bullets li {
            margin-bottom: 4px;
        }

        /* ===== PROJECTS ===== */
        .project-title {
            margin-top: 10px;
            font-weight: 700;
        }

        .project-item {
            margin-left: 18px;
            font-size: 11pt;
            margin: 3px 0px;
        }

        /* ===== EDUCATION ===== */
        .edu-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            line-height: 1.5;
        }

        .edu-degree {
            font-weight: 700;

        }

        .edu-fileds {
            line-height: 1.3;
        }

        .edu-years {

            font-weight: 600;
            color: #0e7ac4;
        }

        /* ===== CERTIFICATION ===== */
        .cert-item {
            margin-bottom: 6px;
            display: flex;
            align-items: center;
        }

        .certi-role {
            margin-bottom: 6px;
            font-weight: 500;

        }


        .cert-dot {
            width: 8px;
            height: 8px;
            background: #0e7ac4;
            border-radius: 50%;
            margin-right: 8px;
        }

        .contact-item,
        .cert-item,
        .skill-item {
            font-size: 12pt;
            margin-bottom: 6px;
        }

        .exp-dec {
            line-height: 1.3;
            margin: 5px 0px;
        }

        .project-block {
            margin: 5px 0px;
            border-bottom: 1px solid lightblue;
        }

        .project-skill-line{
               margin-top:5px;
               margin-bottom: 5px;
        }

        .contact-item{
         word-break:break-word;
         overflow-wrap:break-word;
        }

         .left-bg {
           position: fixed;
           top: 0;
           left: 0;
           width: 34%;
           height: 100vh;
           background: lightblue;
           z-index: -1;
         }

         .certi-list{
                 overflow-wrap:break-word;
                 word-break:break-word;
               }

    </style>
</head>

<body>
<div class="left-bg"></div>


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

           <#if profileImage?? && profileImage?has_content>
			  <img class="profile-img" src="${profileImage}" />
			</#if>


            <div class="name-block">
                <#if name?? && name?has_content>
                <div class="name">${name}</div>
                </#if>

                <#if role?? && role?has_content>
                <div class="role">${role}</div>
                </#if>
            </div>




            <div class="sidebar-section">
                <div class="sidebar-title">Contact</div>

                <#if phone?? && phone?has_content>
                <div class="contact-item">${phone}</div>
                </#if>

                <#if email?? && email?has_content>
                <div class="contact-item">${email}</div>
                </#if>

				<#if linkedin?? && linkedin?has_content>
                <div class="contact-item">${linkedin}</div>
                </#if>

                <#if location?? && location?has_content>
                <div class="contact-item"> ${location}</div>
                </#if>



            </div>



            <!-- SKILLS -->


            <!-- SOFT SKILLS -->
            <#if softSkills?? && softSkills?trim?length gt 0>
            <div class="sidebar-section">
                <div class="sidebar-title">Soft Skills</div>

                <#list softSkills?split(",") as ss>
                    <#if ss?has_content>
                    <div class="skill-line">
                        <div class="skill-square"></div>${ss?trim}
                    </div>
                    </#if>
                </#list>

            </div>
            </#if>


            <!-- STRENGTHS -->
            <#if strengths?? && strengths?trim?length gt 0>
            <div class="sidebar-section">
                <div class="sidebar-title">Strenghts</div>

                <#list strengths?split(",") as st>
                    <#if st?has_content>
                    <div class="skill-line">${st?trim}</div>
                    </#if>
                </#list>

            </div>
            </#if>

               <#if competencies?? && competencies?trim?length gt 0>
                        <div class="section">
                            <div class="sidebar-title">Core Competencies</div>

                            <#list competencies?split(",") as cmp>
                                <#if cmp?has_content>
                                <div class="skill-line">${cmp?trim}</div>
                                </#if>
                            </#list>

                        </div>
                        </#if>


            <!-- GOALS -->
            <#if goals?? && goals?trim?length gt 0>
            <div class="sidebar-section">
                <div class="sidebar-title">Goals</div>

                <#list goals?split(",") as gl>
                    <#if gl?has_content>
                    <div class="skill-line">${gl?trim}</div>
                    </#if>
                </#list>

            </div>
            </#if>


            <!-- EXTRA CIRCULAR ACTIVITES -->
            <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
            <div class="sidebar-section">
                <div class="sidebar-title">Extracurricular  Activities</div>

                <#list extraCurricularActivities?split(",") as ex>
                    <#if ex?has_content>
                    <div class="skill-line">${ex?trim}</div>
                    </#if>
                </#list>

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



            <#if addAdditionalDetails && hasCollegeProjects>
            <div class="sidebar-section">
                <div class="sidebar-title">Personal Details</div>

                <#if fatherName?? && fatherName?has_content>
                <div class="skill-line"><strong>Father Name: </strong> ${fatherName}</div>
                </#if>

                <#if gender?? && gender?has_content>
                <div class="skill-line"><strong>Gender: </strong> ${gender}</div>
                </#if>

                <#if dob?? && dob?has_content>
                <div class="skill-line"><strong>DOB: </strong> ${extractDobYear(dob)}</div>
                </#if>

                <#if nationality?? && nationality?has_content>
                <div class="skill-line"><strong>Nationality: </strong> ${nationality}</div>
                </#if>


				  <#if languagesKnown?? && languagesKnown?has_content>
					<div class="skill-line"><strong>Languages:</strong> ${languagesKnown?replace(",", ", ")}</div>
				  </#if>


				  <#if address?? && address?has_content>
					<div class="skill-line"><strong>Address</strong> - ${address}</div>
				  </#if>


                <#if maritalStatus?? && maritalStatus?has_content>
                <div class="skill-line"><strong>Martial Status: </strong> ${maritalStatus}</div>
                </#if>



            </div>
            </#if>

        </div>

        <!-- ================= RIGHT SECTION ================= -->
        <div class="right-section">

            <!-- SUMMARY -->
            <#if summary?? && summary?has_content>
            <div class="section">
                <div class="sidebar-title">Summary</div>
                <div class="sidebar-text">${summary}</div>
            </div>
            </#if>

             <#if objective?? && objective?has_content>
                <div class="section">
                    <div class="sidebar-title">Objective</div>
                    <div class="sidebar-text">${objective}</div>
                </div>
                </#if>

                 <#if skills?? && skills?trim?length gt 0>
                       <div class="sidebar-section">
                           <div class="sidebar-title">Skills</div>

                           <#list skills?split(",") as sk>
                               <#if sk?? && sk?has_content>
                               <div class="skill-line">
                                   <div class="skill-square"></div>${sk?trim}
                               </div>
                               </#if>
                           </#list>

                       </div>
                       </#if>



            <!-- EXPERIENCE -->
            <#if experiences?? && experiences?size gt 0>
            <div class="section">
                <div class="section-title">
                    Experience
                </div>
                <div class="line"></div>

                <#list experiences as exp>
                <div class="exp-item">

                    <#if exp.role?? && exp.role?has_content>
                    <div class="exp-role">
                        ${exp.role}
                        <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                        <span class="exp-dates">
                            ${extractmonth(exp.experienceYearStartDate)}
                            <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                                 &#8211; ${extractmonth(exp.experienceYearEndDate)}
                            <#else>
                                 &#8211; Present
                            </#if>
                        </span>
                        </#if>
                    </div>
                    </#if>

                    <#if exp.companyName?? && exp.companyName?has_content>
                    <div class="exp-company">${exp.companyName}</div>
                    </#if>

                    <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
                    <ul class="bullets">
                        <#list exp.responsibilities?split(",") as rs>
                            <#if rs?has_content>
                            <li>${rs?trim}</li>
                            </#if>
                        </#list>
                    </ul>
                    </#if>


                    <!-- EXPERIENCE PROJECTS -->
                    <#if exp.projects?? && exp.projects?size gt 0>
                    <div class="project-title">Projects:</div>

                    <#list exp.projects as prj>
                    <div class="project-block">

                        <#if prj.projectName?? && prj.projectName?has_content>
                        <div class="project-item"><b>Name:</b> ${prj.projectName}</div>
                        </#if>

                        <#if prj.projectRole?? && prj.projectRole?has_content>
                        <div class="project-item"><b>Role:</b> ${prj.projectRole}</div>
                        </#if>

                        <#if prj.projectSkills?? && prj.projectSkills?trim?length gt 0>
                        <div class="project-item"><b>Skills:</b></div>
                        <ul class="bullets">
                            <#list prj.projectSkills?split(",") as skp>
                                <#if skp?has_content>
                                <li>${skp?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                        </#if>

                        <#if prj.projectDescription?? && prj.projectDescription?has_content>
                        <strong>Description:</strong>
                        <ul class="bullets">
                            <#list prj.projectDescription?split(",") as pdesc>
                                <#if pdesc?has_content>
                                <li>${pdesc?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                        </#if>

                    </div>
                    </#list>
                    </#if>

                </div>
                </#list>

            </div>
            </#if>


            <!-- EDUCATION -->
            <#if education?? && education?size gt 0>
            <div class="section">
                <div class="section-title">Education</div>
                <div class="line"></div>

                <#list education as edu>
                <div class="edu-item">

                    <div>
                        <#if edu.department?? && edu.department?has_content>
                        <div class="edu-degree">${edu.department}</div>
                        </#if>

                        <#if edu.institutionName?? && edu.institutionName?has_content>
                        <div class="edu-fileds">${edu.institutionName}</div>
                        </#if>

						<#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                        <div class="edu-fileds">${edu.fieldOfStudy}

						<#if edu.percentage?? && edu.percentage?has_content>
                           &#8208; ${edu.percentage}%
                        </#if>
						</div>

						<#else>
						<#if edu.percentage?? && edu.percentage?has_content>
                                                   &#8208; ${edu.percentage}%
                                                </#if>
                        </#if>


                    </div>

                    <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                    <div class="edu-years">
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


            <!-- ACADEMIC PROJECTS -->
            <#if collegeProject?? && collegeProject?size gt 0>
            <div class="section">
                <div class="section-title">Academic Projects</div>
                <div class="line"></div>

                <#list collegeProject as cp>
                <div class="exp-item">

                    <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
                    <div class="exp-role">Name: ${cp.collegeProjectName}</div>
                    </#if>
                    </br>

                    <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
                    <strong>Skills:</strong>
                    <#list cp.collegeProjectSkills?split(",") as csk>
                        <#if csk?has_content>
                        <div class="project-skill-line">${csk?trim}</div>
                        </#if>
                    </#list>
                    </#if>

                    <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?trim?length gt 0>
                    <div class="exp-dec"><strong>Description:</strong> ${cp.collegeProjectDescription}</div>
                    </#if>

                </div>
                </#list>

            </div>
            </#if>


            <!-- CERTIFICATION -->
           <#if certificates?? && certificates?size gt 0>
             <div class="section">
               <div class="section-title">Certification</div>
               <div class="line"></div>

               <div class="certi-list">
                 <#list certificates as ct>
                   <#if ct.courseName?? && ct.courseName?has_content>
                     <div class="certi-role">
                       ${ct.courseName}

                       <#if ct.courseStartDate?? && ct.courseStartDate?has_content>
                         <span class="exp-dates">
                           ${extractmonth(ct.courseStartDate)}
                           <#if ct.courseEndDate?? && ct.courseEndDate?has_content>
                             &#8211; ${extractmonth(ct.courseEndDate)}
                           </#if>
                         </span>
                       </#if>

                     </div>
                   </#if>
                 </#list>
               </div>

             </div>
           </#if>



            <!-- ACHIEVEMENTS -->
            <#if achievements?? && achievements?size gt 0>
            <div class="section">
                <div class="section-title">Achivements</div>
                <div class="line"></div>
        <div class="certi-list">
                <#list achievements as ac>
                    <#if ac.achievementsName?? && ac.achievementsName?has_content>
                    <div class="certi-role">
                        ${ac.achievementsName}
                        <#if ac.achievementsDate?? && ac.achievementsDate?has_content>
                        <span class="exp-dates">${extractmonth(ac.achievementsDate)}</span>
                        </#if>
                    </div>
                    </#if>
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



                        <#if addAdditionalDetails && !hasCollegeProjects>
                        <div class="sidebar-section">
                            <div class="sidebar-title">Personal Details</div>

                            <#if fatherName?? && fatherName?has_content>
                            <div class="skill-line"><strong>Father Name: </strong> ${fatherName}</div>
                            </#if>

                            <#if gender?? && gender?has_content>
                            <div class="skill-line"><strong>Gender: </strong> ${gender}</div>
                            </#if>

                            <#if dob?? && dob?has_content>
                            <div class="skill-line"><strong>DOB: </strong> ${extractDobYear(dob)}</div>
                            </#if>

                            <#if nationality?? && nationality?has_content>
                            <div class="skill-line"><strong>Nationality: </strong> ${nationality}</div>
                            </#if>


            				  <#if languagesKnown?? && languagesKnown?has_content>
            					<div class="skill-line"><strong>Languages:</strong> ${languagesKnown?replace(",", ", ")}</div>
            				  </#if>


            				  <#if address?? && address?has_content>
            					<div class="skill-line"><strong>Address</strong> - ${address}</div>
            				  </#if>


                            <#if maritalStatus?? && maritalStatus?has_content>
                            <div class="skill-line"><strong>Martial Status: </strong> ${maritalStatus}</div>
                            </#if>



                        </div>
                        </#if>


        </div>

    </div>

</body>
