	<style>body{font-family:courier new}</style>
	<cfparam name="form.username" default="" />
	<cfparam name="form.password" default="" />
	<cfset setUpUsers() />



<!--------------------------------------------------------------------------------
                        //Begin
 --------------------------------------------------------------------------------->

	<!---// Get the utility object --->
	<cfset crypto = createObject('component' ,'Crypto') />
	<!---// Get user password hash and salt from db --->
	<cfset  user = getUserHash(form.username) />
	<!---//Hash what was entered in the form using the salt from the target user: --->
	<cfset  formPasswordHash = crypto.computeHash(form.password,user.salt) />

	<div align="center">
    <!---
      Onec we have the password hash from the db and the hash from the
      password entered by the user, we simply compare the 2 strings.
     --->
	<cfif formPasswordHash.equals(user.password_hash)>
	  <strong>Valid User!</strong>
	 <cfelse>
	  <strong style="color:darkred">Invalid User</strong>
	</cfif>

	<p><a href="LoginForm.cfm">Try Another?</a></p>
    <p><a href="AddUserForm.cfm">Try Add User Example?</a></p>

  </div>

<!--------------------------------------------------------------------------------
                         //End
 --------------------------------------------------------------------------------->


<p><hr size="1" noshade="true" /></p>
<h4 align="center">Debug Info</h4>

<cfdump var="#form#" label="You submitted the following data:">

<pre>
<cfoutput>
 <strong>formPasswordHash</strong>:    #formPasswordHash#<br />
 <strong>user.password_hash</strong>:  #user.password_hash#<br />
</cfoutput>
</pre>



 <p>Example data. Normally this would be in a database or other persisted store.</p>

<cffunction name="setUpUsers" hint="Just sets a bunch of test users up for testing.">
<cf_querysim>
users
id,username,password,password_hash,salt
1|admin|password|AF110ABD7E446BDF2ECD587BAF3102316FF5589E135F57565DE1CC86703549E5DA387609CCC9F1609AD7DFA740929DE8971E391505410025CB4BA801FD774273|dccT3ZSRkv/ENfApOBf5jg==
2|jenjen|iloveyou|D6CB94D869154F9479E9CD9B38AAA7ED6852E32457D44987DB06046A38D8D12DAF7D94A4EBA939E82261F0487FEA087B475E11136D6BC3F20B67C23A45360089|ccCdsaiTXFX8T7/JyiABdQ==
3|blinky|miss4you|48D2911E2D1D956AA59D90A85EBA3EFE487EB5102C8E4EADB98F49EBB9BC22D7142F180EFEF5DE93E135992F2740374DA925FBB72B20852CB533945598618DA7|VUeqUfPjg/aZbCgXAdCy2w==
4|fabfive|password19|9ABB8D357CBC8C7CFB96299EEC070BA1C9189EA6A567900C098FC086ACA0325EAB713128CF680765C876B6E104315D4FA527579D3252C5EB1197FBDC0AFA140E|Rv7tHDgn7e8izBvgEy47Bw==
5|bushman|ganja|98E0CF617D1B0221738A1C6A6A3464A44993C925A6245C9D4C60FCD257C1819CED793CC208F3A2DACF13F61D5A103C703C90C540632383F6553C889BA08A712D|RAi/zJvDQYwft7N7YPBSsg==
6|rastapasta|phuckyou|8D145163218B143003F90471892E575FC52ADA1BA01DD4F3925F610069597DE2D1D4059015CB5BAAED4A6FED4DF4D1FA0E60F9CAEB314EF5641220FD639B16F6|qhM0GNe7OklYpIAQGaSFig==
7|belladonna|tink69|AC99C7510D4C8F7219DF7BCDEDF513C837D0005CB676F2F4DB1DECA75455995502AE5FB3A233E4A23EA05AFF583CD0581928F9A10C51A911EA9267AB6D373426|dcx+mWQQXPcNmdDkzhJcLQ==

</cf_querysim>
</cffunction>


<cfdump var="#users#" label="list of example users.">

<cffunction name="getUserHash">
  <cfargument name="username">
  <cfquery name="q" dbtype="query" maxrows="1">
    select password_hash,salt from users where username=<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="24" value="#arguments.username#" />
  </cfquery>
  <cfreturn q />
</cffunction>
<!---
<cfset saltyHash()>--->

<!--- Util to populate query above --->
<cffunction name="saltyHash">
  <cfset var salt = ''>
<textarea cols="200" rows="16">
<cfoutput query="users">
 <cfset salt = crypto.genSalt() />
 #id#|#username#|#password#|#crypto.computeHash(password,salt)#|#salt##chr(10)#
 </cfoutput>
</textarea>
</cffunction>


