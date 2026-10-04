
<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="UTF-8" />
<@fonts.loadFonts />

<style>

  @page:first { margin-top: 10px; }
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
    font-family: ${(style.primaryFont)!'Inter, Helvetica, Arial, sans-serif'};
    font-size: ${(style.bodySize)!'12pt'};
    line-height: ${(style.lineSpacing)!'1.4'};
    color: ${(style.bodyColor)!'#222'};
    background: white;
  }

  /* ================= HEADER ================= */
  .header {
    padding: 30px 20px 18px 20px;
    width: 210mm;
    margin: auto;
    border-bottom: 2px solid #333;
  }

  .name {
   color: ${(style.nameColor)!'#1f2933'};
   font-size: ${(style.nameSize)!'28pt'};
   font-weight: ${(style.fontWeightname)!'800'};
    letter-spacing: 1px;
  }

  .name span.last {
    font-weight: 800;
    text-transform: uppercase;
    color: ${(style.headingColor)!'#222'};
  }

  .job-title {
    font-size: 13pt;
    margin-top: 4px;
    color: #555;
  }



  .contact-grid {
    margin-top: 14px;
    display: grid;
    grid-template-columns: 18px auto;
    row-gap: 6px;
    column-gap: 10px;

  }

  .icon {
     font-size: ${(style.bodySize)!'12pt'};
  }



  .summary-title {
    text-align: center;
	font-size: ${(style.sectionTitleSize)!'14pt'};
    font-weight: ${(style.fontWeightHeading)!'700'};
    color: ${(style.headingColor)!'#0c3d73'};
    margin-top: 20px;
    margin-bottom: 10px;
    color: #0c3d73;
    letter-spacing: 1px;
  }

  .summary-text {
   width: 210mm;
    margin: auto;

    padding: 0px 20px;
    color: #444;
  }



  .container {
    width: 210mm;
    margin: auto;
    padding: 5px 5px;
    display: grid;
    grid-template-columns: 40% 60%;
    column-gap: 25px;
    box-sizing: border-box;
     overflow-wrap:break-word;

  }

  .left-section {
    /* padding-right: 10px; */
     overflow-wrap:break-word;
  }

  .right-section {
  padding-left: 10px; border-left:
  1px solid #ccc;
  overflow-wrap:break-word;
  }



  .section-title {
    font-size: ${(style.sectionTitleSize)!'13pt'};
    font-weight: ${(style.fontWeightHeading)!'700'};
	  color: ${(style.headingColor)!'#0c3d73'};

    letter-spacing: 0.5px;
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
  }

  .section{
   padding-bottom: 3px;
   margin-top: 15px;
  }

  .sub-section-title {
    font-size: 12.5pt;
    font-weight: 700;

    color: #0c3d73;
  }

  .education-sub-details{
   line-height:1.3;
  }
  .sub-project-section-title{
    font-size: 12pt;
    font-weight: 500;
	margin:10px 0px;
    color: #0c3d73;

  }



  ul {
   padding-left: 18px;
   margin: 0; }

  ul li {
  margin-bottom: 5px;
   }

  .edu-item, .cert-item, .skill-item { margin-bottom: 12px; }

  .exp-role { font-size: 12pt; font-weight: 700; margin-bottom: 4px; }

  .exp-line { font-size: 12pt; font-style: italic; margin-bottom: 6px; }

  .exp-item{
   margin-bottom: 12px;
   border-bottom: 1px solid #ddd;
  }

  .project-description{
   margin-top:5px;
    margin-bottom:5px;

  }

  .project-item{
   border-bottom: 1px solid #ddd;
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




<div class="header">

    <#if name?? && name?has_content>
        <div class="name"><span class="last">${name}</span></div>
    </#if>

    <#if jobTitle?? && jobTitle?has_content>
        <div class="job-title">${jobTitle}</div>
    </#if>

    <div class="contact-grid">

        <#if phone?? && phone?has_content>
            <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                   fill="#E91E63"
                                   xmlns="http://www.w3.org/2000/svg"
                                   style="vertical-align:middle; margin-right:6px;">
                                <path d="M6.6 10.8c1.5 3 4.1 5.6 7.1 7.1l2.4-2.4
                                         c.3-.3.7-.4 1.1-.3 1.2.4 2.6.6 4 .6
                                         .6 0 1 .4 1 1V21c0 .6-.4 1-1 1
                                         C10.5 22 2 13.5 2 3c0-.6.4-1 1-1h4.1
                                         c.6 0 1 .4 1 1 0 1.4.2 2.8.6 4
                                         .1.4 0 .8-.3 1.1L6.6 10.8z"/>
                              </svg>
</div><div>${phone}</div>
        </#if>

        <#if email?? && email?has_content>
            <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                   fill="#B39DDB"
                                   xmlns="http://www.w3.org/2000/svg"
                                   style="vertical-align:middle; margin-right:6px;">
                                <path d="M20 4H4c-1.1 0-2 .9-2 2v12
                                         c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6
                                         c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6
                                         l8 5 8-5v2z"/>
                              </svg>
</div><div>${email}</div>
        </#if>

        <#if location?? && location?has_content>
            <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                   fill="#9E9E9E"
                                   xmlns="http://www.w3.org/2000/svg"
                                   style="vertical-align:middle; margin-right:6px;">
                                <path d="M12 2C8.1 2 5 5.1 5 9
                                         c0 5.2 7 13 7 13s7-7.8 7-13
                                         c0-3.9-3.1-7-7-7zm0 9.5
                                         c-1.4 0-2.5-1.1-2.5-2.5
                                         S10.6 6.5 12 6.5
                                         14.5 7.6 14.5 9
                                         13.4 11.5 12 11.5z"/>
                              </svg>
</div><div>${location}</div>
        </#if>

        <#if linkedin?? && linkedin?has_content>
            <div class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                   fill="#9E9E9E"
                                   xmlns="http://www.w3.org/2000/svg"
                                   style="vertical-align:middle; margin-right:6px;">
                                <path d="M10.6 13.4a4 4 0 0 1 0-5.7l2.1-2.1
                                         a4 4 0 1 1 5.7 5.7l-1 1-1.4-1.4
                                         1-1a2 2 0 1 0-2.8-2.8l-2.1 2.1
                                         a2 2 0 0 0 0 2.8l-1.5 1.4z"/>
                                <path d="M13.4 10.6a4 4 0 0 1 0 5.7l-2.1 2.1
                                         a4 4 0 0 1-5.7-5.7l1-1 1.4 1.4
                                         -1 1a2 2 0 0 0 2.8 2.8l2.1-2.1
                                         a2 2 0 0 0 0-2.8l1.5-1.4z"/>
                              </svg>
</div><div>${linkedin}</div>
        </#if>
    </div>
</div>




<#if summary?? && summary?has_content>
<div class="summary-title">SUMMARY</div>
<div class="summary-text">${summary}</div>
</#if>



<!-- ================= MAIN LAYOUT ================= -->
<div class="container">

    <!-- LEFT SECTION -->
    <div class="left-section">

        <!-- EDUCATION -->
        <#if education?? && education?size gt 0>
        <div class="section">
            <div class="section-title">EDUCATION</div>

            <#list education as edu>
            <div class="edu-item">
                <#if edu.institutionName?has_content>
                    <div class="sub-section-title">${edu.institutionName}</div>
                </#if>

                <div class="education-sub-details">
                    <#if edu.department?? && edu.department?has_content>
                        <div>${edu.department}</div>
                    </#if>

					<#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                        <div>${edu.fieldOfStudy}</div>
                    </#if>

                    <#if edu.percentage?? && edu.percentage?has_content>
                        <div>${edu.percentage}%</div>
                    </#if>

                    <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                        <div>(
                            ${extractmonth(edu.qualificationStartYear)}
                            <#if edu.qualificationEndYear?has_content>
                                 &#8211; ${extractmonth(edu.qualificationEndYear)}
                            <#else>  &#8211; Present
                            </#if>
                        )</div>
                    </#if>
                </div>
            </div>
            </#list>

        </div>
        </#if>


        <!-- SKILLS -->
        <#if skills?? && skills?trim?length gt 0>
        <div class="section">
            <div class="section-title">SKILLS</div>
            <ul>
                <#list skills?split(",") as s>
                    <#if s?trim?has_content><li>${s?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


        <!-- CERTIFICATIONS -->
        <#if certificates?? && certificates?size gt 0>
        <div class="section">
            <div class="section-title">CERTIFICATIONS</div>
            <ul>
                <#list certificates as cert>
                    <#if cert.courseName?has_content>
                        <li>${cert.courseName}  &nbsp;
						 <#if cert.courseStartDate?? && cert.courseStartDate?has_content>
						     ${extractmonth(cert.courseStartDate)}
							<#if cert.courseEndDate?? && cert.courseEndDate?has_content>
							&#8211;  ${extractmonth(cert.courseEndDate)}
							 </#if>
						  </#if>

						 </li>
                    </#if>
                </#list>
            </ul>
        </div>
        </#if>


        <!-- SOFT SKILLS -->
        <#if softSkills?? && softSkills?trim?length gt 0>
        <div class="section">
            <div class="section-title">SOFT SKILLS</div>
            <ul>
                <#list softSkills?split(",") as s>
                    <#if s?trim?has_content><li>${s?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


        <!-- CORE COMPETENCIES -->
        <#if competencies?? && competencies?trim?length gt 0>
        <div class="section">
            <div class="section-title">CORE COMPETENCIES</div>
            <ul>
                <#list competencies?split(",") as c>
                    <#if c?trim?has_content><li>${c?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


        <!-- STRENGTHS -->
        <#if strengths?? && strengths?trim?length gt 0>
        <div class="section">
            <div class="section-title">STRENGTH</div>
            <ul>
                <#list strengths?split(",") as st>
                    <#if st?trim?has_content><li>${st?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


        <!-- HOBBIES -->
        <#if hobbies?? && hobbies?trim?length gt 0>
        <div class="section">
            <div class="section-title">HOBBIES</div>
            <ul>
                <#list hobbies?split(",") as h>
                    <#if h?trim?has_content><li>${h?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

		     <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
        <div class="section">
            <div class="section-title">EXTRA CURRICULAR ACTIVITIES</div>
            <ul>
                <#list extraCurricularActivities?split(",") as h>
                    <#if h?trim?has_content><li>${h?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

    </div> <!-- END LEFT -->



    <!-- RIGHT SECTION -->
    <div class="right-section">

        <!-- EXPERIENCE -->
        <#if experiences?? && experiences?size gt 0>
        <div class="section">
            <div class="section-title">PROFESSIONAL EXPERIENCE</div>

            <#list experiences as exp>
            <div class="exp-item">

                <#if exp.role?? && exp.role?has_content>
                    <div class="exp-role">${exp.role}</div>
                </#if>

                <#if exp.companyName?? && exp.companyName?has_content>
                    <div class="exp-line">
                        ${exp.companyName} |

						 <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                        ${extractmonth(exp.experienceYearStartDate)}
                        <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                             &#8211; ${extractmonth(exp.experienceYearEndDate)}
                        <#else>  &#8211; Present
                        </#if>
						</#if>
                    </div>
                </#if>

                <#if exp.responsibilities?? && exp.responsibilities?has_content>
                <ul>
                    <#list exp.responsibilities?split(",") as r>
                        <#if r?trim?has_content><li>${r?trim}</li></#if>
                    </#list>
                </ul>
                </#if>


                <!-- PROJECTS under experience -->
                <#if exp.projects?? && exp.projects?size gt 0>
                <div class="sub-project-section-title">PROJECTS</div>

                <#list exp.projects as proj>

                    <#if  proj.projectName?? && proj.projectName?has_content>
                        <div class="exp-role">Name: ${proj.projectName}</div>
                    </#if>

                    <#if proj.projectRole?? && proj.projectRole?has_content>
                        <div class="exp-line"><strong>Role:</strong> ${proj.projectRole}</div>
                    </#if>

                    <#if proj.projectSkills?? && proj.projectSkills?trim?length gt 0>
                        <ul>
                            <#list proj.projectSkills?split(",") as ps>
                                <#if ps?trim?has_content><li>${ps?trim}</li></#if>
                            </#list>
                        </ul>
                    </#if>

                    <#if  proj.projectDescription?? &&  proj.projectDescription?has_content>
                        <strong>Description</strong>
                        <ul>
                            <#list proj.projectDescription?split(",") as d>
                                <#if d?trim?has_content><li>${d?trim}</li></#if>
                            </#list>
                        </ul>
                    </#if>

                    </br>

                </#list>
                </#if>

            </div>
            </#list>

        </div>
        </#if>



        <!-- ACADEMIC PROJECTS -->
        <#if collegeProject?? && collegeProject?size gt 0>
        <div class="section">
            <div class="section-title">ACADEMIC PROJECTS</div>

            <#list collegeProject as cp>
            <div class="project-item">

                <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
                    <div class="sub-project-section-title">
                        ${cp.collegeProjectName}
                    </div>
                </#if>

                <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?has_content>
                <strong>Skills:</strong>
                <ul>
                    <#list cp.collegeProjectSkills?split(",") as sk>
                        <#if sk?trim?has_content><li>${sk?trim}</li></#if>
                    </#list>
                </ul>
                </#if>

                <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?trim?length gt 0>
                <strong>Description:</strong>
                <div class="project-description">${cp.collegeProjectDescription}</div>
                </#if>

            </div>
            </#list>

        </div>
        </#if>



        <!-- ACHIEVEMENTS -->
        <#if achievements?? && achievements?size gt 0>
        <div class="section">
            <div class="section-title">ACHIEVEMENTS</div>
            <ul>
                <#list achievements as ach>
                    <#if ach.achievementsName?has_content><li>${ach.achievementsName}

                                <#if ach.achievementsDate?? && ach.achievementsDate?has_content>
                                  &#8208; ${extractmonth(ach.achievementsDate)}
                                </#if>
                    </li></#if>
                </#list>
            </ul>
        </div>
        </#if>


		     <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
        <div class="section">
            <div class="section-title">EXTRACURRICULAR ACTIVITIES</div>
            <ul>
                <#list extraCurricularActivities?split(",") as h>
                    <#if h?trim?has_content><li>${h?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


		     <#if goals?? && goals?trim?length gt 0>
        <div class="section">
            <div class="section-title">GOALS</div>
            <ul>
                <#list goals?split(",") as h>
                    <#if h?trim?has_content><li>${h?trim}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>



        <!-- PERSONAL INFO -->
        <#if addAdditionalDetails?? && addAdditionalDetails>
        <div class="section">
            <div class="section-title">PERSONAL DETAILS</div>
            <ul>
                <#if fatherName?has_content><li>Father Name: ${fatherName}</li></#if>
                <#if gender?has_content><li>Gender: ${gender}</li></#if>
                <#if dob?has_content><li>Date of Birth: ${extractDobYear(dob)}</li></#if>
				<#if address?has_content><li>Address: ${address}</li></#if>
				<#if maritalStatus?has_content><li>Martial Status: ${maritalStatus}</li></#if>
                <#if nationality?has_content><li>Nationality: ${nationality}</li></#if>
				 <#if nationality?has_content><li>Languages Known:  ${languagesKnown?replace(",", ", ")}</li></#if>

            </ul>
        </div>
        </#if>

    </div>

</div>
</body>
</html>