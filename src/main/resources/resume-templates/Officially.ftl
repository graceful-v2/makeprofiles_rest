

<!DOCTYPE html>
<html lang="en">

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="UTF-8">
<@fonts.loadFonts />
  <style>
     @page: first {
      margin-top: 10px;
     }

    @page {
      size: A4;
      margin-top: 40px;
      margin-bottom: 20px;
      margin-left: 20px;
      margin-right: 20px;
    }

    .name {
    font-size: ${(style.nameSize)!'26pt'};
    font-weight: ${(style.fontWeightname)!'800'};
    color: ${(style.nameColor)!'#222'};
    }

    html,
    body {
      margin: 0;
      padding: 0;
      width: 210mm;
      background: #fff;
      font-family: ${(style.primaryFont)!'Calibri'};
      font-size: ${(style.bodySize)!'13pt'};
      line-height: ${(style.lineSpacing)!'1.35'};
      color: ${(style.bodyColor)!'#222'};
    }

    .container {
      width: 100%;
      height: 100%;
      display: grid;
      grid-template-columns: 35% 65%;
      padding: 0;
      margin: 0;
      box-sizing: border-box;
      overflow-wrap:break-word;
      word-break:break-word;
    }

    .left-section {
      background: #fff;
      padding: 15px 10px;
      box-sizing: border-box;
      overflow-wrap:break-word;
            word-break:break-word;
    }

    .right-section {
      padding: 15px 10px;
      box-sizing: border-box;
      overflow-wrap:break-word;
            word-break:break-word;
    }

    .profile-pic {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      background: #ddd;
      margin-bottom: 15px;
    }



    .section {
      margin-bottom: 10px;
    }

    .section-title {
      border-bottom: 2px solid #000;
      padding-bottom: 5px;
      margin-bottom: 10px;
      font-size: ${(style.sectionTitleSize)!'18pt'};
      font-weight: ${(style.fontWeightHeading)!'500'};
      color: ${(style.headingColor)!'#1039de'};
    }

    ul {
      padding-left: 18px;
    }

    .small-text {
      line-height: 1.4;
    }



    .exp-block {
      display: flex;
      justify-content: space-between;
    }

    .exp-dec {
      margin-bottom: 10px;
      margin-top: 5px;
    }

    .dates {
      font-size: 12pt;
    }

    .project-title {
      font-size: 14pt;
    }

    .project-block {
      margin-bottom: 10px;
      margin-top: 10px;
      border-bottom: 1px solid rgb(132, 132, 210);
    }

    .exp-item {
      margin-bottom: 10px;
    }

    .edu-block {
      margin-bottom: 10px;
    }

    .fields-items {
      line-height: 1.4;
    }

    .contact-details div {
          margin-bottom: 5px;
          margin-top: 5px;
          overflow-wrap: break-word;

        }

        .cert-list{
         overflow-wrap: break-word;
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

  <div class="container">


    <div class="left-section">

        <#if profileImage?? && profileImage?has_content>


              <img src="${profileImage}" class="profile-pic"/>


          </#if>



     <div class="section">
            <div class="section-title">Contact Details</div>

            <div small-text">

              <#if email?? && email?has_content>
                <div class="contact-details"><div>  ${email}</div></div>
              </#if>

              <#if phone?? && phone?has_content>
                <div class="contact-details"> <div>${phone}</div></div>
              </#if>

              <#if linkedin?? && linkedin?has_content>
                <div class="contact-details"> <div>${linkedin}</div></div>
              </#if>

              <#if location?? && location?has_content>
                <div class="contact-details"> <div> ${location}</div></div>
              </#if>

            </div>
          </div>



		   <#if skills?? && skills?has_content>
                <div class="section">
                    <div class="section-title">Skills</div>
                    <ul class="small-text">
                        <#list skills?split(",") as s>
                            <#if s?has_content><li>${s}</li></#if>
                        </#list>
                    </ul>
                </div>
		</#if>



          <#if competencies?? && competencies?has_content>
          <div class="section">
            <div class="section-title">Core Competencies</div>
            <ul class="small-text">
              <#list competencies?split(",") as c>
                <li>${c}</li>
              </#list>
            </ul>
          </div>
          </#if>


          <#if softSkills?? && softSkills?has_content>
              <div class="section">
                <div class="section-title">Soft Skills</div>
                <ul class="small-text">
                  <#list softSkills?split(",") as s>
                   <#if s?has_content><li>${s}</li></#if>
                  </#list>
                </ul>
              </div>
          </#if>


              <#if goals?? && goals?has_content>
              <div class="section">
                <div class="section-title">Goals</div>
                <div class="fields-items">
                  <#list goals?split(",") as g>
                   <#if g?has_content><div>${g}</div></#if>
                  </#list>
                </div>
              </div>
              </#if>

                    <#if hobbies?? && hobbies?has_content>
                            <div class="section">
                              <div class="section-title">Hobbies</div>
                              <div class="fields-items">
                                <#list hobbies?split(",") as g>
                                 <#if g?has_content><div>${g}</div></#if>
                                </#list>
                              </div>
                            </div>
                            </#if>

                              <#if certificates?? && certificates?size gt 0>
                                          <div class="section">
                                           <div class="section-title">Courses &amp; Training</div>

                                            <ul class="cert-list">
                                             <#list certificates as certi>
                                                                  <#if certi.courseName?? && certi.courseName?has_content>
                                                                     <li>${certi.courseName}
                                                                       <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
                                                                                      ( ${extractmonth(certi.courseStartDate)}
                                                                                        <#if certi.courseEndDate?? && certi.courseEndDate?has_content>
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
            <div class="contact-details small-text">

              <#if fatherName?? && fatherName?has_content>
              <div><strong>Father Name:</strong> ${fatherName}</div>
              </#if>

              <#if nationality?? && nationality?has_content>
              <div><strong>Nationality:</strong> ${nationality}</div>
              </#if>

              <#if maritalStatus?? && maritalStatus?has_content>
              <div><strong>Marital Status:</strong> ${maritalStatus}</div>
              </#if>

              <#if dob?? && dob?has_content>
                    <div> <strong>Dob :</strong> ${extractDobYear(dob)}</div>
                </#if>

              <#if gender?? && gender?has_content>
              <div><strong>Gender:</strong> ${gender}</div>
              </#if>

              <#if address?? && address?has_content>
              <div><strong>Address:</strong> ${address}</div>
              </#if>

              <#if languagesKnown?? && languagesKnown?has_content>
              <div> <strong>Language Known :</strong> ${languagesKnown?replace(",", ", ")}</div>
              </#if>

            </div>
          </div>
          </#if>

    </div>


    <div class="right-section">

      <#if name?? && name?has_content>
      <div class="name">${name}</div>
      </#if>

      <#if jobTitle?? && jobTitle?has_content>
      <div style="margin-bottom:20px;">${jobTitle}</div>
      </#if>

      <!-- SUMMARY -->
      <#if summary?? && summary?has_content>
      <div class="section">
        <div class="section-title">Summary</div>
        <div class="small-text">${summary}</div>
      </div>
      </#if>

          <#if objective?? && objective?has_content>
            <div class="section">
              <div class="section-title">Objective</div>
              <div class="small-text">${objective}</div>
            </div>
            </#if>

      <!-- EDUCATION -->
      <#if education?? && education?size gt 0>
      <div class="section">
        <div class="section-title">Education</div>

        <#list education as edu>
        <div class="edu-block">

          <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
            <div><strong>${edu.fieldOfStudy} </strong>
              <#if edu.percentage?? && edu.percentage?has_content>
                  &#8211;${edu.percentage}%
                  </#if>
              </div>
            <#else>
             <#if edu.percentage?? && edu.percentage?has_content>
              <div>${edu.percentage}%</div>
               </#if>
          </#if>

          <#if edu.institutionName?? && edu.institutionName?has_content>
            <div>${edu.institutionName}</div>
          </#if>

          <#if edu.department?? && edu.department?has_content>
            <div>${edu.department}</div>
          </#if>

          <#if edu.qualificationStartYear?? || edu.qualificationEndYear??>
            <div>
              ${extractmonth(edu.qualificationStartYear)}   &#8211;
              <#if edu.qualificationEndYear?has_content>
                ${extractmonth(edu.qualificationEndYear)}
              <#else>Present</#if>
            </div>
          </#if>

        </div>
        </#list>
      </div>
      </#if>

      <!-- WORK EXPERIENCE -->
     <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <div class="section-title">Work Experience</div>

        <#list experiences as exp>
        <div class="exp-item">

          <div class="exp-block">
            <div>
              <#if exp.companyName??>
                <div>${exp.companyName}</div>
              </#if>

              <#if exp.role??>
                <div>${exp.role}</div>
              </#if>
            </div>

           <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
            <div class="dates">
              <strong>
                ${extractmonth(exp.experienceYearStartDate)}  &#8211;
                <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>${extractmonth(exp.experienceYearEndDate)}<#else>Present</#if>
              </strong>
            </div>
            </#if>

          </div>

          <#if exp.responsibilities?? && exp.responsibilities?has_content>
          <div class="exp-dec"><strong>Responsibilites:</strong> ${exp.responsibilities}</div>
          </#if>




          <#if exp.projects?? && exp.projects?size gt 0>
          <div class="project-title"><strong>Projects</strong></div>

          <#list exp.projects as pr>
          <div class="project-block">
            <#if pr.projectName?? && pr.projectName?has_content><div><strong>Name:</strong> ${pr.projectName}</div></#if>
            <#if pr.projectRole?? &&  pr.projectRole?has_content><div><strong>Role:</strong> ${pr.projectRole}</div></#if>
            <#if pr.projectSkills?? && pr.projectSkills?has_content><div class="exp-dec"><strong>Skills:</strong>

			<#list pr.projectSkills?split(",") as s>
			   ${s?trim}<#if s?has_next>, </#if>
			</#list>


			</div></#if>
            <#if pr.projectDescription?? &&  pr.projectDescription?has_content><div class="exp-dec"><strong>Description:</strong> ${pr.projectSkills}</div></#if>
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

        <#list collegeProject as ap>
        <div class="exp-item">

          <#if ap.collegeProjectName?? && ap.collegeProjectName?has_content>
          <div class="exp-block"><strong>${ap.collegeProjectName}</strong></div>
          </#if>

          <#if ap.collegeProjectDescription?? && ap.collegeProjectDescription?has_content>
          <div class="exp-dec"><strong>Description:</strong> ${ap.collegeProjectDescription}</div>
          </#if>

          <#if ap.collegeProjectSkills?? && ap.collegeProjectSkills?has_content>
          <strong>Skills:</strong>
          <ul>
            <#list ap.collegeProjectSkills?split(",") as s>
            <li>${s}</li>
            </#list>
          </ul>
          </#if>

        </div>
        </#list>
      </div>
      </#if>



       <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
      <div class="section">
        <div class="section-title">Extra-Curricular Activities</div>
        <ul class="small-text">
          <#list extraCurricularActivities?split(",") as ex>
          <li>${ex}</li>
          </#list>
        </ul>
      </div>
      </#if>


      <#if strengths?? && strengths?has_content>
      <div class="section">
        <div class="section-title">Strengths</div>
        <ul class="small-text">
          <#list strengths?split(",") as st>
          <li>${st}</li>
          </#list>
        </ul>
      </div>
      </#if>

       <#if achievements?? && achievements?size gt 0>
                    <div class="section">
                      <div class="section-title">Achievements &amp; Awards</div>

                      <ul class="cert-list">
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
                  <div class="contact-details small-text">

                    <#if fatherName?? && fatherName?has_content>
                    <div><strong>Father Name:</strong> ${fatherName}</div>
                    </#if>

                    <#if nationality?? && nationality?has_content>
                    <div><strong>Nationality:</strong> ${nationality}</div>
                    </#if>

                    <#if maritalStatus?? && maritalStatus?has_content>
                    <div><strong>Marital Status:</strong> ${maritalStatus}</div>
                    </#if>

                    <#if dob?? && dob?has_content>
                          <div> <strong>Dob :</strong> ${extractDobYear(dob)}</div>
                      </#if>

                    <#if gender?? && gender?has_content>
                    <div><strong>Gender:</strong> ${gender}</div>
                    </#if>

                    <#if address?? && address?has_content>
                    <div><strong>Address:</strong> ${address}</div>
                    </#if>

                    <#if languagesKnown?? && languagesKnown?has_content>
                    <div> <strong>Language Known :</strong> ${languagesKnown?replace(",", ", ")}</div>
                    </#if>

                  </div>
                </div>
                </#if>

    </div>

  </div>
</body>

</html>