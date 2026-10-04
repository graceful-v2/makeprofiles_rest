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
    line-height: ${(style.lineSpacing)!'1.3'};
    color: ${(style.bodyColor)!'#000000'};
    background: white;
  }

   .container {
    width: 210mm;
    padding: 7mm;
    margin: auto;
    box-sizing: border-box;
    position: relative;
    overflow-wrap:break-word;
  }

.center { text-align:center; }

.name {
   font-size: ${(style.nameSize)!'28px'};
     font-weight: ${(style.fontWeightname)!'700'};


  margin-bottom: 6px;
}

.contact-line {
  font-size: 12pt;
  color: #444;
  margin-bottom: 20px;
}

/* Sections */
.section {
  margin-top: 15px;
  margin-bottom:10px;
}

.section-title {
  font-size: ${(style.sectionTitleSize)!'14pt'};
  font-weight: ${(style.fontWeightHeading)!'700'};
  text-transform: uppercase;
  letter-spacing: 0.5px;
  border-bottom: 1px solid #000;
  padding-bottom: 4px;
  margin-bottom: 10px;
}

/* Experience layout */
.exp-row {
  display: grid;
  grid-template-columns: 1fr 180px;
  margin-bottom: 6px;
}

.exp-company-title {
  font-weight: 700;
  font-size: 12pt;
  margin-bottom: 3px;
}

.exp-location {
  font-style: italic;
  font-size: 11pt;

}

.exp-date {
  text-align: right;
  font-weight: 500;

}

.bullets {
  margin-left: 18px;
  margin-bottom: 14px;
}

.bullets li {
  margin-bottom: 6px;
  list-style: disc;
}

/* Education */
.edu-row {
  margin-top:10px;
  margin-bottom: 6px;
  line-height:1.3;

}

.edu-degree {
  font-weight: 700;
  margin-bottom: 1px;
}

.edu-school {

  margin-bottom: 6px;
}

.edu-date {

  font-weight: 500;

}

.experience-row{
    border-bottom:1px dashed #1d1d1f;
	margin-bottom:10px;
  }

 .sub-sectoin-title{
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 6px;

  font-weight:700;
  text-decoration:underline;
  text-underline-offset: 3px;
  }

