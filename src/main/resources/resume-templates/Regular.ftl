<!DOCTYPE html>
<html>

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
             font-family: ${(style.primaryFont)!'Poppins, Arial, sans-serif'};
            font-size: ${(style.bodySize)!'12pt'};
            color: ${(style.bodyColor)!'#222'};

            line-height: ${(style.lineSpacing)!'1.2'};
            margin: 0 ;
            padding: 0;
            width: 210mm;
            background: #ffffff;
        }

        .container {
            width: 210mm;
            padding: 0;
            margin: 0;
            display: grid;
            grid-template-columns: 35% 65%;
            gap: 5px;
            overflow-wrap:break-word;
            word-break:break-word;
        }

        /* LEFT SIDEBAR */
        .left-section {
            background: #eef4f7;
            padding: 10px 18px;
            min-height: 100%;
             overflow-wrap:break-word;
                        word-break:break-word;
        }

        .profile-name {
            font-size: ${(style.nameSize)!'24pt'};
           font-weight: ${(style.fontWeightname)!'700'};
           color: ${(style.nameColor)!'#222'};
        }

        .profile-role {

            color: #0084a8;
            font-weight: 600;
            margin-bottom: 10px;
            margin-top: 10px;
        }

        .sidebar-section {
            margin-top: 7px;
            margin-bottom: 9px;
        }

        .sidebar-title {

          font-size: ${(style.sectionTitleSize)!'14pt'};
       font-weight: ${(style.fontWeightHeading)!'700'};
          color: ${(style.headingColor)!'#0b6fa8'};
            margin-bottom: 7px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .sidebar-text {

        }

        .skill-item {
            margin-bottom: 7px;
        }

        /* RIGHT MAIN CONTENT */
        .right-section {
            padding: 20px 10px;
             overflow-wrap:break-word;
                        word-break:break-word;
        }

        .section {
            margin-bottom: 9px;
        }

        .section-title {

         font-size: ${(style.sectionTitleSize)!'14pt'};
           font-weight: ${(style.fontWeightHeading)!'700'};
              color: ${(style.headingColor)!'#0b6fa8'};
            display: flex;
            align-items: center;
            gap: 8px;



            margin-bottom: 6px;
        }

        .divider {
            height: 2px;
            background: #d8e7ef;
            margin-bottom: 12px;
        }

        /* EXPERIENCE */
        .exp-item {
            margin-bottom: 18px;
            border-bottom: 1px solid #eaeaea;
            padding-bottom: 10px;
        }

        .exp-header {
            display: flex;
            justify-content: space-between;
            font-weight: 600;
            line-height: 1.2;
        }

        .exp-role {
            font-size: 12.5pt;
            font-weight: 700;
        }

        .exp-company {
            font-style: italic;

            margin-bottom: 2px;
        }

        .exp-dates {
            color: #0b6fa8;
            font-weight: 700;
            white-space: nowrap;
        }

        .bullets {
            margin-left: 18px;
            margin-top: 6px;

        }

        .project-block {
            margin: 8px 0 0 0;
            padding: 6px 0;
            border-top: 1px dashed #cfe4ef;

        }

        .project-title {
            font-size: 13pt;
            font-weight: 700;
            color: #0b6fa8;
            margin-bottom: 4px;
        }

        .project-desc {
            margin-left: 12px;
            margin-bottom: 4px;
        }

        /* EDUCATION */
        .edu-item {
            margin-bottom: 12px;

        }

        .edu-degree {
            font-weight: 700;
            font-size: 12pt;
        }

        .edu-school {
            color: #333;
        }

        .edu-year {
            color: #0b6fa8;
            font-weight: 700;
        }

        /* CERTIFICATIONS */
        .cert-list li {
            list-style: none;
            margin-bottom: 8px;
            padding-left: 30px;
            position: relative;
        }

        .cert-list li::before {
            content: "✔️";
            position: absolute;
            left: 0;
            top: 0;
        }

        /* LANGUAGES */
        .language-item {
            margin-bottom: 10px;

        }

        .muted {
            color: #666;
            font-style: italic;
        }

        .exp-desc {
            margin-bottom: 10px;
        }

        .project-skills {
            margin-top: 7px;
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
           <div class="profile-name">${name}</div>
           </#if>

           <#if role?? && role?has_content>
           <div class="profile-role">${role}</div>
           </#if>


           <div class="sidebar-section">
               <div class="sidebar-title">Contact</div>
               <div class="sidebar-text">
                   <#if email?? && email?has_content><div class="field-item">${email}</div></#if>
                   <#if phone?? && phone?has_content><div class="field-item">${phone}</div></#if>
   				 <#if linkedin?? && linkedin?has_content><div class="field-item">${linkedin}</div></#if>
                   <#if location?? && location?has_content><div class="field-item">${location}</div></#if>

               </div>
           </div>
</div>

<div class="heading-content">
<#if summary?? && summary?has_content>
        <div class="section">
            <div class="section-title"> Summary</div>
            <div class="divider"></div>
            ${summary}
        </div>
        </#if>

        <#if objective?? && objective?has_content>
        <div class="section">
            <div class="section-title"> Objective</div>
            <div class="divider"></div>
            ${objective}
        </div>
   </#if>

   </div>


<div class="container">
    <div class="left-section">

         <#if softSkills?? && softSkills?has_content>
                            <div class="section">
                                <div class="section-title"> Soft Skills</div>
                                <#list softSkills?split(",") as ss>
                                    <#if ss?has_content><div class="skill-item">${ss?trim}</div></#if>
                                </#list>
                            </div>
                            </#if>


        <#if strengths?? && strengths?has_content>
        <div class="sidebar-section">
            <div class="section-title">Strengths</div>
            <#list strengths?split(",") as st>
                <#if st?has_content><div class="skill-item">${st?trim}</div></#if>
            </#list>
        </div>
        </#if>

        <#if goals?? && goals?has_content>
        <div class="sidebar-section">
            <div class="section-title">Career Goals</div>
            <#list goals?split(",") as gl>
                <#if gl?has_content><div class="skill-item">${gl?trim}</div></#if>
            </#list>
        </div>
        </#if>

       <#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
        <div class="sidebar-section">
            <div class="section-title">Extra-Curricular Activities</div>
            <#list extraCurricularActivities?split(",") as ex>
                <#if ex?has_content><div class="skill-item">${ex?trim}</div></#if>
            </#list>
        </div>
        </#if>

 <#if addAdditionalDetails?? && addAdditionalDetails>
        <div class="sidebar-section">
            <div class="sidebar-title">Personal Details</div>

            <#if fatherName?? && fatherName?has_content>
            <div class="language-item"><strong>Father Name &#8208; </strong> ${fatherName}</div>
            </#if>

            <#if dob?? && dob?has_content>
            <div class="language-item"><strong>DOB &#8208; </strong> ${extractDobYear(dob)}</div>
            </#if>

            <#if nationality?? && nationality?has_content>
            <div class="language-item"><strong>Nationality  &#8208; </strong> ${nationality}</div>
            </#if>

            <#if maritalStatus?? && maritalStatus?has_content>
            <div class="language-item"><strong>Marital Status &#8208; </strong> ${maritalStatus}</div>
            </#if>

            <#if gender?? && gender?has_content>
            <div class="language-item"><strong>Gender &#8208; </strong> ${gender}</div>
            </#if>

			<#if address?? && address?has_content>
            <div class="language-item"><strong>Address &#8208; </strong> ${address}</div>
            </#if>

			<#if languagesKnown?? && languagesKnown?has_content>
            <div class="language-item"><strong>Languages Known &#8208; </strong> ${languagesKnown?replace(",", ", ")}</div>
            </#if>

        </div>
        </#if>
    </div>



    <div class="right-section">

<#if skills?? && skills?has_content>
           <div class="section">
            <div class="section-title"> Skills</div>
            <div class="divider"></div>
            <#list skills?split(",") as skill>
                <#if skill?has_content><div class="skill-item">${skill?trim}</div></#if>
            </#list>
        </div>
        </#if>



         <#if experiences?? && experiences?size gt 0>
        <div class="section">
            <div class="section-title"> Work Experience</div>
            <div class="divider"></div>

            <#list experiences as exp>
            <div class="exp-item">

                <div class="exp-header">
                    <div>
                        <#if exp.role?? && exp.role?has_content>
                        <div class="exp-role">${exp.role}</div>
                        </#if>

                        <#if exp.companyName?? && exp.companyName?has_content>
                        <div class="exp-company">${exp.companyName}<#if exp.location??> — ${exp.location}</#if></div>
                        </#if>
                    </div>

                    <#if exp.experienceYearStartDate?? && exp.experienceYearStartDate?has_content>
                    <div class="exp-dates">
                       ${extractmonth(exp.experienceYearStartDate)}
                         &#8211;
                         <#if exp.experienceYearEndDate?? && exp.experienceYearEndDate?has_content>${extractmonth(exp.experienceYearEndDate)}</#if>
                    </div>
                    </#if>
                </div>



                <#if exp.responsibilities?? && exp.responsibilities?has_content>
                <div class="exp-desc">${exp.responsibilities}</div>
                </#if>

                <#if exp.projects?? && exp.projects?size gt 0>
                <div class="project-title">Project</div>
					<#list exp.projects as pr>
						<div class="project-block">
							<#if pr.projectName?? && pr.projectName?has_content>
							<div class="exp-role project-desc">Name: ${pr.projectName}</div>
							</#if>

							<#if pr.projectRole?? && pr.projectRole?has_content>
							<div class="exp-company project-desc"><strong>Role:</strong> ${pr.projectRole}</div>
							</#if>

							<#if pr.projectSkills?? && pr.projectSkills?trim?length gt 0>
							<div class="exp-company project-desc"><strong>Skills:</strong>

							  <#list pr.projectSkills?split(",") as ps>
                                        ${ps?trim}<#if ps_has_next>, </#if>
                                </#list>

                              </div>
							</#if>

							<#if pr.projectDescription?? && pr.projectDescription?has_content>
							<div class="project-desc"><strong>Description:</strong> ${pr.projectDescription}</div>
							</#if>

					</#list>
                </#if>

            </div>
            </#list>
        </div>
        </#if>


        <#if collegeProject?? && collegeProject?size gt 0>
        <div class="section">
            <div class="section-title"> Academic Projects</div>
            <div class="divider"></div>

            <#list collegeProject as ap>
            <div class="project-block">
                <#if ap.collegeProjectName?? && ap.collegeProjectName?has_content><div class="exp-role">Name: ${ap.collegeProjectName}</div></#if>

                <#if ap.collegeProjectSkills?? && ap.collegeProjectSkills?has_content>
                <div class="project-skills">
                    <strong>Skills:</strong>
                    <ul class="bullets">
                        <#list ap.collegeProjectSkills?split(",") as skl>
                        <#if skl?has_content><li>${skl}</li></#if>
                        </#list>
                    </ul>
                </div>
                </#if>

                <#if  ap.collegeProjectDescription?? && ap.collegeProjectDescription?has_content>
                <div><strong>Description:</strong> ${ap.collegeProjectDescription}</div>
                </#if>
            </div>
            </#list>
        </div>
        </#if>


			 <#if education?? && education?size gt 0>
			<div class="section">
				<div class="section-title"> Education</div>
				<div class="divider"></div>

				<#list education as edu>
				<div class="edu-item">
					<div>


						<#if edu.department?? && edu.department?has_content>
							<div class="edu-degree">${edu.department}

							</div>
						</#if>

						<#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                        								<div class="edu-school">

                        								 ${edu.fieldOfStudy}
                        						</div>
                          </#if>



						<#if edu.institutionName?? && edu.institutionName?has_content>
							<div class="edu-school">
								${edu.institutionName}
								<#if edu.percentage?? && edu.percentage?has_content>
									&#8208; ${edu.percentage}%
								</#if>
							</div>
						</#if>

					</div>


					<#if edu.qualificationStartYear?? || edu.qualificationEndYear??>
					<div class="edu-year">
						<#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
							${extractmonth(edu.qualificationStartYear)}
						</#if>
						 &#8211;
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



                    <#if competencies?? && competencies?has_content>
                    <div class="section">
                         <div class="section-title">Core Compentencies</div>
                          <div class="divider"></div>
                        <#list competencies?split(",") as cp>
                            <#if cp?has_content><div class="skill-item">${cp?trim}</div></#if>
                        </#list>
                    </div>
                    </#if>


        <#if certificates?? && certificates?size gt 0>
        <div class="section">
            <div class="section-title">Certifications</div>
            <div class="divider"></div>
            <ul class="cert-list">
                <#list certificates as ct>
              <#if  ct.courseName?? && ct.courseName?has_content>

                <li>
                ${ct.courseName}

				<#if ct.courseStartDate?? && ct.courseStartDate?has_content>
                      &#8209;  (${extractmonth(ct.courseStartDate)}
                            <#if ct.courseEndDate?? && ct.courseEndDate?has_content>
                            &#8209; ${extractmonth(ct.courseEndDate)}
                            </#if>
                        )
                        </#if>


				</li>
				</#if>
                </#list>
            </ul>
        </div>
        </#if>


        <#if achievements?? && achievements?size gt 0>
        <div class="section">
            <div class="section-title"> Achievements & Awards</div>
            <div class="divider"></div>
            <ul class="cert-list">
                <#list achievements as a>
                <#if a?has_content><li>${a.achievementsName}


				<#if a.achievementsDate?? && a.achievementsDate?has_content>
                            &#8209; ${extractmonth(a.achievementsDate)}
                            </#if>

				</li></#if>
                </#list>
            </ul>
        </div>
        </#if>


    </div>
</div>
</body>
