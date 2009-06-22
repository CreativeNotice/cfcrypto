<cfcomponent>

<cffunction name="init" returntype="Crypto">
  <cfreturn this />
</cffunction>



<cffunction name="genSalt" hint="Simple utility wrapper for generatng random salt.">
 <cfargument name="numBits" type="numeric" required="false" default="128" />   
 <cfreturn generateSecretKey("AES", arguments.numBits) />
</cffunction>

<cffunction name="computeHash" access="public" returntype="String">
  <cfargument name="password" type="string" />
  <cfargument name="salt" type="string" />
  <cfargument name="iterations" type="numeric" required="false" default="1024" />
  <cfargument name="algorithm" type="string" required="false" default="SHA512" />
<cfscript>
  var digest = '';
  var i = 1;
  var input = '';
   digest = createObject("java", "java.security.MessageDigest");
   digest  = digest.getInstance(algorithm);
   digest.reset();
   digest.update(salt.getBytes());
   input = digest.digest(password.getBytes("UTF-8"));
   for (i = 1; i <= iterations; i++) {
      digest.reset();
      input = digest.digest(input);
    }
    return toBase64(input);
</cfscript>
</cffunction>
</cfcomponent>