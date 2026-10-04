<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="UTF-8" />
<@fonts.loadFonts />

<style>


 @page:first {
     margin-top: 10px;
   }
   @page {
     size: A4;
     margin-top: 40px;
     margin-bottom: 10px;
     margin-left: 20px;
     margin-right: 20px;
   }

  html, body {
      margin: 0;
      padding: 0;
	   width: 210mm;
      font-family: ${(style.primaryFont)!'Helvetica, Arial, sans-serif'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.3'};
      color: ${(style.bodyColor)!'#000000'};
  }

  .container {
    width: 210mm;
    padding: 10mm;
    margin: auto;
    box-sizing: border-box;
    position: relative;
    overflow-wrap:break-word;
    word-break:break-word;
  }


  .name-title {

      font-size: ${(style.nameSize)!'28pt'};
      font-weight: ${(style.fontWeightname)!'700'};
      text-align: center;
      margin-bottom: 5px;
      color: ${(style.nameColor)!'#000000'};
  }

  .subtitle {
      text-align: center;
      font-size: 12pt;
      margin-bottom: 6px;
  }

  .contact {
      text-align: center;
      font-size:12pt;
      color: #333;
      margin-bottom: 20px;
  }


  .section-title {
      font-size: ${(style.sectionTitleSize)!'15pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
      margin-top: 10px;
      margin-bottom: 8px;
      border-bottom: 1px solid #000;
      padding-bottom: 4px;
  }

  /* TWO COLUMN LAYOUT (ONLY FOR SKILLS + CERTIFICATIONS) */
  .two-column {

      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
  }


  .job-title {
      font-size: 12pt;
      font-weight: 700;
      margin-bottom: 2px;
  }

  .company-location {

      margin-bottom: 2px;
  }

  .job-dates {

      color: #333;
      margin-bottom: 6px;
  }

  .bullets {
      margin-left: 18px;
      margin-bottom: 12px;
  }

  .bullets li {
      margin-bottom: 4px;
  }


  .project-block {
      margin-left: 12px;
      margin-bottom: 10px;
  }


  .tag {
      background: #e8e8e8;
      padding: 4px 8px;
      border-radius: 4px;
      display: inline-block;
      margin: 3px;
      font-size: 12pt;
  }


  .detail-item {
      margin-bottom: 5px;
  }
  .org-location{
    display:flex;
    justify-content:space-between;

    margin-bottom:4px;
  }

   .projectsection {
    margin-top:8px;
	margin-bottom:8px;
    padding-left:6px;
	line-height:1.5;

  }

   .experience-row{
    border-bottom:1px dashed #1d1d1f;
	margin-top:7px;
  }


   .educationsection {
    margin-top:8px;
	margin-bottom:8px;

	line-height:1.5;

  }

  p{
   line-height:1.3;
  }

  .project-subheading{
       font-weight:700;
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


    <#if name?? && name?has_content>
        <div class="name-title">${name}</div>
    </#if>

    <#if subtitle?? && subtitle?has_content>
        <div class="subtitle">${subtitle}</div>
    </#if>

    <div class="contact">
        <#if location?? && location?has_content>
            ${location}
        </#if>

        <#if email?? && email?has_content>
            <#if location?? && location?has_content> | </#if>
            ${email}
        </#if>

        <#if phone?? && phone?has_content>
            <#if (location?? && location?has_content) || (email?? && email?has_content)> | </#if>
            ${phone}
        </#if>

        <#if linkedin?? && linkedin?has_content>
            <#if (location?? && location?has_content) || (email?? && email?has_content) || (phone?? && phone?has_content)> | </#if>
            <a href="${linkedin}" target="_blank">${linkedin}</a>
        </#if>
    </div>

    <!-- PROFESSIONAL SUMMARY -->
    <#if summary?? && summary?has_content>
        <div class="section">
            <div class="section-title">Professional Summary</div>
            <p>${summary}</p>
        </div>
    </#if>

    <!-- OBJECTIVE -->
    <#if objective?? && objective?has_content>
        <div class="section">
            <div class="section-title">Objective</div>
            <p>${objective}</p>
        </div>
    </#if>



    <#if experiences?? && experiences?size gt 0>
        <div class="section">
            <div class="section-title">Work Experience</div>

            <#list experiences as exp>
                <div class="experience-row">

                    <#if exp.role?? && exp.role?has_content>
                        <div class="job-title">${exp.role}</div>
                    </#if>

                    <div class="org-location">
                        <#if exp.companyName?? && exp.companyName?has_content>
                            <div class="job-title">${exp.companyName}</div>
                        </#if>

                        <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                            <div class="job-dates">
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
                            <#list exp.responsibilities?split(",") as item>
                                <#if item?? && item?trim?has_content>
                                    <li>${item?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </#if>

                    <#if exp.projects?? && exp.projects?size gt 0>

                       <div class="project-subheading">Project:</div>
                        <#list exp.projects as proj>
                            <div class="projectsection">
                                <#if proj.projectName?? && proj.projectName?has_content>
                                    <div><strong>Name:</strong> ${proj.projectName}</div>
                                </#if>

                                <#if proj.projectSkills?? && proj.projectSkills?has_content>
                                    <div><strong>Skills:</strong>
                                        <#list proj.projectSkills?split(",") as skill>
                                            ${skill?trim}<#if skill_has_next>, </#if>
                                        </#list>
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
            </#list>
        </div>
    </#if>



    <#if collegeProject?? && collegeProject?size gt 0>
        <div class="section">
            <div class="section-title">Academic Project</div>

            <#list collegeProject as project>
                <div class="projectsection">
                    <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
                        <div class="job-title">${project.collegeProjectName}</div>
                    </#if>

                    <#if project.collegeProjectSkills?? && project.collegeProjectSkills?has_content>
                        <div class="job-title">

						<#list project.collegeProjectSkills?split(",") as skill>
							${skill?trim}<#if skill_has_next>, </#if>
						  </#list>

						</div>
                    </#if>

                    <#if project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>
                        <ul class="bullets">
                            <#list project.collegeProjectDescription?split(",") as item>
                                <#if item?? && item?trim?has_content>
                                    <li>${item?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </#if>
                </div>
            </#list>

        </div>
    </#if>


			<#if education?? && education?size gt 0>
		<div class="section">
			<div class="section-title">Education</div>

			<#list education as edu>
			<div class="educationsection">

				<!-- Degree / Department -->
				<#if edu.department?? && edu.department?has_content>
					<div><strong>${edu.department}</strong></div>
				</#if>

				<!-- Field of Study (Optional) -->
				<#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
					<div>${edu.fieldOfStudy}</div>
				</#if>

				<!-- Institution -->
				<#if edu.institutionName?? && edu.institutionName?has_content>
					<div> ${edu.institutionName}</div>
				</#if>

				<!-- Graduation Year / Range -->
				<#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
					<div>
						Graduated: (
						${extractmonth(edu.qualificationStartYear)}
						<#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
							 &#8211; ${extractmonth(edu.qualificationEndYear)}
						<#else>
							 &#8211; Present
						</#if>
						)
					</div>

				</#if>

			</div>
			</#list>

		</div>
		</#if>




    <#if skills?? && skills?trim?length gt 0>
        <div class="section">

            <div class="section-title">Skills</div>


                <#if skills?? && skills?trim?length gt 0>

                        <ul class="bullets">
                            <#list skills?split(",") as skill>
                                <#if skill?? && skill?trim?has_content>
                                    <li>${skill?trim}</li>
                                </#if>
                            </#list>
                        </ul>

                </#if>

             </div>


    </#if>



    <#if (softSkills?? && softSkills?trim?length gt 0) || (competencies?? && competencies?trim?length gt 0)>
        <div class="section">
            <div class="section-title">Soft Skills & Core Competencies</div>

            <div class="two-column">

                <#if softSkills?? && softSkills?trim?length gt 0>
                    <div>
                        <span style="margin-left:40px"><strong>Soft Skills</strong></span>
                        <ul class="bullets">
                            <#list softSkills?split(",") as s>
                                <#if s?? && s?trim?has_content>
                                    <li>${s?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </div>
                </#if>

                <#if competencies?? && competencies?trim?length gt 0>
                    <div>
                        <span style="margin-left:40px"><strong>Core Competencies</strong></span>
                        <ul class="bullets">
                            <#list competencies?split(",") as c>
                                <#if c?? && c?trim?has_content>
                                    <li>${c?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </div>
                </#if>

            </div>
        </div>
    </#if>



    <#if (extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0) || (hobbies?? && hobbies?trim?length gt 0)>
        <div class="section">
            <div class="section-title">Extra-Curricular Activities & Hobbies</div>
            <div class="two-column">

                <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                    <div>
                        <span style="margin-left:40px"><strong>Extra-Curricular Activities</strong></span>
                        <ul class="bullets">
                            <#list extraCurricularActivities?split(",") as a>
                                <#if a?? && a?trim?has_content>
                                    <li>${a?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </div>
                </#if>

                <#if hobbies?? && hobbies?trim?length gt 0>
                    <div>
                        <span style="margin-left:40px"><strong>Hobbies</strong></span>
                        <ul class="bullets">
                            <#list hobbies?split(",") as h>
                                <#if h?? && h?trim?has_content>
                                    <li>${h?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </div>
                </#if>

            </div>
        </div>
    </#if>



    <#if achievements?? && achievements?size gt 0>
        <div class="section">
            <div class="section-title">Achievements</div>
            <ul class="bullets">
                <#list achievements as achieve>
                    <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                        <li>
                            ${achieve.achievementsName}
                            <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                                 &#8211; ${extractmonth(achieve.achievementsDate)}
                            </#if>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>

        <#if certificates?? && certificates?size gt 0>
            <div class="section">
                <div class="section-title">Certificates</div>
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


    <!-- EXTRA-CURRICULAR ACTIVITIES (SINGLE LIST) -->
    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
        <div class="section">
            <div class="section-title">Extracurricular Activities</div>
            <ul class="bullets">
                <#list extraCurricularActivities?split(",") as e>
                    <#if e?? && e?trim?has_content>
                        <li>${e?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>



    <#if goals?? && goals?trim?length gt 0>
        <div class="section">
            <div class="section-title">Goals</div>
            <ul class="bullets">
                <#list goals?split(",") as g>
                    <#if g?? && g?trim?has_content>
                        <li>${g?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>


    <!-- PERSONAL DETAILS -->
    <#if addAdditionalDetails?? && addAdditionalDetails>
        <div class="section">
            <div class="section-title">Personal Details</div>

            <#if fatherName?? && fatherName?has_content>
                <div class="detail-item"><strong>Father Name:</strong> ${fatherName}</div>
            </#if>

            <#if maritalStatus?? && maritalStatus?has_content>
                <div class="detail-item"><strong>Marital Status:</strong> ${maritalStatus}</div>
            </#if>

            <#if gender?? && gender?has_content>
                <div class="detail-item"><strong>Gender:</strong> ${gender}</div>
            </#if>

            <#if dob?? && dob?has_content>
                <div class="detail-item"><strong>Date of Birth:</strong> ${extractDobYear(dob)}</div>
            </#if>

            <#if languagesKnown?? && languagesKnown?has_content>
                <div class="detail-item"><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</div>
            </#if>

            <#if nationality?? && nationality?has_content>
                <div class="detail-item"><strong>Nationality:</strong> ${nationality}</div>
            </#if>

            <#if address?? && address?has_content>
                <div class="detail-item"><strong>Address:</strong> ${address}</div>
            </#if>
        </div>
    </#if>

</div>
</body>
</html>