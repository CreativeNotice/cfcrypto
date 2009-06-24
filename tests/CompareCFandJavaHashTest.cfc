<cfcomponent extends="mxunit.framework.TestCase">

<cfscript>
function hashingShouldProduceSameData() {
  var salt = genBinarySalt(16);
  var pwd = 'password';
  cfHash = computeHashCF(pwd, tobase64(salt));
  javaHash = computeHashJava(pwd, tobase64(salt));
  assertEquals( cfHash , javaHash );
}

function smokeCFHash() {
  var salt = genBinarySalt(16);
 hashed = computeHashCF('password', toBase64(salt));
 debug(hashed);
}


</cfscript>

<cffunction name="computeHashCF" access="private" returntype="String">
  <cfargument name="password" type="string" />
  <cfargument name="salt" type="string" />
  <cfargument name="iterations" type="numeric" required="false" default="1024" />
  <cfargument name="algorithm" type="string" required="false" default="SHA512" />
  <cfscript>
    var hashed = '';
    hashed = hash( password & salt, algorithm, 'UTF-16' );
    for (i = 1; i <= iterations; i++) {
      hashed = hash( password & salt, algorithm, 'UTF-16' );
    }
    return hashed;
  </cfscript>
</cffunction>


<cffunction name="computeHashJava" access="private" returntype="String">
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