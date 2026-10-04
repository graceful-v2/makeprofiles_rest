<!DOCTYPE html>
<html>

<head>
<#import "Fonts.ftl" as fonts>
    <meta charset="utf-8" />
     <@fonts.loadFonts />

    <style>
        @page: first {
            margin-top: 10px;
        }

        @page {
            size: A4;
            margin-top: 20px;
            margin-bottom: 10mm;
            margin-left: 20px;
            margin-right: 20px;
        }

        html,
        body {
            width: 210mm;
            margin: 0;
            padding: 0;
            font-family: ${(style.primaryFont)!'Poppins, Helvetica, Arial, sans-serif'};
            font-size: ${(style.bodySize)!'12pt'};
            line-height: ${(style.lineSpacing)!'1.3'};
            color: ${(style.bodyColor)!'#222'};
            background: #ffffff;
        }



        .header {
            margin-bottom: 18px;
        }

        .name {
            font-size: ${(style.nameSize)!'28pt'};
            font-weight: ${(style.fontWeightname)!'800'};
            color: ${(style.nameColor)!'#6d2416'};
            margin: 0 0 6px 0;
        }

        .subtitle {
            font-size: 16px;
            font-weight: 600;
            color: #c79b3a;
            margin: 0 0 8px 0;
        }


        .summary {
            line-height: 1.4;
            color: #111111;
            margin-bottom: 10px;
            max-width: 100%;
        }

        .contact-line {
            color: #666;
            margin-top: 8px;
        }

        .contact-line span {
            margin-right: 12px;
            display:flex;
            gap:10px;
        }
        .contact-item{
         display:flex;
           margin:7px 0px;
          flex-direction:column;
        }


        /* section wrapper */
        .section {
            margin-top: 20px;
            margin-bottom: 12px;

        }

        .section-title {
            font-size: ${(style.sectionTitleSize)!'14pt'};
            font-weight: ${(style.fontWeightHeading)!'700'};
            color: ${(style.headingColor)!'#0b6fa8'};
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-marker {
            width: 12px;
            height: 12px;
            border-radius: 3px;
            border: 2px solid #d1d6da;
            display: inline-block;
            transform: rotate(45deg);
            background: #2d2c2c;
        }

        .divider {
            height: 2px;
            background: #e6eef6;
            margin: 8px 0 12px;
            border-radius: 2px;
        }

        /* Experience */
        .exp-item {
            margin-bottom: 18px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f0f0f0;
        }

        .exp-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
        }

        .exp-left {
            max-width: 72%;
        }

        .exp-title {
            font-weight: 700;
            font-size: 12.5pt;
            margin: 0 0 4px 0;
        }

        .exp-company {

            color: #090909;
            margin-bottom: 6px;
            font-style: italic;
        }

        .exp-dates {

            color: #0b6fa8;
            font-weight: 600;
            white-space: nowrap;
        }

        .exp-desc {
            color: #1a1a1a;
            line-height: 1.4;
            margin: 10px 0;
        }

        .bullets {
            margin-left: 18px;
            margin-top: 6px;
            color: #333;
        }

        .bullets li {
            margin-bottom: 6px;
        }

        /* Project (inside experience) */
        .project-block {
            margin-top: 8px;
            padding-top: 8px;
            border-bottom: 1px dashed #e6eef6;
        }

        .project-title {
            color: #0b6fa8;
            font-weight: 700;
            font-size: 13pt;
            margin-bottom: 6px;
        }

        .project-desc {
            margin-left: 12px;
            color: #252424;

            margin-bottom: 10px;
        }

        /* Education */
        .edu-item {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 10px;
        }

        .edu-left {
            max-width: 75%;
            line-height: 1.5;
        }

        .edu-degree {
            font-weight: 700;
            color: #222;
        }

        .edu-school {
            color: #272626;

            margin-top: 4px;
        }

        .edu-year {
            color: #0b6fa8;
            font-weight: 600;
            white-space: nowrap;
        }

        /* Academic projects */
        .academic-item {

            margin-bottom: 8px;
            color: #444;
        }

        /* Skills grid */
        .skills-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px 18px;
            margin-top: 6px;
        }

        .skill-chip {

            color: #2a2a2a;
        }

        /* Certifications */
        .cert-list {
            margin-left: 18px;
            margin-top: 6px;
        }

        .cert-list li {
            margin-bottom: 8px;
            list-style: none;
            position: relative;
            padding-left: 18px;
            color: #2b2b2b;
            line-height: 2;
        }

        .cert-list li:before {
            content: "";
            position: absolute;
            left: 0;
            top: 10px;
            width: 10px;
            height: 10px;
            background: #0b6fa8;
            border-radius: 50%;
        }

        /* Extras */
        .languages {
            margin-top: 6px;
            color: #202020;
        }

        .footer-note {
            margin-top: 22px;
            color: #999;
            text-align: center;
        }

        /* small helpers */
        .muted {

            font-style: italic;
        }

        .strong {
            font-weight: 700;
            color: #222;
        }

        .container {
            width: 210mm;
            margin: 0;
            padding:7px;
            position:relative;
            overflow-wrap:break-word;
            box-sizing: border-box;
        }

        .other-items {
            line-height: 1.8;
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

            <!-- HEADER -->
            <div class="header">

                <#if name?? && name?has_content>
                    <div class="name">${name}</div>
                </#if>

                <div class="contact-line">

                    <#if email?? && email?has_content>
                      <div class="contact-item">  <span><svg width="15" height="15" viewBox="0 0 24 24"
                                                                 fill="#B39DDB"
                                                                 xmlns="http://www.w3.org/2000/svg"
                                                                 style="vertical-align:middle; margin-right:6px;">
                                                              <path d="M20 4H4c-1.1 0-2 .9-2 2v12
                                                                       c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6
                                                                       c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6
                                                                       l8 5 8-5v2z"/>
                                                            </svg> ${email}</span></div>
                    </#if>

                    <#if phone?? && phone?has_content>
                       <div class="contact-item">    <span><svg width="15" height="15" viewBox="0 0 24 24"
                                                                 fill="#E91E63"
                                                                 xmlns="http://www.w3.org/2000/svg"
                                                                 style="vertical-align:middle; margin-right:6px;">
                                                              <path d="M6.6 10.8c1.5 3 4.1 5.6 7.1 7.1l2.4-2.4
                                                                       c.3-.3.7-.4 1.1-.3 1.2.4 2.6.6 4 .6
                                                                       .6 0 1 .4 1 1V21c0 .6-.4 1-1 1
                                                                       C10.5 22 2 13.5 2 3c0-.6.4-1 1-1h4.1
                                                                       c.6 0 1 .4 1 1 0 1.4.2 2.8.6 4
                                                                       .1.4 0 .8-.3 1.1L6.6 10.8z"/>
                                                            </svg> ${phone}</span></div>
                    </#if>



                    <#if linkedin?? && linkedin?has_content>
                       <div class="contact-item">    <span><svg width="15" height="15" viewBox="0 0 24 24"
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
                                                            </svg> ${linkedin}</span></div>
                    </#if>

					  <#if location?? && location?has_content>
                        <div class="contact-item">   <span><svg width="15" height="15" viewBox="0 0 24 24"
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
                                                            </svg> ${location}</span></div>
                    </#if>

                </div>
            </div>


            <!-- SUMMARY -->
            <#if summary?? && summary?has_content>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> Summary</div>
                <div class="divider"></div>
                <div class="summary">${summary}</div>
            </div>
            </#if>

			 <#if objective?? && objective?has_content>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> Objective</div>
                <div class="divider"></div>
                <div class="summary">${objective}</div>
            </div>
            </#if>



            <!-- SKILLS -->
            <#if skills?? && skills?trim?length gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> SKILLS</div>
                <div class="divider"></div>

                <div class="skills-grid">
                    <#list skills?split(",") as sk>
                        <#if sk?has_content>
                            <div class="skill-chip">${sk?trim}</div>
                        </#if>
                    </#list>
                </div>
            </div>
            </#if>


            <!-- WORK EXPERIENCE -->
            <#if experiences?? && experiences?size gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> WORK EXPERIENCE</div>
                <div class="divider"></div>

                <#list experiences as exp>
                <div class="exp-item">
                    <div class="exp-header">
                        <div class="exp-left">

                            <#if exp.role?? && exp.role?has_content>
                                <div class="exp-title">${exp.role}</div>
                            </#if>

                            <#if exp.companyName?? && exp.companyName?has_content>
                                <div class="exp-company">${exp.companyName}</div>
                            </#if>

                        </div>

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
                    </div>



                    <#if exp.responsibilities?? && exp.responsibilities?has_content>
                        <strong>Responsibilities:</strong>
                        <div class="exp-desc">${exp.responsibilities}</div>
                    </#if>



                    <#if exp.projects?? && exp.projects?size gt 0>
                        <div class="project-title">Projects</div>

                        <#list exp.projects as prj>
                        <div class="project-block">

                            <#if prj.projectName?? && prj.projectName?has_content>
                                <div class="project-desc"><strong>Name:</strong>${prj.projectName}</div>
                            </#if>

                            <#if prj.projectRole?? && prj.projectRole?has_content>
                                <div class="project-desc"><strong>Role:</strong> ${prj.projectRole}</div>
                            </#if>

                            <#if prj.projectSkills?? && prj.projectSkills?trim?length gt 0>
                                <div class="project-desc"><strong>Skills:</strong>
                                    <#list prj.projectSkills?split(",") as ps>
                                        ${ps?trim}<#if ps_has_next>, </#if>
                                    </#list>
                                </div>
                            </#if>

                            <#if prj.projectDescription?? && prj.projectDescription?has_content>
                                <div class="project-desc"><strong>Description:</strong> ${prj.projectDescription}</div>
                            </#if>

                        </div>
                        </#list>
                    </#if>

                </div>
                </#list>

            </div>
            </#if>


            <!-- ACADEMIC PROJECT -->
            <#if collegeProject?? && collegeProject?size gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span>ACADEMIC PROJECT</div>
                <div class="divider"></div>

                <#list collegeProject as cp>
                <div class="exp-item">

                    <#if cp.collegeProjectName?? && cp.collegeProjectName?has_content>
                    <div class="exp-title">${cp.collegeProjectName}</div>
                    </#if>

                    <#if cp.collegeProjectSkills?? && cp.collegeProjectSkills?trim?length gt 0>
                    <strong>Skills:</strong>
                    <ul class="bullets">
                        <#list cp.collegeProjectSkills?split(",") as sl>
                        <#if sl?has_content>
                            <li>${sl?trim}</li>
                        </#if>
                        </#list>
                    </ul>
                    </#if>

                    <#if cp.collegeProjectDescription?? && cp.collegeProjectDescription?has_content>
                    <strong>Description:</strong>
                    <div class="exp-desc">${cp.collegeProjectDescription}</div>
                    </#if>

                </div>
                </#list>

            </div>
            </#if>


            <!-- EDUCATION -->
            <#if education?? && education?size gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> EDUCATION</div>
                <div class="divider"></div>

                <#list education as edu>
                <div class="edu-item">
                    <div class="edu-left">

                        <#if edu.institutionName?? && edu.institutionName?has_content>
                        <div class="edu-degree">${edu.institutionName}</div>
                        </#if>

                        <#if edu.fieldOfStudy?? && edu.fieldOfStudy?has_content>
                        <div class="edu-school muted">${edu.fieldOfStudy}</div>
                        </#if>

                          <#if edu.department?? && edu.department?has_content>
                                <div class="edu-school muted">${edu.department}

                                 <#if edu.percentage?? && edu.percentage?has_content>
                                &#8211;   ${edu.percentage}%

                                 </#if>

                                 </div>
                              <#else>
                                 <#if edu.percentage?? && edu.percentage?has_content>
                                 <div class="edu-school muted">${edu.percentage}%</div>
                                  </#if>
                          </#if>



                    </div>

                    <#if edu.qualificationStartYear?? && edu.qualificationStartYear?has_content>
                    <div class="edu-year">
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


            <!-- ACHIEVEMENTS -->
            <#if achievements?? && achievements?size gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> Achivements</div>
                <div class="divider"></div>

                <ul class="cert-list">
                    <#list achievements as ach>
                        <#if ach.achievementsName?? && ach.achievementsName?has_content>
                        <li>
                            <strong>${ach.achievementsName}</strong>
                            <#if ach.achievementsDate?? && ach.achievementsDate?has_content>
                            &#8209; ${extractmonth(ach.achievementsDate)}
                            </#if>
                        </li>
                        </#if>
                    </#list>
                </ul>

            </div>
            </#if>


            <!-- CERTIFICATES -->
            <#if certificates?? && certificates?size gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> CERTIFICATES</div>
                <div class="divider"></div>

                <ul class="cert-list">
                    <#list certificates as ct>
                    <#if ct.courseName?? && ct.courseName?has_content>
                    <li>
                        <strong>${ct.courseName}</strong>
                        <#if ct.courseStartDate?? && ct.courseStartDate?has_content>
                       &#8209; (${extractmonth(ct.courseStartDate)}
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


            <!-- SOFT SKILLS -->
            <#if softSkills?? && softSkills?trim?length gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span>SOFT SKILLS</div>
                <div class="divider"></div>

                <div class="skills-grid">
                    <#list softSkills?split(",") as sf>
                    <#if sf?has_content>
                        <div class="skill-chip">${sf?trim}</div>
                    </#if>
                    </#list>
                </div>
            </div>
            </#if>


            <!-- CORE COMPETENCIES -->
            <#if competencies?? && competencies?trim?length gt 0>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> CORE COMPENTENCIES</div>
                <div class="divider"></div>

                <div class="skills-grid">
                    <#list competencies?split(",") as com>
                    <#if com?has_content>
                        <div class="skill-chip">${com?trim}</div>
                    </#if>
                    </#list>
                </div>
            </div>
            </#if>

				<#if strengths?? && strengths?trim?length gt 0>
				<div class="section">
					<div class="section-title"><span class="section-marker"></span> STRENGTH</div>
					<div class="divider"></div>
					<div class="other-items">
						<#list strengths?split(",") as st>
							<#if st?has_content>
								<div class="edu-school muted">${st?trim}</div>
							</#if>
						</#list>
					</div>
				</div>
				</#if>


				<#if goals?? && goals?trim?length gt 0>
				<div class="section">
					<div class="section-title"><span class="section-marker"></span> GOALS</div>
					<div class="divider"></div>
					<div class="other-items">
						<#list goals?split(",") as gl>
							<#if gl?has_content>
								<div class="edu-school muted">${gl?trim}</div>
							</#if>
						</#list>
					</div>
				</div>
				</#if>


			<#if extraCurricularActivities?? && extraCurricularActivities?trim?length gt 0>
			<div class="section">
				<div class="section-title"><span class="section-marker"></span> EXTRACURRICULAR ACTIVITIES</div>
				<div class="divider"></div>
				<div class="other-items">
					<#list extraCurricularActivities?split(",") as ex>
						<#if ex?has_content>
							<div class="edu-school muted">${ex?trim}</div>
						</#if>
					</#list>
				</div>
			</div>
			</#if>




            <#if addAdditionalDetails?? && addAdditionalDetails>
            <div class="section">
                <div class="section-title"><span class="section-marker"></span> PERSONAL DETAILS</div>
                <div class="divider"></div>

                <#if fatherName?? && fatherName?has_content>
                <div class="languages"> <strong>Father Name :</strong> ${fatherName}</div>
                </#if>

                <#if nationality?? && nationality?has_content>
                <div class="languages"> <strong>Nationality :</strong> ${nationality}</div>
                </#if>

                <#if dob?? && dob?has_content>
                <div class="languages"> <strong>Dob :</strong> ${extractDobYear(dob)}</div>
                </#if>

                <#if languagesKnown?? && languagesKnown?has_content>
                <div class="languages"> <strong>Language Known :</strong> ${languagesKnown?replace(",", ", ")}</div>
                </#if>

                <#if maritalStatus?? && maritalStatus?has_content>
                <div class="languages"> <strong>Martial Status :</strong> ${maritalStatus}</div>
                </#if>

				      <#if gender?? && gender?has_content>
                <div class="languages"> <strong>Gender :</strong> ${gender}</div>
                </#if>

				      <#if address?? && address?has_content>
                <div class="languages"> <strong>Address :</strong> ${address}</div>
                </#if>

            </div>
            </#if>

        </div>

</body>

</html>
