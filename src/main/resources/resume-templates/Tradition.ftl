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

    html, body {
      margin: 0;
      padding: 0;
      width: 210mm;
      font-family: ${(style.primaryFont)!'Arial, sans-serif'};
      font-family: Arial, sans-serif;
      font-size: ${(style.bodySize)!'12pt'};
      color: ${(style.bodyColor)!'#111'};
      line-height: ${(style.lineHeight)!'1.2'};


    }

    .container {
      width: 200mm;
      margin: auto;
      background: white;
      box-sizing: border-box;
      position: relative;
      overflow-wrap:break-word;
      word-break:break-word;
    }

    h1 {
      margin: 0;
      font-size: ${(style.nameSize)!'22pt'};
      font-weight: ${(style.fontWeightname)!'800'};
      color: ${(style.nameColor)!'#111'};
    }

    h2 {
      font-family: 'Helvetica', 'Arial', sans-serif;
      font-size: 12pt;
      margin: 5px 0 10px;
      color: #1a75cf;
      font-weight: normal;
    }

    .contact {
      margin-top: 8px;
      font-size: 12pt;
    }

    .contact span {
      margin-right: 15px;
    }

    .section {
      margin-top: 13px;
      margin-bottom: 0px;
     }

    .section-title {

      font-size: ${(style.sectionTitleSize)!'13pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
      color: ${(style.headingColor)!'#1a75cf'};
      margin-bottom: 5px;
      border-bottom: 1px solid #000;
      padding-bottom: 3px;

    }

    .job-title {
      font-weight: bold;
      font-size: 13pt;
      margin-top: 10px;
      margin-bottom: 3px;
    }

    .college-project-title {
      font-weight: bold;
      font-size: 13pt;
      margin-top: 10px;
       margin-bottom: 3px;
    }

    .college-project{
      font-weight: bold;
      font-size: 13pt;
      margin-top: 10px;
    }

    .company {
      color: #1a75cf;
      font-weight: bold;
      margin-bottom: 4px;
    }

    .meta {

      margin-bottom: 6px;
    }

    ul {
      margin: 0;
      padding-left: 20px;
    }

    ul li {

      margin-bottom: 6px;
      line-height: 1.3;
    }

    p {
      line-height: 1.3;
    }


    .label {
      font-weight: bold;
      margin-top: 8px;

    }

    a {
      color: #1a75cf;
      text-decoration: none;

    }


    .stack-title {
      color: #1a75cf;

      margin: 10px 0 4px;
    }

	*, *::before, *::after {
     box-sizing: border-box;
    }

    .project {
	  margin-top: 18px;
      margin-bottom: 20px;
	  margin-left:15px;
	}

	.project-title {
	  font-weight: bold;

      margin-bottom: 5px;
	  color: #1a75cf;
	  border-bottom: 1px solid #ccc;
	}

	.project-name {
	  font-weight: bold;

	  margin-bottom: 2px;
      padding-bottom: 2px;
	}

	.project-role {
	 font-weight: bold;


	}

	.project-description{
	  padding-top: 10px;
	 }

	.certs {
	  margin-top:10px;
	 }

     .skills-table {
      width: 100%;
      border-collapse: collapse;
    }

    .skills-table td {
      padding: 4px 20px 4px 0;
      vertical-align: top;
      width: 50%;
       line-height:1.2;
    }



  .certificate{
     line-height: 1.8;
     margin-top:3px;

  }

.experience-item {
margin-bottom: 20px;
padding-bottom: 10px;
border-bottom: 1px dashed #ccc;
}

.projectskillSection{
font-size:14px;
gap:10px
}

 .projectsection{
  margin-bottom: 10px;
    padding-bottom: 5px;
    border-bottom: 1px dashed #ccc;
}

	 .education-entry{
       margin-top:20px;
       margin-bottom: 20px;
        border-bottom: 1px dashed #ccc;
	 }

	 .education-fields{

        margin-top: 5px;
        margin-bottom: 3px;
	 }

    .detail-item {
             margin-top: 7px;
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
    <h1>${name}</h1>
     <div class="contact">
      <span>${phone}</span>
      <span>| ${email}</span>

	  <#if linkedin?? && linkedin?has_content>
      <span>| ${linkedin}</span>
	  </#if>
    </div>

 <#if objective?? && objective?has_content>
    <div class="section">
      <div class="section-title">OBJECTIVE</div>
      <p>${objective}</p>
    </div>
 </#if>


 <#if summary?? && summary?has_content>
    <div class="section">
      <div class="section-title">SUMMARY</div>
      <p>${summary}</p>
    </div>
 </#if>


 <#if experiences?? && experiences?size gt 0>
   <div class="section">
     <div class="section-title">EXPERIENCE</div>
       <#list experiences as experience>
           <div class="experience-item">

              <#if experience.companyName?? && experience.companyName?has_content>
                 <div class="job-title">${experience.companyName}</div>
               </#if>

                  <#if experience.role?? && experience.role?has_content>
                    <div class="job-title">${experience.role}

                     <#if experience.experienceYearStartDate?? && experience.experienceYearStartDate?has_content>

                      ( ${extractmonth(experience.experienceYearStartDate)}
                       <#if experience.experienceYearEndDate?? && experience.experienceYearEndDate?has_content>
                      &#8211; ${extractmonth(experience.experienceYearEndDate)} )
                       <#else>
                         &#8211; Present )
                      </#if>
             </#if>



                    </div>
                  </#if>



              <#if experience.responsibilities?? && experience.responsibilities?trim?length gt 0>
              <div class="job-title" style="text-decoration:underline;">Roles &#38; Responsibilities</div>

                <ul>
                  <#list experience.responsibilities?split(",") as item>
                    <#if item?has_content>
                      <li>${item?trim}</li>
                    </#if>
                  </#list>
                </ul>
              </#if>

              <#if experience.projects?? && experience.projects?size gt 0>
                  <div class="project">
                    <div class="project-title">PROJECT</div>
                    <#list experience.projects as proj>

                   <div class="projectsection">

                      <#if proj.projectName?? && proj.projectName?has_content>
                        <div class="project-name">Name: ${proj.projectName}</div>
                      </#if>

                      <#if proj.projectRole?? && proj.projectRole?has_content>
                        <div class="project-role">Role: ${proj.projectRole}</div>
                      </#if>

                       <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
                         <div class="college-project-title">Skills:</div>

                           <div class="projectskillSection">

                            <#list proj.projectSkills?split(",") as skill>
                              ${skill?trim}<#if skill_has_next>, </#if>
                            </#list>
                          </div>
                      </#if>

                      <#if proj.projectDescription?? && proj.projectDescription?has_content>
                      <div class="job-title" style="text-decoration:underline;">Project Description</div>
                        <div class="project-description">

                            ${proj.projectDescription}

                        </div>
                      </#if>

                      </div>

                    </#list>
                  </div>
              </#if>
          </div>
	</#list>
   </div>
 </#if>


  <#if collegeProject?? && collegeProject?size gt 0>
  <div class="section">
    <div class="section-title">ACADEMIC PROJECT</div>

    <#list collegeProject as project>

      <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
        <div class="college-project">Title: ${project.collegeProjectName}</div>
      </#if>

      <#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
         <div class="college-project-title">Project Skills:</div>

        <ul>
          <#list project.collegeProjectSkills?split(",") as pro>
            <#if pro?has_content>
              <li>${pro?trim}</li>
            </#if>
          </#list>
        </ul>
      </#if>

      <#if project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>

        <div class="job-title" style="text-decoration:underline;">Project Description</div>

             <p> ${project.collegeProjectDescription}</p>
      </#if>

    </#list>
  </div>
</#if>

  <#if education?? && education?size gt 0>
  <div class="section">
    <div class="section-title">EDUCATION</div>

    <#list education as edu>

      <div class="education-entry">

        <#if edu.department?? && edu.department?has_content>
          <div class="education-fields">${edu.department}</div>
        </#if>

        <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
          <div class="education-fields">${edu.fieldOfStudy}</div>
        </#if>



        <#if edu.institutionName?? && edu.institutionName?has_content>
          <div class="education-fields"> ${edu.institutionName}


          <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>

            (
            ${extractmonth(edu.qualificationStartYear)}
            <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
              &#8211; ${extractmonth(edu.qualificationEndYear)}
            <#else>
              &#8211; Present
            </#if>
            )
		        </#if>
		         </div>
        </#if>

         <#if edu.percentage?? && edu.percentage?has_content>
                  <div class="education-fields">Percentage: ${edu.percentage}%</div>
           </#if>

      </div>

    </#list>

  </div>
</#if>


		<#if skills?? && skills?trim?length gt 0>
		  <div class="section">
		    <div class="section-title">SKILLS</div>
		    <#assign skillList = skills?split(",")?filter(s -> s?trim?length > 0)>
		    <table class="skills-table">
		      <#assign i = 0>
		      <#list skillList as skill>
		        <#if i % 2 == 0>
		          <tr>
		        </#if>
		        <td>&#8226; ${skill?trim}</td>
		        <#if i % 2 == 1>
		          </tr>
		        </#if>
		        <#assign i = i + 1>
		      </#list>
 		      <#if (i % 2) != 0>
		        <td></td></tr>
		      </#if>
		    </table>
		  </div>
		</#if>


		<#if competencies?? && competencies?trim?length gt 0>
		  <div class="section">
		    <div class="section-title">CORE COMPETENCIES</div>
		    <#assign compentenciesList = competencies?split(",")?filter(s -> s?trim?length > 0)>
		    <table class="skills-table">
		      <#assign i = 0>
		      <#list compentenciesList as skill>
		        <#if i % 2 == 0>
		          <tr>
		        </#if>
		        <td>&#8226; ${skill?trim}</td>
		        <#if i % 2 == 1>
		          </tr>
		        </#if>
		        <#assign i = i + 1>
		      </#list>
 		      <#if (i % 2) != 0>
		        <td></td></tr>
		      </#if>
		    </table>
		  </div>
		</#if>




  <#if certificates?? && certificates?size gt 0>
    <div class="section">
      <div class="section-title">CERTIFICATES</div>
	 <#list certificates as certificate>

        <#if certificate.courseName?? && certificate.courseName?has_content>
           <div class="certificate"><strong>${certificate.courseName}</strong>

            <#if certificate.courseStartDate?? && certificate.courseStartDate?has_content>
              <span style="padding-left:10px;">  ( ${extractmonth(certificate.courseStartDate)}   </span>

                    <#if certificate.courseEndDate?? && certificate.courseEndDate?has_content>
                        <span style="padding-left:3px;">  &#8211; ${extractmonth(certificate.courseEndDate)} )  </span>
                         <#else>
                             )
                    </#if>

             </#if>


           </div>
        </#if>


	 </#list>
    </div>
  </#if>


   <#if achievements?? && achievements?size gt 0>
      <div class="section">
        <div class="section-title">ACHIEVEMENTS</div>
   <#list achievements as achieve>

          <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
             <div class="certificate"><strong>${achieve.achievementsName}</strong>

             <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                <span style="padding-left:10px;">  &#8211;  ${extractmonth(achieve.achievementsDate)}   </span>

               </#if>


             </div>
          </#if>


  	 </#list>
      </div>
    </#if>

   <#if softSkills?? && softSkills?trim?length gt 0>
		  <div class="section">
		    <div class="section-title">SOFT SKILLS</div>
		   <#assign softSkillsList = softSkills?split(",")?filter(s -> s?trim?length > 0)>
		    <table class="skills-table">
		      <#assign i = 0>
		      <#list softSkillsList as skill>
		        <#if i % 2 == 0>
		          <tr>
		        </#if>
		        <td>&#8226; ${skill?trim}</td>
		        <#if i % 2 == 1>
		          </tr>
		        </#if>
		        <#assign i = i + 1>
		      </#list>
 		      <#if (i % 2) != 0>
		        <td></td></tr>
		      </#if>
		    </table>
		  </div>
		</#if>


		 <#if strengths?? && strengths?trim?length gt 0>
                    <div class="section">
                          <div class="section-title">STRENGHTS</div>
                             <#list strengths?split(",") as skill>
                                   <#if skill?? && skill?has_content>
                                       <div class="detail-item">${skill?trim}</div>
                                    </#if>
                           </#list>

                    </div>
             </#if>


             <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                       <div class="section">
                           <div class="section-title">EXTRACURRICULAR ACTIVITIES</div>
                              <#list extraCurricularActivities?split(",") as skill>
                                    <#if skill?? && skill?has_content>
                                      <div class="detail-item">${skill?trim}</div>

                                     </#if>
                               </#list>

                     </div>
              </#if>

           <#if goals?? && goals?trim?length gt 0>
                         <div class="section">
                             <div class="section-title">GOALS</div>
                                <#list goals?split(",") as skill>
                                      <#if skill?? && skill?has_content>
                                          <div class="detail-item">${skill?trim}</div>
                                       </#if>
                                 </#list>

                       </div>
                </#if>


                 <#if addAdditionalDetails>
                             <div class="section">
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

                             </div>

                        </#if>

  </div>
</body>
</html>
