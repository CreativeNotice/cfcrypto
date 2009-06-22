<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfscript>

  function setup() {
   crypto = createObject('component', 'cfcrypto.Crypto').init();
  
  }

function peepSalt(){
  // byte[] salt = new byte[12];
   s = 'asdfgzxcvbnm';
   salt = s.getBytes();
   debug( arrayLen(salt));
   debug(salt);
   
   salt2Str = generateSecretKey("AES", 128 );
   salt2Bytes = salt2Str.getBytes();
   debug( arrayLen(salt2Bytes));
   debug(salt2Bytes);
   
   rand = createObject("java", "java.security.SecureRandom");
   rand.nextBytes(salt); 
   rand.nextBytes(salt2Bytes); 
   
    
}

 function peep() {
  digest = createObject("java", "java.security.MessageDigest");
  debug(digest);
 }

function testBill() {
 bill = 'bill';
 salt =  crypto.genSalt() ;
 billHash = crypto.computeHash(bill,salt,1024);
 debug(billHash);
 }

 function comparePasswordHashes(){
  p1 = 'password';
  p2 = 'password';
  salt =  crypto.genSalt() ; ;

  p1Hash = crypto.computeHash(p1,salt,1024);
  p2Hash = crypto.computeHash(p2,salt,1024);


  debug("p1");
  debug(p1);
  debug(p1Hash);
  debug(toBase64(p1Hash));

  debug("p2");
  debug(p2);
  debug(p2Hash);
  debug(toBase64(p2Hash));

  assertEquals( p1Hash , p2Hash );

  }


 function passwordsShouldFail() {
  p1 = 'lsk&8309%6jNB\\';
  p2 = '*&(*AHSDHju7213876)';
  salt =  crypto.genSalt() ;
  debug(p1);
  debug(p2);
  debug(salt);

  p1Hash = crypto.computeHash(p1,salt,1024);
  p2Hash = crypto.computeHash(p2,salt,1024);

  assertNotEquals( p1Hash , p2Hash );
 }

  function testComputeHash2() {
    salt =   generateSecretKey("AES",256);
    v = crypto.computeHash('password',salt,1024);
    debug(v);
    debug(toBase64(v));
  }
</cfscript>



</cfcomponent>