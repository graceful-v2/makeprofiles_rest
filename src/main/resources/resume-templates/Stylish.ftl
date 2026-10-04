
<!DOCTYPE html>
<html lang="en">
  <head>
  <#import "Fonts.ftl" as fonts>
    <meta charset="UTF-8" />
    <@fonts.loadFonts />

    <style>
      @page: first {
        margin-top: 10px;
      }

      @page {
        size: A4;
        margin-top: 40px;
        margin-bottom: 10px;
        margin-left: 20px;
        margin-right: 20px;
      }
      html,body {
        margin: 0;
        padding: 0;
        background: #f5f7fa;
        font-family: ${(style.primaryFont)!'Segoe UI, Arial, sans-serif'};
         color: ${(style.bodyColor)!'#222'};
         font-size: ${(style.bodySize)!'12pt'};
         line-height: ${(style.lineSpacing)!'1.35'};
      }
      .container {
        max-width: 210mm;
        width: 100%;
        background: #fff;
        border-radius: 12px;
        overflow-wrap: break-word;
        padding: 0;
      }
      .top-section {
        display: flex;
        padding: 12px 28px 10px 28px;
        align-items: flex-start;
        gap: 15px;
        background: #f9fbfd;
        border-bottom: 2px solid #e1e8f0;
      }
      .profile-data {
        flex: 1.2;
        max-width: 50%;
        min-width: 50%;
      }
      .profile-data h1 {
       margin-bottom: 5px;
        font-size: ${(style.nameSize)!'26pt'};
         font-weight: ${(style.fontWeightname)!'800'};
          color: ${(style.nameColor)!'#35568e'};
      }
      .profile-data .aws {
        color: #55b2e1;
        font-weight: 600;

        margin-bottom: 14px;
      }
      .profile-data .summary {

        color: #415578;
         margin-bottom:5px;
        margin-bottom: 7px;
      }
      .contact-box {
        background: #35568e;
        color: #fff;
        border-radius: 12px;
        padding: 20px 30px;
        margin-bottom: 0;
        min-width: 250px;

        display: flex;
        flex-direction: column;
        gap: 10px;
      }
      .contact-item {
        margin-bottom: 2px;

        display: flex;
        align-items: center;
        gap: 10px;
        max-width: 50%;
        min-width: 100%;
        white-space: normal;
        word-break: break-word;
      }
      .contact-icon {
        display: inline-block;

      }
      .skills-section {
        margin: 0 28px 22px 28px;
      }
      .skills-title {

        font-weight: 600;
        color: #35568e;
        background: #f3f8fc;
        border-radius: 7px;
        padding: 7px 18px;
        margin-bottom: 8px;
      }
      .skills-list {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
      }
      .skill-chip {
        background: #55b2e1;
        color: #fff;
        border-radius: 16px;
        padding: 5px 12px;

        margin-bottom: 7px;
        font-weight: 500;
      }
      .exp-section,
      .edu-section {
        margin: 0 28px 30px 28px;
      }
      .exp-title,
      .edu-title {

        font-weight: 600;
        color: #35568e;
        background: #f3f8fc;
        border-radius: 7px;
        padding: 7px 18px;
        margin-bottom: 8px;
      }
      .job {
        margin-bottom: 13px;
      }
      .job-role {

        font-weight: bold;
        color: #245587;
      }
      .job-company {

        margin-left: 8px;
        font-weight: 500;
        color: #35568e;
      }
      .job-date {

        color: #191a1b;
        margin-left: 12px;
        font-style: italic;
      }
      .job ul {
        padding-left: 22px;
        margin: 0;

        color: #191a1a;
        line-height: 1.5;
      }
      .job li {
        margin-bottom: 5px;
      }
      .edu-detail {
        margin-bottom: 6px;
      }
      .degree {

        font-weight: 600;
        color: #245587;
      }
      .institute {

        color: #35568e;
      }
      .year {

        color: #1c1d1e;
        font-style: italic;
      }

      .section-title {



        background: #dbe4eb;
        border-radius: 7px;
        padding: 5px 18px;
        margin-bottom: 8px;
        font-size: ${(style.sectionTitleSize)!'14pt'};
           font-weight: ${(style.fontWeightHeading)!'700'};
           color: ${(style.headingColor)!'#35568e'};
      }

      .job-desc {

        margin-top: 5px;
        margin-bottom: 5px;
      }

      .project {
        margin-left: 10px;
      }
      .project-section {
        margin-top: 5px;
        margin-bottom: 5px;
        border-bottom: 1px solid rgb(98, 90, 90);
      }

      .project-heading {

        font-weight: bold;
        font-style: italic;
        text-decoration: underline;
        text-underline-offset: 4px;
      }
      .project-role {

        font-weight: bold;
        color: #245587;
      }
      .project-name {

        font-weight: bold;
        color: #232424;
        margin-bottom: 5px;
      }

      .contact-text {
        white-space: normal;
        word-break: break-word;
      }

      .detail-item{
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

  <div class="top-section">
    <div class="profile-data">
      <#if name?? && name?has_content>
        <h1>${name}</h1>
      </#if>

      <#if summary?has_content>
        <div class="summary">${summary}</div>
      </#if>
    </div>

    <div class="contact-box">
      <#if email?has_content>
        <div class="contact-item">
          <span class="contact-icon">&#128231;</span>
          <span class="contact-text">${email}</span>
        </div>
      </#if>

      <#if phone?has_content>
        <div class="contact-item">
          <span class="contact-icon">&#128222;</span>
          <span class="contact-text">${phone}</span>
        </div>
      </#if>

      <#if location?has_content>
        <div class="contact-item">
          <span class="contact-icon">&#128205;</span>
          <span class="contact-text">${location}</span>
        </div>
      </#if>

      <#if linkedin?? && linkedin?has_content>
        <div class="contact-item">
          <span class="contact-icon">&#128279;</span>
          <span class="contact-text">${linkedin}</span>
        </div>
      </#if>

      <#if languagesKnown?? && languagesKnown?has_content>
                <div class="contact-item">
                   <span class="contact-text"> ${languagesKnown?replace(",", ", ")}</span>
                </div>
          </#if>

       <#if gender?? && gender?has_content>
          <div class="contact-item">
             <span class="contact-text">${gender}</span>
          </div>
        </#if>
    </div>
  </div>

  <#if objective?has_content>
    <div class="skills-section">
      <div class="section-title">Objectives</div>
      <div class="summary">${objective}</div>
    </div>
  </#if>

  <#if skills?? && skills?trim?length gt 0>
    <div class="skills-section">
      <div class="section-title">Technical Skills</div>
      <div class="skills-list">
        <#list skills?split(",") as skill>
          <#if skill?has_content>
            <span class="skill-chip">${skill?trim}</span>
          </#if>
        </#list>
      </div>
    </div>
  </#if>

  <#if experiences?? && experiences?size gt 0>
    <div class="exp-section">
      <div class="section-title">Work Experience</div>

      <#list experiences as exp>
        <div class="job">
          <#if exp.role?has_content>
            <span class="job-role">${exp.role}</span>
          </#if>

          <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
            <span class="job-date">
              &#8208; ${extractmonth(exp.experienceYearStartDate)}
              <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                &#8208; ${extractmonth(exp.experienceYearEndDate)}
              <#else>
                &#8208; Present
              </#if>
            </span>
          </#if>

          <#if exp.companyName?has_content>
            <br/><span class="job-role">${exp.companyName}</span>
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

          <#if exp.projects?? && exp.projects?size gt 0>
            <div class="project">
              <div class="project-heading">Project</div>
              <#list exp.projects as proj>
                <div class="project-section">

                  <#if proj.projectName?has_content>
                    <div class="project-name">${proj.projectName}</div>
                  </#if>

                  <#if proj.projectRole?has_content>
                    <div class="project-role">${proj.projectRole}</div>
                  </#if>

                  <#if proj.projectDescription?has_content>
                    <div class="job-desc"><strong>Description:</strong> ${proj.projectDescription}</div>
                  </#if>

                  <#if proj.projectSkills?has_content>
                    <strong>Skills:</strong>
                    <ul>
                      <#list proj.projectSkills?split(",") as skill>
                        <#if skill?has_content>
                          <li>${skill?trim}</li>
                        </#if>
                      </#list>
                    </ul>
                  </#if>
                </div>
              </#list>
            </div>
          </#if>
        </div>
      </#list>
    </div>
  </#if>


  <#if collegeProject?? && collegeProject?size gt 0>
      <div class="exp-section">
        <div class="section-title">Academic Project</div>

               <#list collegeProject as project>
                <div class="project-section">

                    <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
                    <div class="project-name">${project.collegeProjectName}</div>
                  </#if>



                 <#if project.collegeProjectDescription?? && project.collegeProjectDescription?has_content>
                    <div class="job-desc"><strong>Description:</strong> ${project.collegeProjectDescription}</div>
                  </#if>

                      <#if project.collegeProjectSkills?? && project.collegeProjectSkills?trim?length gt 0>
                    <strong>Skills:</strong>
                    <ul>
                      <#list project.collegeProjectSkills?split(",") as skill>
                        <#if skill?has_content>
                          <li>${skill?trim}</li>
                        </#if>
                      </#list>
                    </ul>
                  </#if>
                </div>
              </#list>


      </div>
    </#if>

  <#if education?? && education?size gt 0>
    <div class="edu-section">
      <div class="section-title">Education</div>
      <#list education as edu>
        <div class="edu-detail">
          <#if edu.department?has_content>
            <span class="degree">${edu.department}</span><br/>
          </#if>

          <#if edu.fieldOfStudy?has_content>
            <span class="degree">${edu.fieldOfStudy}

			   <#if edu.percentage?has_content>
               |  ${edu.percentage}%
            </#if><br/>

             <#else>
              <#if edu.percentage?has_content>
                 ${edu.percentage}%<br/>

                </#if>
			</span>
          </#if>



          <#if edu.institutionName?has_content>
            <span class="institute">${edu.institutionName}</span><br/>
          </#if>

          <#if edu.qualificationStartYear?has_content>
            <span class="year">${extractmonth(edu.qualificationStartYear)}
              <#if edu.qualificationEndYear?has_content>
                &#8208; ${extractmonth(edu.qualificationEndYear)}
              <#else>
                &#8208; Present
              </#if>
            </span>
          </#if>
        </div>
      </#list>
    </div>
  </#if>

  <#if certificates?? && certificates?size gt 0>
    <div class="edu-section">
      <div class="section-title">Certificates</div>
      <#list certificates as certi>
        <#if certi.courseName?has_content>
          <div class="edu-detail">
            <span class="degree">${certi.courseName}</span><br/>
            <#if certi.courseStartDate?has_content>
              <span class="year">${extractmonth(certi.courseStartDate)}
                <#if certi.courseEndDate?has_content>
                  &#8208; ${extractmonth(certi.courseEndDate)}
                </#if>
              </span>
            </#if>
          </div>
        </#if>
      </#list>
    </div>
  </#if>

  <#if achievements?? && achievements?size gt 0>
    <div class="edu-section">
      <div class="section-title">Achievements</div>
      <#list achievements as achieve>
        <#if achieve.achievementsName?has_content>
          <div class="edu-detail">
            <span class="degree">${achieve.achievementsName}</span><br/>
            <#if achieve.achievementsDate?has_content>
              <span class="year">${extractmonth(achieve.achievementsDate)}</span>
            </#if>
          </div>
        </#if>
      </#list>
    </div>
  </#if>

  <#if softSkills?? && softSkills?trim?length gt 0>
    <div class="skills-section">
      <div class="section-title">Soft Skills</div>
      <div class="skills-list">
        <#list softSkills?split(",") as skill>
          <#if skill?has_content>
            <span class="skill-chip">${skill?trim}</span>
          </#if>
        </#list>
      </div>
    </div>
  </#if>

  <#if competencies?? && competencies?trim?length gt 0>
    <div class="skills-section">
      <div class="section-title">Core Competencies</div>
      <div class="skills-list">
        <#list competencies?split(",") as comp>
          <#if comp?has_content>
            <span class="skill-chip">${comp?trim}</span>
          </#if>
        </#list>
      </div>
    </div>
  </#if>

   <#if goals?? && goals?trim?length gt 0>
     <div class="skills-section">
       <div class="section-title">Goals</div>
       <div class="skills-list">
         <#list goals?split(",") as skill>
           <#if skill?has_content>
             <span class="skill-chip">${skill?trim}</span>
           </#if>
         </#list>
       </div>
     </div>
   </#if>

    <#if strengths?? && strengths?trim?length gt 0>
      <div class="skills-section">
        <div class="section-title">Strength</div>
        <div class="skills-list">
          <#list strengths?split(",") as skill>
            <#if skill?has_content>
              <span class="skill-chip">${skill?trim}</span>
            </#if>
          </#list>
        </div>
      </div>
    </#if>


      <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
        <div class="skills-section">
          <div class="section-title">ExtraCurricular Activities</div>
          <div class="skills-list">
            <#list extraCurricularActivities?split(",") as skill>
              <#if skill?has_content>
                <span class="skill-chip">${skill?trim}</span>
              </#if>
            </#list>
          </div>
        </div>
      </#if>

       <#if addAdditionalDetails>
                       <div class="skills-section">

       <div class="section-title">Personal Details</div>
                           <#if fatherName?? && fatherName?has_content>
                               <div class="detail-item">
                                   <strong>Father Name:</strong> ${fatherName}
                               </div>
                           </#if>

                           <#if maritalStatus?? && maritalStatus?has_content>
                               <div class="detail-item">
                                   <strong>Marital Status:</strong> ${maritalStatus}
                               </div>
                           </#if>



                           <#if dob?? && dob?has_content>
                               <div class="detail-item">
                                   <strong>Dob:</strong> ${extractDobYear(dob)}
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
