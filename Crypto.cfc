<cfcomponent>

<cffunction name="init" returntype="Crypto">
  <cfreturn this />
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


<cffunction name="genSalt" access="public" returnType="any" output="no">
   <cfargument name="size" type="numeric" required="false" default="16" hint="How many bytes should be used to generate the salt" />
   <cfargument name="type" type="string"  required="false" default="base64" hint="Should be either binary or base64" />
     <cfscript>
     switch(arguments.type){
       case 'binary':
        return genBinarySalt(size);
       break;
       case 'bin':
        return genBinarySalt(size);
       break;
       default :
         return genBase64Salt(size);
       break;
     }
    </cfscript>
</cffunction>



<cffunction name="genBase64Salt" access="private" returnType="string" output="no">
    <cfargument name="size" type="numeric" required="true"/>
    <cfscript>
     return toBase64( genBinarySalt(size) );
    </cfscript>
</cffunction>


<cffunction name="genBinarySalt" access="private" returnType="binary" output="no">
    <cfargument name="size" type="numeric" required="true"/>
    <cfscript>
     var byteType = createObject('java', 'java.lang.Byte').TYPE;
     var bytes = createObject('java','java.lang.reflect.Array').newInstance( byteType , size);
     var rand = createObject('java', 'java.security.SecureRandom').nextBytes(bytes);
     return bytes;
    </cfscript>
</cffunction>


</cfcomponent>