
<!DOCTYPE html>
<html>
  <head>
   <#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
     <@fonts.loadFonts />
    <style>
     @page {
        size: A4;
        margin: 10mm 10mm;
      }
      html,body {
       margin: 0;
        padding: 0;
         display: flex;
        justify-content: center;
        align-items: flex-start;
        font-family: ${(style.primaryFont)!'sans-serif'};
        font-size: ${(style.bodySize)!'12pt'};
        line-height: ${(style.lineSpacing)!'1.3'};
        color: ${(style.bodyColor)!'#333'};

      }
      .container {
        max-width: 210mm;
        width: 100%;
        overflow-wrap:break-word;
        word-break:break-word;

      }
      h1 {

        margin-bottom: 2px;
        font-size: ${(style.nameSize)!'25pt'};
         font-weight: ${(style.fontWeightname)!'800'};
          color: ${(style.nameColor)!'#222'};
      }
      h2 {

        text-transform: uppercase;
        margin-bottom: 6px;
        text-decoration: underline;
        text-underline-offset: 4px;
        text-decoration-thickness: 1.5px;
        padding-bottom: 5px;
         font-size: ${(style.sectionTitleSize)!'15pt'};
          font-weight: ${(style.fontWeightHeading)!'700'};
          color: ${(style.headingColor)!'#222'};
      }
      h3 {

        margin: 2px 0;
        font-weight: bold;
      }
      p {
        margin: 2px 0 8px 0;
      }
      .header {
        text-align: left;
        margin-bottom: 15px;
      }
      .sub-header {

        color: #666;
      }
      .divider {
        border-bottom: 1px solid #999;
      }
      .section {
        margin-bottom: 12px;
      }
      .two-columns {
        overflow-wrap:break-word;

      }
      .two-columns div {
        margin:6px 0px;
      }
      .skills {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* exactly 2 columns */
        gap: 10px 30px; /* space between rows and columns */
        margin-top: 8px;
      }

      .skills div {
        width: 100%;
      }

      .small-text {
        color: #131313;
        margin-top: 3px;
        margin-bottom:4px;
      }
      .exp {
        border-bottom: 1px solid black;
        margin-top: 8px;
      }

      .project {
        margin-left: 10px;
        margin-bottom: 10px;
      }

      .experience-project {
        margin-bottom: 10px;
        border-bottom: 1px solid rgb(180, 157, 157);
      }
      .contact-item{
       margin:5px 0px;
      }

      .exp-item{
       margin:7px 0px;
      }

      .education-items{
       margin-top: 5px;
       margin-bottom: 10px;
       border-bottom:1px solid  rgb(180, 157, 157);
      }

      .hobbies-item{
        margin:5px 0px;
      }

      .small-text {
            line-height: 1.4;
          }

     .contact-details div {
            margin-bottom: 5px;
            margin-top: 5px;
            overflow-wrap: break-word;

          }




    </style>
  </head>