.detail-item {
margin-bottom: 6px;
}
.project-block {
  margin-top: 8px;
   margin-bottom: 8px;
  font-size: 12pt;
  color: #333;
  line-height:1.3;
  border-bottom: 2px dashed #d1d5db;

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


    <div class="center">

        <#if name?? && name?has_content>
            <div class="name">${name}</div>
        </#if>

        <div class="contact-line">
            <#if email?? && email?has_content>
                ${email}
            </#if>

            <#if phone?? && phone?has_content>
                <#if email?has_content> • </#if>
                ${phone}
            </#if>

			<#if location?? && location?has_content>
                <#if email?has_content || phone?has_content> • </#if>
                 ${location}
            </#if>

            <#if linkedin?? && linkedin?has_content>
                <#if email?has_content || phone?has_content> • </#if>
                <a href="${linkedin}" target="_blank">${linkedin}</a>
            </#if>
        </div>
    </div>




    <#if summary?? && summary?has_content>
        <div class="section">
            <div class="section-title">Professional Summary</div>
            <p>${summary}</p>
        </div>
    </#if>



    <#if objective?? && objective?has_content>
        <div class="section">
            <div class="section-title">Objective</div>
            <p>${objective}</p>
        </div>
    </#if>




    <#if skills?? && skills?trim?length gt 0>
        <div class="section">
            <div class="section-title">Skills</div>
            <ul class="bullets">
                <#list skills?split(",") as skill>
                    <#if skill?trim?has_content>
                        <li>${skill?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if experiences?? && experiences?size gt 0>
        <div class="section">
            <div class="section-title">Professional Experience</div>

            <#list experiences as exp>
                <div class="experience-row">

                    <div class="exp-row">
                        <div>
                            <#if exp.role?? && exp.role?has_content>
                                <div class="exp-company-title">${exp.role}</div>
                            </#if>

                            <#if exp.companyName?? && exp.companyName?has_content>
                                <div class="exp-location">${exp.companyName}</div>
                            </#if>
                        </div>

                        <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                            <div class="exp-date">
                                ${extractmonth(exp.experienceYearStartDate)}
                                <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                                     &#8211; ${extractmonth(exp.experienceYearEndDate)}
                                <#else>
                                     &#8211; Present
                                </#if>
                            </div>
                        </#if>
                    </div>


                    <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
                        <ul class="bullets">
                            <#list exp.responsibilities?split(",") as item>
                                <#if item?trim?has_content>
                                    <li>${item?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </#if>


                    <#if exp.projects?? && exp.projects?size gt 0>
                        <div class="sub-sectoin-title">Projects</div>
                        <#list exp.projects as proj>
                            <div class="project-block">
                                <#if proj.projectName?has_content>
                                    <div><strong>Name:</strong> ${proj.projectName}</div>
                                </#if>

                                <#if proj.projectSkills?has_content>
                                    <div><strong>Skills:</strong>
                                        <#list proj.projectSkills?split(",") as s>
                                            ${s?trim}<#if s_has_next>, </#if>
                                        </#list>
                                    </div>
                                </#if>

                                <#if proj.projectRole?has_content>
                                    <div><strong>Role:</strong> ${proj.projectRole}</div>
                                </#if>

                                <#if proj.projectDescription?? && proj.projectDescription?trim?length gt 0>
                                    <ul class="bullets">
                                        <#list proj.projectDescription?split(",") as task>
                                            <#if task?trim?has_content>
                                                <li>${task?trim}</li>
                                            </#if>
                                        </#list>
                                    </ul>
                                </#if>
                            </div>
                        </#list>
                    </#if>

                </div>
            </#list>
        </div>
    </#if>





    <#if collegeProject?? && collegeProject?size gt 0>
        <div class="section">
            <div class="section-title">Academic Project</div>

            <#list collegeProject as cp>
                <div class="experience-row">
                    <div class="exp-row">
                        <div>
                            <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
                                <div class="exp-company-title">${cp.collegeProjectName}</div>
                            </#if>

                            <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?has_content>
                                <div class="exp-location">

								   <#list cp.collegeProjectSkills?split(",") as skill>
										${skill?trim}<#if skill_has_next>, </#if>
									  </#list>
								</div>
                            </#if>
                        </div>
                        <div class="exp-date"></div>
                    </div>

                    <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?trim?length gt 0>
                        <ul class="bullets">
                            <#list cp.collegeProjectDescription?split(",") as p>
                                <#if p?trim?has_content>
                                    <li>${p?trim}</li>
                                </#if>
                            </#list>
                        </ul>
                    </#if>
                </div>
            </#list>

        </div>
    </#if>




    <#if education?? && education?size gt 0>
        <div class="section">
            <div class="section-title">Education</div>

            <#list education as edu>
                <div class="edu-row">

                    <#if edu.department?? && edu.department?has_content>
                        <div class="edu-degree">${edu.department}</div>
                    </#if>

                    <#if edu.institutionName?? && edu.institutionName?has_content>
                        <div>${edu.institutionName}</div>
                    </#if>

                    <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                        <div>${edu.fieldOfStudy}</div>
                    </#if>

                    <#if edu.percentage?? && edu.percentage?has_content>
                        <div>${edu.percentage}%</div>
                    </#if>

                    <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                        <div class="edu-date">
                            ${extractmonth(edu.qualificationStartYear)}
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
            <div class="section-title">Certifications</div>
            <ul class="bullets">
                <#list certificates as cert>
                    <#if cert.courseName?has_content>
                        <li>${cert.courseName}

                        <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
                                              &#8209;  (${extractmonth(cert.courseStartDate)}
                                                    <#if cert.courseEndDate?? && cert.courseEndDate?has_content>
                                                    &#8209; ${extractmonth(cert.courseEndDate)}
                                                    </#if>
                                                )
                                                </#if>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if achievements?? && achievements?size gt 0>
        <div class="section">
            <div class="section-title">Achievements</div>
            <ul class="bullets">
                <#list achievements as ach>
                    <#if ach.achievementsName?has_content>
                        <li>${ach.achievementsName}

                        <#if ach.achievementsDate?? && ach.achievementsDate?has_content>
                                                    &#8209; ${extractmonth(ach.achievementsDate)}
                                                    </#if>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if competencies?? && competencies?trim?length gt 0>
        <div class="section">
            <div class="section-title">Core Competencies</div>
            <ul class="bullets">
                <#list competencies?split(",") as comp>
                    <#if comp?trim?has_content>
                        <li>${comp?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if softSkills?? && softSkills?trim?length gt 0>
        <div class="section">
            <div class="section-title">Soft Skills</div>
            <ul class="bullets">
                <#list softSkills?split(",") as soft>
                    <#if soft?trim?has_content>
                        <li>${soft?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if strengths?? && strengths?trim?length gt 0>
        <div class="section">
            <div class="section-title">Strengths</div>
            <ul class="bullets">
                <#list strengths?split(",") as str>
                    <#if str?trim?has_content>
                        <li>${str?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if hobbies?? && hobbies?trim?length gt 0>
        <div class="section">
            <div class="section-title">Hobbies</div>
            <ul class="bullets">
                <#list hobbies?split(",") as hob>
                    <#if hob?trim?has_content>
                        <li>${hob?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if goals?? && goals?trim?length gt 0>
        <div class="section">
            <div class="section-title">Goals</div>
            <ul class="bullets">
                <#list goals?split(",") as goal>
                    <#if goal?trim?has_content>
                        <li>${goal?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>

    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
        <div class="section">
            <div class="section-title">Extracurricular  Activites</div>
            <ul class="bullets">
                <#list extraCurricularActivities?split(",") as goal>
                    <#if goal?trim?has_content>
                        <li>${goal?trim}</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>




    <#if addAdditionalDetails?? && addAdditionalDetails>
        <div class="section">
            <div class="section-title">Personal Details</div>

			<#if fatherName?? && fatherName?has_content>
                <div class="detail-item"><strong>Father Name:</strong> ${fatherName}</div>
            </#if>

			<#if maritalStatus?? && maritalStatus?has_content>
                <div class="detail-item"><strong>Martial Status:</strong> ${maritalStatus}</div>
            </#if>

            <#if dob?? && dob?has_content>
                <div class="detail-item"><strong>Date of Birth:</strong> ${extractDobYear(dob)}</div>
            </#if>

            <#if gender?? && gender?has_content>
                <div class="detail-item"><strong>Gender:</strong> ${gender}</div>
            </#if>

            <#if nationality?? && nationality?has_content>
                <div class="detail-item"><strong>Nationality:</strong> ${nationality}</div>
            </#if>

            <#if languagesKnown?? && languagesKnown?has_content>
                <div class="detail-item"><strong>Languages:</strong> ${languagesKnown?replace(",", ", ")}</div>
            </#if>

            <#if address?? && address?has_content>
                <div class="detail-item"><strong>Address:</strong> ${address}</div>
            </#if>
        </div>
    </#if>

</div>
</body>

</html>