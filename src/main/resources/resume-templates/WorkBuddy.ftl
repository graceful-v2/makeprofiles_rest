
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
    margin-bottom: 10px;
    margin-left: 20px;
    margin-right: 20px;
  }

  html, body {
    margin: 0;
    padding: 0;
    font-family: ${(style.primaryFont)!'PT Serif'};
    font-size: ${(style.bodySize)!'12pt'};
    line-height: ${(style.lineSpacing)!'1.35'};
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
  grid-template-columns: 35% 65%;
  padding: 5px 5px;
	width: 210mm;
	margin: auto;
	box-sizing: border-box;
	position: relative;
	overflow-wrap:break-word;
	word-break:break-word;
	}


.left-section {
padding-right: 5px;
 overflow-wrap:break-word;
 word-break:break-word;
 }


.right-section {
  border-left: 1px solid #ddd;
  padding-left: 5px;
  overflow-wrap:break-word;
  word-break:break-word;
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
        - ${email}
      </#if>
      <#if linkedin?? && linkedin?has_content>
        - ${linkedin}
      </#if>
   </div>
</div>

<div class="container">

  <div class="left-section">

    <!-- SUMMARY (LEFT) -->
    <#if summary?? && summary?has_content>
    <div class="section">
      <div class="section-title">Summary</div>
      <p>${summary}</p>
    </div>
    </#if>

    <!-- SKILLS -->
    <#if skills?? && skills?trim?length gt 0>
    <div class="section">
      <div class="section-title">Skills</div>
      <hr/>
      <ul class="bullets">
        <#list skills?split(",") as skill>
          <#if skill?? && skill?has_content>
            <li>${skill?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>

    <!-- SOFT SKILLS -->
    <#if softSkills?? && softSkills?trim?length gt 0>
    <div class="section">
      <div class="section-title">Soft Skills</div>
      <hr/>
      <ul class="bullets">
        <#list softSkills?split(",") as skill>
          <#if skill?? && skill?has_content>
            <li>${skill?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>

    <!-- STRENGTH -->
    <#if strengths?? && strengths?trim?length gt 0>
    <div class="section">
      <div class="section-title">Strength</div>
      <hr/>
      <ul class="bullets">
        <#list strengths?split(",") as skill>
          <#if skill?? && skill?has_content>
            <li>${skill?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>

    <!-- HOBBIES -->
    <#if hobbies?? && hobbies?trim?length gt 0>
    <div class="section">
      <div class="section-title">Hobbies</div>
      <hr/>
      <ul class="bullets">
        <#list hobbies?split(",") as hobby>
          <#if hobby?? && hobby?has_content>
            <li>${hobby?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>

    <!-- PERSONAL INFO (CONTACT + PERSONAL) -->
    <#if addAdditionalDetails>
    <div class="section">
      <div class="section-title">Personal Info</div>
      <hr/>

      <#if fatherName?? && fatherName?has_content>
        <div class="detail-item"><strong>Father Name:</strong> &#8208; ${fatherName}</div>
      </#if>


      <#if maritalStatus?? && maritalStatus?has_content>
        <div class="detail-item"><strong>Martial Status</strong> &#8208; ${maritalStatus}</div>
      </#if>



      <#if languagesKnown?? && languagesKnown?has_content>
        <div class="detail-item"><strong>Languages:</strong> ${languagesKnown?replace(",", ", ")}</div>
      </#if>


      <#if address?? && address?has_content>
        <div class="detail-item"><strong>Address</strong> &#8208; ${address}</div>
      </#if>

      <#if dob?? && dob?has_content>
        <div class="detail-item"><strong>DOB</strong> &#8208; ${extractDobYear(dob)}</div>
      </#if>

      <#if gender?? && gender?has_content>
        <div class="detail-item"><strong>Gender</strong> &#8208; ${gender}</div>
      </#if>
    </div>
    </#if>

  </div>

  <div class="right-section">

    <!-- SUMMARY (RIGHT optional, usually you’d remove one, but conditioned) -->
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

          <!-- DATE RANGE -->
          <div>
            <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
              ${extractmonth(exp.experienceYearStartDate)}
              <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                &#8211; ${extractmonth(exp.experienceYearEndDate)}
              <#else>
                &#8211; Present
              </#if>
            </#if>
          </div>

          <div>
            <#if exp.role?? && exp.role?has_content>
              <div class="exp-role">${exp.role}</div>
            </#if>
            <#if exp.companyName?? && exp.companyName?has_content>
              <div class="exp-location">${exp.companyName}</div>
            </#if>
          </div>

        </div>

        <!-- KEY ACHIEVEMENTS / RESPONSIBILITIES -->
        <#if exp.responsibilities?? && exp.responsibilities?trim?length gt 0>
          <strong>Key Achievements</strong>
          <ul class="bullets">
            <#list exp.responsibilities?split(",") as item>
              <#if item?? && item?has_content>
                <li>${item?trim}</li>
              </#if>
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
              <div class="exp-location">
                <strong>Skills:</strong>
                <#list proj.projectSkills?split(",") as skill>
                  ${skill?trim}<#if skill_has_next>, </#if>
                </#list>
              </div>
            </#if>

          </div>

          <#if proj.projectDescription?? && proj.projectDescription?has_content>
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

      <#list collegeProject as project>
      <div class="education-details">
        <div class="project-row">
          <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
            <div class="exp-role">${project.collegeProjectName}</div>
          </#if>
          <#if project.collegeProjectRole?? && project.collegeProjectRole?has_content>
            <div class="exp-location">
			<#list project.collegeProjectSkills?split(",") as sk>
                        <#if sk?trim?has_content><li>${sk?trim}</li></#if>
                    </#list>
					</div>
          </#if>
        </div>

        <#if project.collegeProjectDescription?? && project.collegeProjectDescription?trim?length gt 0>
          <strong>Description</strong>
          <ul class="bullets">
            <li>${project.collegeProjectDescription}</li>
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
            <div class="edu-item">${edu.fieldOfStudy}</div>
          </#if>

          <#if edu.institutionName?? && edu.institutionName?has_content>
            <div class="edu-item">${edu.institutionName}</div>
          </#if>

          <#if edu.percentage?? && edu.percentage?has_content>
            <div class="edu-item">${edu.percentage}%</div>
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


    <#if certificates?? && certificates?size gt 0>
        <div class="section">
           <div class="section-title">Certificates</div>

               <#list certificates as certi>
                       <#if certi.courseName?? && certi.courseName?has_content>
                           <div class="exp-row">
                             <div>
                               <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                                 ${extractmonth(certi.courseStartDate)}
                               </#if>
                             </div>
                             <div>${certi.courseName}</div>
                           </div>
                       </#if>
                </#list>

        </div>
    </#if>


    <#if achievements?? && achievements?size gt 0>
        <div class="section">
           <div class="section-title">Achievements</div>

              <#list achievements as achieve>
                    <#if achieve.achievementsName?? && achieve.achievementsName?has_content>
                        <div class="exp-row">
                              <div>
                                <#if achieve.achievementsDate?? && achieve.achievementsDate?has_content>
                                  ${extractmonth(achieve.achievementsDate)}
                                </#if>
                              </div>
                              <div>${achieve.achievementsName}</div>
                        </div>
                    </#if>
              </#list>

        </div>
    </#if>

    <!-- CORE COMPETENCIES -->
    <#if competencies?? && competencies?trim?length gt 0>
    <div class="section">
      <div class="section-title">Core Compentencies</div>
      <hr/>
      <ul class="bullets">
        <#list competencies?split(",") as skill>
          <#if skill?? && skill?has_content>
            <li>${skill?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>

    <!-- EXTRA CIRCULAR ACTIVITIES -->
    <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
    <div class="section">
      <div class="section-title">Extracurricular activities</div>
      <hr/>
      <ul class="bullets">
        <#list extraCurricularActivities?split(",") as skill>
          <#if skill?? && skill?has_content>
            <li>${skill?trim}</li>
          </#if>
        </#list>
      </ul>
    </div>
    </#if>

  </div>

</div>

</body>

</html>
