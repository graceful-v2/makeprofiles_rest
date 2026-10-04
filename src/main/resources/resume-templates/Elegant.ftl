
<!DOCTYPE html>
<html lang="en">
  <head>
  <#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
     <@fonts.loadFonts />
    <style>
      @page {
        size: A4;
        margin: 10mm 5mm;
      }
      body {
        margin: 0;
        padding: 0;
        font-family: ${(style.primaryFont)!'Arial,Helvetica, sans-serif'};
        font-size: ${(style.bodySize)!'11pt'};
        line-height: ${(style.lineSpacing)!'1.3'};
        color: ${(style.bodyColor)!'#1a1f36'};
      }

      .container {
        max-width: 210mm;
        width: 100%;
        margin: 0 auto;
        padding: 10px;
        box-sizing: border-box;
        display: flex;
        overflow-wrap:break-word;
        word-break:break-word;
      }

      .left-column {
        width: 35%;
        padding-right: 18px;
        border-right: 2px solid #d9d9d9;
        box-sizing: border-box;
        overflow-wrap:break-word;
        word-break:break-word;
      }

      .right-column {
        width: 65%;
        padding-left: 18px;
        box-sizing: border-box;
        overflow-wrap:break-word;
        word-break:break-word;
      }

      h1 {
        margin: 0 0 15px 0;
        letter-spacing: -0.5px;
        font-size: ${(style.nameSize)!'20pt'};
        font-weight: ${(style.fontWeightname)!'800'};
        color: ${(style.nameColor)!'#00539c'};

      }

      h2 {
        margin: 7px 0 7px 0;
        border-bottom: 2px solid #00539c;
        padding-bottom: 2px;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        font-style: italic;
        font-size: ${(style.sectionTitleSize)!'13pt'};
         font-weight: ${(style.fontWeightHeading)!'500'};
          color: ${(style.headingColor)!'#00539c'};
      }

      h3 {
        font-weight: bold;
        color: #333333;
        margin: 5px 0 2px 0;
      }

      p {
        margin: 0 0 6px 0;
        line-height: 16px;
      }

      .contact-info p {
        overflow-wrap: break-word;
        word-break:break-word;
        margin: 0 0 10px 0;
        color: #4d4d4d;
      }

      .summary {
        line-height: 16px;
        margin-bottom: 8px;
        font-style: italic;
        color: #333333;
      }

      ul {
        margin: 4px 0 10px 16px;
        padding: 0;
        list-style-type: disc;
      }

      ul li {
        margin-bottom: 4px;
        line-height: 16px;
        color: #333333;
      }

      .section-subtitle {
        font-weight: normal;
        color: #999999;
        margin-bottom: 4px;
      }

      .dates {
        color: #131212;
        margin-bottom: 6px;
      }

      .skills-list,
      .tools-list,
      .languages-list,
      .certifications-list,
      .additional-info-list {
        line-height: 16px;
        padding-left: 16px;
        margin-top: 4px;
        margin-bottom: 12px;
      }

      .skills-list li,
      .tools-list li,
      .languages-list li,
      .certifications-list li,
      .additional-info-list li {
        list-style: disc;
        margin-bottom: 3px;
      }

      .project {
        margin-left: 10px;
      }

      .sub-heading {
        color: #00539c;
        font-weight: bold;
        margin: 18px 0 8px 0;
        padding-bottom: 2px;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        font-style: italic;
        text-decoration: underline;
      }

      .skills{
        margin-top: 5px;
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
        <#local parsedDate = input?date("dd/MM/yyyy")>
        <#return parsedDate?string("MMM yyyy")>
      <#recover>
        <#attempt>
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
  <div class="left-column">


    <#if name?? && name?has_content>
      <h1>${name}</h1>
    </#if>


    <#if summary?has_content>
      <div class="summary">
        <h2>Summary</h2>
        <p>${summary}</p>
      </div>
    </#if>





    <#if skills?? && skills?trim?length gt 0>
      <h2>Skills</h2>
      <ul class="skills-list">
        <#list skills?split(",") as skill>
          <#if skill?has_content>
            <li>${skill?trim}</li>
          </#if>
        </#list>
      </ul>
    </#if>

    <#if softSkills?? && softSkills?trim?length gt 0>
      <h2>Soft Skills</h2>
      <ul class="skills-list">
        <#list softSkills?split(",") as skill>
          <#if skill?has_content>
            <li>${skill?trim}</li>
          </#if>
        </#list>
      </ul>
    </#if>


     <#if competencies?? && competencies?trim?length gt 0>
          <h2>Core Competencies</h2>
          <ul class="skills-list">
            <#list competencies?split(",") as skill>
              <#if skill?has_content>
                <li>${skill?trim}</li>
              </#if>
            </#list>
          </ul>
        </#if>


        <#if strengths?? && strengths?trim?length gt 0>
                <div class="section">
                    <h2>Strengths</h2>
                        <#list strengths?split(",") as strength>
                          <#if strength?has_content>
                               <p>${strength?trim}</p>
                          </#if>
                        </#list>
                </div>
            </#if>





    <#if certificates?? && certificates?size gt 0>
      <h2>Certification</h2>
      <ul class="certifications-list">
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
    </#if>


      			<#if achievements?? && achievements?size gt 0>
          <h2>Achievements</h2>
          <ul class="certifications-list">
           <#list achievements as achieve>
              <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                <li>${achieve.achievementsName}
                   <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
    					   ${extractmonth(achieve.achievementsName)}

                        <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                        						        &#8211;        ${extractmonth(achieve.achievementsDate)}
                        						                </#if>
    			        </#if>
    			</li>
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


     <#if addAdditionalDetails && hasCollegeProjects>
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

  <div class="right-column">

   <h2>Contact</h2>
      <div class="contact-info">
        <#if address?? && address?has_content>
          <p>${address}</p>
        </#if>
         <#if phone?? && phone?has_content>
                <p>${phone}</p>
              </#if>
        <#if email?? && email?has_content>
          <p>${email}</p>
        </#if>

        <#if linkedin?? && linkedin?has_content>
          <p>${linkedin}</p>
        </#if>
      </div>


    <#if objective?has_content>
      <div class="summary">
        <h2>Career Objectives</h2>
        <p>${objective}</p>
      </div>
    </#if>

    <#if education?? && education?size gt 0>
        <div class="section">
          <h2>Educational Background</h2>
          <#list education as edu>
            <div>
  		   <#if edu.department?? && edu.department?has_content>
              <h3>${edu.department}</h3>
  			</#if>
  			 <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
              <h3>${edu.fieldOfStudy}</h3>
  			</#if>
              <div class="dates">

              <#if edu.institutionName?? && edu.institutionName?has_content>
             ${edu.institutionName} <br/>
            </#if>

             <#if edu.percentage?? && edu.percentage?has_content>
                         ${edu.percentage}% <br/>
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
            </div>
          </#list>
        </div>
      </#if>


    <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <h2>Work Experience</h2>
        <#list experiences as exp>
          <div>

		   <#if exp.role?? && exp.role?has_content>

            <h3>${exp.role} ,

			 <#if exp.companyName?? && exp.companyName?has_content>
			    ${exp.companyName}
			</#if>

			</h3>
			</#if>

            <div class="dates">
              <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                ${extractmonth(exp.experienceYearStartDate)}
                <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                  &#8211; ${extractmonth(exp.experienceYearEndDate)}
                <#else>
                  &#8211; Present
                </#if>
              </#if>
            </div>
            <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
              <ul>
                <#list exp.responsibilities?split(",") as item>
                  <#if item?has_content>
                    <li>${item?trim}</li>
                  </#if>
                </#list>
              </ul>
            </#if>


            <#if exp.projects?? && exp.projects?size gt 0>
              <div class="project">
                <div class="sub-heading">Projects</div>
                <#list exp.projects as proj>

                  <#if proj.projectName??>
                   <h3>${proj.projectName}</h3>
                   </#if>


                  <#if proj.projectRole?? && proj.projectRole?has_content>
                    <p><strong>Role:</strong> ${proj.projectRole}</p>
                  </#if>

				    <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
					  <div class="skills">
						<span>
						  <strong>Skills :</strong>
						  <#list proj.projectSkills?split(",") as skill>
							${skill?trim}<#if skill_has_next>, </#if>
						  </#list>
						</span>
					  </div>
					</#if>


                <#if proj.projectDescription?? && proj.projectDescription?has_content>
				    <div class="skills">
                     <ul>
						  <li>${proj.projectDescription}</li>
					  </ul>
					</div>
                  </#if>

                </#list>
              </div>
            </#if>
          </div>
        </#list>
      </div>
    </#if>

	<#if collegeProject?? && collegeProject?size gt 0>
			<div class="section">
			 <#list collegeProject as project>


				  <h2>Academic Project</h2>


				  <div>
				  <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
					<h3>${project.collegeProjectName}</h3>
				  </#if>

					<#if project.collegeProjectSkills?? &&  project.collegeProjectSkills?trim?length gt 0>
					 <span><strong>Skills:</strong> </span>
						<ul>
						 <#list project.collegeProjectSkills?split(",") as skills>
							  <#if skills?? &&  skills?has_content>
								<li>${skills}</li>
							  </#if>
							</#list>
						</ul>
					</#if>

				 <#if project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>
    		               <p><strong>Description:</strong> ${project.collegeProjectDescription}</p>
    		      </#if>

					</div>
				</#list>
			  </div>
	 </#if>


                 <#if goals?? && goals?trim?length gt 0  >
                               <div class="section">
                                   <h2>Goals</h2>
                                   <#list goals?split(",") as goal>
                                          <#if goal?has_content>
                                               <p>${goal?trim}</p>
                                          </#if>
                                     </#list>
                               </div>
                           </#if>



                       <#if hobbies?? && hobbies?trim?length gt 0 >
                          <div class="section">
                              <h2>Hobbies</h2>
                                 <#list hobbies?split(",") as hobbie>
                                     <#if hobbie?has_content>
                                          <p>${hobbie?trim}</p>
                                     </#if>
                                </#list>
                          </div>
                      </#if>

<#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                                 <div class="section">
                                    <h2>Extracurricular Activites</h2>
                                         <#list extraCurricularActivities?split(",") as activities>
                                           <#if activities?has_content>
                                                <p>${activities?trim}</p>
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


     <#if addAdditionalDetails && !hasCollegeProjects>
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
</html>