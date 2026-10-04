<!DOCTYPE html>
<html lang="en">
<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="UTF-8" />
  <@fonts.loadFonts />
  <style>

 @page:first {
    margin-top: 10px;
  }
  @page {
    size: A4;
    margin-top: 40px;
    margin-bottom: 20px;
    margin-left: 20px;
    margin-right: 20px;
  }


    html, body {
      margin: 0;
      padding: 0;
      width: 210mm;

      font-family: ${(style.primaryFont)!'Arial, sans-serif'};
      font-size: ${(style.bodySize)!'12pt'};
       line-height: ${(style.lineSpacing)!'1.3'};
         color: ${(style.bodyColor)!'#111'};
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

    .profile-pic {
      position: absolute;
      top: 3mm;
      right: 10mm;
      width: 30mm;
      height: 30mm;
      object-fit: cover;
      border-radius: 50%;
     }
    
    p{
	  line-height:1.3;
	}

    h1 {
      font-size: 32px;
      font-weight: bold;
      margin-bottom: 0;
    }

    .blue {
      color: #0054a6;
      font-weight: bold;
    }

    .contact {

      margin-bottom: 20px;
    }

    h2 {
      border-bottom: 2px solid #222;
      font-size: ${(style.nameSize)!'25pt'};
      font-weight: ${(style.fontWeightname)!'800'};
      color: ${(style.nameColor)!'#111'};
    }

    .section {
      margin-top: 18px;
     }

    .section-title {
      border-bottom: 2px solid #000;
       font-size: ${(style.sectionTitleSize)!'14pt'};
       font-weight: ${(style.fontWeightHeading)!'700'};
       color: ${(style.headingColor)!'#0054a6'};
    }

    .job-title {
     line-height: 1.5;
    }

    .location-date {

      color: #555;
      margin-top: 10px;
    }

    .bullets {
      padding-left: 20px;
    }

    .bullets li {
      line-height:1.3;
    }

    .tags {
      margin-top: 10px;
    }

    .tag {
      display: inline-block;
      background-color: #eee;
      border-radius: 4px;
      padding: 4px 8px;
      margin: 4px 4px 0 0;

    }

    .skills-section {
    width: 100%;
  }

  .skill-item {
    display: table;
    width: 100%;
    margin-top: 6px;
  }

  .skill-name {
    display: table-cell;
    width: 40%;
    font-weight: bold;
    padding-right: 8px;
    vertical-align: middle;
  }

  .skill-dots {
    display: table-cell;
    width: 60%;
    vertical-align: middle;
  }

  .dot {
    display: inline-block;
    width: 9px;
    height: 9px;
    border-radius: 50%;
    background-color: #ccc;
    margin-right: 4px;
  }

  .dot.filled {
    background-color: #0054a6;
  }

    .timeline {
      position: relative;
      margin-top: 13px;
      padding-left: 20px;
      border-left: 3px dotted #0054a6;
    }

    .timeline-item {
      position: relative;
      padding-left: 20px;
    }

    .timeline-item::before {
      content: '';
      position: absolute;
      left: -11px;
      top: 5px;
      width: 14px;
      height: 14px;
      background-color: #0054a6;
      border-radius: 50%;
      border: 3px solid white;
      box-shadow: 0 0 0 4px #0054a6;
    }

    .timeline-date {
      font-weight: bold;
      color: #0054a6;
    }

    .timeline-content .job-title {
      font-weight: bold;

    }

    .timeline-content .company {

      margin-bottom: 8px;
    }
    
     ul{
     line-height: 1.5;
     margin-bottom: 5px;
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

	  color: #003366;

	  }

	  .projectsection{
      	  margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 1px dashed #ccc;
      	}

      	.detail-item {
             margin-top: 7px;
         }

         .education-list{
           line-height:1.4;
         }
         .contact-details{

         margin-top:5px;
         margin-bottom:5px;

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

	 <#if profileImage?? && profileImage?has_content>
	    <img src="${profileImage}"    class="profile-pic" />
	 </#if>

      <h1>${name}</h1>

   <div class="contact">

	   <#if phone?has_content>

	      <div class="contact-details">  ${phone} </div>
	    </#if>
	    
	    <#if email?has_content>
	        <div class="contact-details">      ${email} </div>
	    </#if>
	    
	    <#if linkedin?? && linkedin?has_content>
	        <div class="contact-details">     <a href="${linkedin}" target="_blank">${linkedin}</a> </div>
	    </#if>
   </div>
  
  <#if objective?has_content>
		<div class="section">
		    <div class="section-title">OBJECTIVE</div>
		    <p>${objective}</p>
		</div>
   </#if> 		

 <#if summary?has_content>
	  <div class="section">
	    <div class="section-title">SUMMARY</div>
	     <p>${summary}</p>
 	  </div>
 </#if>	  


	  	<#if skills?? && skills?trim?length gt 0>
          		  <div class="section">
          		    <div class="section-title">SKILLS</div>
          		    <div class="tags">
          			    <#list skills?split(",") as skill>
          			    	<#if skill?? && skill?has_content>
           			           <span class="tag"> ${skill?trim}</span>
          			        </#if>
          			    </#list>
          		    </div>
          		  </div>
              </#if>


 
<#if experiences?? && experiences?size gt 0> 
  <div class="section">
    <div class="section-title">PROFESSIONAL EXPERIENCE</div>
    <div class="timeline">

      <#list experiences as experience>
       <div class="experience-item">
        <div class="timeline-item">
          <div class="timeline-date">

             <#if experience.companyName?? && experience.companyName?has_content>
                          <div class="company">${experience.companyName}</div>
                        </#if>
          </div>

          <div class="timeline-content">

             <#if experience.experienceYearStartDate?? && experience.experienceYearStartDate?has_content>
                         ${extractmonth(experience.experienceYearStartDate)}
                               <#if experience.experienceYearEndDate?? && experience.experienceYearEndDate?has_content>
                                    &#8211; ${extractmonth(experience.experienceYearEndDate)}
                                         <#else>
                                             &#8211; Present
                                </#if>
                       </#if>

            <#if experience.role?? && experience.role?has_content>
              <div class="job-title">${experience.role}</div>
            </#if>

            <#if experience.responsibilities?? && experience.responsibilities?trim?length gt 0>
              <ul class="bullets">
                <#list experience.responsibilities?split(",") as item>
                  <#if item?has_content>
                    <li>${item?trim}</li>
                  </#if>
                </#list>
              </ul>
            </#if>
          </div>
        </div>
        
        
          <#if experience.projects?? && experience.projects?size gt 0>
				        <div class="sub-section">
				          <div class="section-subtitle">Projects</div>
				          <#list experience.projects as proj>

				            <div class="projectsection">
				            
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
 				            </div>
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
     <div class="section-title">ACADEMIC PROJECT</div>
     
         <#list collegeProject as project>
         <div class="experience-item">
             
              <div style="margin-top:8px;">
	                <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
	                 <div><strong>Project Title: </strong> ${project.collegeProjectName}</div>
	                </#if>	
	           </div>
	                <#if project.collegeProjectSkills?? &&  project.collegeProjectSkills?trim?length gt 0>
	                    <div style="text-align:left; margin-top:7px;">  <strong>Project Skills: </strong> <br/></div> 

			                    <div class="projectskills">
                                     <#list project.collegeProjectSkills?split(",") as skill>
                                      ${skill?trim}<#if skill_has_next>, </#if>
                                    </#list>
                                 </div>
			                 
	               </#if>

                        <#if project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>
		               <p><strong>Project Description:</strong> ${project.collegeProjectDescription}</p>
		            </#if>
             
         
             </div>
        </#list>
  </div>
  </#if>

  
 <#if education?? && education?size gt 0> 
	<div class="section">
		    <div class="section-title">EDUCATION</div>
 				    <ul class="bullets">
				    	<#list education as edu>
						 <li class="education-list">
 						      <#if edu.department?? && edu.department?has_content>  
							      <strong>
							         ${edu.department}
							       </strong> 
							    </#if>	 
							    <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
	  						        &#8211; ${edu.fieldOfStudy}
	  						    </#if> 
	  						    <#if edu.percentage?? && edu.percentage?has_content>
							          &#8211; ${edu.percentage}%
							       </#if>  
 								<#if edu.institutionName?? && edu.institutionName?has_content>
	  						        &#8211; ${edu.institutionName}
	  						    </#if>   
   						            <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content> 
			                                  ( ${extractmonth(edu.qualificationStartYear)}
			                                      <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                                                    &#8211; ${extractmonth(edu.qualificationEndYear)} )
                                                      <#else>
                                                       &#8211; Present )</#if>
			                           </#if> 
 						   </li>
  						</#list>     
				    </ul>
		  </div>
 </#if> 
    





    

	<#if achievements?? && achievements?size gt 0> 

		 <div class="section">
		 
		    <div class="section-title">ACHIEVEMENTS</div>
		    <ul class="bullets">
		    <#list achievements as achieve>
				<#if achieve.achievementsName?? && achieve.achievementsName?has_content>
		             
		             <li>${achieve.achievementsName} 
		             
		                  <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
						                  &#8211; ${extractmonth(achieve.achievementsDate)}
						    </#if> 
		             </li>
		        </#if>
			</#list>    
 		    </ul>
		 </div>
		  
	</#if> 	 
	
	<#if certificates?? && certificates?size gt 0> 
		 <div class="section">
		    <div class="section-title">CERTIFICATES</div>
		    <ul class="bullets">
		    <#list certificates as certi>
				<#if certi.courseName?? && certi.courseName?has_content>
		             <li>${certi.courseName} 
		                  <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
						            ( ${extractmonth(certi.courseStartDate)}
 								          <#if  certi.courseEndDate?? && certi.courseEndDate?has_content>
		                                        &#8211; ${extractmonth(certi.courseEndDate)} )
		                                                <#else>
		                                )
		                    </#if>
 						 </#if> 
		             </li>
		        </#if>
			</#list>    
 		    </ul>
		 </div>
 	</#if> 
		  
     <#if competencies?? && competencies?trim?length gt 0> 
		  <div class="section">
		    <div class="section-title">CORE COMPETENCIES</div>
		    <div class="tags">
			    <#list competencies?split(",") as comp>
			    	<#if comp?? && comp?has_content>
 			           <span class="tag"> ${comp?trim}</span>
			        </#if>
			    </#list> 
		    </div>
		  </div>
		  
    </#if> 		  
		  
    <#if softSkills?? && softSkills?trim?length gt 0> 
		  <div class="section">
		    <div class="section-title">SOFT SKILLS</div>
		    <div class="tags">
			    <#list softSkills?split(",") as skill>
			    	<#if skill?? && skill?has_content>
 			           <span class="tag"> ${skill?trim}</span>
			        </#if>
			    </#list> 
		    </div>
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


                     <#if addAdditionalDetails?? && addAdditionalDetails>

                                 <div class="section">
                                     <div class="section-title">PERSONAL DETAILS</div>

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
