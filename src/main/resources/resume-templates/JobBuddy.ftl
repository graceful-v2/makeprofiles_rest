

<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="UTF-8">
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
    background: #FFFFFF;
    font-family: ${(style.primaryFont)!'Poppins, Arial, sans-serif'};
    font-size: ${(style.bodySize)!'12pt'};
    line-height: ${(style.lineSpacing)!'1.45'};
	color: ${(style.bodyColor)!'#2E2E2E'};

  }


  .container {
    width: 210mm;
    margin: auto;
    display: grid;
    grid-template-columns: 34% 66%;
    box-sizing: border-box;
    overflow-wrap:break-word;
  }


  .left-section {
    background: #f4a460;
    padding: 30px 15px;
    box-sizing: border-box;
    overflow-wrap:break-word;
  }

  .profile-img {
    width: 120px;
    height: 120px;
    border-radius: 12px;
    background: #D9D9D9;
    margin: auto;
    margin-bottom: 22px;
  }

  .name {
    text-align: center;
   color: ${(style.nameColor)!'#094067'};
   font-size: ${(style.nameSize)!'16pt'};
   font-weight: ${(style.fontWeightname)!'800'};
   text-transform:uppercase;

  }

  .job-title {
    font-size: 13pt;
  }

  .sub-section-title{
   font-size: 13pt;
    margin-top:10px;
	text-decoration:underline;
	text-underline-offect:2;
  }

  .section {
    margin-top: 22px;
    margin-bottom: 22px;
  }

  .section-title {
    font-size: ${(style.sectionTitleSize)!'13.5pt'};
    font-weight: ${(style.fontWeightHeading)!'700'};
	color: ${(style.headingColor)!'#094067'};

    margin-bottom: 10px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding-bottom: 3px;
    border-bottom: 2px solid #E5E5E5;
  }

  .detail-item {
    margin-bottom: 7px;

    overflow-wrap:break-word;
    word-break:break-word;

  }

  ul {
    margin: 0;
    padding-left: 18px;
  }

  ul li {
    margin-bottom: 6px;
  }

  /* ====================== RIGHT SECTION ======================= */
  .right-section {
    background: #FFFFFF;
    padding: 35px 15px;
    box-sizing: border-box;
    overflow-wrap:break-word;
  }

  .profile-text {
    margin-bottom: 18px;
    font-size: ${(style.bodySize)!'12pt'};
  }

  .exp-item {
    margin-bottom: 10px;
     border-bottom:1px dashed  #094067;
    padding-bottom: 15px;
  }

  .exp-role {
    font-size: 13pt;
    font-weight: 700;
    color: #094067;
  }

  .exp-company {
    font-size: 12pt;
    font-style: italic;
    margin-bottom: 7px;
	margin-top:7px;
  }

  .project-title {
    font-weight: 600;
    margin-top: 8px;
    color: #3DA9FC;
  }

  .project-description {
    margin-bottom: 6px;
  }

  .exp-section{
   margin: 10px 0px;
   border-bottom:1px dashed  #094067;
  }
  .exp-fields{
   margin: 5px 0px;
  }
  .exp-skills{
  margin: 3px 0px;
  }

 .project-section{
  margin: 7px 0px;
   border-bottom: 1px solid #E5E5E5;
 }

 .bullets{
 line-height:1.7;
 }

  .left-bg {
    position: fixed;
    top: 0;
    left: 0;
    width: 34%;
    height: 100vh;
    background: #f4a460;
    z-index: -2;
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

<div class="left-bg"></div>


<div class="container">


    <div class="left-section">


        <#if name?? && name?has_content>
        <div class="name">${name}</div>
        </#if>


        <#if jobTitle?? && jobTitle?has_content>
        <div class="job-title">${jobTitle}</div>
        </#if>

        <!-- CONTACT -->

        <div class="section">
            <div class="section-title">Contact</div>
             <#if phone?? && phone?has_content>
            <div class="detail-item">${phone}</div>
            </#if>

            <#if email?? && email?has_content>
            <div class="detail-item">${email}</div>
            </#if>

			 <#if linkedin?? && linkedin?has_content>
            <div class="detail-item">${linkedin}</div>
            </#if>

            <#if location?? && location?has_content>
            <div class="detail-item">${location}</div>
            </#if>

        </div>


        <!-- SKILLS -->
        <#if skills?? && skills?has_content>
        <div class="section">
            <div class="section-title">Skills</div>
            <ul class="bullets">
                <#list skills?split(",") as skill>
                <#if skill?trim?has_content><li>${skill}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

        <!-- SOFT SKILLS -->
        <#if softSkills?? && softSkills?has_content>
        <div class="section">
            <div class="section-title">Soft Skills</div>
            <ul class="bullets">
                <#list softSkills?split(",") as soft>
                <#if soft?trim?has_content><li>${soft}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

        <!-- STRENGTHS -->
        <#if strengths?? && strengths?has_content>
        <div class="section">
            <div class="section-title">Strength</div>
            <ul class="bullets">
                <#list strengths?split(",") as str>
                <#if str?trim?has_content><li>${str}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

        <!-- CORE COMPETENCIES -->
        <#if competencies?? && competencies?has_content>
        <div class="section">
            <div class="section-title">Core Competencies</div>
            <ul class="bullets">
                <#list competencies?split(",") as comp>
                <#if comp?trim?has_content><li>${comp}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

        <!-- HOBBIES -->
        <#if hobbies?? && hobbies?has_content>
        <div class="section">
            <div class="section-title">Hobbies</div>
            <ul class="bullets">
                <#list hobbies?split(",") as hobby>
                <#if hobby?trim?has_content><li>${hobby}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

        <!-- GOALS -->
        <#if goals?? && goals?has_content>
        <div class="section">
            <div class="section-title">Goals</div>
            <ul class="bullets">
                <#list goals?split(",") as g>
                <#if g?trim?has_content><li>${g}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>

    </div>

    <!-- RIGHT SECTION -->
    <div class="right-section">

        <!-- SUMMARY -->
        <#if summary?? && summary?has_content>
        <div class="section">
            <div class="section-title">Summary</div>
            <div class="profile-text">${summary}</div>
        </div>
        </#if>

        <!-- OBJECTIVE -->
        <#if objective?? && objective?has_content>
        <div class="section">
            <div class="section-title">Objective</div>
            <div class="profile-text">${objective}</div>
        </div>
        </#if>

        <!-- EXPERIENCE -->
        <#if experiences?? && experiences?size gt 0>
        <div class="section">
            <div class="section-title">Experience</div>
            <#list experiences as exp>
            <div class="exp-item">

                <#if exp.role?? && exp.role?has_content>
                <div class="exp-role">${exp.role}</div>
                </#if>

                <#if exp.companyName?? && exp.companyName?has_content>
                <div class="exp-company">${exp.companyName}</div>
                </#if>

                <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                <div class="exp-date">${extractmonth(exp.experienceYearStartDate)}
                    <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>  &#8211; ${extractmonth(exp.experienceYearEndDate)}</#if>
                </div>
                </#if>

                <!-- Responsibilities -->
                <#if exp.responsibilities?? && exp.responsibilities?has_content>
                <ul class="bullets">
                    <#list exp.responsibilities?split(",") as r>
                    <#if r?trim?has_content><li>${r}</li></#if>
                    </#list>
                </ul>
                </#if>

                <!-- PROJECTS under experience -->
                <#if exp.projects?? && exp.projects?size gt 0>
                <div class="sub-section-title">Projects</div>
                <#list exp.projects as proj>
                <div class="project-section">
                    <#if proj.projectName??><div class="project-title">${proj.projectName}</div></#if>
                    <#if proj.projectRole??><div class="exp-company">${proj.projectRole}</div></#if>

                    <#if proj.projectSkills??>
                    <ul class="bullets">
                        <#list proj.projectSkills?split(",") as s>
                        <#if s?trim?has_content><li>${s}</li></#if>
                        </#list>
                    </ul>
                    </#if>

                    <#if proj.projectDescription??>
                    <div class="project-description">${proj.projectDescription}</div>
                    </#if>
                </div>
                </#list>
                </#if>

            </div>
            </#list>
        </div>
        </#if>

        <!-- ACADEMIC PROJECTS -->
        <#if collegeProject?? && collegeProject?size gt 0>
        <div class="section">
            <div class="section-title">Academic Projects</div>

            <#list collegeProject as cp>
            <div class="project-item">
                <#if cp.projectName??><div class="sub-project-section-title">${cp.projectName}</div></#if>

                <#if cp.projectSkills??>
                <strong>Skills:</strong>
                <ul class="bullets">
                    <#list cp.projectSkills?split(",") as sk>
                    <#if sk?trim?has_content><li>${sk}</li></#if>
                    </#list>
                </ul>
                </#if>

                <#if cp.projectDescription??>
                <strong>Description:</strong>
                <div class="project-description">${cp.projectDescription}</div>
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
            <div class="exp-section">

                <#if edu.department?? && edu.department?has_content><div class="exp-role">${edu.department}</div></#if>
                <#if edu.institutionName?? && edu.institutionName?has_content><div class="exp-fields">${edu.institutionName}</div></#if>
                <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content><div class="exp-fields">${edu.fieldOfStudy}</div></#if>
                <#if edu.percentage?? && edu.percentage?has_content><div class="exp-fields">${edu.percentage}%</div></#if>

                <#if edu.qualificationStartYear??>
                <div class="exp-fields">
                    (${edu.qualificationStartYear}
                    <#if edu.qualificationEndYear??>  &#8211; ${edu.qualificationEndYear}</#if>)
                </div>
                </#if>

            </div>
            </#list>

        </div>
        </#if>


        <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
        <div class="section">
            <div class="section-title">Extracurricular Activities</div>
            <ul class="bullets">
                <#list extraCurricularActivities?split(",") as ex>
                <#if ex?trim?has_content><li>${ex}</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


        <#if certificates?? && certificates?size gt 0>
        <div class="section">
            <div class="section-title">Certifications</div>
            <ul class="bullets">
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
        </div>
        </#if>


        <#if achievements?? && achievements?size gt 0>
        <div class="section">
            <div class="section-title">Achievements</div>
            <ul class="bullets">
                   <#list achievements as achieve>
                        <#if achieve.achievementsName?has_content>
                          <li>${achieve.achievementsName}
                            <#if achieve.achievementsDate?has_content>
                               &#8211; ${extractmonth(achieve.achievementsDate)}
                            </#if>
                          </li>
                        </#if>
                      </#list>
            </ul>
        </div>
        </#if>


           <#if addAdditionalDetails?? && addAdditionalDetails>
			<div class="section">
				<div class="section-title">Personal Details</div>

				<#if fatherName?? && fatherName?has_content>
				<div class="exp-fields"><strong>Father Name:</strong> ${fatherName}</div>
				</#if>

				<#if dob?? && dob?has_content>
				<div class="exp-fields"><strong>Date of Birth:</strong> ${dob}</div>
				</#if>

				<#if gender?? && gender?has_content>
				<div class="exp-fields"><strong>Gender:</strong> ${gender}</div>
				</#if>

				<#if nationality?? && nationality?has_content>
				<div class="exp-fields"><strong>Nationality:</strong> ${nationality}</div>
				</#if>

				<#if address?? && address?has_content>
				<div class="exp-fields"><strong>Address:</strong> ${address}</div>
				</#if>

				<#if languagesKnown?? && languagesKnown?has_content>
				<div class="exp-fields"><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</div>
				</#if>

				<#if maritalStatus?? && maritalStatus?has_content>
				<div class="exp-fields"><strong>Marital Status:</strong> ${maritalStatus}</div>
				</#if>

			</div>
			</#if>


    </div>

</div>
</body>
</html>