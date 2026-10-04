<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="UTF-8"/>
<@fonts.loadFonts />
<style>


 @page:first {
    margin-top: 10px;
  }
  @page {
    size: A4;
    margin-top: 40px;
    margin-bottom: 10px;
    margin-left: 20px;
    margin-right: 20px;
  }

  html, body {
    margin: 0;
    padding: 0;
    font-family: ${(style.primaryFont)!'PT Serif'};
    font-size: ${(style.bodySize)!'12pt'};
    line-height: ${(style.lineSpacing)!'1.2'};
    color: ${(style.bodyColor)!'#000000'};
    background: white;
  }
  

 
.header {
  background: #0c3d73;
  padding: 35px 50px;
  color: white;
   width: 210mm;
  margin: auto;
    box-sizing: border-box;
    position: relative;
}
.name{
  color: ${(style.nameColor)!'#ffffff'};
  font-size: ${(style.nameSize)!'28pt'};
   font-weight: ${(style.fontWeightname)!'800'};
}

 
.container {
  display: grid;
  grid-template-columns: 65% 35%;
  padding: 5px 5px;
	width: 210mm;
	margin: auto;
	box-sizing: border-box;
	position: relative;
	}

 
.left-section { padding-right: 5px; }

 
.right-section {
  border-left: 1px solid #ddd;
  padding-left: 5px;
}

 
.section-title {
  font-size: 14pt;
  font-weight: 700;
  color: #0c3d73;
  margin-top: 25px;
  margin-bottom: 10px;
}

.section-title {
  font-size: ${(style.sectionTitleSize)!'15pt'};
  font-weight: ${(style.fontWeightHeading)!'700'};
   color: ${(style.headingColor)!'#0c3d73'};
 
  margin-top: 20px;
  margin-bottom: 8px;
}

.sub-section-title {
  font-size: 13pt;
  font-weight: 700;
  color: #0c3d73;
  margin-bottom: 8px;
  text-decoration:underline;
  text-underline-offect:2;
}

