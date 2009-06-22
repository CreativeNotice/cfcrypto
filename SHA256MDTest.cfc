<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfscript>

  function setup() {
   crypto = createObject('component', 'Crypto').init();
   randomizer = createObject('component', 'sandbox.randomizer.Randomizer');
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
  p1 = randomizer.genRandomPassword();
  p2 = randomizer.genRandomPassword();
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