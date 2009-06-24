<cfcomponent output="false">
<!--- @cfmlvariable name="md" type="java.security.MessageDigest" --->
<!--- @cfmlvariable name="mda" type="java.security.MessageDigestSpi" --->
<!--- @cfmlvariable name="mac"  type="javax.crypto.Mac" --->
  <cfscript>

  function md5Foo() {
    md = createObject("java", "java.security.MessageDigest");
    md.getInstance("MD5");
  }


    /* md = createObject("java", "java.security.MessageDigest");
   mds = createObject("java", "java.security.MessageDigestSpi");
   mac = createObject("java", "javax.crypto.Mac");
   md.getInstance()



   package com.thinksec.example;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.Mac;
import java.security.NoSuchAlgorithmException;
import java.security.InvalidKeyException;
import org.apache.commons.codec.binary.Base64;

public class HmacExample {

    public static void main(String args[]) {
        try {
            KeyGenerator kg = KeyGenerator.getInstance("HmacSHA256");
       	    SecretKey sk = kg.generateKey();

            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(sk);
            byte[] hmac = mac.doFinal("data".getBytes());

            String encodedString = new String( Base64.encodeBase64(hmac) );
		    System.out.println(encodedString);
		} catch (NoSuchAlgorithmException e1) {
	        System.err.println(e1);
		} catch (InvalidKeyException e2) {
		    System.err.println(e2);
		}
    }

}
   */
  </cfscript>
</cfcomponent>