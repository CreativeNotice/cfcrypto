<cfscript>
/**
 * Crypto.cfc
 * This project originally started by Bill Shelton (virtix) in 2009.
 * I've updated the CFC to use the much nicer (IMO) script syntax and removed
 * the superfluous files that I don't need. Thanks to Bill for sharing this 
 * to the interwebs.
 *
 * NOTE: cfscript tags are not needed and should be removed. I've got them in place
 * 		 so Sublime Text 2 will apply the CF language formatting.
 *
 * @author Bill Shelton https://github.com/virtix/cfcrypto
 * @author Ryan Mueller https://github.com/CreativeNotice/cfcrypto
 * @created 07/19/2012
 *
 * @displayname CFCrypto
 * @hint 		Cryptography component
 */
component
{
	/**
	 * computeHash
	 * 
	 * @hint Will hash a password and salt a number of iterations.
	 * @returnType String
	 */
	public function computeHash (required string password, required string salt, required numeric interations=1024, required string algorithm='SHA-512') 
	{
		// first hash
		var hashed = hash( arguments.password & arguments.salt, arguments.algorithm, 'UTF-8');
		// iterate hash
		for(var i = 1; i <= arguments.interations; i=i+1){
			hashed = hash( hashed & arguments.salt, arguments.algorithm, 'UTF-8' );
		}
		// return hash
		return hashed;
	}

	/**
	 * generateSalt
	 * Requires generateBinarySalt()
	 * Requires generateBase64Salt()
	 * 
	 * @hint Will generate a random binary or base64 salt
	 * @size How many bytes should be used to generate the salt.
	 * @type binary or base64 are your options.
	 * @returnType Any
	 */
	public function generateSalt (required numeric size=16, required string type='base64')
	{
		switch (arguments.type) {
			case 'binary' : {
				return generateBinarySalt(arguments.size);
				break;
			}
			default : {
				return generateBase64Salt(arguments.size);
				break;
			}
		}
	}

	/**
	 * generateBase64Salt
	 * Requires generateBinarySalt()
	 * 
	 * @hint Will return a random salt Base64 encoded.
	 * @size How many bytes should be used to generate the salt.
	 * @returnType String
	 */
	private function generateBase64Salt (required numeric size)
	{
		return BinaryEncode( generateBinarySalt(arguments.size), 'Base64' );
	}

	/**
	 * generateBinarySalt
	 * Thanks to Christian Cantrell!!
	 * http://weblogs.macromedia.com/cantrell/archives/2004/01/byte_arrays_and_1.html
	 * 
	 * @hint Returns random binary salt.
	 * @size How many bytes should be used to generate the salt.
	 * @returnType Binary
	 */
	private function generateBinarySalt (required numeric size)
	{
		var byteType = createObject('java', 'java.lang.Byte').TYPE;
		var bytes    = createObject('java', 'java.lang.reflect.Array').newInstance( byteType , arguments.size);
		var rand     = createObject('java', 'java.security.SecureRandom').nextBytes(bytes);
    	return bytes;
	}
}
</cfscript>