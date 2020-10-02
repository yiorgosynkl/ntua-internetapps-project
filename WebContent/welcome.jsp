<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="com.ynkl.*"%>
<%@ page import="java.util.*"%>

<%
	String connectionURL = "jdbc:mysql://localhost:3306/ntua_internetapps_2020";
	Connection connection = null;
	Statement statement = null;	
	String pageState = "LOGIN_START";
	String username = "";
	String password = "";
	
	if (request.getParameter("username") != null && request.getParameter("password") != null){ 
		
		username = request.getParameter("username");
		password = request.getParameter("password");
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		connection = DriverManager.getConnection(connectionURL, "root", "");
		statement = connection.createStatement();
		String searchSql = "SELECT password FROM users WHERE username='" + username  + "';";
		ResultSet result = statement.executeQuery(searchSql);
		String dbPassword = (result.next()) ? result.getString("password") : null;

		if (dbPassword == null){
			pageState = "LOGIN_FAIL_USER";
		} else if (password.equals(dbPassword)){
			pageState = "LOGIN_SUCCESS";
			session.setAttribute( "SessionUsername", username );
			session.setAttribute( "SessionPassword", password );
		} else {
			pageState = "LOGIN_FAIL_PASSWORD";
		}
	}	
%>

<html>
<head>
	<title>E-shop page</title>
	<link rel=stylesheet type="text/css" href="style.css">
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0" background="images/background.jpg">


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

<%
	if (pageState.equals("LOGIN_SUCCESS")){ 
%>
	<a href="./products.jsp">products</a><BR>
	<a href="./basket.jsp">basket</a><BR>
	<a href="./profile.jsp">profile</a><BR>
	<a href="./login.jsp">logout</a><BR>
<%	} else {%>
	<a href="./login.jsp">login</a><BR>
	<a href="./register.jsp">register</a><BR>
<%	}	%>

<!--------------------------------------------------------------------------------->

</td></tr></table>
		</td>

		<td width="510">
			<table width="510" cellpadding="5" cellspacing="5" border="0">
				<tr valign="top">
					<td width="510" style="text-align:right">
						<% if (pageState.equals("LOGIN_SUCCESS")){  %>
							<p>Welcome, <%= username %> </p>
						<%	}	%>
					</td>
				</tr>
				<tr valign="top">
					<td width="510">
<!------------------------ Content zone, add your content below ---------------------------->
<center><h3>Welcome</h3></center>
		
			<% if (pageState.equals("LOGIN_FAIL_USER")){ %>
				<p>The user doesn't exist </p>
			<% } 
			else if (pageState.equals("LOGIN_FAIL_PASSWORD")){ %>
				<p>The password was incorrect </p>
			<% } 
			else if (pageState.equals("LOGIN_SUCCESS")){ %>
				<p>The password was correct. Explore our site!! </p>
			<% }
			else { %>
				<p>There was an error! </p>
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
