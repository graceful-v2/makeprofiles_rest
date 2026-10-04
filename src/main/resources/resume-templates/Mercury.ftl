<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
<@fonts.loadFonts />
    <style>
        @page {
            size: A4;
            margin-top: 10mm;
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
           width: calc(210mm - 24mm);
           height: 277mm;
           margin: auto;
           background: white;
           box-sizing: border-box;
           overflow-wrap:break-word;

           word-break: break-word;
       }


        .header {
            margin-bottom: 6px;
        }

        .contact-info {
            font-size: 12pt;
            color: black;
			font-weight: bold;
        }

        h1 {
            margin: 0;

          font-size: ${(style.nameSize)!'25pt'};
           font-weight: ${(style.fontWeightname)!'800'};
           color: ${(style.nameColor)!'#111'};
        }

        h2 {
        border-bottom: 1px solid #003366;
        margin-top: 8px;
        margin-bottom: 8px;
          font-size: ${(style.sectionTitleSize)!'13pt'};
          font-weight: ${(style.fontWeightHeading)!'600'};
          color: ${(style.headingColor)!'#003366'};
        }

        h3 {
            margin: 4px 0;
            font-size: 12pt;
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
            width: 50%;
            padding-right: 5mm;
            vertical-align: top;
        }

        .right-column {
            display: table-cell;
            width: 50%;
            padding-left: 5mm;
            vertical-align: top;
        }

        .section {
            margin-bottom: 6px;
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
            <p class="contact-info"> <img src="${phoneIcon}" style="width:16px; height:16px; vertical-align:middle;" />  ${phone} | <img src="${mailIcon}" style="width:16px; height:16px; vertical-align:middle;" />  ${email}
           
           <#if linkedin?has_content>
           | ${linkedin}
           </#if> 
            </p>
        </div>

    <#if objective?has_content>
        <div class="section">
            <h2>Career Objective</h2>
            <p>${objective}</p>
        </div>
     </#if> 
     
     
        <div class="content-wrapper">
            <div class="left-column">
       <#if summary?has_content>
                <div class="section">
                    <h2>Professional Summary</h2>
                    <p>${summary}</p>
                </div>
       </#if>           

           <#if experiences?? && experiences?size gt 0>
                <div class="section">
                    <h2>Work Experience</h2>
                    <#list experiences as experience>
						  <div class="experience-item">
						  
						     <#if experience.companyName?has_content>
						        <p>${experience.companyName}</p>
						     </#if>
						     
						     <#if experience.role?has_content || experience.experienceYearStartDate?has_content>
						        <p>
						          <#if experience.role?has_content>
						            ${experience.role}
						          </#if>   
						          
						          <#if experience.experienceYearStartDate?? && experience.experienceYearStartDate?has_content>    
						            <img src="${calendarIcon}" style="width:16px; height:16px; vertical-align:middle; margin-top:10px;" />  
						            (${extractmonth(experience.experienceYearStartDate)} &#8211;
						              <#if experience.experienceYearEndDate?? && experience.experienceYearEndDate?has_content> 
						                ${extractmonth(experience.experienceYearEndDate)}
						              <#else> Present </#if>)
						          </#if>     
						        </p>
						     </#if>  
						     
						     <#if experience?? && experience.responsibilities?? && experience.responsibilities?trim?length gt 0>
						        <p><strong>Responsibilities: </strong></p>
						        <ul>
						            <#list experience.responsibilities?split(",") as item>
						               <#if item?has_content>
						                 <li>${item?trim}</li>
						               </#if>  
						            </#list>
						        </ul>
						     </#if>  
						
						  </div>  
						</#list>

                </div>
            </#if> 



            <#if collegeProject?? && collegeProject?size gt 0>
				    <div class="section">
				        <h2>Academic Project</h2>
				        <#list collegeProject as project>
				            <#if project.collegeProjectName?? &&  project.collegeProjectName?has_content>
				                <p><strong>Title: </strong>${project.collegeProjectName}</p>
				            </#if>
				
				            <#if project.collegeProjectSkills?? && project.collegeProjectSkills?has_content>
				            
				            <p><strong>Skills:</strong></p>
				            
				                <ul>
				                    <#list project.collegeProjectSkills?split(",") as skill>
				                        <#if skill?has_content>
				                            <li>${skill?trim}</li>
				                        </#if>
				                    </#list>
				                </ul>


				            </#if>
				
				            <#if project.collegeProjectDescription?? &&  project.collegeProjectDescription?has_content>
				                <p><strong>Description:</strong> ${project.collegeProjectDescription}</p>
				            </#if>
				        </#list>
				    </div>
          </#if>
          
          <#if education?? && education?size gt 0>
                <div class="section">
                    <h2>Education Details</h2>
                    <#list education as edu>

                     <div class="experience-item">
                    
                    <#if edu.department?has_content || edu.institutionName?has_content>
                        <p>
                        
                        <#if edu.department?has_content>
                            ${edu.department} <br />
                        </#if>
                        
                        <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                            ${edu.fieldOfStudy}

                           <#if edu.percentage?? && edu.percentage?has_content>
						          &#8211; ${edu.percentage}%
						           <br />
						    </#if>
                             <#else>
                             <#if edu.percentage?? && edu.percentage?has_content>
                                 ${edu.percentage}%
                            </#if>

                        </#if>
                     
	                    <#if edu.institutionName?has_content>  
	                         ${edu.institutionName}
	                     </#if>
                        
                        <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                            ${extractmonth(edu.qualificationStartYear)}
                        <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                            &#8211; ${extractmonth(edu.qualificationEndYear)}
                            <#else>
                                &#8211; Present
                        </#if>
                           </#if> 
                         </p>
                      </#if>
                      </div>
                    </#list>
                </div>
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



                 <#if !hasCollegeProjects  && addAdditionalDetails>
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

                                  <#if address?? && address?has_content>
                                      <p><strong>Address:</strong> ${address}</p>
                                  </#if>


                             </div>
                        </#if>



      </div>
            <div class="right-column">
            
            <#if skills?? && skills?trim?length gt 0>
                <div class="section">
                    <h2>Technical Skills</h2>
                    <ul>
                        <#list skills?split(",") as skill>
                          <#if skill?has_content>
                             <li>${skill?trim}</li>
                          </#if>  
                        </#list>
                    </ul>
                </div>
            </#if>   


              <#assign hasProjects = false>
			<#if experiences?? && experiences?size gt 0>
			    <#list experiences as exp>
			        <#if exp.projects?? && exp.projects?size gt 0>
			            <#list exp.projects as proj>
			                <#if (proj.projectName?? && proj.projectName?has_content) 
			                   || (proj.projectRole?? && proj.projectRole?has_content) 
			                   || (proj.projectDescription?? && proj.projectDescription?has_content)>
			                       <#assign hasProjects = true>
			                       <#break>
			                </#if>
			            </#list>
			        </#if>
			        <#if hasProjects>
			            <#break>
			        </#if>
			    </#list>
			</#if>


         <#if hasProjects>
             <div class="section">
                 <h2>Projects</h2>
         <#list experiences as exp>
            <#if exp.projects?? && exp.projects?size gt 0>
                <#list exp.projects as proj>
                  <div class="experience-item">
                
                <#if exp.companyName?has_content>
                    <p><strong>Company Name:</strong> ${exp.companyName}</p>
                 </#if>
                <#if proj.projectName?? && proj.projectName?has_content>
                    <p><strong>Name:</strong> ${proj.projectName}</p>
                 </#if>
                 
                 <#if proj.projectRole?? && proj.projectRole?has_content>   
                    <p><strong>Role:</strong> ${proj.projectRole}</p>
                  </#if> 
                  
                  <#if proj.projectSkills?? && proj.projectSkills?has_content>   
                    <p><strong>Skills: </strong><#list proj.projectSkills?split(",") as skill>${skill?trim}<#if skill_has_next>, </#if></#list></p>
                    
                  </#if> 
                   
                  <#if proj.projectDescription?? && proj.projectDescription?has_content>
                    <p><strong>Description:</strong> ${proj.projectDescription}</p>
                    </#if>
                    
                      </div>
                </#list>
            </#if>
          </#list>
         </div>
        </#if>


            
         <#if softSkills?? && softSkills?trim?length gt 0>
                <div class="section">
                    <h2>Soft Skills</h2>
                    <ul>
                        <#list softSkills?split(",") as skill>
                           <#if skill?has_content>
                              <li>${skill?trim}</li>
                           </#if>   
                        </#list>
                    </ul>
                </div>
           </#if>
           
          <#if competencies?? && competencies?trim?length gt 0>
                <div class="section">
                    <h2>Core Competencies</h2>
                    <ul>
                        <#list competencies?split(",") as comp>
                            <#if comp?has_content>
                               <li>${comp?trim}</li>
                            </#if>
                        </#list>
                    </ul>
                </div>
           </#if>


            <#if certificates?? && certificates?size gt 0>
                           <div class="section">
                               <h2>Certificates</h2>
                               <#list certificates as certi>

                                <div class="experience-item">

                               <#if certi.courseName?? && certi.courseName?has_content>
                                   <p>

                                   <#if certi.courseName?has_content>
                                       ${certi.courseName} <br />
                                   </#if>

                                  <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                                                    ( ${extractmonth(certi.courseStartDate)}
                                                      <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                                                        &#8211; ${extractmonth(certi.courseEndDate)} )
                                                      <#else>
                                                        )
                                       </#if>
                                      </#if>

                                    </p>
                                 </#if>
                                 </div>
                               </#list>
                           </div>
                  </#if>


                  <#if achievements?? && achievements?size gt 0>
                         <div class="section">
                             <h2>Achievements</h2>
                             <#list achievements as achieve>

                              <div class="experience-item">

                             <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                                 <p>

                                 <#if achieve.achievementsName?has_content>
                                     ${achieve.achievementsName} <br />
                                 </#if>

                                <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                                                 &#8211; ${extractmonth(achieve.achievementsDate)}
                                  </#if>

                                  </p>
                               </#if>
                               </div>
                             </#list>
                         </div>
               </#if>

                <#if goals?? && goals?trim?length gt 0>
                       <div class="section">
                           <h2>Goals</h2>
                           <ul>
                               <#list goals?split(",") as goal>
                                 <#if goal?has_content>
                                    <li>${goal?trim}</li>
                                 </#if>
                               </#list>
                           </ul>
                       </div>
                   </#if>

                   <#if hobbies?? && hobbies?trim?length gt 0>
                      <div class="section">
                          <h2>Hobbies</h2>
                          <ul>
                              <#list hobbies?split(",") as hobbie>
                                <#if hobbie?has_content>
                                   <li>${hobbie?trim}</li>
                                </#if>
                              </#list>
                          </ul>
                      </div>
                  </#if>


                 <#if hasCollegeProjects  && addAdditionalDetails>
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

                                    <#if address?? && address?has_content>
                                    <p><strong>Address:</strong> ${address}</p>
                                    </#if>
                         </div>
                    </#if>
            </div>
        </div>
    </div>
</body>
</html>
