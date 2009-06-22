<cfcomponent output="false" extends="mxunit.framework.TestCase">

<cffunction name="testtes">
<cfoutput query="q">
  <cfset debug( q.foo )>
  <cfset assertEquals(q.foo,q.bar) />
</cfoutput>
</cffunction>

<cffunction name="comparedHashesAndSameSaltShouldBeEqual" mxunit:data="myfile">
 <cfargument name="q" />
  <cfset debug( q.foo )>
  <cfset assertEquals(q.foo,q.bar) />
</cffunction>

<cffile action="read" file="foo.xls" variable="myfile" />

<cf_querysim>
data
foo,bar,asd
asd|asd|asd
qwe|qwe|qwe
xxx|xxx|xxx
123|123|123
</cf_querysim>
</cfcomponent>