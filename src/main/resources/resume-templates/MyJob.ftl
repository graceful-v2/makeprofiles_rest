
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
  width: 210mm;
  margin: 0 auto;
  padding: 0;
  font-family: ${(style.primaryFont)!'Poppins, Arial, sans-serif'};
  font-size: ${(style.bodySize)!'12pt'};
  line-height: ${(style.lineSpacing)!'1.3'};
  background: #FFFFFF;
  color: ${(style.bodyColor)!'#2A2A2A'};
}


.header {
  width: 210mm;
  background: #0078ff;
  color: white;
  /* padding: 40px 45px 60px 45px;*/
  clip-path: polygon(0 0, 100% 0, 100% 85%, 0 100%);
  position: relative;
  padding-bottom:20px;
}

.header-name {
   color: ${(style.nameColor)!'#ffffff'};
   font-size: ${(style.nameSize)!'25pt'};
   font-weight: ${(style.fontWeightname)!'800'};
}

.header-role {
  color: #E5B76B;
  font-size: 13pt;
  margin-bottom: 15px;
}

.header-summary {
  width: 60%;
  color: #DADADA;
  margin-top: 12px;
  line-height: 1.3;

}

/* Profile image in header */
.header-profile-img {
  width: 115px;
  height: 115px;
  border-radius: 50%;
  background: #DDD;
  position: absolute;
  right: 45px;
  top: 25px;
  object-fit: cover;
}


.contact-block {
  right: 45px;
  top: 170px;
  color: #EEE;

  line-height: 1.6;
}

.contact-item {
  display: flex;
  align-items: center;
  margin-bottom: 6px;
  font-size: 12pt;
}

.contact-icon {
  width: 16px; height: 16px;
  margin-right: 8px;
  fill: #E5B76B;
}

/* ================= PAGE GRID ================= */
.container {
  width: 210mm;
  margin: auto;

  display: grid;
  grid-template-columns: 58% 42%;

  box-sizing: border-box;
}


.section {
  margin-bottom: 6px;
}

.section-title {
  font-size: ${(style.sectionTitleSize)!'14pt'};
  font-weight: ${(style.fontWeightHeading)!'700'};
  color: ${(style.headingColor)!'#1F242E'};

  border-bottom: 2px solid #E2E2E2;
  margin-bottom: 7px;
  display: flex;
  align-items: center;
}

/* Title icon */
.title-icon {
  width: 22px;
  height: 22px;
  margin-right: 10px;
  fill: #1F242E;
}


.exp-item {
  margin-bottom: 22px;

}

.exp-role {
  font-size: 13pt;
  font-weight: 700;
}

.exp-company {

  font-weight: 500;
  margin-bottom: 3px;
  margin-top: 5px;
}

.exp-dates {
  font-size: 12pt;
   margin-top: 5px;
  margin-bottom: 10px;
}

ul {
  margin: 0;
  padding-left: 20px;
}

ul li {
  margin-bottom: 6px;
}

 .project-block {
  margin-top: 10px;
  border-bottom: 1px dashed grey;
}

.project-title {
  font-weight: 600;
  color: #1F242E;
  margin-bottom: 4px;
}

.project-description {
  margin-bottom: 6px;
}

/* ================= SKILLS TAGS ================= */
.skill-tag {
  display: inline-block;
  background: #E7E7E7;
  padding: 6px 10px;
  border-radius: 6px;
  margin: 4px;

}

/* ================= EDUCATION ================= */
.education-item {
  margin-bottom: 20px;
}

.edu-degree {
  font-weight: 700;
  font-size: 12.5pt;
}

.edu-school {
  font-style: italic;

}

/* ================= LANGUAGES ================= */
.language-item {
  margin-bottom: 8px;
}

.lang-label {
  font-weight: 600;
}
.header-detials{
padding:30px;
}

.left-section{
  padding: 20px 15px;
}
.right-section{
  padding: 20px 15px;
}

