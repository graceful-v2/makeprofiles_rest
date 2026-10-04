<!DOCTYPE html>
<html>
<head>
<#import "Fonts.ftl" as fonts>
<meta charset="UTF-8">
<@fonts.loadFonts />
<style>

  @page:first { margin-top: 20px; }

  @page {
    size: A4;
    margin-top: 40px;
    margin-bottom: 10px;
    margin-left: 20px;
    margin-right: 20px;
  }

html, body {
  margin: 0;
  padding: 10;
  background: #FFFFFF;
  font-family: ${(style.primaryFont)!'PT Serif'};
  font-size: ${(style.bodySize)!'12pt'};
  line-height: ${(style.lineSpacing)!'1.2'};

    color: ${(style.bodyColor)!'#2A2A2A'};
}


.header {
margin:0 auto;
  background: #EFE7E2;
 width: 210mm;
  clip-path: polygon(0 0, 100% 0, 100% 100%, 0 80%);
  position: relative;
  height:60mm;
}

.header-name {
  font-size: ${(style.nameSize)!'28pt'};
   font-weight: ${(style.fontWeightname)!'800'};
   color: ${(style.nameColor)!'#1B1B1B'};
  margin-bottom: 5px;
}

.header-role {
  letter-spacing: 2px;
  font-size:13pt;
  text-transform: uppercase;
  color: #3A3A3A;
}
.header-item{
  letter-spacing: 0.1cap;
 font-size:13pt;
  color: #3A3A3A;
  line-height:1.4;
}

.header-profile-img {
  width: 165px;
  height: 165px;
  border-radius: 50%;
  object-fit: cover;
  position: absolute;
  right: 45px;
  top: 10px;
  background: #DDD;
}

/* ================= TWO COLUMN CONTENT ================= */
.container {
  width: 210mm;
  margin: auto;

  display: grid;
  grid-template-columns: 50% 50%;

  box-sizing: border-box;
}

.left-section{
  padding: 20px 15px;
}
.right-section{
  padding: 20px 15px;
}


/* ================= SECTIONS ================= */
.section {
  margin-bottom: 7px;
}

.section-title {
  font-size: ${(style.sectionTitleSize)!'14pt'};
  font-weight: ${(style.fontWeightHeading)!'700'};
   color: ${(style.headingColor)!'#1B1B1B'};
  text-transform: uppercase;
  letter-spacing: 1px;
  margin-bottom: 5px;

}

/* ================= EXPERIENCE ================= */
.exp-item {
  margin-bottom: 18px;
  border-bottom: 1px dashed grey;
}

.exp-role {
  font-weight: 700;
  font-size: 12.5pt;
}

.exp-company {
  font-style: italic;
  margin-bottom: 4px;
}

.exp-dates {
  font-size: 12pt;

  margin-bottom: 8px;
}

ul {
  margin: 0;
  padding-left: 20px;
}

ul li {
  margin-bottom: 6px;
}

/* ================= PROJECT INSIDE EXPERIENCE ================= */
.project-block {
  margin-top: 10px;
  margin-bottom:10px;
    border-bottom: 2px dashed lightgrey;

}

.project-title {
  font-weight: 600;
  margin-bottom: 4px;
}

.project-description {
  margin-bottom: 6px;
}

/* ================= EDUCATION ================= */
.education-item {
  margin-bottom: 18px;
}

.edu-degree {
  font-weight: 700;
  font-size: 12pt;
}

.edu-school {
  font-style: italic;
  margin-bottom: 5px;
}

/* ================= LANGUAGES ================= */
.language-item {
  margin-bottom: 10px;
}

.header-detials{
padding:30px;
}

.extra-section-details{
line-height:1.5;
  overflow-wrap: break-word;
       word-break:break-word;

}

