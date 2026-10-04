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



<div class="section">
        <h2 class="section-title">Personal Details</h2>

         <#if fatherName?? && fatherName?has_content>
                    <p><strong>Father Name: </strong> ${fatherName}</p>
         </#if>

         <#if maritalStatus?? && maritalStatus?has_content>
                     <p><strong>Marital Status: </strong> ${maritalStatus}</p>
         </#if>

         <#if gender?? && gender?has_content>
                      <p><strong>Gender: </strong> ${gender}</p>
         </#if>

         <#if languageKnown?? && languageKnown?has_content>
                  <p><strong>Language Known: </strong><#list languageKnown?split(",") as language>${language?trim}<#if language_has_next>, </#if></#list></p>
          </#if>

         <#if hobbies?? && hobbies?has_content>
           <p><strong>Hobbies: </strong><#list hobbies?split(",") as hob>${hob?trim}<#if hob_has_next>, </#if></#list></p>
         </#if>

           <#if nationality?? && nationality?has_content>
                              <p><strong>Nationality: </strong> ${nationality}</p>
           </#if>

           <#if address?? && address?has_content>
                     <p><strong>Address: </strong> ${address}</p>
            </#if>


            <#if dob?? && dob?has_content>
                     <p><strong>Dob: </strong> ${extractmonth(dob)}</p>
             </#if>

  </div>