<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="com.ynkl.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/ntua_internetapps_2020";
	Connection connection = null;
	Statement statement = null;	
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
						<p>Welcome, <%=session.getAttribute("SessionUsername").toString()%> </p>
					</td>
				</tr>
				<tr valign="top">
					<td width="510">
<!------------------------ Content zone, add your content below ---------------------------->
			<%
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				connection = DriverManager.getConnection(connectionURL, "root", "");
				statement = connection.createStatement();
				String searchSql = "SELECT * FROM products;";
				ResultSet result = statement.executeQuery(searchSql);
				String idPar = "22";
				String namePar = "Macbook 2";
				Integer pricePar = 30;
				Product pr1 = new Product("22", namePar, pricePar);
			%>

<center><h3>Products</h3></center>

			<p><%=pr1.getName()%></p>
			<table width="510" cellpadding="2" cellspacing="1" border="1">
				<% 
					while (result.next()){
						String productName = result.getString("name");
						int productPrice = result.getInt("price");
						int productId = result.getInt("id");
				%>
					<tr valign="top" align="center">
						<td width="310">
							<p><%=productName%> </p>
						</td>
						<td width="100">
							<p><%=productPrice%> $</p>
						</td>
						<td width="100">				
							<form action="./products.jsp" method="get">
								<input type="hidden" name="productId" value=<%=productId%> />
								<button type="submit" style="padding: 14px 28px;">Add</button>
							</form>
						</td>
					</tr>	
				<%	
					}
				%>
			</table>
			
			
		<%
			String rqProductId = request.getParameter("productId");
			
			if (rqProductId != null){
				session.setAttribute( "SessionProductId", rqProductId );
		%>
				<p>The product was added to the basket</p>
		<% 
			}
		%>

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