.sub-heading-name{
font-size:14pt;

font-weight:500;
text-decoration:underline;
text-underline-offset:2;
margin-top:5px;
margin-bottom:5px;

}

 .certi-list{

       overflow-wrap: break-word;
       word-break:break-word;

        }


  .project-subheading{
           font-weight:700;
           margin:3px 0px;
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

    <#if jobTitle?? && jobTitle?has_content>
    <div class="header-role">${jobTitle}</div>
    </#if>

    <#if profileImage?? && profileImage?has_content>
    <img class="header-profile-img" src="${profileImage}" />
    </#if>


    <div class="contact-block">

      <#if email?? && email?has_content>
      <div class="contact-item">
        <svg class="contact-icon"><circle cx="8" cy="8" r="7"/></svg>
        ${email}
      </div>
      </#if>


      <#if phone?? && phone?has_content>
      <div class="contact-item">
        <svg class="contact-icon"><circle cx="8" cy="8" r="7"/></svg>
        ${phone}
      </div>
      </#if>

      <#if linkedin?? && linkedin?has_content>
      <div class="contact-item">
        <svg class="contact-icon"><circle cx="8" cy="8" r="7"/></svg>
        ${linkedin}
      </div>
      </#if>

	  <#if location?? && location?has_content>
      <div class="contact-item">
        <svg class="contact-icon"><circle cx="8" cy="8" r="7"/></svg>
        ${location}
      </div>
      </#if>

    </div>


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



    <#if experiences?? && experiences?size gt 0>
    <div class="section">
      <div class="section-title">Work Experience</div>

      <#list experiences as exp>
      <div class="exp-item">

        <#if exp.role?? && exp.role?has_content>
        <div class="exp-role">${exp.role}</div>
        </#if>

        <#if exp.companyName?? && exp.companyName?has_content>
        <div class="exp-company">${exp.companyName}</div>
        </#if>

        <#if  exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content >
        <div class="exp-dates">
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
              <#list exp.responsibilities?split(",") as item>
                        <#if item?trim?has_content><li>${item?trim}</li></#if>
                 </#list>
        </ul>
        </#if>



        <#if exp.projects?? && exp.projects?size gt 0>

        <div class="project-subheading">Project:</div>

        <#list exp.projects as pro>
        <div class="project-block">

          <#if pro.projectName?? && pro.projectName?has_content>
          <div class="project-title">${pro.projectName}</div>
          </#if>

          <#if pro.projectRole?? && pro.projectRole?has_content>
          <div class="project-title"><strong>Role:</strong> ${pro.projectRole}</div>
          </#if>

          <#if pro.projectSkills?? && pro.projectSkills?has_content>
          <ul>
            <#list pro.projectSkills?split(",") as sk>${sk}<#if sk_has_next>, </#if></#list>
          </ul>
          </#if>

          <#if pro.projectDescription?? && pro.projectDescription?has_content>
          <div class="project-description">${pro.projectDescription}</div>
          </#if>

        </div>
        </#list>
        </#if>

      </div>
      </#list>

    </div>
    </#if>


    <#-- ACADEMIC PROJECTS -->
    <#if collegeProject?? && collegeProject?size gt 0>
    <div class="section">
      <div class="section-title">Academic Projects</div>

      <#list collegeProject as ap>
      <div class="project-block">

        <#if ap.collegeProjectName?? && ap.collegeProjectName?has_content>
        <div class="project-title">${ap.collegeProjectName}</div>
        </#if>

        <#if ap.collegeProjectSkills?? && ap.collegeProjectSkills?has_content>
        <ul>
          <#list ap.collegeProjectSkills?split(",") as sk>
          <li>${sk}</li>
          </#list>
        </ul>
        </#if>

        <#if ap.collegeProjectDescription?? && ap.collegeProjectDescription?has_content>
        <div class="project-description">${ap.collegeProjectDescription}</div>
        </#if>

      </div>
      </#list>

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
		<div class="edu-school">${edu.fieldOfStudy}  &nbsp;
		 <#if  edu.percentage?? && edu.percentage?has_content>${edu.percentage}%</#if>
		</div>

		   <#else>
		    <#if  edu.percentage?? && edu.percentage?has_content>
		        <div class="edu-school">
           		 ${edu.percentage}%
           		</div>
           		</#if>
     	</#if>

		<div class="edu-school">
		  <#if  edu.institutionName?? && edu.institutionName?has_content>${edu.institutionName}</#if>
		   <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
		      &nbsp;  ${extractmonth(edu.qualificationStartYear)}
                           <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                                    &#8211; ${extractmonth(edu.qualificationEndYear)}
                                <#else>
                                    &#8211; Present
                                </#if>
						   </#if>
		</div>

      </div>
      </#list>

    </div>
    </#if>


    <#-- GOALS -->
    <#if goals?? && goals?has_content>
    <div class="section">
      <div class="section-title">Goals</div>
      <#list goals?split(",") as g><div>
	    <#if g?trim?has_content>
	  ${g}</div>
	  </#if>
	  </#list>
    </div>
    </#if>


    <#-- HOBBIES -->
    <#if hobbies?? && hobbies?has_content>
    <div class="section">
      <div class="section-title">Hobbies</div>
      <#list hobbies?split(",") as h><div>
	  <#if h?trim?has_content>
	  ${h}</div>
	   </#if>
	  </#list>
    </div>
    </#if>


    <#-- EXTRA CIRCULAR -->
    <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
    <div class="section">
      <div class="section-title">Extracurricular Activities</div>
      <#list extraCurricularActivities?split(",") as ex>
	    <#if ex?trim?has_content>
	  <div>${ex}</div>
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

          <#if fatherName?? && fatherName?has_content>
          <div class="language-item">
            <span class="lang-label">Father Name:</span> ${fatherName}
          </div>
          </#if>

          <#if gender?? && gender?has_content>
          <div class="language-item">
            <span class="lang-label">Gender:</span> ${gender}
          </div>
          </#if>

          <#if maritalStatus?? && maritalStatus?has_content>
          <div class="language-item">
            <span class="lang-label">Marital Status:</span> ${maritalStatus}
          </div>
          </#if>

    	   <#if address?? && address?has_content>
          <div class="language-item">
            <span class="lang-label">Address:</span> ${address}
          </div>
          </#if>


    	   <#if nationality?? && nationality?has_content>
          <div class="language-item">
            <span class="lang-label">Address:</span> ${nationality}
          </div>
          </#if>

              <#if dob?? && dob?has_content>
                      <div class="language-item">
                     <span class="lang-label">DOB:</span> ${extractDobYear(dob)}

                        </div>
              </#if>



              <#if nationality?? && nationality?has_content>
               <div class="language-item">
                <span class="lang-label">Nationality:</span> ${nationality}
              </div>
              </#if>

              <#if address?? && address?has_content>
               <div class="language-item">
               <span class="lang-label"><strong>Address:</span> ${address}
               </div>
              </#if>


          <#if languagesKnown?? && languagesKnown?has_content>
                  <div class="language-item">
                        <span class="lang-label">Language Known:</span>
                         ${languagesKnown?replace(",", ", ")}
                      </div>
          </#if>

        </div>
        </#if>

  </div> <!-- LEFT END -->



  <!-- RIGHT SECTION -->
  <div class="right-section">

    <#-- OBJECTIVE -->
    <#if objective?? && objective?has_content>
    <div class="section">
      <div class="section-title">Objective</div>
      <div>${objective}</div>
    </div>
    </#if>


    <#-- SPECIAL SKILLS -->
    <#if skills?? && skills?has_content>
    <div class="section">
      <div class="section-title">Skills & Competencies</div>
      <#list skills?split(",")  as s>
          <#if s?? && s?has_content>
            <div class="skill-tag">${s}</div>
          </#if>
      </#list>
    </div>
    </#if>


    <#-- SOFT SKILLS -->
    <#if softSkills?? && softSkills?has_content>
    <div class="section">
      <div class="section-title">Soft Skills</div>
      <#list softSkills?split(",") as ss>
       <#if ss?? && ss?has_content>
          <div class="skill-tag">${ss}</div>
       </#if>
      </#list>
    </div>
    </#if>


    <#-- CORE COMP -->
    <#if competencies?? && competencies?has_content>
    <div class="section">
      <div class="section-title">Core Competencies</div>
      <#list competencies?split(",") as cc>
         <#if cc?? && cc?has_content>
            <div class="skill-tag">${cc}</div>
         </#if>
      </#list>
    </div>
    </#if>



     <#if certificates?? && certificates?size gt 0>
    <div class="section">
      <div class="section-title">Certificates & Courses</div>
      <#list certificates as certi>
      <div class="certi-list">
                   <#if certi.courseName?? && certi.courseName?has_content>
                    ${certi.courseName}

                                  <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                                                     (

                                      ${extractmonth(certi.courseStartDate)}
                                                    <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
                                                            &#8211;  ${extractmonth(certi.courseEndDate)}
                                                    </#if>

                                    )
                                   </#if>
                     </#if>

 </div>
	  </#list>
    </div>
    </#if>


    <#-- ACHIEVEMENTS -->
    <#if achievements?? && achievements?has_content>
    <div class="section">
      <div class="section-title">Achivements</div>

        <div class="certi-list">
      <#list achievements as achieve><div>

	           <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                         ${achieve.achievementsName}
                       <#if achieve.achievementsDate?has_content>
                                                       &nbsp;    &#8211; ${extractmonth(achieve.achievementsDate)}
                                                        </#if>
                    </#if>
	  </div></#list>
	  </div>
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

      <#if fatherName?? && fatherName?has_content>
      <div class="language-item">
        <span class="lang-label">Father Name:</span> ${fatherName}
      </div>
      </#if>

      <#if gender?? && gender?has_content>
      <div class="language-item">
        <span class="lang-label">Gender:</span> ${gender}
      </div>
      </#if>

      <#if maritalStatus?? && maritalStatus?has_content>
      <div class="language-item">
        <span class="lang-label">Marital Status:</span> ${maritalStatus}
      </div>
      </#if>

	   <#if address?? && address?has_content>
      <div class="language-item">
        <span class="lang-label">Address:</span> ${address}
      </div>
      </#if>


	   <#if nationality?? && nationality?has_content>
      <div class="language-item">
        <span class="lang-label">Nationality:</span> ${nationality}
      </div>
      </#if>

      <#if dob?? && dob?has_content>
          <span class="lang-label">DOB:</span> ${dob}
          </#if>



      <#if languagesKnown?? && languagesKnown?has_content>
      <div class="language-item">
			<span class="lang-label">Language Known:</span>
			 ${languagesKnown?replace(",", ", ")}
		  </div>
      </#if>

    </div>
    </#if>

  </div>

</div>

</body>

</html>
