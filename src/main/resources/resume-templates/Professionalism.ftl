 <!DOCTYPE html>
<html>

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="utf-8" />
  <@fonts.loadFonts />
  <style>
    @page: first {
      size: A4;
      margin-top: 0px;
    }

    @page {
      size: A4;
      margin-top: 40px;
      margin-bottom: 20px;
      margin-left: 20px;
      margin-right: 20px;
    }

    html,
    body {
      margin: 0;
      padding: 0;
      width: 210mm;
      background: #ffffff;
      font-family: ${(style.primaryFont)!'Poppins'},Arial, sans-serif;
       font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.4'};
      color: ${(style.bodyColor)!'#333333'};

    }

    .page {
      width: 210mm;
      padding: 0;
      margin: 0;
      box-sizing: border-box;
    }


    .header {
      position: relative;
      background: #2f3138;
      color: #ffffff;
      padding: 22px 40px 40px 180px;
      box-sizing: border-box;
      overflow: visible;
    }


    .header::before {
      content: "";
      position: absolute;
      left: 0;
      bottom: -50px;
      width: 260px;
      height: 50px;
      background: #2f3138;
      clip-path: polygon(0 0, 260px -30px, 0 100%);
    }

    .name {
      letter-spacing: 0.5px;
      margin-left: 3rem;
      font-size: ${(style.nameSize)!'26pt'};
      font-weight: ${(style.fontWeightname)!'600'};
      color: ${(style.nameColor)!'#fdfeff'};
    }



    .profile-wrapper {
      position: absolute;
      left: 50px;
      top: 30px;
      width: 110px;
      height: 110px;
      border-radius: 50%;
      overflow: hidden;
      border: 4px solid #ffffff;
      box-shadow: 0 0 0 2px #00000026;
      background: #d0d0d0;
    }

    .profile-wrapper img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }


    .container {
      display: grid;
      grid-template-columns: 34% 66%;
      column-gap: 0;
      overflow-wrap:break-word;
      word-break:break-word;
    }

    .left-section {
      background: #f3e9dd;
      /* warm beige */
      padding: 40px 10px 30px 20px;
      box-sizing: border-box;
      min-height: 100%;
      overflow-wrap:break-word;
       word-break:break-word;
    }

    .right-section {
      background: #ffffff;
      padding: 32px 16px 36px 10px;
      box-sizing: border-box;
      overflow-wrap:break-word;
       word-break:break-word;
    }

    /* ===== SIDEBAR ELEMENTS ===== */
    .section-title {
       font-size: ${(style.sectionTitleSize)!'14pt'};
       font-weight: ${(style.fontWeightHeading)!'600'};
      color: ${(style.headingColor)!'#222'};
      text-transform: uppercase;
      margin-bottom: 8px;

    }

    .sidebar-block {
      margin-bottom: 22px;

    }

    .contact-item {

      margin-bottom: 6px;
      color: #333333;
      overflow-wrap: break-word;

    }

    .contact-item a {
      color: #333333;
      text-decoration: none;
    }

    .contact-item a:hover {
      text-decoration: underline;
    }

    .edu-item {

      margin-bottom: 8px;
    }

    .edu-degree {
      font-weight: 600;
    }

    .edu-school {
      margin-top: 2px;
    }

    .edu-year {

      color: #555555;
      margin-top: 2px;
    }

    .skill-item {

      margin-bottom: 4px;
    }

    .skill-name {
      font-weight: 500;
    }

    .skill-level {
      color: #666666;
    }

    /* ===== MAIN SECTION STYLES ===== */
    .section {
      margin-bottom: 18px;
    }



    .section-underline {
      height: 1px;
      background: #000000;
      margin-bottom: 6px;
    }

    .section-text {}

    /* work experience */
    .job {
      margin-bottom: 14px;
    }

    .job-title {
      font-weight: 600;

    }

    .job-company {
      font-weight: 600;
	    margin-bottom: 7px;

    }

    .job-dates {

      color: #555555;
      margin-top: 2px;
    }

    .job-bullets {
      margin: 4px 0 0 18px;

    }

    .job-bullets li {
      margin-bottom: 3px;
    }

    /* simple lists */
    .list {

      margin-left: 18px;
    }

    .list li {
      margin-bottom: 3px;
    }

    /* personal details list */
    .details-table {}

    .details-table div {
      margin-bottom: 3px;
    }

    .details-label {
      font-weight: 600;
    }

    .project-section {
      margin-top: 10px;
      margin-bottom: 10px;
    }

    .Project-title {
      margin-top: 10px;
      margin-bottom: 10px;
      font-weight: 700;
    }

    .details-item {
      margin-bottom: 7px;
    }

    .extra-items {
      margin-bottom: 7px;

    }

     .left-bg {
       position: fixed;
       top: 0;
       left: 0;
       width: 34%;
       height: 100vh;
       background: #f3e9dd;
       z-index: -2;
     }

     .certi-list{
      overflow-wrap:break-word;
      word-break:break-word;
     }

     .detail-item{
     margin:4px 0px;
     }

  </style>
