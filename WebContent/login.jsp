<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/ntua_internetapps_2020";
	Connection connection = null;
	Statement statement = null;	
	String pageState = "LOGIN_START";
%>

<html>
<head>
	<title>E-shop page</title>
	<link rel=stylesheet type="text/css" href="style.css">
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0" background="images/background.jpg">

	<%
		if (request.getParameter("username") != null && request.getParameter("password") != null){ 
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL, "root",
					"");
			statement = connection.createStatement();
			String searchSql = "SELECT password FROM users WHERE username='" + username  + "';";
			ResultSet result = statement.executeQuery(searchSql);
			String dbPassword = (result.next()) ? result.getString("password") : null;

			if (dbPassword == null){
				pageState = "LOGIN_FAIL_USER";
			} else if (password.equals(dbPassword)){
				pageState = "LOGIN_SUCCESS";
				// action
			} else {
				pageState = "LOGIN_FAIL_PASSWORD";
			}
		}	

	%>


<table width="780" height="143" cellpadding="0" cellspacing="0" border="0">
	<tr valign="top">
		<td width="780">
<!----- Insert your logo below, or change templogotop.jpg to blanklogo.jpg if you do not know how to work with a graphics editor ------------------------------------------>
<img src="images/templogo.jpg" width="780" height="143" border="0" alt="LOGO">
<!---------------------------------------------------------------------->
		</td>
	</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr valign="top">
		<td width="175">
<table width="175" cellpadding="4" cellspacing="0" border="0"><tr valign="top"><td width="175">
<!------------------------ Menu section, links go below ---------------------------->
<BR>
<a href="./login.jsp">login</a><BR>
<a href="./register.jsp">register</a><BR>
<!--------------------------------------------------------------------------------->

</td></tr></table>
		</td>
		
		<td width="510">
			<table width="510" cellpadding="5" cellspacing="5" border="0">
				<tr valign="top">
					<td width="510" style="text-align:right">
					</td>
				</tr>
				<tr valign="top">
					<td width="510">
<!------------------------ Content zone, add your content below ---------------------------->
<center><h3>Login</h3></center>

	<form method="post" action="login.jsp">
		<table>
			<tr>
				<td>Username:</td>
				<td><input type="text" name="username" size=40 /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password" size=40 /></td>
			</tr>
			<tr>
				<td colspan=2><input type=submit /></td>
			</tr>
		</table>
	</form>
	
	<% if (pageState.equals("LOGIN_FAIL_USER")){ %>
		<p>The user doesn't exist </p>
	<% } 
	if (pageState.equals("LOGIN_FAIL_PASSWORD")){ %>
		<p>The password was incorrect </p>
	<% } 
	if (pageState.equals("LOGIN_SUCCESS")){ %>
		<p>The password was correct. Continue to the <a href="products.jsp">products</a> page </p>
	<% } %>

<BR><BR>
<!------------------------------------------------------------------------------------------>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>
