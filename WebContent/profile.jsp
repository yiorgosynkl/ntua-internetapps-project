<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/ntua_internetapps_2020";
	Connection connection = null;
	Statement statement = null;	
	String pageState = "PROFILE_UPDATE_START";
	String username = session.getAttribute("SessionUsername").toString();
%>

<html>
<head>
	<title>E-shop page</title>
	<link rel=stylesheet type="text/css" href="style.css">
</head>

<body bottommargin="0" leftmargin="0" marginheight="0" marginwidth="0" rightmargin="0" topmargin="0" background="images/background.jpg">

	<%
		if (request.getParameter("name") != null && request.getParameter("date") != null){ 
			
			String name = request.getParameter("name");
			String date = request.getParameter("date");
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL, "root",
					"");
			statement = connection.createStatement();
			String searchSql = "SELECT * FROM users WHERE username='" + username  + "';";
			ResultSet result = statement.executeQuery(searchSql);
			if (result.next()){
				String updateSql = "UPDATE users SET name='" + name + "', date='" + date + "' WHERE username='" + username + "'";
				int result2 = statement.executeUpdate(updateSql);
				System.out.println(result2);
				pageState = (result2 == 1) ? "PROFILE_UPDATE_SUCCESS" : "PROFILE_UPDATE_FAIL"; 
			}
			else {
				pageState = "PROFILE_UPDATE_FAIL";
			} 
		}
		System.out.println(pageState);


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
<a href="./products.jsp">products</a><BR>
<a href="./basket.jsp">basket</a><BR>
<a href="./profile.jsp">profile</a><BR>
<a href="./login.jsp">logout</a><BR>

<!--------------------------------------------------------------------------------->

</td></tr></table>
		</td>
		
		<td width="510">
			<table width="510" cellpadding="5" cellspacing="5" border="0">
				<tr valign="top">
					<td width="510" style="text-align:right">
						<p>Welcome, <%=session.getAttribute("SessionUsername")%> </p>
					</td>
				</tr>
				<tr valign="top">
					<td width="510">
<!------------------------ Content zone, add your content below ---------------------------->
<center><h3>Profile</h3></center>

	<form method="post" action="./profile.jsp">
		<table>
			<tr>
				<td>First and Last Name:</td>
				<td><input type="text" name="name" value="" size=40 /></td>
			</tr>
			<tr>
				<td>Birth Date:</td>
			 	<td><input type="date" id="start" name="date" value="2010-06-21" min="1900-01-01" max="2019-12-31"></td>
			</tr>
			<tr>
				<td colspan=2><input type=submit /></td>
			</tr>
		</table>
	</form>
	<% if (pageState.equals("PROFILE_UPDATE_SUCCESS")){ %>
		<p>The update was successful </p>
	<% } 
	if (pageState.equals("PROFILE_UPDATE_FAIL")){ %>
		<p>The update failed </p>
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
