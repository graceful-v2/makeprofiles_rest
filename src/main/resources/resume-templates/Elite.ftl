<!DOCTYPE html>
<html lang="en">
<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="UTF-8" />
  <@fonts.loadFonts />
  <style>

  @page {
     size: A4;
     margin: 10mm 0mm;
     }

   html, body {
       margin: 0;
	  padding: 0;
	  width: 210mm;
	  box-sizing: border-box;
	  overflow-x: hidden;
	  word-break: break-word;
	  font-family: ${(style.primaryFont)!'Arial, sans-serif'};
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.2'};
      color: ${(style.bodyColor)!'#111'};

     }

    h1, h2 {
      color: #003366;
    }

    p{
       line-height:1.3;
       word-break: break-word;
       overflow-wrap: break-word;
    }

    h1 {
     font-size: ${(style.nameSize)!'22pt'};
     font-weight: ${(style.fontWeightname)!'800'};
     color: ${(style.nameColor)!'black'};
      text-align: center;
      margin-bottom: 5px;
    }

    h2 {
      font-size: 16px;
      border-bottom: 1px solid #003366;
      margin-top: 25px;
	  justify-content:center;
    }

    .contact {
      text-align: center;
      font-size: 13px;
      margin-bottom: 20px;
    }
    .section {
      margin-top: 15px;
    }

    .job-title {
      line-height: 1.5;
    }

    .job-details {
      margin: 5px 0 10px 0;
      line-height: 1.5;
    }

    .edu-entry, .strengths, .skills-list, .achievements-list, .org-skills {
      margin-bottom: 10px;
    }

    ul {
      padding-left: 18px;
      margin-top: 5px;
      margin-bottom: 5px;
    }

	li{
	padding-bottom:3px;
	line-height:1.3;
	}

    .declaration {
      margin-top: 20px;
      font-style: italic;
    }
    .two-col {
      display: flex;
      justify-content: space-between;
    }
    .column {
      width: 48%;
    }
    hr {
      border: none;
      border-top: 2px solid #003366;
      margin: 20px 0;
    }

	.section {
      margin-top: 13px;
      margin-bottom: 0px;
     }

     .section-title {

	  margin-bottom: 5px;
	  padding-bottom: 3px;
	  border-bottom: 1px solid #003366;
	  text-align: center;
	   font-size: ${(style.sectionTitleSize)!'13pt'};
        font-weight: ${(style.fontWeightHeading)!'600'};
      color: ${(style.headingColor)!'#003366'};

     }

	 .education{
	   padding-bottom: 3px;
	   margin-top:7px;
	 }

	 .percentage{
	   font-weight: bold;
	 }

	 .EducationYear{
	   font-weight: bold;
	 }

	 .container {
	      max-width: 190mm;
		  margin: auto;
		  padding: 10px 15px;
		  box-sizing: border-box;
		   overflow-wrap:break-word;
                word-break:break-word;
	  }

	  .section-subtitle{
	  font-weight: bold;
	  margin-bottom: 5px;
	  padding-bottom: 3px;
	  font-size: 17px;
	  color: #003366;
	  }

    .experience-item {
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 1px dashed #ccc;
    }

    .edu-entry{
     margin-top:20px;

    }
    .addAdditional{
     margin-top:3px;
     margin-bottom:3px;
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
      <h1>${name}</h1>

     <div class="contact">

       <#if email?has_content>
           ${email}
        </#if>

        <#if phone?has_content>
          |  ${phone}
         </#if>

         <#if linkedin?? && linkedin?has_content>
          | ${linkedin}
          </#if>

      </div>

       <#if objective?? && objective?has_content>
          <div class="section">
                <div class="section-title">Career Objectives</div>
                 <p>${objective}</p>
           </div>
        </#if>

       <#if summary?? && summary?has_content>
		   <div class="section">
			    <div class="section-title">Summary</div>
			     <p>${summary}</p>
			</div>
       </#if>

				<#if experiences?? && experiences?size gt 0>
				  <div class="section">
				    <div class="section-title">Professional Experience</div>

				    <#list experiences as experience>
				        <div class="experience-item">

				      <#if experience.companyName?? && experience.companyName?has_content>
				        <div class="job-title">
				            ${experience.companyName}
				          <#if experience.experienceYearStartDate?? && experience.experienceYearStartDate?has_content>
				            <span class="EducationYear">
				              ( ${extractmonth(experience.experienceYearStartDate)}
				              <#if experience.experienceYearEndDate?? && experience.experienceYearEndDate?has_content>
				                &#8211; ${extractmonth(experience.experienceYearEndDate)} )
				              <#else>
				                &#8211; Present )
				              </#if>
				            </span>
				          </#if>
				        </div>
				      </#if>

				      <#if experience.role?has_content || experience.responsibilities?trim?length gt 0>

				          <#if experience.role?? && experience.role?has_content>
				          	 <div class="job-title">
				               ${experience.role}
				             </div>
				          </#if>



				          <#if experience.responsibilities?? && experience.responsibilities?trim?length gt 0>
				          <div class="job-title">
				            <strong>Roles &#38; Responsibilities </strong>
				            <ul>
				              <#list experience.responsibilities?split(",") as item>
				                <#if item?has_content>
				                  <li>${item?trim}</li>
				                </#if>
				              </#list>
				            </ul>
				            </div>
				          </#if>

				      </#if>


				      <#if experience.projects?? && experience.projects?size gt 0>
				        <div class="sub-section">
				          <div class="section-subtitle">Projects</div>
				          <#list experience.projects as proj>

				            <#if proj.projectName?? && proj.projectName?has_content>
				              <div class="job-title"><strong>Name:</strong> ${proj.projectName}</div>
				            </#if>

				            <#if proj.projectSkills?? && proj.projectSkills?has_content>
							  <div class="job-title">
							    <strong>Skills:</strong>
							    <#list proj.projectSkills?split(",") as skill>
							      ${skill?trim}<#if skill_has_next>, </#if>
							    </#list>
							  </div>
							</#if>


				            <#if proj.projectRole?? && proj.projectRole?has_content>
				              <div class="job-title">
				                <strong>Role:</strong> ${proj.projectRole}
				                </div>

				                <#if proj.projectDescription?? && proj.projectDescription?has_content>
				                <div class="job-title">
				                  <strong>Description:</strong> ${proj.projectDescription}
				                  </div>
				                </#if>
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
			        <div class="section-title">Academic Project</div>

			        <#list collegeProject as project>

			            <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
			                <div><strong>Title:</strong> ${project.collegeProjectName}</div>
			            </#if>

			            <#if project.collegeProjectSkills?has_content>
			                <div class="job-details">
			                    <#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
			                        <strong>Skills:</strong> <br/>
			                        <ul>
			                            <#list project.collegeProjectSkills?split(",") as item>
			                                <#if item?has_content>
			                                    <li>${item?trim}</li>
			                                </#if>
			                            </#list>
			                        </ul>
			                    </#if>
			                </div>
			            </#if>

			            <#if project.collegeProjectDescription?has_content>
			                <div class="job-details">

			                    <p> <strong>Description:</strong> ${project.collegeProjectDescription}</p>
			                </div>
			            </#if>

			        </#list>
			    </div>
      </#if>



           <#if education?? && education?size gt 0>
			  <div class="section">
			      <div class="section-title">Education</div>
			           <div class="edu-entry">
			               <#list education as edu>
			                      <#if edu.department?has_content || edu.institutionName?has_content>
 			                            <div class="education">
			                               <#if edu.institutionName?? && edu.institutionName?has_content>
			                                 ${edu.institutionName}
			                                </#if>
			                                <#if edu.department?? && edu.department?has_content>
			                                  &#8211; ${edu.department}
			                                 </#if>

			                                <div style="margin-top:5px">
                                                 <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                                                   ${edu.fieldOfStudy}

                                                    <#if edu.percentage?? && edu.percentage?has_content>
                                                     <span class="percentage"> &#8211; ${edu.percentage}%</span>
                                                    </#if>

                                                    <#else>

                                                     <#if edu.percentage?? && edu.percentage?has_content>
                                                     <span class="percentage"> ${edu.percentage}%</span>
                                                    </#if>
                                                 </#if>

                                                     <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                                                       <span class="EducationYear">( ${extractmonth(edu.qualificationStartYear)}
                                                          <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                                                            &#8211; ${extractmonth(edu.qualificationEndYear)} )
                                                              <#else>
                                                          &#8211; Present )</#if></span>
                                                     </#if>
			                                  </div>

			                            </div>
			                        </#if>
 			                </#list>
 			            </div>
			     </div>
			  </#if>


			  <#if skills?? && skills?trim?length gt 0>
		        <div class="section">
		              <div class="section-title">Skills</div>
					             <#list skills?split(",") as skill>
					                   <#if skill?? && skill?has_content>
					                      <div class="detail-item">${skill?trim}</div>
					                    </#if>
					           </#list>

		        </div>
		    </#if>



			<#if achievements?? && achievements?size gt 0>
				 <div class="section">
				      <div class="section-title">Achievements</div>
				        <div class="achievements-list">
						    <ul>
						      <#list achievements as achieve>
						         <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
						            <li>${achieve.achievementsName}
						                <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
						                  <span class="EducationYear">${extractmonth(achieve.achievementsDate)} </span>
						                </#if>
						            </li>
						         </#if>
 						      </#list>
						    </ul>
				       </div>
				 </div>
		    </#if>

		    <#if certificates?? && certificates?size gt 0>
				 <div class="section">
				      <div class="section-title">Certificates</div>
				        <div class="achievements-list">
						    <ul>
						      <#list certificates as certi>
						         <#if certi.courseName?? && certi.courseName?has_content>
						            <li>${certi.courseName}
						                <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
						                   <span class="EducationYear"> ( ${extractmonth(certi.courseStartDate)}

								                   <#if  certi.courseEndDate?? && certi.courseEndDate?has_content>
		                                                    &#8211; ${extractmonth(certi.courseEndDate)} )
		                                             </#if>
                                            </span>
						                </#if>
						            </li>
						         </#if>
 						      </#list>
						    </ul>
				       </div>
				 </div>
		    </#if>

		    <#if competencies?? && competencies?trim?length gt 0>
		        <div class="section">
		              <div class="section-title">Core Competencies</div>

					             <#list competencies?split(",") as comp>
					                   <#if comp?? && comp?has_content>
					                      <div class="detail-item">${comp?trim}</div>
					                    </#if>
					           </#list>


		        </div>
		    </#if>

		    <#if softSkills?? && softSkills?trim?length gt 0>
		        <div class="section">
		              <div class="section-title">Soft Skills</div>

					             <#list softSkills?split(",") as skill>
					                   <#if skill?? && skill?has_content>
					                       <div class="detail-item">${skill?trim}</div>
					                    </#if>
					           </#list>

		        </div>
		    </#if>


              <#if strengths?? && strengths?trim?length gt 0>
                            <div class="section">
                                  <div class="section-title">Strengths</div>
                                     <#list strengths?split(",") as skill>
                                           <#if skill?? && skill?has_content>
                                               <div class="detail-item">${skill?trim}</div>
                                            </#if>
                                   </#list>

                            </div>
                     </#if>


                     <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                               <div class="section">
                                   <div class="section-title">Extracurricular Activites</div>
                                      <#list extraCurricularActivities?split(",") as skill>
                                            <#if skill?? && skill?has_content>
                                              <div class="detail-item">${skill?trim}</div>

                                             </#if>
                                       </#list>

                             </div>
                      </#if>

                       <#if goals?? && goals?trim?length gt 0>
                                     <div class="section">
                                         <div class="section-title">Goals</div>
                                            <#list goals?split(",") as skill>
                                                  <#if skill?? && skill?has_content>
                                                      <div class="detail-item">${skill?trim}</div>
                                                   </#if>
                                             </#list>

                                   </div>
                            </#if>


                             <#if addAdditionalDetails>
                                         <div class="section">
                                             <div class="section-title">Personal Details</div>

                                             <#if fatherName?? && fatherName?has_content>
                                                 <div class="detail-item">
                                                     <strong>Father's Name:</strong> ${fatherName}
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
