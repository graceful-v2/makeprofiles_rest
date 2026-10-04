

<!doctype html>
<html>

<head>
<#import "Fonts.ftl" as fonts>
  <meta charset="utf-8" />
    <@fonts.loadFonts />

  <style>
  @page: first {
      margin-top: 20px;
    }

    @page {
      size: A4;
      margin-top: 40px;
      margin-bottom: 5mm;
      margin-left: 20px;
      margin-right: 20px;
    }


    html,
    body {
      margin: 0;
      padding: 0;
	    font-family: ${(style.primaryFont)!'Poppins'}, Arial, sans-serif;
      font-size: ${(style.bodySize)!'12pt'};
      line-height: ${(style.lineSpacing)!'1.35'};
      color: ${(style.bodyColor)!'#222'};
      background: #fff;
    }

    .page {
      width: 210mm;
      margin: 0 auto;
      box-sizing: border-box;
      padding: 0;
      overflow-wrap:break-word;
    }

    .header-band {
      background: #0c6f75;
      color: #fff;
      padding: 18px 22px 14px 22px;
    }

    .name {
     margin: 0;
     font-size: ${(style.nameSize)!'28pt'};
     font-weight: ${(style.fontWeightname)!'800'};
     color: ${(style.nameColor)!'white'};
    }

    .subtitle {
      color: #c7eef1;
      margin-top: 4px;
      font-weight: 600
    }

    .layout {
      display: grid;
      grid-template-columns: 64% 36%;
      gap: 14px;
      padding: 18px 0px;
      box-sizing: border-box;
       overflow-wrap:break-word;
    }

    /* right sidebar (teal) */
    .right-section {
      background: #e6f6f6;
      padding: 18px;
      border-left: 1px solid rgba(12, 111, 117, 0.12);
      box-sizing: border-box;
      border-radius: 4px;
       overflow-wrap:break-word;
    }

    .right-block {
      margin-bottom: 18px
    }

    .right-title {
      display: flex;
      font-size:14pt;
      align-items: center;
      gap: 8px;
      font-weight: 700;
      color: #222;
    }

    .contact-item {
      display: flex;
      align-items: center;
      gap: 8px;
      color: #0c6f75;
      margin-bottom: 8px;

    }

    .contact-item .icon {
      font-size: 14px;
    }

    .skill-chip {
      display: inline-block;
      background: rgba(12, 111, 117, 0.12);
      color: #0c6f75;
      padding: 5px 8px;
      border-radius: 12px;
      margin: 6px 6px 0 0;

    }

    .cert-list {
      margin: 8px 0 0 12px;
      padding: 0
    }

    .cert-list li {
      list-style: none;
      margin-bottom: 8px;
      position: relative;
      padding-left: 18px
    }

    .cert-list li:before {
      content: "\2713";
      position: absolute;
      left: 0;
      top: 0;
      color: #0c6f75;
      font-weight: 700
    }

    .language-pill {
      display: inline-block;
      width: 46px;
      height: 10px;
      background: rgba(12, 111, 117, 0.12);
      border-radius: 6px;
      margin-right: 8px
    }

    /* main content */
    .main {
      padding: 4px 6px 0 6px
      overflow-wrap:break-word;
    }

    .section {
      margin-bottom: 10px
    }

    .section-title {
      display: flex;
      align-items: center;
      gap: 8px;
      text-transform: uppercase;
      font-size: ${(style.sectionTitleSize)!'14pt'};
      font-weight: ${(style.fontWeightHeading)!'700'};
      color: ${(style.headingColor)!'#0c6f75'};

    }

    .divider {
      height: 2px;
      background: #eaf7f6;
      margin: 3px 0 3px 0px;
      border-radius: 2px
    }

    .summary {
      color: #ffffff;
      margin-top: 6px
    }

    .exp-item {
      margin-bottom: 18px;
      padding-bottom: 10px;
      border-bottom: 1px solid #f0f3f3
    }

    .exp-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      gap: 12px
    }

    .exp-left {
      max-width: 76%
    }

    .exp-role {
      font-weight: 700;
      font-size: 12.5pt;
      margin: 0;
      color: #142b2b
    }

    .exp-company {
      font-style: italic;
      color: #333;
	  margin-top: 7px;
      margin-bottom: 10px;
    }

    .exp-dates {
      color: #0c6f75;
      font-weight: 600;
      white-space: nowrap
    }

    .bullets {
      margin-left: 18px;
      margin-top: 6px
    }

    .bullets li {
      margin-bottom: 6px
    }

    .project-block {
      margin-top: 8px;
      padding-top: 8px;
      border-top: 1px dashed #eaf7f6
    }

    .project-title {
      color: #0c6f75;
      font-weight: 700;
      margin-bottom: 6px
    }

    .project-desc {
      margin-left: 12px;
      margin-bottom: 6px
    }

    .edu-item {
      display: flex;
      justify-content: space-between;
      margin-bottom: 12px
    }

    .edu-left {
      max-width: 76%
    }

    .edu-degree {
      font-weight: 700;
      color: #222
    }

    .edu-school {
      color: #666
    }

    .edu-year {
      color: #0c6f75;
      font-weight: 600
    }

    /* small lists */
    .two-col {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px
    }

    .list {
      margin-left: 18px
    }

    .list li {
      margin-bottom: 6px;
      color: #333
    }

    .personal-details {
      line-height: 1.45;
      color: #333
    }

    .pd-row {
      margin-bottom: 8px
    }

    .muted {
      color: #666;
      font-style: italic
    }

    .small {

      color: #444
    }

    /* icons sizing */
    .title-icon {
      font-size: 14px
    }

     img.profile-photo {
      width: 88px;
      height: 88px;
      border-radius: 50%;
      object-fit: cover
    }

    .contact-items{
      margin:5px 0px;
    }

   .detail-item{

   margin:3px 0px;
   }

  .project-heading{
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

  <div class="page">


    <div class="header-band">
      <div style="display:flex;justify-content:space-between;align-items:center;">
        <div>
          <div class="name">${name}</div>
           <#if jobTitle?? && jobTitle?has_content>
          <div class="subtitle">${jobTitle}</div>
            </#if>

            <div>
                  <#if email??>
                    <div class="contact-items" ><span class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                    fill="#B39DDB"
                                    xmlns="http://www.w3.org/2000/svg"
                                    style="vertical-align:middle; margin-right:6px;">
                                    <path d="M20 4H4c-1.1 0-2 .9-2 2v12
                                    c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6
                                    c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6
                                    l8 5 8-5v2z"/>
                                    </svg></span> ${email}</div>
                  </#if>

                  <#if phone??>
                    <div class="contact-items" ><span class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
                                                                                                      fill="#E91E63"
                                                                                                      xmlns="http://www.w3.org/2000/svg"
                                                                                                      style="vertical-align:middle; margin-right:6px;">
                                                                                                   <path d="M6.6 10.8c1.5 3 4.1 5.6 7.1 7.1l2.4-2.4
                                                                                                            c.3-.3.7-.4 1.1-.3 1.2.4 2.6.6 4 .6
                                                                                                            .6 0 1 .4 1 1V21c0 .6-.4 1-1 1
                                                                                                            C10.5 22 2 13.5 2 3c0-.6.4-1 1-1h4.1
                                                                                                            c.6 0 1 .4 1 1 0 1.4.2 2.8.6 4
                                                                                                            .1.4 0 .8-.3 1.1L6.6 10.8z"/>
                                                                                                 </svg></span> ${phone}</div>
                  </#if>

                   <#if linkedin??>
                    <div class="contact-items" ><span class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
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
                                                                                                 </svg></span> ${linkedin}</div>
                  </#if>

                  <#if location??>
                    <div class="contact-items" ><span class="icon"><svg width="15" height="15" viewBox="0 0 24 24"
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
                                                                                                 </svg></span> ${location}</div>
                  </#if>
                </div>

        </div>

            <#if profileImage?? && profileImage?has_content>
                    <div style="text-align:right">
                      <img src="${profileImage}"
                           class="profile-photo" alt="photo" />
                    </div>
                      </#if>
      </div>


      <#if summary?? && summary?has_content>
      <div class="section" style="margin-top:10px;">
        <div class="section-title"><span class="title-icon"></span><div style="color:white;">Professional Summary</div></div>
        <div class="divider"></div>
        <div class="summary">${summary}</div>
      </div>
      </#if>
    </div>

	<#if objective?? && objective?has_content>
      <div class="section" style="margin-top:10px">
        <div class="section-title"><span class="title-icon"></span><div>Objective</div></div>
        <div class="divider"></div>
        <div>${objective}</div>
      </div>
      </#if>

    <div class="layout">


      <div class="main">


        <!-- WORK EXPERIENCE -->
        <#if experiences?? && experiences?size gt 0>
        <div class="section">
          <div class="section-title"><span class="title-icon"></span><div>Work Experience</div></div>
          <div class="divider"></div>

          <#list experiences as exp>
          <div class="exp-item">
            <div class="exp-header">
              <div class="exp-left">

                <#if exp.role?? && exp.role?has_content>
                  <div class="exp-role">${exp.role}</div>
                </#if>
                 <#if exp.companyName?? && exp.companyName?has_content>
                  <div class="exp-company">${exp.companyName}</div>
                </#if>
              </div>

              <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
              <div class="exp-dates">
                <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>${extractmonth(exp.experienceYearStartDate)}</#if>
                <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content> &#8209;  ${extractmonth(exp.experienceYearEndDate)}<#else> &#8209; Present</#if>
              </div>
              </#if>
            </div>




            <#if exp.responsibilities?? && exp.responsibilities?has_content>
            <ul class="bullets">
              <#list exp.responsibilities?split(",") as r>
                <li>${r}</li>
              </#list>
            </ul>
            </#if>

            <#if exp.projects?? && exp.projects?size gt 0>

              <div class="project-heading">Project</div>
              <#list exp.projects as p>
              <div class="project-block">
                <#if p.projectName?? && p.projectName?has_content>
                  <div class="project-title">Name: ${p.projectName}</div>
                </#if>

                <#if p.projectRole?? && p.projectRole?has_content>
                  <div class="project-title">Role: ${p.projectRole}</div>
                </#if>

                  <#if p.projectDescription?? && p.projectDescription?has_content>
                   <div class="project-desc"> <strong>Description:</strong> ${p.projectDescription}</div>
                  </#if>

                  <#if p.projectSkills?? && p.projectSkills?has_content>
                  <div class="project-desc">

                  <#list p.projectSkills?split(",") as sk>
                    <li>${sk}</li>
                   </#list>

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
			  <div class="section-title"><span class="title-icon"></span><div>ACADEMIC PROJECT</div></div>
                  <div class="divider"></div>
				   <#list collegeProject as ap>
						<div class="exp-item">

							  <#if ap.collegeProjectName?? && ap.collegeProjectName?has_content>
								<div class="exp-role"><strong>Name:</strong> ${ap.collegeProjectName}</div>
							  </#if>

							  <#if ap.collegeProjectSkills?? && ap.collegeProjectSkills?has_content>
								<div class="exp-company"><strong>Skills:</strong> ${ap.collegeProjectSkills}</div>
							  </#if>

							  <#if ap.collegeProjectDescription?? && ap.collegeProjectDescription?has_content>
								<div class="exp-desc muted"><strong>Description:</strong> ${ap.collegeProjectDescription}</div>
							  </#if>

						</div>
				  </#list>
		    </#if>



       <#if education?? && education?size gt 0>
         <div class="section">
           <div class="section-title">
             <span class="title-icon"></span>
             <div>Education</div>
           </div>
           <div class="divider"></div>

           <#list education as edu>
             <div class="edu-item">
               <div class="edu-left">

                 <#if edu.department?? && edu.department?has_content>
                   <div class="edu-degree">${edu.department}</div>
                 </#if>

                 <#if edu.institutionName?? && edu.institutionName?has_content>
                   <div class="edu-school">${edu.institutionName}</div>
                 </#if>

                 <#if (edu.fieldOfStudy?? && edu.fieldOfStudy?has_content)
                     || (edu.percentage?? && edu.percentage?has_content)>
                   <div class="edu-school">
                     <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                       ${edu.fieldOfStudy}
                     </#if>

                     <#if edu.percentage?? && edu.percentage?has_content>
                        ${edu.percentage}%
                     </#if>
                   </div>
                 </#if>

               </div>

               <#if (edu.qualificationStartYear?? && edu.qualificationStartYear?has_content)
                  || (edu.qualificationEndYear?? && edu.qualificationEndYear?has_content)>
                 <div class="edu-year">
                   <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                   &nbsp;  ${extractmonth(edu.qualificationStartYear)}
                   </#if>
                   &#8209;
                   <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                     ${extractmonth(edu.qualificationEndYear)}
                   <#else>
                     Present
                   </#if>
                 </div>
               </#if>

             </div>
           </#list>

         </div>
       </#if>





        <#if achievements?? && achievements?size gt 0>
        <div class="section">
          <div class="section-title"><span class="title-icon"></span><div>Achievements & Awards</div></div>
          <div class="divider"></div>
          <ul class="list">
            <#list achievements as ach><li>
                ${ach.achievementsName}

                <#if ach.achievementsDate?? && ach.achievementsDate?has_content>
                                                       &#8209; ${extractmonth(ach.achievementsDate)}
                                                       </#if>


            </li></#list>
          </ul>
        </div>
        </#if>







       <#if extraCurricularActivities?? && extraCurricularActivities?has_content>
        <div class="section">
          <div class="section-title"><span class="title-icon">&#127895;</span><div>Extracurricular Activities</div></div>
          <div class="divider"></div>
          <ul class="list">
            <#list extraCurricularActivities?split(",") as e><li>${e}</li></#list>
          </ul>
        </div>
        </#if>

         <#if competencies?? && competencies?trim?length gt 0>
            <div class="section">
              <div class="section-title"><span class="title-icon">&#127895;</span><div>Core Competencies</div></div>
              <div class="divider"></div>
              <ul class="list">
                <#list competencies?split(",") as e><li>${e}</li></#list>
              </ul>
            </div>
            </#if>

           <#if addAdditionalDetails>
                      <div class="section">
                               <div class="section-title"><span class="title-icon">&#127895;</span><div>Personal Details</div></div>
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

      </div>


      <div class="right-section">






        <#if skills?? && skills?has_content>
        <div class="right-block">
          <div class="right-title"><span class="title-icon"></span><div>Skills</div></div>
          <div style="margin-top:8px">
            <#list skills?split(",") as ex>
              <div class="skill-chip">${ex}</div>
            </#list>
          </div>
        </div>
        </#if>

		   <#if strengths?? && strengths?has_content>
            <div class="right-block">
           <div class="right-title"><span class="title-icon"></span><div>Strengths</div></div>
          <div style="margin-top:8px">
            <#list strengths?split(",") as ex>
              <div class="skill-chip">${ex}</div>
            </#list>
          </div>
        </div>
        </#if>

          <#if softSkills?? && softSkills?trim?length gt 0>
                    <div class="right-block">
                   <div class="right-title"><span class="title-icon"></span><div>Soft Skills</div></div>
                  <div style="margin-top:8px">
                    <#list softSkills?split(",") as ex>
                      <div class="skill-chip">${ex}</div>
                    </#list>
                  </div>
                </div>
                </#if>



        <#if goals?? && goals?has_content>
         <div class="right-block">
            <div class="right-title"><span class="title-icon"></span><div>Goals</div></div>
			  <div style="margin-top:8px">
				<#list goals?split(",") as ex>
				  <div class="skill-chip">${ex}</div>
				</#list>
			  </div>
        </div>
        </#if>


        <#if certificates?? && certificates?size gt 0>
        <div class="right-block">
          <div class="right-title"><span class="title-icon"></span><div>Courses & Training</div></div>
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




      </div>

    </div>
  </div>
</body>
</html>