
<!DOCTYPE html>
<html lang="en">
  <head>
  <#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
        <@fonts.loadFonts />
    <style>
         @page: first {
           margin-top: 0px;
         }

         @page {
           size: A4;
           margin-top: 20px;
           margin-bottom: 10px;
         }

      body {
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        font-family: ${(style.primaryFont)!'Arial,Helvetica, sans-serif'};
        font-size: ${(style.bodySize)!'12pt'};
        line-height: ${(style.lineSpacing)!'1.3'};
        color: ${(style.bodyColor)!'#1a1f36'};
      }

      .container {
        display: grid;
        grid-template-columns: 30% 70%;
         max-width: 210mm;
        width: 100%;
        margin: 0 auto;
        overflow-wrap:break-word;


        border-radius: 6px;
      }

      .left {
        background-color: #1b2a47;
        background: #1b2a47;
        color: #fff;
        padding: 25px 15px;
      }

      .profile-photo {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        border: 4px solid #fff;
        object-fit: cover;
        display: block;
        margin: 0 auto 15px auto;
      }

      .left h2 {

        padding: 3px 10px;
        background-color: #0f1a30;
        background: #0f1a30;
        display: inline-block;
        border-radius: 4px;
        font-size: ${(style.sectionTitleSize)!'13pt'};
        font-weight: ${(style.fontWeightHeading)!'400'};

      }

      .left p,
      .left li {
        font-size: 13px;
        margin: 3px 0;
      }

      .left ul {
        list-style: none;
        padding: 0;
        margin: 0;
      }

      .right {
        background-color: #fff;
        padding: 25px 10px;
      }

      .name-title {
        text-align: left;
      }

      .name-title h1 {
        margin: 0;
       font-size: ${(style.nameSize)!'20pt'};
       font-weight: ${(style.fontWeightname)!'800'};
       color: ${(style.nameColor)!'#1b2a47'};
      }

      .name-title h2 {
        font-size: 16px;
        margin: 2px 0 0 0;
        font-weight: normal;
        color: #555;
      }

      .section {
      }

      .section h2 {


        background-color: #1b2a47;
        -fs-background: #1b2a47;
        -fs-pdf-fill: #1b2a47;
        padding: 3px 10px;
        display: inline-block;
        border-radius: 4px;
        margin-bottom: 2px;
        font-size: ${(style.sectionTitleSize)!'13pt'};
        font-weight: ${(style.fontWeightHeading)!'500'};
        color: ${(style.headingColor)!'#fff'};
      }

      .section p,
      .section li {
        font-size: 13px;
        margin: 3px 0;
        line-height: 1.5;
      }

      .work-item {

      }

      .work-item h3 {
        margin: 0;
        font-size: 14px;
        font-weight: bold;
        color: #1b2a47;
      }

      .work-item span {
        display: block;
        font-size: 12px;
        color: #666;
        margin: 3px 0 6px 0;
      }

      .project-section h4 {
        font-size: 12px;
        color: #1b2a47;
        border-bottom: 1px solid #1b2a47;
        padding-bottom: 2px;
        margin: 8px 0;
      }

      .project-item {

        margin: 5px 0 5px 15px;
      }
      .project-skills{

        margin-top: 10px;
      }

      .contact-item{
       margin:5px 0px;
       overflow-wrap: break-word;
       word-break:break-word;
      }

      .education-item{
       border-bottom:1px dashed #222;
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
    <!-- LEFT COLUMN -->
    <div class="left">
      <#if profilePhoto?? && profilePhoto?has_content>
        <img src="${profilePhoto}" class="profile-photo" />
      </#if>

      <h2>Contact Me</h2>
      <#if phone?has_content><div class="contact-item"> ${phone}</div></#if>
      <#if email?has_content><div class="contact-item"> ${email}</div></#if>
      <#if location?has_content><div class="contact-item">  ${location}</div></#if>

      <#if skills?? && skills?trim?length gt 0>
        <h2>Skills</h2>
        <ul>
          <#list skills?split(",") as skill>
            <#if skill?? && skill?has_content>
              <li>${skill?trim}</li>
            </#if>
          </#list>
        </ul>
      </#if>

      <#if competencies?? && competencies?trim?length gt 0>
        <h2>Core Competencies</h2>
        <ul>
          <#list competencies?split(",") as comp>
            <#if comp?? && comp?has_content>
              <li>${comp?trim}</li>
            </#if>
          </#list>
        </ul>
      </#if>

      <#if softSkills?? && softSkills?trim?length gt 0>
        <h2>Soft Skills</h2>
        <ul>
          <#list softSkills?split(",") as skill>
            <#if skill?? && skill?has_content>
              <li>${skill?trim}</li>
            </#if>
          </#list>
        </ul>
      </#if>

      <#if strengths?? && strengths?trim?length gt 0>

             <h2>Strengths</h2>
               <ul>
                 <#list strengths?split(",") as strength>
                   <#if strength?has_content>
                        <p>${strength?trim}</p>
                   </#if>
                 </#list>
          </ul>
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

       <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0 && hasCollegeProjects>

                 <h2>Extracurricular Activites</h2>
                  <ul>
                      <#list extraCurricularActivities?split(",") as activities>
                        <#if activities?has_content>
                             <p>${activities?trim}</p>
                        </#if>
                      </#list>
              </ul>
          </#if>






         <#if addAdditionalDetails && hasCollegeProjects>

                         <h2>Personal Details</h2>

                         <#if fatherName?? && fatherName?has_content>
                             <p><strong>Father's Name:</strong> ${fatherName}</p>
                         </#if>

                         <#if maritalStatus?? && maritalStatus?has_content>
                             <p><strong>Marital Status:</strong> ${maritalStatus}</p>
                         </#if>

                         <#if gender?? && gender?has_content>
                             <p><strong>Gender:</strong> ${gender}</p>
                         </#if>

                         <#if dob?? && dob?has_content>
                              <p><strong>Dob:</strong> ${extractDobYear(dob)}</p>
                          </#if>

                         <#if languagesKnown?? && languagesKnown?has_content>
                             <p><strong>Language Known:</strong>
                                 ${languagesKnown?replace(",", ", ")}
                             </p>
                         </#if>

                         <#if nationality?? && nationality?has_content>
                             <p><strong>Nationality:</strong> ${nationality}</p>
                         </#if>


                </#if>





    </div>

    <!-- RIGHT COLUMN -->
    <div class="right">
      <div class="name-title">
        <#if name?? && name?has_content><h1>${name}</h1></#if>

      </div>

      <#if summary?? && summary?has_content>
        <div class="section summary">
          <h2>About Me</h2>
          <p>${summary}</p>
        </div>
      </#if>

     <#if objective?? && objective?has_content>
          <div class="section summary">
            <h2>Objective</h2>
            <p>${objective}</p>
          </div>
        </#if>

        <#if education?? && education?size gt 0>
              <div class="section education">
                <h2>Education</h2>
                <#list education as edu>
                  <div class="education-item">

                      <#if edu.department?? && edu.department?has_content><p><strong>${edu.department}</strong>

                           <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                           &#8211;  ${extractmonth(edu.qualificationStartYear)}
                           <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                             &#8211; ${extractmonth(edu.qualificationEndYear)}
                           <#else>
                             &#8211; Present
                           </#if>
                         </#if>

                      </p></#if>




                      <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>

                      <p>  <strong>${edu.fieldOfStudy}</strong>
                      <#if edu.percentage?? && edu.percentage?has_content> &#8211; ${edu.percentage}% </#if>
                      <#else>
                       <p>
                      <#if edu.percentage?? && edu.percentage?has_content> ${edu.percentage}% </#if>
                      </p>

                      </#if>


                    <#if edu.institutionName?? && edu.institutionName?has_content><p>${edu.institutionName}</p></#if>
                  </div>
                </#list>
              </div>
            </#if>

	   <#if objectives?? && objectives?has_content>
        <div class="section summary">
          <h2>Objectives</h2>
          <p>${objectives}</p>
        </div>
      </#if>

      <#if experiences?? && experiences?size gt 0>
        <div class="section">
          <h2>Experience</h2>
          <#list experiences as exp>
            <div class="work-item">
              <h3>
                <#if exp.companyName?has_content>${exp.companyName}</#if>
                <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                  ( ${extractmonth(exp.experienceYearStartDate)}
                  <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                    &#8211; ${extractmonth(exp.experienceYearEndDate)}
                  <#else>
                    &#8211; Present
                  </#if>
                  )
                </#if>
              </h3>
              <#if exp.role?has_content><span>${exp.role}</span></#if>
              <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
                <p>${exp.responsibilities}</p>
              </#if>

              <#if exp.projects?? && exp.projects?size gt 0>
                <div class="project-section">
                  <h4>Projects</h4>
                  <#list exp.projects as proj>
                    <div class="project-item">
                      <#if proj.projectName?? && proj.projectName?has_content>
                        <strong>Name:&nbsp;</strong> ${proj.projectName} </br>
                      </#if>

                       <#if proj.projectRole?? && proj.projectRole?has_content>
                                   <strong>Role:&nbsp;</strong>             ${proj.projectRole}  </br>
                                            </#if>
                      <#if proj.projectDescription?? && proj.projectDescription?has_content>
                        <strong>Description:&nbsp;</strong>      ${proj.projectDescription}  </br>
                      </#if>
                      <#if proj.projectSkills?? && proj.projectSkills?has_content>
                        <div class="project-skills">
                         <strong>Skills:&nbsp;</strong>
                          <#list proj.projectSkills?split(",") as skill>
                            ${skill?trim}<#if skill_has_next>, </#if>
                          </#list>
                        </div>
                      </#if>
                    </div>
                  </#list>
                </div>
              </#if>
            </div>
            <hr>
          </#list>
        </div>
      </#if>

	  <#if collegeProject?? && collegeProject?size gt 0>
		  <div class="section">
			<h2>Academic Project</h2>
			<#list collegeProject as project>
			  <div class="work-item">

				<#if project.collegeProjectName?? && project.collegeProjectName?has_content>
				  <h3>${project.collegeProjectName}</h3>
				</#if>


				<#if project.collegeProjectDescription?? && project.collegeProjectDescription?has_content>
				  <p>${project.collegeProjectDescription}</p>
				</#if>

				<#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
				  <div class="project-section">
					<h4>Skills</h4>
					<div class="project-skills">
					  <#list project.collegeProjectSkills?split(",") as skill>
						${skill?trim}<#if skill_has_next>, </#if>
					  </#list>
					</div>
				  </div>
				</#if>
			  </div>
			  <hr>
			</#list>
		  </div>
		</#if>





		  <#if certificates?? && certificates?size gt 0>
			  <div class="section education">
				<h2>Certificates</h2>

				  <div class="education-item">
				  <#list certificates as certi>
					<#if certi.courseName?? && certi.courseName?has_content>
					  <p>
						<strong>${certi.courseName}</strong>
						<#if certi.courseStartDate?? && certi.courseStartDate?has_content>
						  ( ${extractmonth(certi.courseStartDate)}
						  <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
							&#8211; ${extractmonth(certi.courseEndDate)}
						  <#else>
							)
						  </#if>
						  )
						</#if>
					  </p>
					</#if>
					</#list>
				  </div>
			  </div>
			</#if>


			<#if achievements?? && achievements?size gt 0>
            		  <div class="section education">
            			<h2>Achievements / Awards</h2>
            			  <div class="education-item">
                                  <#list achievements as achieve>
                                    <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                                      <p>
                                        <strong>${achieve.achievementsName}</strong>
                                        <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                                          - ${extractmonth(achieve.achievementsDate)}
                                        </#if>
                                      </p>
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

                       			        	<#if goals?? && goals?trim?length gt 0  && !hasCollegeProjects >
                                                      <div class="section">
                                                           <h2>Goals</h2>

                                                           <#list goals?split(",") as goal>
                                                                  <#if goal?has_content>
                                                                       <p>${goal?trim}</p>
                                                                  </#if>
                                                             </#list>

                                                       </div>
                                                   </#if>





                                  <#if extraCurricularActivities??
                                      && extraCurricularActivities?has_content  && !hasCollegeProjects>

                                  <div class="section">
                                      <h2>Extracurricular Activities</h2>

                                      <#list extraCurricularActivities?split(",") as activities>
                                          <#if activities?has_content>
                                              <p>${activities?trim}</p>
                                          </#if>
                                      </#list>
                                  </div>

                                  </#if>



                        <#if goals?? && goals?trim?length gt 0  && hasCollegeProjects >
                                <div class="section">
                                                   <h2>Goals</h2>
                                                    <ul>
                                                   <#list goals?split(",") as goal>
                                                          <#if goal?has_content>
                                                               <p>${goal?trim}</p>
                                                          </#if>
                                                     </#list>
                                                     </ul>
                                        </div>
                                           </#if>



                                       <#if hobbies?? && hobbies?trim?length gt 0 >
                         <div class="section">
                                              <h2>Hobbies</h2>
                                               <ul>
                                                 <#list hobbies?split(",") as hobbie>
                                                     <#if hobbie?has_content>
                                                          <p>${hobbie?trim}</p>
                                                     </#if>
                                                </#list>
                                           </ul>
                                           </div>
                                      </#if>



                 <#if addAdditionalDetails?? && addAdditionalDetails && !hasCollegeProjects>
                             <div class="section">
                                 <h2>Personal Details</h2>

                                 <#if fatherName?? && fatherName?has_content>
                                     <p><strong>Father's Name:</strong> ${fatherName}</p>
                                 </#if>

                                 <#if maritalStatus?? && maritalStatus?has_content>
                                     <p><strong>Marital Status:</strong> ${maritalStatus}</p>
                                 </#if>

                                 <#if gender?? && gender?has_content>
                                     <p><strong>Gender:</strong> ${gender}</p>
                                 </#if>

                                 <#if dob?? && dob?has_content>
                                      <p><strong>Dob:</strong> ${extractDobYear(dob)}</p>
                                  </#if>

                                 <#if languagesKnown?? && languagesKnown?has_content>
                                     <p><strong>Language Known:</strong>
                                         ${languagesKnown?replace(",", ", ")}
                                     </p>
                                 </#if>

                                 <#if nationality?? && nationality?has_content>
                                     <p><strong>Nationality:</strong> ${nationality}</p>
                                 </#if>

                             </div>
                        </#if>
    </div>
  </div>
</body>
