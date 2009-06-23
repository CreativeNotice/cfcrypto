<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfscript>
  
  
 
  function setUp(){
  
  }
  
  function tearDown(){
  
  }    
   
  
  function testGetBinarySalt(){
   salt = genBinarySalt(32);
   debug( salt );
  }  
  
  function testGetBase64Salt(){
   salt = genBase64Salt(32);
   debug( salt );
  }  
  
  
  function testGenSalt(){
   salt = genSalt(123,'binary');
   debug( salt );
  }  
    
</cfscript>


<cffunction name="genSalt" access="private" returnType="any" output="no">
   <cfargument name="size" type="numeric" required="false" default="32" hint="How many bytes should be used to generate the salt" />
   <cfargument name="type" type="string"  required="false" default="base64" hint="Should be either binary or base64" />
     <cfscript>
     switch(arguments.type){
       case 'binary':
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