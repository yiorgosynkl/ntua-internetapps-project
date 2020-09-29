<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/mydatabase";
	Connection connection = null;
	Statement statement = null;	
%>


<html>
<body>
	<%
		if (request.getParameter("username") == null || request.getParameter("password") == null 
				) {
	%>

	<br /> Please Login!
	<form method="get" action="login.jsp">
		<table>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="username" size=12 /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password" size=12 /></td>
			</tr>
			<tr>
				<td colspan=2><input type=submit /></td>
			</tr>
		</table>
	</form>

	<%
			}else {
			
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				connection = DriverManager.getConnection(connectionURL, "root",
						"");
				statement = connection.createStatement();
				String searchSql = "SELECT password FROM mytable WHERE username=\"" + username  + "\" ;";
				ResultSet result = statement.executeQuery(searchSql);
				String dbPassword = (result.next()) ? result.getString("password") : null;

				if (dbPassword.equals(null)){
	%>
			<h1> User <%=username%> does not exist </h1>
	<%					
				} else if (password.equals(dbPassword)){
					System.out.println( (password.equals(dbPassword)) ? "correct" : "incorrect" );
	%>
			<h1> Thank you for logging in, <%=username%> </h1>
	<%
				} else {
					
	%>
			<h1> This is not the correct password for <%=username%> </h1>
	<%
				}
			}
	%>


</body>
</html>