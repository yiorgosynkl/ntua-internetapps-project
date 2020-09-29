<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/mydatabase";
	Connection connection = null;
	Statement statement = null;	
	String pageState = "REGISTRATION_START";
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
			String searchSql = "SELECT password FROM mytable WHERE username='" + username  + "';";
			ResultSet result = statement.executeQuery(searchSql);
			if (!result.next()){
				pageState = "VALID_USER";
				String insertSql = "INSERT INTO mytable (username, password) VALUES( '" + username  + "' ,'" + password + "') ;";
				int result2 = statement.executeUpdate(insertSql);
				pageState = (result2 == 1) ? "REGISTRATION_SUCCESS" : "REGISTRATION_FAIL_PROBLEM"; 
			}
			else {
				pageState = "REGISTRATION_FAIL_USER_EXISTS";
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
<center><h3>Register</h3></center>

	<form method="get" action="register.jsp">
		<table>
			<tr>
				<td>Name:</td>
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
	
	<% if (pageState.equals("REGISTRATION_SUCCESS")){ %>
		<p>The registration was successful </p>
	<% } 
	if (pageState.equals("REGISTRATION_FAIL_USER_EXISTS")){ %>
		<p>The registration failed because user already exists </p>
	<% } 
	if (pageState.equals("REGISTRATION_FAIL_PROBLEM")){ %>
		<p>The registration failed </p>
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
