<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Riaan Chandran Resume</title>
    <meta name="viewport" content="width=800, initial-scale=1.0" />
    <style>
      @page {
        size: A4;
        margin: 0;
      }
      html,body {
        background: #f9f9fb;
        margin: 0;
        padding: 0;
        font-family: ${(style.primaryFont)!'"Inter", Arial, Helvetica, sans-serif'};
        font-size: ${(style.bodySize)!'12pt'};
        line-height: ${(style.lineSpacing)!'1.3'};
      }
      .resume-container {
        max-width: 210mm;
        width: 100%;
        border-radius: 20px;
        padding: 30px 38px 30px 38px;
        position: relative;
        overflow-wrap:break-word;
        word-break:break-word;
      }
      .top-bar {
        display: flex;
        background: #2368ea;
        color: #fff;
        border-top-left-radius: 16px;
        border-top-right-radius: 16px;
        padding: 10px 22px;
        justify-content: flex-start;
        gap:10px;
        margin: -32px -36px 14px -36px;
      }
      .profile-section {
        display: flex;
        align-items: center;
        margin-bottom: 18px;
      }
      .profile-img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 100px;
        margin-right: 30px;
        border: 2.5px solid #2368ea;
      }
      .profile-name-title {
      }
      .profile-name {
        margin-bottom: 3px;
        font-size: ${(style.nameSize)!'24pt'};
        font-weight: ${(style.fontWeightname)!'600'};
         color: ${(style.nameColor)!'#1b2330'};
      }
      .profile-title {
        font-size: 22px;
        color: #313b56;
        font-weight: 500;
      }
      .columns {
        display: flex;
        gap: 24px;
      }
      .left-column,
      .right-column {
        flex: 1;
        overflow-wrap:break-word;
                word-break:break-word;
      }
      .section-block {
        margin-bottom: 10px;
      }
      .section-header {
        background: #2368ea;
        padding: 5.5px 18px;
        border-radius: 14px;
        display: inline-block;
        margin-bottom: 8px;
       font-size: ${(style.sectionTitleSize)!'14pt'};
     font-weight: ${(style.fontWeightHeading)!'700'};
     color: ${(style.headingColor)!'#fff'};
      }
      .section-content {
        padding-left: 2px;
        font-size: 13.5px;
        color: #232939;
        line-height: 1.4;
      }
      .education-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13px;
      }
      .education-table th,
      .education-table td {
        text-align: left;
        padding: 4px 2px;
      }
      .education-table th {
        color: #2368ea;
        font-weight: 700;
        font-size: 14px;
        background: #f3f7fd;
      }
      .skills-list {
        display: flex;
        flex-wrap: wrap;
        gap: 7px 15px;
        margin-top: 8px;
      }
      .skill-chip {
        background: #eff5fd;
        color: #2368ea;
        border-radius: 12px;
        padding: 5px 16px;
        font-size: 13px;
        font-weight: 600;
        border: 1.5px solid #2368ea;
      }
      .work-exp-block {
        border-bottom: 1px solid rgb(148, 137, 137);
        margin-top: 10px;
      }
      .work-exp-header {
        font-size: 15px;
        font-weight: 700;
        color: #2368ea;
        margin-bottom: 2px;
      }
      .work-exp-role {
        font-size: 14px;
        color: #232939;
        font-weight: 600;
        margin-bottom: 2px;
      }
      .work-exp-date {
        font-size: 12.5px;
        color: #1d1d1e;
        margin-bottom: 5px;
      }
      .work-exp-detail {
        font-size: 13.5px;
        color: #232939;
        margin-bottom: 4px;
        padding-left: 2px;
      }

      .project {
        margin-left: 10px;
      }
      .work-exp-project {
        font-size: 14px;
        color: #232939;
        font-weight: 600;
        margin-bottom: 2px;
        text-decoration: underline;
        text-underline-offset: 2px;
      }
      .work-exp-skills {
        font-size: 13.5px;
        color: #232939;
        margin-bottom: 4px;
        padding-left: 2px;
        text-transform: uppercase;
      }

      .education-item{
        border-bottom: 1px solid #add8e6;
      }

      .languages{
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


  <div class="resume-container">


      <div class="top-bar">
        <#if phone?has_content><div>${phone}</div></#if>
        <#if email?has_content><div>${email}</div></#if>
        <#if linkedIn?has_content><div>${linkedIn}</div></#if>
      </div>





    <div class="columns">

      <div class="left-column">

       <#if profileImage?? && profileImage?has_content>
        <div class="section-block">
             <div class="profile-section">

              <img src="${profileImage}" class="profile-img" alt="Profile Photo" />

              <div class="profile-name-title">
               <#if name?? && name?has_content>
                        <div class="profile-name">${name}</div>
                </#if>

                 <#if jobTitle?? && jobTitle?has_content>
                        <div class="profile-title">${jobTitle}</div>
                    </#if>
                 </div>

            </div>
             </div>
            </#if>

        <#if summary?has_content>
          <div class="section-block">
            <div class="section-header">Summary</div>
            <div class="section-content">${summary}</div>
          </div>
        </#if>


        <#if education?? && education?size gt 0>
          <div class="section-block">
            <div class="section-header">Education</div>
            <div class="section-content">

                <#list education as edu>

                 <div class="education-item">
              <table class="education-table">
                   <tr>
                          <#if edu.institutionName?? && edu.institutionName?has_content>
                            <td><strong>${edu.institutionName}</strong></td>
                          </#if>

                           <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                                <td>${edu.fieldOfStudy}</td>
                             </#if>
                   </tr>

				   <tr>

                             <#if edu.department?? && edu.department?has_content>
                                <td>${edu.department}</td>
                            </#if>

                            <#if edu.percentage?? && edu.percentage?has_content>
                              <td>${edu.percentage} %</td>
                             </#if>
 			       </tr>

			       <tr>
			           <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                  					 <td>

                          ${extractmonth(edu.qualificationStartYear)}
                          <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                            &#8211; ${extractmonth(edu.qualificationEndYear)}
                          <#else>
                            &#8211; Present)
                          </#if>
                          </td>
                        </#if>
			       </tr>
			       </table>
                 </div>
               </#list>

            </div>
          </div>
        </#if>

        <!-- Skill -->
        <#if skills?? && skills?trim?length gt 0>
          <div class="section-block">
            <div class="section-header">Skill</div>
            <div class="skills-list">
              <#list skills?split(",") as skill>
                <#if skill?has_content><span class="skill-chip">${skill?trim}</span></#if>
              </#list>
            </div>
          </div>
        </#if>

        <!-- Soft Skill -->
        <#if softSkills?? && softSkills?trim?length gt 0>
          <div class="section-block">
            <div class="section-header">Soft Skill</div>
            <div class="skills-list">
              <#list softSkills?split(",") as s>
                <#if s?has_content><span class="skill-chip">${s?trim}</span></#if>
              </#list>
            </div>
          </div>
        </#if>

        <!-- Core Competencies -->
        <#if competencies?? && competencies?trim?length gt 0>
          <div class="section-block">
            <div class="section-header">Core Competencies</div>
            <div class="skills-list">
              <#list competencies?split(",") as c>
                <#if c?has_content><span class="skill-chip">${c?trim}</span></#if>
              </#list>
            </div>
          </div>
        </#if>

         <#if goals?? && goals?trim?length gt 0>
          <div class="section-block">
            <div class="section-header">Goals</div>
            <div class="skills-list">
              <#list goals?split(",") as skill>
                <#if skill?has_content><span class="skill-chip">${skill?trim}</span></#if>
              </#list>
            </div>
          </div>
        </#if>

        <!-- Certifications -->
        <#if certificates?? && certificates?size gt 0>
          <div class="section-block">
            <div class="section-header">Certifications</div>
            <div class="section-content">
              <table class="education-table">
                <#list certificates as cert>
                  <tr>
				  <#if cert.courseName?? && cert.courseName?has_content>
                    <td><strong>${cert.courseName}</strong></td>

					    <#if cert.courseStartDate??>
				          <td>
							  <#if cert.courseStartDate??>
								${extractmonth(cert.courseStartDate)}
								<#if cert.courseEndDate??>
								- ${extractmonth(cert.courseEndDate)}</#if>
							    </#if>
							   </#if>
                          </td>
					</#if>
                  </tr>
                </#list>
              </table>
            </div>
          </div>
        </#if>

      </div>

      <!-- RIGHT COLUMN -->
      <div class="right-column">

        <!-- Objective -->
        <#if objective?has_content>
          <div class="section-block">
            <div class="section-header">Objective</div>
            <div class="section-content">${objective}</div>
          </div>
        </#if>

        <!-- Work Experience -->
        <#if experiences?? && experiences?size gt 0>
          <div class="section-block">
            <div class="section-header">Work Experience</div>
            <div class="section-content">
              <#list experiences as exp>
                <div class="work-exp-block">

				  <#if exp.companyName?? && exp.companyName?has_content>
				 <div class="work-exp-header">${exp.companyName}</div>
				  </#if>

				 <#if exp.role?? && exp.role?has_content>
                  <div class="work-exp-role">${exp.role}</div>
				  </#if>

                  <div class="work-exp-date">
                    <#if exp.experienceYearStartDate??>
                      ${extractmonth(exp.experienceYearStartDate)}
                      <#if exp.experienceYearEndDate??> - ${extractmonth(exp.experienceYearEndDate)}<#else> - Present</#if>
                    </#if>
                  </div>

                  <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
                       <div class="work-exp-detail">
					     ${exp.responsibilities}
					   </div>
                  </#if>

                  <#if exp.projects?? && exp.projects?size gt 0>
                    <div class="project">
                      <div class="work-exp-project">Projects</div>
                      <#list exp.projects as proj>
                        <#if proj.projectName?has_content><div><strong>Name:</strong> ${proj.projectName}</div></#if>
                              <#if proj.projectRole?has_content><div><strong>Role:</strong> ${proj.projectRole}</div></#if>

						<#if proj.projectDescription?has_content>
                          <strong>Description:</strong>
						   <div class="work-exp-detail">${proj.projectDescription}</div>
                        </#if>


                       <#if proj.projectSkills?? && proj.projectSkills?has_content>
                           <strong>Skills:</strong>

                           <div class="work-exp-skills">
						     <#list proj.projectSkills?split(",") as skill>
                               <#if skill?has_content>
                                ${skill?trim}<#if skill_has_next>, </#if>
                               </#if>
                              </#list>
						   </div>
                        </#if>

                      </#list>
                    </div>
                  </#if>
                </div>
              </#list>
            </div>
          </div>
        </#if>

        <!-- Academic Projects -->
        <#if collegeProject?? && collegeProject?size gt 0>
          <div class="section-block">
            <div class="section-header">Academic Project</div>
            <div class="section-content">
              <#list collegeProject as project>
                <div class="work-exp-block">

                  <#if project.collegeProjectName?has_content>
					<div class="work-exp-header">
					 ${project.collegeProjectName}
					</div>
				  </#if>


				 <#if project.collegeProjectSkills?has_content><strong>Skills:</strong>
					  <div class="work-exp-skills">
					     <#list project.collegeProjectSkills?split(",") as skill>
								   <#if skill?has_content>
									${skill?trim}<#if skill_has_next>, </#if>
								   </#if>
						  </#list>
						</div>
				  </#if>


                  <#if project.collegeProjectDescription?has_content><strong>Description:</strong>
				  <div class="work-exp-detail">
				    ${project.collegeProjectDescription}</div>
				  </#if>

                </div>
              </#list>
            </div>
          </div>
        </#if>

        <#if strengths?? && strengths?trim?length gt 0>
              <div class="section-block">
                <div class="section-header">Strength</div>
                <div class="skills-list">
                  <#list strengths?split(",") as skill>
                    <#if skill?has_content><span class="skill-chip">${skill?trim}</span></#if>
                  </#list>
                </div>
              </div>
            </#if>

           <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                        <div class="section-block">
                          <div class="section-header">ExtraCurricular Activities</div>
                          <div class="skills-list">
                            <#list extraCurricularActivities?split(",") as skill>
                              <#if skill?has_content><span class="skill-chip">${skill?trim}</span></#if>
                            </#list>
                          </div>
                        </div>
                      </#if>


                <#if addAdditionalDetails?? && addAdditionalDetails>
                      <div class="section-block">
                        <div class="section-header">Personal Details</div>

                           <#if fatherName?? && fatherName?has_content>
                             <div class="languages"> <strong>Father Name :</strong> ${fatherName}</div>
                             </#if>

                             <#if nationality?? && nationality?has_content>
                             <div class="languages"> <strong>Nationality :</strong> ${nationality}</div>
                             </#if>

                             <#if dob?? && dob?has_content>
                             <div class="languages"> <strong>Dob :</strong> ${extractDobYear(dob)}</div>
                             </#if>

                             <#if languagesKnown?? && languagesKnown?has_content>
                             <div class="languages"> <strong>Language Known :</strong> ${languagesKnown?replace(",", ", ")}</div>
                             </#if>

                             <#if maritalStatus?? && maritalStatus?has_content>
                             <div class="languages"> <strong>Martial Status :</strong> ${maritalStatus}</div>
                             </#if>

                                  <#if gender?? && gender?has_content>
                             <div class="languages"> <strong>Gender :</strong> ${gender}</div>
                             </#if>

                                  <#if address?? && address?has_content>
                             <div class="languages"> <strong>Address :</strong> ${address}</div>
                             </#if>
                      </div>
                    </#if>





        <#if achievements?? && achievements?size gt 0>
          <div class="section-block">
            <div class="section-header">Achievements</div>
            <div class="section-content">
              <table class="education-table">
                <#list achievements as achieve>
                  <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                    <tr>

                      <td>${achieve.achievementsName}</td>

					    <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
					       <td>
                           ${extractmonth(achieve.achievementsDate)}
                            </td>
						</#if>

                    </tr>
                  </#if>
                </#list>
              </table>
            </div>
          </div>
        </#if>

      </div>
    </div>
  </div>
</body>
</html>