.left-section hr { border: none; border-top: 1px solid #ddd; margin: 6px 0 15px 0; }

 
.exp-row {
  display: grid;
  grid-template-columns: 0.5fr 1fr;
  margin-bottom: 6px;
  font-weight: 500;
}

.project-row{
 display: grid;
  grid-template-columns: 0.7fr 1fr;
  margin-bottom: 6px;
  font-weight: 500;
}


.exp-role {
  font-weight: 700;
  font-size: 12pt;
  margin-bottom: 4px;
}

.exp-location {
  font-style: italic;
 
  
  margin-bottom: 6px;
}

.bullets {
 margin-bottom: 12px;
}

.bullets li { margin-bottom: 6px; }

 
.edu-degree {
  font-weight: 700;
   
}

.edu-school {
  margin-bottom: 4px;

}

.edu-item{
 margin-top:5px;
 margin-bottom:5px;
 
}

.detail-item { 
margin-bottom: 
8px; }

.education-details{
 border-bottom:1px dashed #555;
 margin-bottom:8px;
}

 
.qualification-details{
 display:flex;
 justify-content:space-between;
  margin:10px 0px;
}

.contact-info{
  margin:5px 0px;
}

.certi-list{
 overflow-wrap:break-word;
 word-break:break-word;
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

<div class="header">
    
    <#if name?? && name?has_content>
        <div class="name">${name}</div>
    </#if>

    <div class="contact-info">
        <#if phone?? && phone?has_content>
            ${phone}
        </#if>

        <#if email?? && email?has_content>
            <#if phone?has_content> - </#if>${email}
        </#if>

        <#if linkedin?? && linkedin?has_content>
            <#if phone?has_content || email?has_content> - </#if>
            <a href="${linkedin}" style="color:#ffffff;" target="_blank">${linkedin}</a>
        </#if>
    </div>
</div>



<div class="container">

    <div class="left-section">

        <!-- SUMMARY -->
        <#if summary?? && summary?has_content>
        <div class="section">
            <div class="section-title">Summary</div>
            <p>${summary}</p>
        </div>
        </#if>


        <!-- EXPERIENCE -->
        <#if experiences?? && experiences?size gt 0>
        <div class="section">
            <div class="section-title">Experience</div>

            <#list experiences as exp>
            <div class="education-details">

                <div class="exp-row">
                    <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                        <div>
                            ${extractmonth(exp.experienceYearStartDate)}
                            <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                                 &#8211; ${extractmonth(exp.experienceYearEndDate)}
                            <#else>
                                 &#8211; Present
                            </#if>
                        </div>
                    </#if>

                    <div>
                        <#if exp.role?? && exp.role?has_content>
                            <div class="exp-role">${exp.role}</div>
                        </#if>
                        <#if exp.companyName?? && exp.companyName?has_content>
                            <div class="exp-location">${exp.companyName}</div>
                        </#if>
                    </div>
                </div>

                <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
                <strong>Responsibilities</strong>
                <ul class="bullets">
                    <#list exp.responsibilities?split(",") as item>
                        <#if item?trim?has_content><li>${item?trim}</li></#if>
                    </#list>
                </ul>
                </#if>


                <!-- PROJECTS -->
                <#if exp.projects?? && exp.projects?size gt 0>
                <div class="sub-section-title">Projects</div>

                <#list exp.projects as proj>
                <div class="project-row">
                    <div>
                        <#if proj.projectName?? && proj.projectName?has_content>
                            <div class="exp-role">Name: ${proj.projectName}</div>
                        </#if>
                        <#if proj.projectRole?? && proj.projectRole?has_content>
                            <div class="exp-location">Role: ${proj.projectRole}</div>
                        </#if>
                    </div>

                    <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
                        <div class="exp-location"><strong>Skills:</strong>
                            <#list proj.projectSkills?split(",") as sk>
                                ${sk?trim}<#if sk_has_next>, </#if>
                            </#list>
                        </div>
                    </#if>
                </div>

                <#if proj.projectDescription?? && proj.projectDescription?trim?length gt 0>
                    <strong>Description:</strong>
                    <p>${proj.projectDescription}</p>
                </#if>

                </#list>
                </#if>

            </div>
            </#list>

        </div>
        </#if>




        <!-- ACADEMIC PROJECT -->
        <#if collegeProject?? && collegeProject?size gt 0>
        <div class="section">
            <div class="section-title">Academic Project</div>

            <#list collegeProject as cp>
            <div class="education-details">

                <div class="project-row">
                    <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
                        <div class="exp-role">${cp.collegeProjectName}</div>
                    </#if>

                    <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
                        <div class="exp-location"> <#list cp.collegeProjectSkills?split(",") as skill>
										${skill?trim}<#if skill_has_next>, </#if>
									  </#list></div>
                    </#if>
                </div>

                <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?trim?length gt 0>
                <strong>Description</strong>
                <ul class="bullets">
                    <#list cp.collegeProjectDescription?split(",") as item>
                        <#if item?trim?has_content><li>${item?trim}</li></#if>
                    </#list>
                </ul>
                </#if>

            </div>
            </#list>

        </div>
        </#if>



        <!-- EDUCATION -->
        <#if education?? && education?size gt 0>
        <div class="section">
            <div class="section-title">Education</div>

            <#list education as edu>
            <div class="qualification-details">
                <div>
                    <#if edu.department?? && edu.department?has_content>
                        <div class="edu-degree">${edu.department}</div>
                    </#if>

                    <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                        <div class="edu-item">${edu.fieldOfStudy} &nbsp; 
						
						<#if  edu.percentage?? && edu.percentage?has_content>${edu.percentage}%</#if>
						
						</div>

						 <#else>
						  <div class="edu-item">

                        <#if  edu.percentage?? && edu.percentage?has_content>${edu.percentage}%</#if>

                        </div>
                    </#if>

                    <#if  edu.institutionName?? && edu.institutionName?has_content>
                        <div class="edu-item">${edu.institutionName}</div>
                    </#if>
                </div>

                <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                    <div class="edu-school">
                        (${extractmonth(edu.qualificationStartYear)}
                        <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                            &#8211; ${extractmonth(edu.qualificationEndYear)})
                        <#else>
                            &#8211; Present)
                        </#if>
                    </div>
                </#if>

            </div>
            </#list>

        </div>
        </#if>



        <!-- CERTIFICATES -->
        <#if certificates?? && certificates?size gt 0>
        <div class="section">
            <div class="section-title">Certificates</div>
        <div class="certi-list">
            <#list certificates as cert>
                <div class="exp-row">
                    <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
                        <div>${extractmonth(cert.courseStartDate)}
						
						<#if cert.courseEndDate?? && cert.courseEndDate?has_content>
						&#8211;  ${extractmonth(cert.courseEndDate)}
						 </#if>
						</div>
                    </#if>

                    <#if cert.courseName?? && cert.courseName?has_content>
                        <div>${cert.courseName}</div>
                    </#if>
                </div>
            </#list>
            </div>
        </div>
        </#if>



        
        <#if achievements?? && achievements?size gt 0>
        <div class="section">
            <div class="section-title">Achievements</div>
          <div class="certi-list">
               <#list achievements as achieve>
                <div class="exp-row">
                    <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                        <div> ${extractmonth(achieve.achievementsDate)}}</div>
                    </#if>

                    <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                        <div>${achieve.achievementsName}</div>
                    </#if>
                </div>
            </#list>
            </div>
        </div>
        </#if>

 <#if softSkills?? && softSkills?trim?length gt 0>
        <div class="section">
            <div class="section-title">Soft Skills</div>
            <ul class="bullets">
                <#list softSkills?split(",") as s>
                    <#if s?trim?has_content><li>${s?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


        <!-- CORE COMPETENCIES -->
        <#if competencies?? && competencies?trim?length gt 0>
        <div class="section">
            <div class="section-title">Core Competencies</div>
            <ul class="bullets">
                <#list competencies?split(",") as c>
                    <#if c?trim?has_content><li>${c?trim}</li></#if>
                </#list>
            </ul>
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



                <!-- PERSONAL DETAILS -->
                <#if addAdditionalDetails?? && addAdditionalDetails && !hasCollegeProjects>
                <div class="section">
                    <div class="section-title">Personal Info</div>

        			<#if fatherName?? && fatherName?has_content>
                        <div class="detail-item"><strong>Father Name:</strong> ${fatherName}</div>
                    </#if>

        			<#if maritalStatus?? && maritalStatus?has_content>
                        <div class="detail-item"><strong>Martial Status:</strong> ${maritalStatus}</div>
                    </#if>

        			<#if nationality?? && nationality?has_content>
                        <div class="detail-item"><strong>Nationality:</strong> ${nationality}</div>
                    </#if>


                    <#if address?has_content>
                        <div class="detail-item"><strong>Address:</strong> ${address}</div>
                    </#if>

                    <#if dob?has_content>
                        <div class="detail-item"><strong>DOB:</strong> ${extractDobYear(dob)}</div>
                    </#if>

        			<#if languagesKnown?? && languagesKnown?has_content>
                        <div class="detail-item"><strong>Languages:</strong> ${languagesKnown?replace(",", ", ")}</div>
                    </#if>

                    <#if gender?has_content>
                        <div class="detail-item"><strong>Gender:</strong> ${gender}</div>
                    </#if>

                </div>
                </#if>

    </div> <!-- END LEFT -->


    <!-- RIGHT SECTION -->
    <div class="right-section">
	
	  <#if objective?? && objective?has_content>
        <div class="section">
            <div class="section-title">Objective</div>
            <p>${objective}</p>
        </div>
        </#if>

        <!-- SKILLS -->
        <#if skills?? && skills?trim?length gt 0>
        <div class="section">
            <div class="section-title">Skills</div>
            <ul class="bullets">
                <#list skills?split(",") as skill>
                    <#if skill?trim?has_content><li>${skill?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


          <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
                <div class="section">
                    <div class="section-title">Extracurricular  Activities</div>
                    <ul class="bullets">
                        <#list extraCurricularActivities?split(",") as e>
                            <#if e?trim?has_content><li>${e?trim}</li></#if>
                        </#list>
                    </ul>
                </div>
                </#if>




         <#if strengths?? && strengths?trim?length gt 0>
        <div class="section">
            <div class="section-title">Strength</div>
            <ul class="bullets">
                <#list strengths?split(",") as s>
                    <#if s?trim?has_content><li>${s?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


         <#if hobbies?? && hobbies?trim?length gt 0>
        <div class="section">
            <div class="section-title">Hobbies</div>
            <ul class="bullets">
                <#list hobbies?split(",") as h>
                    <#if h?trim?has_content><li>${h?trim}</li></#if>
                </#list>
            </ul>
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



        <!-- PERSONAL DETAILS -->
        <#if addAdditionalDetails?? && addAdditionalDetails && hasCollegeProjects>
        <div class="section">
            <div class="section-title">Personal Info</div>
			
			<#if fatherName?? && fatherName?has_content>
                <div class="detail-item"><strong>Father Name:</strong> ${fatherName}</div>
            </#if>
			
			<#if maritalStatus?? && maritalStatus?has_content>
                <div class="detail-item"><strong>Martial Status:</strong> ${maritalStatus}</div>
            </#if>
			
			<#if nationality?? && nationality?has_content>
                <div class="detail-item"><strong>Nationality:</strong> ${nationality}</div>
            </#if>


            <#if address?has_content>
                <div class="detail-item"><strong>Address:</strong> ${address}</div>
            </#if>

            <#if dob?has_content>
                <div class="detail-item"><strong>DOB:</strong> ${extractDobYear(dob)}</div>
            </#if>
			
			<#if languagesKnown?? && languagesKnown?has_content>
                <div class="detail-item"><strong>Languages:</strong> ${languagesKnown?replace(",", ", ")}</div>
            </#if>

            <#if gender?has_content>
                <div class="detail-item"><strong>Gender:</strong> ${gender}</div>
            </#if>

        </div>
        </#if>

    </div> <!-- END RIGHT -->

</div>

</body>

</html>
