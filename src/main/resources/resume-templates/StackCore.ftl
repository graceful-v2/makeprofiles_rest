<!DOCTYPE html>
<html>
  <head>
  <#import "Fonts.ftl" as fonts>
   <meta charset="UTF-8" />
    <@fonts.loadFonts />

 <style>

        @page {
              size: A4;
              margin: 10mm 5mm;
            }

      body {

        margin: 0;
        padding: 0;
      font-family: ${(style.primaryFont)!'Montserrat, Arial, sans-serif'};
        font-size: ${(style.bodySize)!'12pt'};
        line-height: ${(style.lineSpacing)!'1.4'};
        color: ${(style.bodyColor)!'black'};
      }
      .container {
        max-width: 210mm;
        width: 100%;
        margin: 0 auto;
        padding: 10px;
        box-sizing: border-box;
        padding: 0 20px;
      }
      .header {
        display: flex;
        align-items: center;
        margin-bottom: 24px;
      }
      .photo {
        width: 100px;
        height: 100px;
        border-radius: 10px;
        margin-right: 25px;
        object-fit: cover;
        background: #ddd;
      }
      .personal-info {
        line-height: 1.5;

      }
      .name {
        letter-spacing: 1px;
        margin-bottom: 6px;
        font-size: ${(style.nameSize)!'28pt'};
        font-weight: ${(style.fontWeightname)!'800'};
        color: ${(style.nameColor)!'#1177b0'} ;
      }
      .label {
        font-weight: bold;
      }
      .section-title {
        margin-bottom: 8px;
        letter-spacing: 1px;
        border-bottom: 2px solid #1177b0;
        padding-bottom: 4px;
        font-size: ${(style.sectionTitleSize)!'15pt'};
        font-weight: ${(style.fontWeightHeading)!'700'} ;
        color: ${(style.headingColor)!'#1177b0'} ;
      }
      .summary,
      .list,
      .block {
        margin-bottom: 16px;

        line-height: 1.4;
      }
      .role-title {
        font-weight: bold;

        margin-bottom: 2px;
      }
      .org-duration {
        color: #1177b0;

        display: block;
        margin-bottom: 8px;
      }
      .edu-institute {
        font-weight: bold;

        margin-bottom: 2px;
      }
      ul {
        padding-left: 18px;
        margin-top: 4px;
      }
      li {
        margin-bottom: 6px;
      }
      .info-row {
        margin-bottom: 1px;
      }

      .project {
        margin-left: 20px;
      }

      .sub-section-title {
        font-size: 13pt;
        font-weight: bold;
        color: #1177b0;
        margin-bottom: 8px;
        letter-spacing: 1px;
        border-bottom: 2px solid #1177b0;
      }

      .work-divider {
        border: none;
        border-top: 1px solid #ccc;
        margin: 18px 0;
      }
      .acheivemnets {
        margin-top: 5px;

      }
      .section{
      margin-top: 10px;
      }

      .certi-list{
        overflow-wrap:break-word;
        word-break:break-word;
      }

      .achievements{
      margin:7px 0px;
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

    <div class="header">




      <div class="personal-info">
      <#if name?? && name?has_content>
                <div class="name">${name}</div>
              </#if>

        <#if address?? && address?has_content>
          <div class="info-row">
            <span class="label">Address:</span> ${address}
          </div>
        </#if>
        <#if phone?? && phone?has_content>
          <div class="info-row">
            <span class="label">Phone:</span> ${phone}
          </div>
        </#if>
        <#if email?? && email?has_content>
          <div class="info-row">
            <span class="label">Email:</span>
            ${email}
          </div>
        </#if>
        <#if linkedin?? && linkedin?has_content>
          <div class="info-row">
            <span class="label">LinkedIn:</span>
            ${linkedin}
          </div>
        </#if>
      </div>
    </div>

    <#if summary?? && summary?has_content>
      <div class="section">
        <div class="section-title">SUMMARY</div>
        <div class="summary">${summary}</div>
      </div>
    </#if>

	<#if objective?? && objective?has_content>
       <div class="section">
        <div class="section-title">OBJECTIVE</div>
        <div class="summary">${objective}</div>
      </div>
     </#if>



    <#if skills?? && skills?has_content>
      <div class="section">
        <div class="section-title">SKILLS</div>
        <div class="block">
          <ul>
            <#list skills?split(",") as  skill>
              <#if skill?has_content>
                <li>${skill}</li>
              </#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>

    <#if experiences?? && experiences?size gt 0>
      <div class="section">
        <div class="section-title">WORK EXPERIENCE</div>
        <#list experiences as exp>
          <div class="block">
            <div>
              <#if exp.role?? && exp.role?has_content>
                <span class="role-title">${exp.role}</span>,
              </#if>
              <#if exp.companyName?? && exp.companyName?has_content>
                ${exp.companyName}
              </#if>
              <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                <span class="org-duration">( ${extractmonth(exp.experienceYearStartDate)}
                  <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>
                    &#8211; ${extractmonth(exp.experienceYearEndDate)})
					<#else>
					&#8211; Present
					)
                  </#if>
                </span>
              </#if>
            </div>
            <#if exp.responsibilities?? && exp.responsibilities?has_content>
              <ul>
                <#list exp.responsibilities?split(",") as responsibility>
                  <#if responsibility?has_content>
                    <li>${responsibility}</li>
                  </#if>
                </#list>
              </ul>
            </#if>
            <#if exp.projects?? && exp.projects?size gt 0>
              <div class="project">
                <div class="sub-section-title">PROJECTS</div>
                <#list exp.projects as project>
                  <div>
                    <#if project.projectName?? && project.projectName?has_content>
                      <span class="role-title"><strong>Title : </strong></span>${project.projectName}
                    </#if>
                  </div>
				  <div>
                    <#if project.projectRole?? && project.projectRole?has_content>
                      <span class="role-title"><strong>Role : </strong></span>${project.projectRole}
                    </#if>
                  </div>
                  <div>
                    <#if project.projectSkills?? && project.projectSkills?has_content>
                      <span class="role-title"><strong>Skills : </strong></span>

					    <ul>
                       <#list project.projectSkills?split(",") as skill>
                          <#if skill?has_content>
                          ${skill?trim}<#if skill_has_next>, </#if>
                          </#if>
                       </#list>
                      </ul>

                    </#if>
                  </div>
                  <div>
                    <#if project.projectDescription?? && project.projectDescription?has_content>


					   <div class="skills">
					   <span class="role-title"><strong>Description : </strong> ${project.projectDescription}</span>
					   <div>
                    </#if>
                  </div>
                </#list>
              </div>
            </#if>
          </div>
          <hr class="work-divider" />
        </#list>
      </div>
    </#if>

   <#if collegeProject?? && collegeProject?size gt 0>
      <div class="section">
        <div class="section-title">ACADEMIC PROJECT</div>
        <#list collegeProject as project>
          <div class="block">
            <#if project.collegeProjectName?? && project.collegeProjectName?has_content>
              <div><span class="role-title"><strong>Title : </strong></span>${project.collegeProjectName}</div>
            </#if>
            <#if project.collegeProjectSkills?? &&  project.collegeProjectSkills?trim?length gt 0>
              <div><span class="role-title"><strong>Skills : </strong></span>
			   <ul>
					<#list project.collegeProjectSkills?split(",") as skills>
					  <#if skills?? &&  skills?has_content>
						<li>${skills}</li>
					  </#if>
					</#list>
			  </ul>
            </#if>
            <#if project.collegeProjectDescription?? && project.collegeProjectDescription?has_content>
              <div>
                <span class="role-title"><strong>Description : </strong></span>
                <ul>
                  <#list project.collegeProjectDescription?split(",") as  desc>
                    <#if desc?has_content>
                      <li>${desc}</li>
                    </#if>
                  </#list>
                </ul>
              </div>
            </#if>
          </div>
        </#list>
      </div>
    </#if>

    <#if education?? && education?size gt 0>
      <div class="section">
        <div class="section-title">EDUCATION</div>
        <#list education as edu>
          <div class="block">
            <#if edu.department?? && edu.department?has_content>
              <span class="edu-institute">${edu.department}
			   <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
			      &#8211;  ${edu.fieldOfStudy}
			  </#if>
			  </span>  <br />
            </#if>
            <#if edu.institutionName?? && edu.institutionName?has_content>
              ${edu.institutionName}

               &#8211;

               <#if edu.percentage?? && edu.percentage?has_content>
                                       ${edu.percentage}%
                       </#if>
            </#if>
            <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
              <span class="org-duration"> ${extractmonth(edu.qualificationStartYear)}
                <#if edu.qualificationEndYear?? && edu.qualificationEndYear?has_content>
                 &#8211;  ${extractmonth(edu.qualificationEndYear)}
                 <#else>
				&#8211; Present
				</#if>

              </span>
            </#if>
          </div>
          <hr class="work-divider" />
        </#list>
      </div>
    </#if>

    <#if softSkills?? && softSkills?has_content>
      <div class="section">
        <div class="section-title">SOFT SKILLS</div>
        <div class="block">
          <ul>
            <#list softSkills?split(",") as skill>
              <#if skill?has_content>
                <li>${skill}</li>
              </#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>

    <#if coreCompetencies?? && coreCompetencies?size gt 0>
      <div class="section">
        <div class="section-title">CORE COMPETENCIES</div>
        <div class="block">
          <ul>
            <#list coreCompetencies?split(",") as  comp>
              <#if comp?has_content>
                <li>${comp}</li>
              </#if>
            </#list>
          </ul>
        </div>
      </div>
    </#if>

    <#if achievements?? && achievements?size gt 0>
      <div class="section">
        <div class="section-title">ACHIEVEMENTS</div>
        <div class="certi-list">
        <#list achievements as award>
          <#if award.achievementsName?? && award.achievementsName?has_content>
            <div class="achievements">
              <span class="role-title">${award.achievementsName}</span>
              <#if award.achievementsDate?? && award.achievementsDate?has_content>
               &#8211; ( ${extractmonth(award.achievementsDate)} )
              </#if>
            </div>
          </#if>
        </#list>
        </div>
      </div>
    </#if>

    <#if certificates?? && certificates?size gt 0>
      <div class="section">
        <div class="section-title">CERTIFICATIONS</div>
        <div class="certi-list">
        <#list certificates as certi>
          <#if certi.courseName?? && certi.courseName?has_content>
            <div class="achievements">
              <span class="role-title">${certi.courseName}</span>
              <#if certi.courseStartDate?? && certi.courseStartDate?has_content>
					  ( ${extractmonth(certi.courseStartDate)}
						<#if certi.courseEndDate?? && certi.courseEndDate?has_content>
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

	    <#if addAdditionalDetails?? && addAdditionalDetails>
          <div class="section">
           <div class="section-title">PERSONAL DETAILS</div>

		  <ul>

		 <#if fatherName?? && fatherName?has_content>
               <li><strong>Father Name:</strong> ${fatherName}</li>
            </#if>

            <#if dob?? && dob?has_content>
                <li><strong>Date of Birth:</strong> ${extractDobYear(dob)}</li>
            </#if>

            <#if gender?? && gender?has_content>
                <li><strong>Gender:</strong> ${gender}</li>
            </#if>

            <#if nationality?? && nationality?has_content>
               <li><strong>Nationality:</strong> ${nationality}</li>
            </#if>

            <#if languagesKnown?? && languagesKnown?has_content>
                <li><strong>Languages Known:</strong> ${languagesKnown?replace(",", ", ")}</li>
            </#if>

            <#if address?? && address?has_content>
                <li><strong>Address:</strong> ${address}</div>
            </#if>

			 <#if maritalStatus?? && maritalStatus?has_content>
                <li><strong>Martial Status:</strong> ${maritalStatus}</li>
            </#if>

		  </ul>

      </div>
    </#if>

  </div>
</body>
</html>