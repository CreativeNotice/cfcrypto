<cfcomponent output="false" extends="mxunit.framework.TestCase">


 <cfset randomizer = createObject("component","sandbox.randomizer.Randomizer") />
 <cfset crypto = createObject('component', 'Crypto') />
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