.sub-heading-title{
margin-top:15px;
text-transform:uppercase;
text-decoration:underline;
text-underline-offset:2;
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
<div class="header-detials">

  <#if name?? && name?has_content>
    <div class="header-name">${name}</div>
  </#if>

  <div class="header-item">
    <#if phone?? && phone?has_content>
      <div> <svg width="15" height="15" viewBox="0 0 24 24"
                                                  fill="#E91E63"
                                                  xmlns="http://www.w3.org/2000/svg"
                                                  style="vertical-align:middle; margin-right:6px;">
                                               <path d="M6.6 10.8c1.5 3 4.1 5.6 7.1 7.1l2.4-2.4
                                                        c.3-.3.7-.4 1.1-.3 1.2.4 2.6.6 4 .6
                                                        .6 0 1 .4 1 1V21c0 .6-.4 1-1 1
                                                        C10.5 22 2 13.5 2 3c0-.6.4-1 1-1h4.1
                                                        c.6 0 1 .4 1 1 0 1.4.2 2.8.6 4
                                                        .1.4 0 .8-.3 1.1L6.6 10.8z"/>
                                             </svg> ${phone}</div>
    </#if>

    <#if email?? && email?has_content>
      <div><svg width="15" height="15" viewBox="0 0 24 24"
                                                 fill="#B39DDB"
                                                 xmlns="http://www.w3.org/2000/svg"
                                                 style="vertical-align:middle; margin-right:6px;">
                                              <path d="M20 4H4c-1.1 0-2 .9-2 2v12
                                                       c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6
                                                       c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6
                                                       l8 5 8-5v2z"/>
                                            </svg> ${email}</div>
    </#if>

    <#if linkedin?? && linkedin?has_content>
      <div> <svg width="15" height="15" viewBox="0 0 24 24"
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
                                             </svg> <a href="${linkedin}" target="_blank">${linkedin}</a></div>
    </#if>

    <#if location?? && location?has_content>
      <div> <svg width="15" height="15" viewBox="0 0 24 24"
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
                                             </svg> ${location}</div>
    </#if>
  </div>

  <#if profileImage?? && profileImage?has_content>
    <img class="header-profile-img" src="${profileImage}" alt="Profile Image" />
  </#if>

</div>
</div>


<div class="container">

  <div class="left-section">

    <#if summary?? && summary?has_content>
    <div class="section">
      <div class="section-title">Summary</div>
      <div>${summary}</div>
    </div>
    </#if>


    <#if skills?? && skills?trim?length gt 0>
    <div class="section">
      <div class="section-title">Skills</div>
      <ul>
        <#list skills?split(",") as s>
          <#if s?? && s?has_content>
            <li>${s?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>


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
        <div class="exp-dates">
          ${extractmonth(exp.experienceYearStartDate)}
          <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
             &#8211; ${extractmonth(exp.experienceYearEndDate)}
          <#else>
             &#8211; Present
          </#if>
        </div>
        </#if>

        <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
        <ul>
          <#list exp.responsibilities?split(",") as r>
            <#if r?has_content>
              <li>${r?trim}</li>
            </#if>
          </#list>
        </ul>
        </#if>

        <#if exp.projects?? && exp.projects?size gt 0>
        <div class="sub-heading-title">Projects</div>
        <#list exp.projects as prj>
        <div class="project-block">

          <#if prj.projectName?? && prj.projectName?has_content>
          <div class="project-title"><strong>Name: </strong>${prj.projectName}</div>
          </#if>

          <#if prj.projectRole?? && prj.projectRole?has_content>
          <div class="project-title"><strong>Role: </strong>${prj.projectRole}</div>
          </#if>

          <#if prj.projectSkills?? && prj.projectSkills?trim?length gt 0>
          <div class="project-description">
            <strong>Skills:</strong>
            <#list prj.projectSkills?split(",") as skill>
              ${skill?trim}<#if skill_has_next>, </#if>
            </#list>
          </div>
          </#if>

          <#if prj.projectDescription?? && prj.projectDescription?has_content>
          <div class="project-description">
            <strong>Description: </strong>${prj.projectDescription}
          </div>
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
      <div class="section-title">Academic Projects</div>

      <#list collegeProject as cp>
      <div class="project-block">

        <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
        <div class="project-title">${cp.collegeProjectName}</div>
        </#if>

		 <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
          <div class="project-description">
            <strong>Skills:</strong>
            <#list cp.collegeProjectSkills?split(",") as skill>
              ${skill?trim}<#if skill_has_next>, </#if>
            </#list>
          </div>
          </#if>


        <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
        <div class="project-description"><strong>Description: </strong>${cp.collegeProjectDescription}</div>
        </#if>

      </div>
      </#list>

    </div>
    </#if>


    <#if competencies?? && competencies?trim?length gt 0>
    <div class="section">
      <div class="section-title">Core Competencies</div>
      <ul>
        <#list competencies?split(",") as c>
          <#if c?? && c?has_content>
            <li>${c?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>


    <#if goals?? && goals?trim?length gt 0>
    <div class="section">
      <div class="section-title">Goals</div>
	  <#list goals?split(",") as c>
          <#if c?? && c?has_content>
            <div>${c?trim}</div>
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


    <#if addAdditionalDetails?? && addAdditionalDetails && !hasCollegeProjects>
    <div class="section">
      <div class="section-title">Personal Details</div>
      <ul>

        <#if fatherName?? && fatherName?has_content>
        <li>Father Name: ${fatherName}</li>
        </#if>

        <#if dob?? && dob?has_content>
        <li>Date of Birth: ${extractDobYear(dob)}</li>
        </#if>


		  <#if languagesKnown?? && languagesKnown?has_content>
        <li>Languages Known : ${languagesKnown?replace(",", ", ")}</li>
        </#if>



        <#if gender?? && gender?has_content>
        <li>Gender: ${gender}</li>
        </#if>

        <#if nationality?? && nationality?has_content>
        <li>Nationality: ${nationality}</li>
        </#if>

	   <#if address?? && address?has_content>
		<li>Address: ${address}</li>
		</#if>

       <#if maritalStatus?? && maritalStatus?has_content>
        <li>Martial Status: ${maritalStatus}</li>
        </#if>


      </ul>
    </div>
    </#if>

  </div>



  <!-- ================= RIGHT COLUMN ================= -->
  <div class="right-section">



      <#if objective?? && objective?has_content>
            <div class="section">
              <div class="section-title">Objective</div>
              <div>${summary}</div>
            </div>
       </#if>

    <#if education?? && education?size gt 0>
    <div class="section">
      <div class="section-title">Education</div>

      <#list education as edu>
      <div class="education-item">

        <#if edu.department?? && edu.department?has_content>
        <div class="edu-degree">${edu.department}</div>
        </#if>

        <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
        <div class="edu-school">${edu.fieldOfStudy}


		<#if edu.percentage?? && edu.percentage?has_content>
         &#8209; ${edu.percentage}%
        </#if>

		</div>
		<#else>
		<#if edu.percentage?? && edu.percentage?has_content>
                ${edu.percentage}%
            </#if>
        </#if>

        <#if edu.institutionName?? && edu.institutionName?has_content>
        <div class="edu-school">${edu.institutionName}</div>
        </#if>

        <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
        <div class="edu-school">
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


    <#if achievements?? && achievements?size gt 0>
    <div class="section">
      <div class="section-title">Awards</div>
      <div class="extra-section-details">
        <#list achievements as ac>
          <#if ac.achievementsName?? && ac.achievementsName?has_content>
          <div>
            ${ac.achievementsName}
            <#if ac.achievementsDate?? && ac.achievementsDate?has_content>
               &#8211; ${extractmonth(ac.achievementsDate)}
            </#if>
          </div>
          </#if>
        </#list>
      </div>
    </div>
    </#if>


    <#if certificates?? && certificates?size gt 0>
    <div class="section">
      <div class="section-title">Certificates</div>
      <div class="extra-section-details">
        <#list certificates as cr>
          <#if cr.courseName?? && cr.courseName?has_content>
          <div>
            ${cr.courseName}
            <#if cr.courseStartDate?? && cr.courseStartDate?has_content>
              ( ${extractmonth(cr.courseStartDate)}
                <#if cr.courseEndDate?? && cr.courseEndDate?has_content>
                   &#8211; ${extractmonth(cr.courseEndDate)} )
                <#else>
                  )
                </#if>
            </#if>
          </div>
          </#if>
        </#list>
      </div>
    </div>
    </#if>


    <#if softSkills?? && softSkills?trim?length gt 0>
    <div class="section">
      <div class="section-title">Soft Skills</div>
      <ul>
        <#list softSkills?split(",") as sskill>
          <#if sskill?? && sskill?has_content>
            <li>${sskill?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>


    <#if hobbies?? && hobbies?trim?length gt 0>
    <div class="section">
      <div class="section-title">Hobbies</div>
      <ul>
        <#list hobbies?split(",") as hb>
          <#if hb?? && hb?has_content>
            <li>${hb?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>


    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
    <div class="section">
      <div class="section-title">Extracurricular  Activities</div>

	  <#list extraCurricularActivities?split(",") as hb>
          <#if hb?? && hb?has_content>
           <div>${hb}</div>
          </#if>
        </#list>

    </div>
    </#if>


    <#if strengths?? && strengths?trim?length gt 0>
    <div class="section">
      <div class="section-title">Strength</div>
      <#list strengths?split(",") as hb>
          <#if hb?? && hb?has_content>
           <div>${hb}</div>
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


    <#if addAdditionalDetails?? && addAdditionalDetails && hasCollegeProjects>
    <div class="section">
      <div class="section-title">Personal Details</div>
      <ul>

        <#if fatherName?? && fatherName?has_content>
        <li>Father Name: ${fatherName}</li>
        </#if>

        <#if dob?? && dob?has_content>
        <li>Date of Birth: ${extractDobYear(dob)}</li>
        </#if>


		  <#if languagesKnown?? && languagesKnown?has_content>
        <li>Languages Known : ${languagesKnown?replace(",", ", ")}</li>
        </#if>



        <#if gender?? && gender?has_content>
        <li>Gender: ${gender}</li>
        </#if>

        <#if nationality?? && nationality?has_content>
        <li>Nationality: ${nationality}</li>
        </#if>

	   <#if address?? && address?has_content>
		<li>Address: ${address}</li>
		</#if>

       <#if maritalStatus?? && maritalStatus?has_content>
        <li>Martial Status: ${maritalStatus}</li>
        </#if>




      </ul>
    </div>
    </#if>

  </div>

</div>

</body>
</html>
