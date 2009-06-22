<cfcomponent output="false" extends="mxunit.framework.TestCase">
<!--- @cfmlvariable name="cipher" type="javax.crypto.Cipher" --->
<!--- @cfmlvariable name="kg" type="javax.crypto.KeyGenerator" --->
<cfscript>


function dumpProviders (){
    providers = createObject('java' ,'java.security.Security').getProviders();
    dump(providers);
}

function testGenSecretKey(){
   
 key = generateSecretKey("AES",128);
 asd = encrypt('foo','foo','MD5');
}

function compareHashes() {

	//Encrypt(string, key [, algorithm, encoding, IVorSalt, iterations])
	//EncryptBinary(bytes, key [, algorithm, IVorSalt, iterations]) //no encoding

    originalPassword = "123abcxyz";
    comparePassword = "123abcxyz";
    key = generateSecretKey("AES",128); //retrieve from db
    ivString = "whatever";
    ivOrSalt = generateSecretKey("AES",256);
    debug(key);
    debug(ivOrSalt);
    encrypted = encrypt(originalPassword,key,"AES", "UU", ivOrSalt , 1024);

    encrypted2 = encrypt(comparePassword,key,"AES", "UU", ivOrSalt , 1024);

    debug(encrypted);
    debug(encrypted2);

    assertEquals( encrypted , encrypted2 );


    //decrypted = decrypt(encrypted,key,"DESede");
    //debug(decrypted);
    // assertEquals(originalString,decrypted);

 }


function cfencryptTest() {

	//Encrypt(string, key [, algorithm, encoding, IVorSalt, iterations])
	//EncryptBinary(bytes, key [, algorithm, IVorSalt, iterations]) //no encoding




    originalString = "a quick brown fox jumps over the lazy dog";
    key = generateSecretKey("AES");
    ivString = "whatever";
    ivOrSalt = generateSecretKey("AES");
    debug(key);
    debug(ivOrSalt);
    encrypted = encrypt(originalString,key,"AES", "UU", ivOrSalt , 1024);



    debug(encrypted);
    //decrypted = decrypt(encrypted,key,"DESede");
    //debug(decrypted);
   // assertEquals(originalString,decrypted);

 }
/*
    SecureRandom random = new SecureRandom();
     	random.nextBytes(salt);
     	md.update(salt);
*/

 function MD_SHA256() {
     username = 'admin';
     password = 'password';
     md = createObject("java", "java.security.MessageDigest");
    // sr = createObject("java", "java.security.SecureRandom");
    // debug(sr);
     md  = md.getInstance("SHA256");
     md.update(password.getBytes());
     salt = generateSecretKey("AES",128);
     debug( toBase64(salt) ); //store this next to pwd fingerprint
     md.update( toBinary(salt) );
     debug(md.digest());
     debug( toBase64(md.digest()) );
  }


  function HMAC_SHA256() {
    mac = createObject('java', 'javax.crypto.Mac');
    //debug(mac);
    keyGen  = createObject("java", "javax.crypto.KeyGenerator").getInstance("HmacSHA256");
    mac = mac.getInstance("HmacSHA256");
    mac.init(keyGen.generateKey());
    //encrypt some bytes
    password = 'password';
    encrypted = mac.doFinal( password.getBytes() );
    debug(encrypted);
    debug(toBase64(encrypted));

  }

  function DESede_168_Encrypt() {
    kg  = createObject("java", "javax.crypto.KeyGenerator").getInstance("DESede");
    cipher = createObject("java", "javax.crypto.Cipher").getInstance("DESede/CBC/PKCS5Padding");
    sk = kg.generateKey();
    cipher.init( javacast("int",1) , sk);

    debug(cipher);
    iv = cipher.getIv();
    debug(iv);

    ivSp2 = createObject("java", "javax.crypto.spec.IvParameterSpec").init(iv);

    debug(sk.getEncoded());

    keyAsString = tobase64(sk.getEncoded());
    debug(keyAsString);


    originalString = "a quick brown fox jumps over the lazy dog";
    originalBytes = originalString.getBytes();

    encrypted = cipher.doFinal(originalBytes);
    debug(encrypted);

   cipher.init( javacast("int",2) , sk, ivSp2);
   decrypted = cipher.doFinal(encrypted);

   decryptedStr = createObject('java', 'java.lang.String').init(decrypted);
   debug(decryptedStr);
   assertEquals( originalString , decryptedStr );

  }



  function setUp(){
   crypto = createObject('component', 'cfcrypto.Crypto').init();
   assertSame(crypto,crypto);
  }

  function tearDown(){

  }





 function MD_SHA256B() {
     username = 'admin';
     password = 'password';
     md = createObject("java", "java.security.MessageDigest");
    // sr = createObject("java", "java.security.SecureRandom");
    // debug(sr);
     md  = md.getInstance("SHA256");
     md.update(password.getBytes());
     salt = generateSecretKey("AES",128);
     debug( toBase64(salt) ); //store this next to pwd fingerprint
     md.update( toBinary(salt) );
     debug(md.digest());
     debug( toBase64(md.digest()) );
  }


</cfscript>

<cffunction name="getSHA256Hash" access="package">
  <cfargument name="password" type="string" />
  <cfargument name="salt" type="binary" /> <!--- base64? --->
  <cfargument name="iterations" type="numeric" />
  <cfargument name="algorithm" type="string" required="false" default="SHA256" />
<cfscript>
  var digest = '';
  var i = 1;
  var input = '';
   digest = createObject("java", "java.security.MessageDigest");
   digest  = md.getInstance("SHA256");
   digest.reset();
   digest.update(salt);
   for (i = 1; i <= iterationNb; i++) {
      digest.reset();
      input = digest.digest(input);
    }
    return input;
</cfscript>
<!--- public byte[] getHash(int iterationNb, String password, byte[] salt) throws NoSuchAlgorithmException {
       MessageDigest digest = MessageDigest.getInstance("SHA-1");
       digest.reset();
       digest.update(salt);
       byte[] input = digest.digest(password.getBytes("UTF-8"));
       for (int i = 0; i < iterationNb; i++) {
           digest.reset();
           input = digest.digest(input);
       }
       return input;
   } --->

</cffunction>
</cfcomponent>