<body>

  <#function extractYear input>
    <#if input?is_date>
      <#return input?string("yyyy")>
    <#elseif input?? && input?has_content>
      <#attempt>
        <#local parsedDate = input?date("dd/MM/yyyy")>
        <#return parsedDate?string("MM/yyyy")>
      <#recover>
        <#attempt>
          <#local parsedDate = input?date("yyyy-MM-dd")>
          <#return parsedDate?string("MM/yyyy")>
        <#recover>
          <#return "">
        </#attempt>
      </#recover>
    <#else>
      <#return "">
    </#if>
  </#function>

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
    <div class="header">
      <h1>${name!""}</h1>

      <div class="contact-info">
           <#if phone?? && phone?has_content>
            <div class="contact-item">${phone}</div>
            </#if>

            <#if email?? && email?has_content>
               <div class="contact-item">${email}</div>
            </#if>

            <#if linkedin?? && linkedin?has_content>
               <div class="contact-item">${linkedin}</div>
            </#if>

      </div>
    </div>

    <!-- SUMMARY -->
    <#if summary?? && summary?has_content>
      <div class="section">
        <h2>Summary</h2>
        <p>${summary}</p>
      </div>
    </#if>

    <!-- OBJECTIVES -->
    <#if objective?? && objective?has_content>
      <div class="section">
        <h2>Objectives</h2>
        <p>${objective}</p>
      </div>
    </#if>

    <!-- SKILLS -->
    <#if skills?? && skills?has_content>
      <div class="section">
        <h2>Skills</h2>
        <div class="skills">
          <#list skills?split(",") as skill>
            <div>${skill}</div>
          </#list>
        </div>
      </div>
    </#if>


    <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <h2>Experience</h2>
        <#list experiences as exp>
          <div class="exp">

		    <#if exp.companyName?? && exp.companyName?has_content>
            <h3>${exp.companyName}</h3>
			</#if>

			 <#if exp.role?? && exp.role?has_content>
			  <div class="small-text">${exp.role}</div>
			 </#if>

			 <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
             <div class="small-text">
              <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                   ${extractYear(exp.experienceYearStartDate)}
                  <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                    &#8211; ${extractYear(exp.experienceYearEndDate)}
                  <#else>
                    &#8211; Present
                  </#if>

                </#if>
             </div>
			 </#if>



             <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
               <div class="exp-item"> <p>${exp.responsibilities}</p> </div>
              </#if>


            <#if exp.projects?? && exp.projects?size gt 0>
              <div class="project">
                <h2>Projects</h2>
                <#list exp.projects as project>
                   <div class="experience-project">
                     <#if project.projectName?? && project.projectName?has_content>
					<h3>${project.projectName}</h3>
					 </#if>

					<#if project.projectRole?? && project.projectRole?has_content>
                      <div class="small-text">${project.projectRole}</div>
				    </#if>

					<#if project.projectDescription?? && project.projectDescription?has_content>
                    <p>${project.projectDescription}</p>
					</#if>

                    <#if project.projectSkills?? && project.projectSkills?has_content>
                      <ul>
                        <#list project.projectSkills?split(",") as skill>
                          <li>${skill}</li>
                        </#list>
                      </ul>
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
			<h2>Academic Project</h2>

			<#list collegeProject as project>
			  <div class="exp">
				<#if project.collegeProjectName?? && project.collegeProjectName?has_content>
				  <h3>${project.collegeProjectName}</h3>
				</#if>

				<#if project.collegeProjectDescription?? && project.collegeProjectDescription?has_content>
				  <p>${project.collegeProjectDescription}</p>
				</#if>

				<#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
				  <div>
					<h3>Skills:</h3>
					 <ul>
                        <#list project.collegeProjectSkills?split(",") as skill>
                          <li>${skill}</li>
                        </#list>
                      </ul>
				  </div>
				</#if>
			  </div>
			</#list>
		  </div>
		</#if>


    <#if education?? && education?size gt 0>
      <div class="section">
        <h2>Education</h2>

          <#list education as edu>
           <div class="education-items">

             <#if edu.institutionName??>
                       <b>${edu.institutionName}</b> <br />
               </#if>
			<#if edu.department?? && edu.department?has_content>
              <b>${edu.department}</b><br />
			 </#if>



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

			  <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                <div class="small-text">  ${extractmonth(edu.qualificationStartYear)}
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


    <#if certificates?? && certificates?size gt 0>
      <div class="section">
        <h2>Certifications</h2>

          <#list certificates as cert>
            <div class="two-columns">
				<#if cert.courseName?? && cert.courseName?has_content>
				  <b>${cert.courseName}</b><br />

				  <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
				   <div class="small-text">
				   <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
						  ( ${extractmonth(cert.courseStartDate)}
						  <#if cert.courseEndDate?? && cert.courseEndDate?has_content>
							&#8211; ${extractmonth(cert.courseEndDate)}
						  <#else>
							)
						  </#if>
						  )
						</#if>
				   </div>
				  </#if>

				 </#if>
            </div>
          </#list>

      </div>
    </#if>


    <#if achievements?? && achievements?size gt 0>
      <div class="section">
        <h2>Achievements & Awards</h2>

          <#list achievements as achieve>
            <div class="two-columns">
			<#if achieve.achievementsName?? && achieve.achievementsName?has_content>
              <b>${achieve.achievementsName}</b><br />

			  <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
              <div class="small-text">${extractmonth(achieve.achievementsDate)}</div>
			  </#if>
			 </#if>
            </div>
          </#list>

      </div>
    </#if>


    <#if softSkills?? && softSkills?has_content>
      <div class="section">
        <h2>Soft Skills</h2>
        <ul class="list-items">
          <#list softSkills?split(",") as skill>
            <#if skill?has_content>
               <li class="hobbies-item">${skill?trim}</li>
            </#if>
          </#list>
      </ul>
      </div>
    </#if>


    <#if competencies?? && competencies?has_content>
      <div class="section">
        <h2>Core Competencies</h2>
        <ul class="list-items">
          <#list competencies?split(",") as skill>
            <#if skill?has_content>
               <li class="hobbies-item">${skill?trim}</li>
            </#if>
          </#list>
      </ul>
      </div>
    </#if>

    <#if goals?? && goals?has_content>
          <div class="section">
            <h2>Goals</h2>
            <ul class="list-items">
              <#list goals?split(",") as skill>
                <#if skill?has_content>
                   <li class="hobbies-item">${skill?trim}</li>
                </#if>
              </#list>
          </ul>
          </div>
        </#if>


        <#if strengths?? && strengths?has_content>
              <div class="section">
                <h2>Strengths</h2>
                 <ul class="list-items">
                   <#list strengths?split(",") as skill>
                     <#if skill?has_content>
                        <li class="hobbies-item">${skill?trim}</li>
                     </#if>
                   </#list>
               </ul>
              </div>
            </#if>


            <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
                  <div class="section">
                    <h2>ExtraCurricular Activities</h2>
                      <ul class="list-items">
                          <#list extraCurricularActivities?split(",") as skill>
                            <#if skill?has_content>
                               <li class="hobbies-item">${skill?trim}</li>
                            </#if>
                          </#list>
                      </ul>
                  </div>
                </#if>

             <#if hobbies?? && hobbies?has_content>
                      <div class="section">
                        <h2>Hobbies</h2>

                         <ul class="list-items">
                         <#list hobbies?split(",") as skill>
                           <#if skill?has_content>
                              <li class="hobbies-item">${skill?trim}</li>
                           </#if>
                         </#list>
                     </ul>

                      </div>
                    </#if>



                 <#if addAdditionalDetails?? && addAdditionalDetails>
                <div class="section">
                 <h2>Personal Details</h2>
                  <div class="contact-details small-text">

                    <#if fatherName?? && fatherName?has_content>
                    <div><strong>Father Name:</strong> ${fatherName}</div>
                    </#if>

                    <#if nationality?? && nationality?has_content>
                    <div><strong>Nationality:</strong> ${nationality}</div>
                    </#if>

                    <#if maritalStatus?? && maritalStatus?has_content>
                    <div><strong>Marital Status:</strong> ${maritalStatus}</div>
                    </#if>

                    <#if dob?? && dob?has_content>
                          <div> <strong>Dob :</strong> ${extractDobYear(dob)}</div>
                      </#if>

                    <#if gender?? && gender?has_content>
                    <div><strong>Gender:</strong> ${gender}</div>
                    </#if>

                    <#if address?? && address?has_content>
                    <div><strong>Address:</strong> ${address}</div>
                    </#if>

                    <#if languagesKnown?? && languagesKnown?has_content>
                    <div> <strong>Language Known :</strong> ${languagesKnown?replace(",", ", ")}</div>
                    </#if>

                  </div>
                </div>
                </#if>

  </div>
</body>
</html>