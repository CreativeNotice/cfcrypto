<style>body{font-family:courier new}</style>
<div align="center">
<h3>Example Add User Form</h3>
<p>This shows you what info you would write to the database:</p>


<form action="AddUserAction.cfm" method="post">
Name: <input type="text" name="name" value="Joe Admin" /> <br />    
Username: <input type="text" name="username" value="admin" /> <br />
Password: <input type="text" name="password" value="password" /> <br />
<input type="submit" />

<p>Password field above is "open" to facilitate testing.</p>
</form>
<p><a href="LoginForm.cfm">Try Login Example?</a></p>
</div>