</head>

 <body>
<div class="left-bg"></div>

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

  <div class="page">


    <div class="header">
     <#if profileImage?? && profileImage?has_content>
      <div class="profile-wrapper">
        <img src="${profileImage}" alt="Profile" />
      </div>
      </#if>
      <h1 class="name">${name}</h1>
	      <#if jobTitle?? && jobTitle?has_content>
         <div class="role">${jobTitle}</div>
	   </#if>
    </div>

    <div class="container">

      <!-- ===== LEFT SIDEBAR ===== -->
      <div class="left-section">



        <div class="sidebar-block">
          <div class="section-title">Contact Details</div>

          <#if email?? && email?has_content>
            <div class="contact-item">${email}</div>
          </#if>

          <#if phone?? && phone?has_content>
            <div class="contact-item">${phone}</div>
          </#if>

		  <#if linkedin?? && linkedin?has_content>
            <div class="contact-item">${linkedin}</div>
          </#if>


          <#if location?? && location?has_content>
            <div class="contact-item">${location}</div>
          </#if>


        </div>



        <!-- Skills -->
        <#if skills?? && skills?has_content>
        <div class="sidebar-block">
          <div class="section-title">Skills</div>

          <#list skills?split(",") as s>
            <#if s?trim?has_content>
              <div class="skill-item">${s?trim}</div>
            </#if>
          </#list>

        </div>
        </#if>


        <!-- Soft Skills -->
        <#if softSkills?? && softSkills?has_content>
        <div class="sidebar-block">
          <div class="section-title">Soft Skills</div>
          <#list softSkills?split(",") as s>
            <#if s?trim?has_content>
              <div class="skill-item">${s?trim}</div>
            </#if>
          </#list>
        </div>
        </#if>


        <!-- Core Competencies -->
        <#if competencies?? && competencies?has_content>
        <div class="sidebar-block">
          <div class="section-title">Core Competencies</div>
          <#list competencies?split(",") as c>
            <#if c?trim?has_content>
              <div class="skill-item">${c?trim}</div>
            </#if>
          </#list>
        </div>
        </#if>


        <!-- Goals -->
        <#if goals?? && goals?has_content>
        <div class="sidebar-block">
          <div class="section-title">Goals</div>
          <#list goals?split(",") as g>
            <#if g?trim?has_content>
              <div class="skill-item">${g?trim}</div>
            </#if>
          </#list>
        </div>
        </#if>


        <!-- Strengths -->
        <#if strengths?? && strengths?has_content>
        <div class="sidebar-block">
          <div class="section-title">Strengths</div>
          <#list strengths?split(",") as st>
            <#if st?trim?has_content>
              <div class="skill-item">${st?trim}</div>
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
                               <div class="sidebar-block">
                                       <div class="section-title">Personal Details</div>
                                       <div class="divider"></div>

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
                                          <strong>DOB:</strong> ${extractDobYear(dob)}
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


      </div> <!-- left-section end -->


      <!-- ===== RIGHT SECTION ===== -->
      <div class="right-section">

        <!-- Summary -->
        <#if summary?? && summary?has_content>
        <div class="section">
          <div class="section-title">Summary</div>
          <div class="section-underline"></div>
          <div class="section-text">${summary}</div>
        </div>
        </#if>


        <!-- Objective -->
        <#if objective?? && objective?has_content>
        <div class="section">
          <div class="section-title">Objective</div>
          <div class="section-underline"></div>
          <div class="section-text">${objective}</div>
        </div>
        </#if>


        <!-- Work Experience -->
        <#if experiences?? && experiences?size gt 0>
        <div class="section">
          <div class="section-title">Work Experience</div>
          <div class="section-underline"></div>

          <#list experiences as exp>

          <div class="job">
            <#if exp.companyName?? && exp.companyName?has_content>
              <div class="job-company">${exp.companyName}</div>
            </#if>

			<#if exp.role?? && exp.role?has_content>
              <div class="job-company">${exp.role}</div>
            </#if>

          <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
              <div class="job-dates">
                <strong>
                  ${extractmonth(exp.experienceYearStartDate)}
                   &#8211;
                   <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>${extractmonth(exp.experienceYearEndDate)}<#else>Present</#if>
                </strong>
              </div>
            </#if>


            <#if exp.responsibilities?? && exp.responsibilities?has_content>
            <ul class="job-bullets">
              <#list exp.responsibilities?split(",") as r>
                <#if r?trim?has_content>
                  <li>${r?trim}</li>
                </#if>
              </#list>
            </ul>
            </#if>





            <#if exp.projects?? && exp.projects?size gt 0>
              <div class="Project-title">Projects</div>

              <#list exp.projects as pr>
              <div class="project-section">

                <#if pr.projectName?? && pr.projectName?has_content>
                  <div class="details-item"><strong>Name: </strong>${pr.projectName}</div>
                </#if>

                <#if pr.projectRole?? && pr.projectRole?has_content>
                  <div class="details-item"><strong>Role: </strong>${pr.projectRole}</div>
                </#if>

                 <!-- Project Description -->
                                <#if pr.projectDescription?? && pr.projectDescription?has_content>
                                  <div><strong>Description: </strong>${pr.projectDescription}</div>
                                </#if>

                <!-- Project Skills -->
                <#if pr.projectSkills?? && pr.projectSkills?has_content>
                <ul class="job-bullets">
                  <#list pr.projectSkills?split(",") as ps>
                    <#if ps?trim?has_content>
                      <li>${ps?trim}</li>
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
          <div class="section-title">Academic Projects</div>
          <div class="section-underline"></div>

          <#list collegeProject as ap>
          <div class="job">

            <#if ap.collegeProjectName?? && ap.collegeProjectName?has_content>
              <div class="job-company">${ap.collegeProjectName}</div>
            </#if>

            <!-- academic skills -->
            <#if ap.collegeProjectSkills?? && ap.collegeProjectSkills?has_content>
            <ul class="job-bullets">
              <#list ap.collegeProjectSkills?split(",") as s>
                <#if s?trim?has_content>
                  <li>${s?trim}</li>
                </#if>
              </#list>
            </ul>
            </#if>


            <#if ap.collegeProjectDescription?? && ap.collegeProjectDescription?has_content>
              <div><strong>Description: </strong>${ap.collegeProjectDescription}</div>
            </#if>

          </div>
          </#list>

        </div>
        </#if>




        <#if education?? && education?size gt 0>
        <div class="section">
          <div class="section-title">Education</div>
          <div class="section-underline"></div>

          <#list education as edu>
          <div class="edu-item">

            <#if edu.department?? && edu.department?has_content>
              <div class="edu-degree">${edu.department}</div>
            </#if>
            <#if edu.institutionName?? && edu.institutionName?has_content>
                          <div class="edu-degree">${edu.institutionName}</div>
                        </#if>

          <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
            <div class="edu-school">
              ${edu.fieldOfStudy}
              <#if edu.percentage?? && edu.percentage?has_content>
                &#8211; ${edu.percentage}%
              </#if>
            </div>
          <#else>
            <#if edu.percentage?? && edu.percentage?has_content>
              <div class="edu-school">
                ${edu.percentage}%
              </div>
            </#if>
          </#if>




             <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
              <div class="edu-year">
                ${extractmonth(edu.qualificationStartYear)}  &#8211;
                <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>${extractmonth(edu.qualificationEndYear)}<#else>Present</#if>
              </div>
            </#if>

          </div>
          </#list>

        </div>
        </#if>




        <#if certificates?? && certificates?has_content>
        <div class="section">
          <div class="section-title">Certifications</div>
          <div class="section-underline"></div>
         <div class="certi-list">
          <#list certificates as certi>
            <#if certi.courseName?? && certi.courseName?has_content>
              <div class="extra-items">${certi.courseName}

			   <#if certi.courseStartDate?has_content>
                ( ${extractmonth(certi.courseStartDate)}
                <#if certi.courseEndDate?has_content>
                   &#8211; ${extractmonth(certi.courseEndDate)} )
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



        <!-- Achievements -->
        <#if achievements?? && achievements?has_content>
        <div class="section">
          <div class="section-title">Achievements</div>
          <div class="section-underline"></div>
          <div class="certi-list">
                  <#list achievements as achieve>
                    <#if achieve?trim?has_content>
                      <div class="extra-items">${achieve.achievementsName}

                      <#if achieve.achievementsDate?has_content>
                         &#8211; ${extractmonth(achieve.achievementsDate)}
                      </#if>

                      </div>
                    </#if>
                  </#list>
          </div>
        </div>
        </#if>



        <!-- Extra-Curricular -->
      <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
        <div class="section">
          <div class="section-title">Extra-Curricular Activities</div>
          <div class="section-underline"></div>
          <ul class="job-bullets">
            <#list extraCurricularActivities?split(",") as ec>
              <#if ec?trim?has_content>
                <li>${ec?trim}</li>
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
                                             <div class="divider"></div>

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
                                                <strong>DOB:</strong> ${extractDobYear(dob)}
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

      </div> <!-- right-section end -->

    </div>
  </div>
</body>

</html>