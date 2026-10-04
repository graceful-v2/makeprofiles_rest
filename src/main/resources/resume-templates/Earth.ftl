<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
    <@fonts.loadFonts />
     <style>
        @page {
            size: A4;
            margin:10mm 10mm;
        }

        html, body {
            margin: 0;
            padding: 0;
            width: 210mm;
            box-sizing: border-box;
            background: white;
            font-family: ${(style.primaryFont)!'Arial, sans-serif'};
            font-size: ${(style.bodySize)!'12pt'};
            line-height: ${(style.lineSpacing)!'1.2'};
            color: ${(style.bodyColor)!'#111'};
        }

        .container {
            width: 200mm;

            margin: auto;
            background: white;
            box-sizing: border-box;
            overflow-wrap:break-word;

        }

        .header {
            margin-bottom: 6px;
        }

        .contact-info {
            font-size: 13pt;
            color: black;
			font-weight:500;
			font-family: "Times New Roman", Times, serif;
        }

        h1 {
            margin: 0;

			font-family: "Times New Roman", Times, serif;
			font-size: ${(style.nameSize)!'28pt'};
            font-weight: ${(style.fontWeightname)!'800'};
            color: ${(style.nameColor)!'#111'};
        }

        h2 {
		    font-family: "Times New Roman", Times, serif;
            border-bottom: 1px solid #003366;
            margin-top: 4px;
            font-size: ${(style.sectionTitleSize)!'18pt'};
             font-weight: ${(style.fontWeightHeading)!'600'};
             color: ${(style.headingColor)!'#0000ff'};

        }

        h3 {
            margin: 4px 0;
            font-size: 15px;
			color:#1a75cf;
        }

        p, ul {
            margin: 3px 0;
            line-height: 1.5;
        }

        ul {
            padding-left: 15px;
        }

        ul li {
            margin: 2px 0;
        }

        .content-wrapper {
            display: table;
            width: 100%;
        }

        .left-column {
            display: table-cell;
            width: 45%;
            padding-right: 5mm;
            vertical-align: top;
             overflow-wrap:break-word;
             word-break:break-word;
        }

        .right-column {
            display: table-cell;
            width: 55%;
            padding-left: 5mm;
            vertical-align: top;
             overflow-wrap:break-word;
             word-break:break-word;
        }

        .section {
            margin-bottom: 6px;
        }
		 
		.skills-text {
         font-size: 15px;
         
         }
		 .certificates{
		    margin-top:5px;
		 
		 }

		 .experience-item {
          margin-bottom: 7px;
          padding-bottom: 7px;
          border-bottom: 1px dashed #2d2a2a;
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
        <div class="header">
            <h1>${name}</h1>
        
            <p class="contact-info"> ${phone} | ${email}
           
            <#if linkedin?? && linkedin?has_content>
             | ${linkedin}
            </#if> 
               
               </p>
        </div>

       

      <div class="content-wrapper">
           <div class="left-column">
			
			<#if objective?? && objective?has_content>
			     <div class="section">
                    <h2>Career Objective</h2>
                        <p>${objective}</p>
                </div>
			</#if>
			

		   
		  <#if skills?? && skills?trim?length gt 0>
        				  <div class="section">
                               <h2>Skills</h2>
                                  <p class="skills-text">
                                     <#list skills?split(",") as skill>${skill?trim}<#if skill_has_next>, </#if></#list>
                                   </p>
                           </div>
        			 </#if>




            <#if competencies?? && competencies?trim?length gt 0>
                             <div class="section">
                                  <h2>Core Competencies</h2>
                                    <#list competencies?split(",") as com>
                                         <#if com?has_content>
                                              <p>${com?trim}</p>
                                          </#if>
                                     </#list>
                             </div>
           		      </#if>
           
           
           <#if achievements?? && achievements?size gt 0>
                <div class="section">
                    <h2>Achievements</h2>
                        <#list achievements as achieve>
                            <div class="certificates">
                                 <#if achieve.achievementsName??  && achieve.achievementsName?has_content> 
                                 <strong><a>${achieve.achievementsName}</a></strong>
                    
		                         <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
		                           &#8211; ( ${extractmonth(achieve.achievementsDate)} )
		                          </#if> 
		                          
		                          </#if> 
                              </div>  
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





            <#if addAdditionalDetails && !hasCollegeProjects>
                    <div class="section">
                        <h2>Personal Details</h2>

                        <#if fatherName?? && fatherName?has_content>
                            <p><strong>Father Name:</strong> ${fatherName}</p>
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

                         <#if address?? && address?has_content>
                             <p><strong>Address:</strong> ${address}</p>
                         </#if>


                    </div>
               </#if>


                 <#if goals?? && goals?trim?length gt 0 &&  !addAdditionalDetails && !hasCollegeProjects>
                                                   <div class="section">
                                                       <h2>Goals</h2>
                                                       <#list goals?split(",") as goal>
                                                              <#if goal?has_content>
                                                                   <p>${goal?trim}</p>
                                                              </#if>
                                                         </#list>
                                                   </div>
                                               </#if>



                       <#if hobbies?? && hobbies?trim?length gt 0 &&  !addAdditionalDetails && !hasCollegeProjects>
                          <div class="section">
                              <h2>Hobbies</h2>
                                 <#list hobbies?split(",") as hobbie>
                                     <#if hobbie?has_content>
                                          <p>${hobbie?trim}</p>
                                     </#if>
                                </#list>
                          </div>
                      </#if>




               	<#if collegeProject?? && collegeProject?size gt 0>
                            				 <div class="section">
                                                  <h2>Academic Project</h2>
                                               <#list collegeProject as project>
                                                    <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
                                                   <p> <strong>Title: </strong> ${project.collegeProjectName}</p>
                                                    </#if>

                                               <#if  project?? &&  project.collegeProjectSkills?? &&  project.collegeProjectSkills?trim?length gt 0>

                                                    <p class="skills-text">
                            							   <strong> Skills: </strong>
                            							   <#list project.collegeProjectSkills?split(",") as skill>
                            							      ${skill?trim}<#if skill_has_next>, </#if>
                            							   </#list>
                            						</p>
                                                </#if>

                                               <#if  project?? && project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>

                                                   <strong> Descrption: </strong>
                                                  <ul>
                                                       <li>${project.collegeProjectDescription}</li>
                                                  </ul>
                                               </#if>
                                                </#list>
                                              </div>
                            			</#if>

			  
       </div>

        <div class="right-column">

        	<#if summary?? && summary?has_content>
                         <div class="section">
                             <h2>Professional Summary</h2>
                                 <p>${summary}</p>
                         </div>
                    </#if>
            

 <#if education?? && education?size gt 0>
				 <div class="section">
                     <h2>Education Details</h2>
                          <#list education as edu>
                          <div class="experience-item">

                          <#if edu.department?? && edu.department?has_content || edu.instutionName?has_content>
                             <p>
                               <#if edu.department?? && edu.department?has_content>
                                   <strong>${edu.department}</strong><br />
                                </#if>

                                <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                                     ${edu.fieldOfStudy}
	                                  <#if edu.percentage?? && edu.percentage?has_content>
	                                 &#8211; ${edu.percentage}% <br />
	                                </#if>
	                                <#else>
                                     <#if edu.percentage?? && edu.percentage?has_content>
                                          ${edu.percentage}%
                                        </#if>
                                </#if>



	                             <#if edu.institutionName?? && edu.institutionName?has_content>
	                                 ${edu.institutionName} <br />
	                             </#if>

                             <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                               (${extractmonth(edu.qualificationStartYear)} &#8211;
                                  <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                                      ${extractmonth(edu.qualificationEndYear)}
                                       <#else>
                                        Present </#if>)
                              </#if>
                              </p>
                           </#if>

                               </div>
                          </#list>
                 </div>
            </#if>


              <#if softSkills?? && softSkills?trim?length gt 0> 
                   <div class="section">
                        <h2>Soft Skills</h2>
                        <#list softSkills?split(",") as skill>
                           <#if skill?has_content>
                                <p>${skill?trim}</p>
                           </#if>
                      </#list>
                   </div>
               </#if>    

                 <#if certificates?? && certificates?size gt 0>
                            <div class="section">
                                <h2>Certificates</h2>
                                    <#list certificates as certificate>
                                        <div class="certificates">

                                             <#if certificate.courseName?? && certificate.courseName?has_content>
                                             <strong><a>${certificate.courseName}</a></strong>

                                             <#if certificate.courseStartDate?? && certificate.courseStartDate?has_content>
                                                &#8211; ${extractmonth(certificate.courseStartDate)}

                                                <#if certificate.courseEndDate?? && certificate.courseEndDate?has_content>
                                                							  &#8211; ${extractmonth(certificate.courseEndDate)}

                                                					</#if>
                                              </#if>

                                              </#if>
                                         </div>
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

                         <#if addAdditionalDetails || hasCollegeProjects>

                               <#if goals?? && goals?trim?length gt 0>
                                    <div class="section">
                                        <h2>Goals</h2>
                                        <#list goals?split(",") as goal>
                                               <#if goal?has_content>
                                                    <p>${goal?trim}</p>
                                               </#if>
                                          </#list>
                                    </div>
                                </#if>
                              </#if>


                         <#if addAdditionalDetails || hasCollegeProjects>
                                <#if hobbies?? && hobbies?trim?length gt 0>
                                   <div class="section">
                                       <h2>Hobbies</h2>
                                          <#list hobbies?split(",") as hobbie>
                                              <#if hobbie?has_content>
                                                   <p>${hobbie?trim}</p>
                                              </#if>
                                         </#list>
                                   </div>
                               </#if>
                            </#if>


                              <#if addAdditionalDetails && hasCollegeProjects>
                                                 <div class="section">
                                                     <h2>Personal Details</h2>

                                                     <#if fatherName?? && fatherName?has_content>
                                                         <p><strong>Father Name:</strong> ${fatherName}</p>
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

                                                      <#if address?? && address?has_content>
                                                          <p><strong>Address:</strong> ${address}</p>
                                                      </#if>


                                                 </div>
                                            </#if>

            </div>
        </div>

          <#if experiences?? && experiences?size gt 0>
                             <div class="section">
                                 <h2>Work Experience</h2>

                                 <#list experiences as experience>
                                      <div class="experience-item">

                                     <#-- Role -->
                                     <#if experience.companyName?? && experience.companyName?has_content>
                                         <h3>${experience.companyName}</h3>
                                     </#if>

                                     <p><strong>
                                         <#-- Company Name -->
                                         <#if experience.role?? && experience.role?has_content>
                                              ${experience.role}
                                         </#if>

                                         <#-- Experience Dates -->
                                         <#if experience.experienceYearStartDate?? && experience.experienceYearStartDate?has_content>
                                             ( ${extractmonth(experience.experienceYearStartDate)}  &#8211;

                                             <#if experience.experienceYearEndDate?? && experience.experienceYearEndDate?has_content>
                                                 ${extractmonth(experience.experienceYearEndDate)} )
                                             <#else>
                                                 Present )
                                             </#if>
                                         </#if>
                                     </strong></p>

                                     <#-- Responsibilities -->
                                     <#if experience?? && experience.responsibilities?? && experience.responsibilities?trim?length gt 0>
                                         <ul>
                                             <#list experience.responsibilities?split(",") as item>
                                                 <#if item?has_content>
                                                     <li>${item?trim}</li>
                                                 </#if>
                                             </#list>
                                         </ul>
                                     </#if>

                                     <#-- Projects under Work Experience -->
                                     <#if experience.projects?? && experience.projects?size gt 0>
                                         <div class="section">
                                             <h3>Projects</h3>
                                             <#list experience.projects as proj>
                                                 <#if (proj??)
                                                     && (
                                                         (proj.projectName?? && proj.projectName?has_content)
                                                         || (proj.projectRole?? && proj.projectRole?has_content)
                                                         || (proj.projectSkills?? && proj.projectSkills?has_content)
                                                         || (proj.projectDescription?? && proj.projectDescription?has_content)
                                                     )
                                                 >

                                                     <#if proj.projectName?? && proj.projectName?has_content>
                                                         <p><strong>Name:</strong> ${proj.projectName}</p>
                                                     </#if>


                                                     <#if proj.projectRole?? && proj.projectRole?has_content>
                                                         <p><strong>Role:</strong> ${proj.projectRole}</p>
                                                     </#if>


                                                     <#if proj.projectSkills?? && proj.projectSkills?has_content>
                                                         <p>
                                                             <strong>Skills:</strong>
                                                             <#list proj.projectSkills?split(",") as skill>
                                                                 ${skill?trim}<#if skill_has_next>, </#if>
                                                             </#list>
                                                         </p>
                                                     </#if>


                                                     <#if proj.projectDescription?? && proj.projectDescription?has_content>
                                                         <p><strong>Description:</strong> ${proj.projectDescription}</p>
                                                     </#if>

                                                     <br/>
                                                 </#if>
                                             </#list>
                                         </div>
                                     </#if>
                                    </div>
                                 </#list>
                             </div>
                         </#if>









     </div>



</body>
</html>
