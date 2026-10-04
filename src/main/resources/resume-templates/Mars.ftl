
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
           font-size: ${(style.bodySize)!'12pt'};
           line-height: ${(style.lineSpacing)!'1.35'};
           color: ${(style.bodyColor)!'#111'};
        }

        .container {
          width: 210mm;
          background: white;
          box-sizing: border-box;
        }

        h1 {
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
          margin-bottom: 5px;
          border-bottom: 1px solid #000;
          padding-bottom: 3px;
        font-size: ${(style.sectionTitleSize)!'15pt'};
        font-weight: ${(style.fontWeightHeading)!'600'};
        color: ${(style.headingColor)!'#1a75cf'};
            }

        .job-title {
          font-weight: bold;
          font-size: 12pt;
          margin-top: 10px;
    	  margin-bottom: 10px;

        }

        .company {
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
          line-height: 1;
        }

        p {
          line-height: 1.5;
        }

        .skills, .certs {
          display: flex;
          flex-wrap: wrap;
          gap: 10px;
        }

        .skills div, .certs div {

          font-size: 12pt;
    	  flex: 1 1 45%;
          min-width: 150px;
          word-break: break-word;
        }

        .label {
          font-weight: bold;
          margin-top: 8px;

        }

        a {
          color: #1a75cf;
          text-decoration: none;
          font-size:12pt;
        }

        .skill-container {
          font-size: 12pt;
          margin-bottom: 10px;
        }

        .skill-badge {
          display: inline-block;
          font-weight: bold;
          color: #333;
          border-bottom: 2px solid #ccc;
          padding: 2px 6px;
          margin: 4px 6px 4px 0;
        }

        .stack-title {
          color: #1a75cf;
          font-size: 12pt;
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
          font-size: 12pt;
          margin-bottom: 5px;
          padding-bottom: 5px;
    	  color: #1a75cf;
    	  border-bottom: 1px solid #ccc;
    	}

    	.project-name {
    	  font-weight: bold;
          font-size: 12pt;
    	  margin-bottom: 2px;
          padding-bottom: 2px;
    	}

    	.project-role {
    	 font-weight: bold;
          font-size: 12pt;

    	}

    	.project-descriptoin{
    	  padding-top: 10px;
    	 }

    	.certs {
    	  margin-top:10px;
    	 }

    	 .skills-text{
    	   font-size: 15px;
    	    line-height: 1.2;
    	 }

    	.skills-grid {
    	  display: grid;
    	  grid-template-columns: repeat(2, 1fr);
    	  gap: 3px 1px;
    	  margin-top: 10px;
    	}

    	.skills-grid div {
    	  position: relative;
    	  padding-left: 20px;
    	  font-weight: 500;
    	}

    	.skills-grid div::before {
    	  content: '•';
    	  position: absolute;
    	  left: 0;
    	  color: #000;
    	  font-size: 18px;
    	  line-height: 1;
    	}

    .skills-table td {
        padding: 4px 12px;
        vertical-align: top;
      }

      .meta {
      display: flex;
      align-items: center;
      font-weight: 500;
      margin-top: 5px;
      color: #333;
    }

      .college-project-title {
          font-weight: bold;
          font-size: 12pt;
          margin-top: 10px;
           margin-bottom: 3px;
        }

    	.projectskills{
    	 font-size:15px;
    	 gap:10px;
    	}

    	.sub-jobtitle{
    	 font-weight: bold;
    	 text-decoration:underline;
    	 text-underline-offset: 3px;
    	 margin-bottom:7px;
    	 margin-top:7px;
    	 font-size:14pt;
    	}

    	.exp-responsibilities{
    	line-height:1.5;
    	}
    	.edu-job-title{
    	  font-weight: bold;
          font-size: 12pt;
          margin-top: 7px;

    	 margin-bottom:15px;
    	}
    	.extra-subtitle{
    	  font-size: 12pt;
          margin-top: 12px;
    	  margin-bottom: 4px;

    	}
    	.skill-badge-new{
    		margin-top:10px;
    	}

    	.skill-ai{
    	margin-bottom:5px;
    	margin-top:5px;
    	  line-height:1.3;
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
      <#if phone?? && phone?has_content>
        <span>${phone}</span>
      </#if>
      <#if email?? && email?has_content>
        <span>| ${email}</span>
      </#if>
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

    <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <div class="section-title">EXPERIENCE</div>
        <#list experiences as experience>
          <#if experience.role?? && experience.role?has_content>
            <div class="job-title">${experience.role}</div>
          </#if>

          <#if experience.companyName?? && experience.companyName?has_content>
            <div class="job-title">
              ${experience.companyName}
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
            <div class="sub-jobtitle">Roles &#38; responsibilities</div>
            <ul>
              <#list experience.responsibilities?split(",") as item>
                <#if item?has_content>
                  <li class="exp-responsibilities">${item?trim}</li>
                </#if>
              </#list>
            </ul>
          </#if>

          <#if experience.projects?? && experience.projects?size gt 0>
            <div class="project">
              <div class="project-title">PROJECT</div>
              <#list experience.projects as proj>
                <#if proj.projectName?? && proj.projectName?has_content>
                  <div class="job-title">Name: ${proj.projectName}</div>
                </#if>

                <#if proj.projectRole?? && proj.projectRole?has_content>
                  <div class="job-title">Role: ${proj.projectRole}</div>
                </#if>

                <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
                  <span class="college-project-title">Skills: </span>
                  <span>
                    <#list proj.projectSkills?split(",") as skill>
                      ${skill?trim}<#if skill_has_next>, </#if>
                    </#list>
                  </span>
                </#if>

                <#if proj.projectDescription?? && proj.projectDescription?has_content>
                  <div class="project-descriptoin">
                    <div class="sub-jobtitle">Project Description</div>
                    <p>${proj.projectDescription}</p>
                  </div>
                </#if>
              </#list>
            </div>
          </#if>

        </#list>
      </div>
    </#if>

    <#if collegeProject?? && collegeProject?size gt 0>
      <div class="section">
        <div class="section-title">ACADEMIC PROJECT</div>
        <#list collegeProject as project>
          <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
            <div class="job-title">${project.collegeProjectName}</div>
          </#if>

          <#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
            <span class="college-project-title">Skills: </span>
            <span>
              <#list project.collegeProjectSkills?split(",") as skill>
                <#if skill?has_content>
                  ${skill?trim}<#if skill_has_next>, </#if>
                </#if>
              </#list>
            </span>
          </#if>

          <#if project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>
            <div class="project-descriptoin">
              <div class="sub-jobtitle">Roles &#38; responsibilities</div>
              <ul>
                <#list project.collegeProjectDescription?split(",") as item>
                  <#if item?has_content>
                    <li class="exp-responsibilities">${item?trim}</li>
                  </#if>
                </#list>
              </ul>
            </div>
          </#if>
        </#list>
      </div>
    </#if>

    <#if education?? && education?size gt 0>
      <div class="section">
        <div class="section-title">EDUCATION</div>
        <#list education as edu>
          <#if edu.department?? && edu.department?has_content>
            <div class="job-title">${edu.department}</div>
          </#if>
          <#if edu.institutionName?? && edu.institutionName?has_content>
            <div class="edu-job-title">
              ${edu.institutionName}
              <#if edu.percentage?? && edu.percentage?has_content>
              &#8211; ${edu.percentage}%
              </#if>
              <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                   ${extractmonth(edu.qualificationStartYear)}
                  <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                    &#8211; ${extractmonth(edu.qualificationEndYear)}
                  <#else>
                    &#8211; Present
                  </#if>

              </#if>
            </div>
          </#if>
        </#list>
      </div>
    </#if>

    <#if certificates?? && certificates?size gt 0>
      <div class="section">
        <div class="section-title">CERTIFICATES</div>
        <#list certificates as certificate>
          <#if certificate.courseName?? && certificate.courseName?has_content>
            <div class="extra-subtitle">
              ${certificate.courseName}
              <#if certificate.courseStartDate?? && certificate.courseStartDate?has_content>
                <span> ( ${extractmonth(certificate.courseStartDate)}
                  <#if certificate.courseEndDate?? && certificate.courseEndDate?has_content>
                    &#8211; ${extractmonth(certificate.courseEndDate)} )
                  <#else>
                    )
                  </#if>
                </span>
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
         <#if achieve.achievementsName??  && achieve.achievementsName?has_content>
                  <strong>${achieve.achievementsName}</strong>

                 <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                   &#8211; ( ${extractmonth(achieve.achievementsDate)} )
                  </#if>

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

    <#if strengths?? && strengths?trim?length gt 0>
      <div class="section">
        <div class="section-title">STRENGTH</div>
        <#list strengths?split(",") as skill>
          <#if skill?? && skill?has_content>
            <div class="skill-ai">${skill?trim}</div>
          </#if>
        </#list>
      </div>
    </#if>

    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
      <div class="section">
        <div class="section-title">EXTRACURRICULAR ACTIVITIES</div>
        <#list extraCurricularActivities?split(",") as skill>
          <#if skill?? && skill?has_content>
            <div class="skill-ai">${skill?trim}</div>
          </#if>
        </#list>
      </div>
    </#if>

    <#if goals?? && goals?trim?length gt 0>
      <div class="section">
        <div class="section-title">GOALS</div>
        <#list goals?split(",") as skill>
          <#if skill?? && skill?has_content>
            <div class="skill-ai">${skill?trim}</div>
          </#if>
        </#list>
      </div>
    </#if>

    <#if hobbies?? && hobbies?trim?length gt 0>
      <div class="section">
        <div class="section-title">HOBBIES</div>
        <#list hobbies?split(",") as skill>
          <#if skill?? && skill?has_content>
            <div class="skill-ai">${skill?trim}</div>
          </#if>
        </#list>
      </div>
    </#if>

    <#if addAdditionalDetails>
      <div class="section">
        <div class="section-title">PERSONAL DETAILS</div>

		  <#if fatherName?? && fatherName?has_content>
				 <div class="skill-ai">
					 <strong>Father's Name:</strong> ${fatherName}
				 </div>
			 </#if>

			 <#if maritalStatus?? && maritalStatus?has_content>
				  <div class="skill-ai">
					 <strong>Marital Status:</strong> ${maritalStatus}
				 </div>
			 </#if>

			<#if gender?? && gender?has_content>
			  <div class="skill-ai"><strong>Gender: </strong> ${gender}</div>
			</#if>

			<#if nationality?? && nationality?has_content>
			  <div class="skill-ai"><strong>Nationality: </strong> ${nationality}</div>
			</#if>

			<#if languagesKnown?? && languagesKnown?has_content>
			  <div class="skill-ai">
				<strong>Language Known: </strong> ${languagesKnown?replace(",", ", ")}
			  </div>
			</#if>

			 <#if dob?? && dob?has_content>
				 <div class="skill-ai">
					 <strong>Dob:</strong> ${extractDobYear(dob)}
				 </div>
			 </#if>

			 <#if address?? && address?has_content>
				  <div class="skill-ai">
					 <strong>Address:</strong> ${address}
				 </div>
			 </#if>
      </div>
    </#if>

</div>

 </body>
</html>
