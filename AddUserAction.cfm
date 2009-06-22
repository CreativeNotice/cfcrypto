	<style>body{font-family:courier new}</style>
	<cfparam name="form.name" default="" />
    <cfparam name="form.username" default="" />
	<cfparam name="form.password" default="" />
	    
    
<!--------------------------------------------------------------------------------
                        //Begin
 --------------------------------------------------------------------------------->
	
	<!---// Get the utility object --->
	<cfset crypto = createObject('component' ,'Crypto') />
	<cfset salt = crypto.genSalt() />
    <!---// Get user password hash and salt from db --->
	<cfset  passwordHash = crypto.computeHash(form.password, salt) />
    <cfset sql = htmlEditFormat('
    <cfquery name="addUser" datasource="myDatasource">
       INSERT INTO USERS
       
       (id, 
        name,
        username,
        password_hash,
        salt)
        
       VALUES
       
       (''#createUUID()#'', 
        ''#form.name#'',
        ''#form.username#'',
        ''#passwordHash#'', 
        ''#salt#'')
    </cfquery>      
                
      ')/>
	
    
    
	<div align="center">  <strong>Example SQL Statement</strong><br />
    for adding hashed password and salt to a database.
        
    <pre style="text-align:left;padding-left:120">
    <cfoutput>
     #sql#
    </cfoutput>
   </pre>
	
	<p><a href="AddUserForm.cfm">Try Another?</a></p>
    <p><a href="LoginForm.cfm">Try Login Example?</a></p>
  
  </div>

<!--------------------------------------------------------------------------------
                         //End
 --------------------------------------------------------------------------------->


<p><hr size="1" noshade="true" /></p>
<h4 align="center">Debug Info</h4>

<cfdump var="#form#" label="You submitted the following data:">



