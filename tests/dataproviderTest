<cfcomponent output="false" extends="mxunit.framework.TestCase">
<!--- 
  NOTE: To run this test, you will need the randomizer components, which
  can be found here: http://github.com/virtix/randomizer/tree/master
  
  Also, this uses a new possibly volitile mxunit annotation ... mxunit:data. 
  If this fails, you might want to pull the most recent version from the
  mxunit svn trunk and/or change the mxunit:data annotation to mxunit:dataProvider.

 --->

 <cfset randomizer = createObject("component","sandbox.randomizer.Randomizer") />
 <cfset crypto = createObject('component', 'cfcrypto.Crypto') />
 <cfset cols = {password='password'} />
 <cfset passwords = randomizer.genRandomQuery(256,cols) />
 <cfset salt = crypto.genSalt() />


<cffunction name="comparedHashesAndSameSaltShouldBeEqual" mxunit:data="passwords">
 <cfargument name="q" />
 <!--- Make sure each pwd is a unique instance --->
 <cfset var pwd1 = createObject('java','java.lang.String').init(q.password) />
 <cfset var pwd2 = createObject('java','java.lang.String').init(q.password) />
 <cfset var hash1 = crypto.computeHash(pwd1,salt) />
 <cfset var hash2 = crypto.computeHash(pwd2,salt) />
 <cfset assertEquals( hash1 , hash2 , 'failed at row #q.recordCount#') />
</cffunction>

</cfcomponent>