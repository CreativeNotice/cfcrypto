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
1|admin|password|nXdE+x4xrkOlIjreiRRI2fH0uMJlYN6N80apGvyPLarNpc8Av4TaXVIndCCzK+EINw1Dqesqba3TjTmibYkNOQ==|8H/Yr+F23UXRoNBBQK/kEwibo6StLNmPuCnaRNfx7JM=
2|jenjen|iloveyou|3UH+W180O/FAEDOqfthnGeWNd6nNV5I0IrqbrElhUnZ7Mp3TSycZk/VxUb1LPjklqwPe0Iymqel3klr0NCvjJg==|DoaVpTKI/eUkmn7DaeWztFqQqAPu4HFpnMNlcdnb2BE=
3|blinky|miss4you|v3uDqd+NcJp8GYAwRbhrRApyVqK16CvB0MJI2QP+2Xr81SCH/Nk8XjF71ppGEQq2z5gFB3UadY1H1Xn8QEoLOg==|bpNP7SkCUE0bVZg+YlSPGk6DUPkPKT3NkwIFSUA65+0=
4|fabfive|password19|iqMH/mIMhh5Q4TTiuNKDEcVrRvCxrbPSzHBMF7YqzVtnIyp3uSjy/qeAWLzJIeJ1XCzauAUjwD1HsiNbgXuM/A==|zbZ64U40SE4/aBp6MzxVngnM2bicnH3xamQKWa8yt9w=
5|bushman|ganja|De1Maw6AayP3LcDNHd484OA8u1MDUiD26e2G5iAE67KYZdxhFb6YZI1OA7tVW6Yyn5cmsoSX/XFPgUeyXfA9gA==|dQckvntZtwL5smfmLmIrn5M7pXGrNGtRNkceVWMUYzM=
6|rastapasta|phuckyou|/FjdMs5wfkSup2kQJ3WAWxGfJ/61fQ7t2U6kfp90ZKr9LGAkiffdjZLsELj1ZFHtwtrdmw8Ra3SBZOv0sHra2g==|ZacLEUrEwbcR+1X83I+uLrFjgFVAV/W7ImGLeN61bfc=
7|belladonna|tink69|XKCV7rAREYJ9j1lFzaU1mfN3zTUlp/oik3X1HNA2XntImKhlUhR/Zk3p7wvSgaQLGo1XSDAFAcs4QlaiTb14Pg==|EqwirpFVRAAZrqzdDyCwV77DKRnYL/1FuomZmur+Lg8=

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
<cfset saltyHash()>
 ---> 
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


