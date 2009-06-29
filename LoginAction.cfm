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
1|admin|password|9280E149198775259E57FE06022F3CFAE96A9F2FC99474F7864ABDCB34CED5A82C94B171116465BA4DD542B72E51AB045EE64764862014D2E4AD689A3CC7D8EF|N6lUg9fdHQsY8A8iJTPygA==
2|jenjen|iloveyou|60EA0B2C9CEE5C8A35C77F80664C30C724084C9D8ED443AF67CC4C5B61B18412D1748066522968AB7860BCC1EEA5E9C41E00FD26A9955D524EDBDF80F7D14F5C|BcNP/J3Y91a9+daj9DrFkQ==
3|blinky|miss4you|22F3D42932E5C660DCDA4582C9949CD63212BF91085B2CDF49A7A7372B4783985F7797628FEB587108D16D945785FFF1FF3E5955F0FCD848E1DDB807E9256487|lCw/0pHTWQgG2ULj6FxhqA==
4|fabfive|password19|2D37303ACE295381AC25B28C0767F9FB164F3737394FBC485F9D5D9F1A988C8BE58574917AADB25C243B8723044081220BC421023B5CFF6EEC4E740C9DC46453|UTskcZLgCFk/BML6uJKwvA==
5|bushman|ganja|8C87DB1EE408F76036D25FB85ED94D8F4AE0925584BBEFFBEAF833A1C46BDFCD326EDDFF861347E6C4BC80F400107794B743F8EDCCC1E7D2EFCCEC0322BBC7BA|hUIO43NZfAT62EsiByHBWg==
6|rastapasta|phuckyou|628C48574DF8740FF9AF0288549863A581056737F06BB8A1BC47242C8166C4FC35E1885F1201F731DE410AC5597AE35FA67909C7A4091D914457FF99ECB382F5|eAYWfcEw+X4ky3KnPAt16Q==
7|belladonna|tink69|38DCE80C702402326C71E0CFD85A88DE98F09F5888FAC9FD40FF49EE6A29FED11F8B0752A57DDE368ADFBCF699F740001C9F08A9AD4D67BAC6E201F1CC5C03B9|SX01/9fMu0+nJmlSGGjeag==
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


