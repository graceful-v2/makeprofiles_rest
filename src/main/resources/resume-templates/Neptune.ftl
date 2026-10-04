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


    body {

      margin: 0;
      padding: 0;
      background: #fdfdfd;

      font-family: ${(style.primaryFont)!'Arial, Helvetica, sans-serif'};
      font-size: ${(style.bodySize)!'12pt'};
       line-height: ${(style.lineSpacing)!'1.6'};
         color: ${(style.bodyColor)!'#1a1f36'};
    }

    .container {
      max-width: 210mm;      
	  width: 100%;           
	  margin: 0 auto;      
	  box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);

	  box-sizing: border-box;
	  overflow-wrap:break-word;
	  word-break:break-word;
    }

    /* Header */
    .header {
      text-align: center;
      border-bottom: 2px solid #ddd;
      padding-bottom: 10px;
      margin-bottom: 0px;
	  font-weight:bold;
    }
    .header .top-info {
      font-size: 15px;
      
    }
    .header h1 {
      font-size: 28px;
       
    }

     
    h2.section-title {

      padding: 2px 10px;
      border-left: 4px solid #444;
      margin-top: 10px;
      margin-bottom: 10px;
	  background: #648ff3;
	  font-size: ${(style.sectionTitleSize)!'14pt'};
       font-weight: ${(style.fontWeightHeading)!'700'};
       color: ${(style.headingColor)!'#111'};

    }
 
    .summary p {
      font-size: 14px;
      
    }

    
    .core ul {
      list-style: none;
      padding: 0;
      margin: 0;
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 5px;
    }


    
    .experience .job {
      margin-bottom: 20px;
    }
    .experience .job h3 {
      font-size: 14px;
      font-weight: bold;
      margin: 0;
    }
    .experience .job span {
      font-size: 12px;
      
    }
    .experience ul {
      margin: 5px 0 0 15px;
    }

    
    .education p {
      margin: 5px 0;
      font-size: 14px;
    }
	
	   .tags span {
      display: inline-block;
      border: 1px solid #e6e9ef;
      padding: 4px 8px;
      border-radius: 12px;
      font-size: 13px;
      margin: 2px;
      font-weight:bold;
      line-height:1.1;

   }
   
   .meta span {
      margin-right: 20px;
      display: inline-block;
   }

    .job-title {
        line-height: 1.5;
        font-size:14px;
     }

     .project-title {
      font-size:14px;
      font-weight:bold;
      margin-bottom:3px;
     }

    .name{

      font-size: ${(style.nameSize)!'25pt'};
       font-weight: ${(style.fontWeightname)!'800'};
        color: ${(style.nameColor)!'#111'};
       }

   .experience-item {
          margin-bottom: 20px;
          padding-bottom: 10px;
          border-bottom: 1px dashed #ccc;
        }

               .section-subtitle{
       	  font-weight: bold;
       	  margin-bottom: 5px;
       	  padding-bottom: 3px;
       	  font-size: 17px;
       	  color: #003366;
       	  }

       	  .company-name{
       	  font-size: 15px;
       	  }

       	  li {
       	   font-size:14px;
       	  }

       	    .education-list{
                     line-height:1.4;
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
      <#if name?? && name?has_content>
        <span class="name">${name}</span>
      </#if>
      
      <div class="top-info">
        <#if email?has_content>
           ${email}
        </#if>
        
        <#if phone?has_content>
          |  ${phone}
        </#if>
        
        <#if linkedin?? && linkedin?has_content>
          |  ${linkedin}
        </#if>
      </div>
    </div>
	
    <#if summary?has_content>
      <div class="section">
        <h2 class="section-title">Professional Summary</h2>
        <div class="summary">
          <p>${summary}</p>
        </div>
      </div>
    </#if>
	
    <#if objective?has_content>
      <div class="section">
        <h2 class="section-title">Objective</h2>
        <div class="summary">
          <p>${objective}</p>
        </div>
      </div>
    </#if>

		   <#if skills?? && skills?trim?length gt 0>
		  <div class="section">
		    <h2 class="section-title">Skills</h2>
		    <div class="tags">
		      <#list skills?split(",") as skill>
		        <#if skill?? && skill?has_content>
		          <span>${skill?trim}</span>
		        </#if>
		      </#list>
		    </div>
		  </div>
		</#if>

	
    <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <h2 class="section-title">Experience</h2>
        <div class="experience">
          <#list experiences as exp>
          <div class="experience-item">
            <div class="job">
              <#if exp.companyName?has_content || (exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content)>
                <h3>
                  <#if exp.companyName?has_content>
                     ${exp.companyName}
                  </#if>
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
              </#if>
              
              <#if exp.role?has_content>
                <h3 class="company-name"> ${exp.role}</h3>
              </#if>
              
              <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
                <ul>
                  <#list exp.responsibilities?split(",") as item>
                    <#if item?has_content>
                      <li>${item?trim}</li>
                    </#if>
                  </#list>
                </ul>
              </#if>
            </div>

       <#if exp.projects?? && exp.projects?size gt 0>
            <div class="sub-section">
             <div class="section-subtitle">Projects</div>
              <#list exp.projects as proj>

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
      </div>
    </#if>

    <#if  collegeProject?? && collegeProject?size gt 0>

      <div class="section">

          <h2 class="section-title">Academic Project</h2>

             <#list collegeProject as project>
             <div class="experience-item">

                  <div style="margin-top:8px;">
    	                <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
    	                 <div><strong>Title: </strong> ${project.collegeProjectName}</div>
    	                </#if>
    	           </div>
    	                <#if project.collegeProjectSkills?? &&  project.collegeProjectSkills?trim?length gt 0>
    	                    <div style="text-align:left; margin-top:7px;">  <strong>Skills: </strong> <br/></div>
    			                   <ul class="bullets">
    					                <#list project.collegeProjectSkills?split(",") as item>
    					                  <#if item?has_content>
    					                    <li>${item?trim}</li>
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

    <#if education?? && education?size gt 0>
      <div class="section">
        <h2 class="section-title">Education</h2>
        <div class="education">
          <#list education as edu>
            <p>
              <#if edu.department?? && edu.department?has_content>
                <strong>${edu.department}</strong>
              </#if>
              <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                &#8211; <strong>${edu.fieldOfStudy}</strong>
              </#if>
              <#if edu.percentage?? && edu.percentage?has_content>
			          &#8211; ${edu.percentage}%
			    </#if>
              <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                &#8211; ( ${extractmonth(edu.qualificationStartYear)}
                  <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                    &#8211; ${extractmonth(edu.qualificationEndYear)}
                  <#else>
                    &#8211; Present
                  </#if>
                )
              </#if>
            </p>
            
            <#if edu.institutionName?? && edu.institutionName?has_content>
                <p>${edu.institutionName}</p>
            </#if>
          </#list>
        </div>
      </div>
    </#if>

    <#if certificates?? && certificates?size gt 0>
      <div class="section">
        <h2 class="section-title">Certificates</h2>
        <div class="education">
          <#list certificates as certi>
            <#if certi.courseName?? && certi.courseName?has_content>
              <p><strong>${certi.courseName}
                <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                  ( ${extractmonth(certi.courseStartDate)}
                    <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                      &#8211; ${extractmonth(certi.courseEndDate)} )
                    <#else>
                      )
                    </#if>
                </#if>
              </strong></p>
            </#if>
          </#list>
        </div>
      </div>
    </#if>

    <#if achievements?? && achievements?size gt 0>
      <div class="section">
        <h2 class="section-title">Achievements</h2>
        <div class="education">
          <#list achievements as achieve>
            <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
              <p><strong>${achieve.achievementsName}
                <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                  &#8211; ${extractmonth(achieve.achievementsDate)}
                </#if>
              </strong></p>
            </#if>
          </#list>
        </div>
      </div>
    </#if>

    <#if softSkills?? && softSkills?trim?length gt 0>
      <div class="section">
        <h2 class="section-title">Soft Skills</h2>
        <div class="core">
          <ul>
            <#list softSkills?split(",") as skill>
              <#if skill?? && skill?has_content>
                <li>${skill?trim}</li>
              </#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>
	
    <#if competencies?? && competencies?trim?length gt 0>
      <div class="section">
        <h2 class="section-title">Core Competencies</h2>
        <div class="core">
          <ul>
            <#list competencies?split(",") as comp>
              <#if comp?? && comp?has_content>
                <li>${comp?trim}</li>
              </#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>


    <#if strengths?? && strengths?trim?length gt 0>
    <div class="section">
        <h2 class="section-title">Strength</h2>
        <div class="core">
            <ul>
                <#list strengths?split(",") as skill>
                    <#if skill?? && skill?has_content>
                        <li>${skill?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
    </#if>

    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
    <div class="section">
        <h2 class="section-title">Extracurricular Activities</h2>
        <div class="core">
            <ul>
                <#list extraCurricularActivities?split(",") as activity>
                    <#if activity?? && activity?has_content>
                        <li>${activity?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
    </#if>

    <#if goals?? && goals?trim?length gt 0>
    <div class="section">
        <h2 class="section-title">Goals</h2>
        <div class="core">
            <ul>
                <#list goals?split(",") as goal>
                    <#if goal?? && goal?has_content>
                        <li>${goal?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
    </#if>


                       <#if addAdditionalDetails>
                                     <div class="section">
                                         <h2 class="section-title">Personal Details</h2>

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
