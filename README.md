## CFCrypto ##

This project is forked from Bill Shelton's 2009 project of the same name.

I really liked Bill's take on managing one's own hashing tools rather than rely on Adobe, no offence Adobe.

I've, hopefully, brought the original project up to date with a cfscript refactor.

**Usage**<br />
There are only two public methods you'll be using in your application. 

- generateSalt()
 - size - required numeric default = 16
 - type - required string default = 'base64'
- computeHash()
 - password - required string
 - salt - required string
 - interations - required numeric default = 1024
 - algorithm - required string default = SHA-512

You'll want to generate a salt first, then run that  and your password through computeHash().

> var crypto = new Crypt0();<br />
> var salt = crypto.generateSalt();<br />
> var hash = crypto.computeHash('mypassword', salt);
