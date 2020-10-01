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
						<p>Welcome, <%=session.getAttribute("SessionUsername")%> </p>
					</td>
				</tr>
				<tr valign="top">
					<td width="510">
<!------------------------ Content zone, add your content below ---------------------------->
			<%
				Catalog basketCatalog = (Catalog) session.getAttribute("SessionBasketCatalog");			
				if (basketCatalog == null){
					basketCatalog = new Catalog();
					session.setAttribute("SessionBasketCatalog", basketCatalog);
				}
			%>

<center><h3>Basket</h3></center>
<p>Total Price = <%=basketCatalog.totalPrice(false) %> $</p>
<form method="post" action="login.jsp">
	<table>
		<tr>
			<td><label>Voucher:</label></td>
			<td><input type="text" name="username" size=40 /></td>
		</tr>
		<tr>
			<td><label>Country:</label></td>
			 <td>
			 <select id="country" name=country>
				    <option value="USA">USA</option>
				    <option value="Ecuador">Ecuador</option>
				    <option value="Zimbabwe">Zimbabwe</option>
				    <option value="Puerto Rico">Puerto Rico</option>
				    <option value="El Salvador">El Salvador</option>
			  </select>
			  <td>
		</tr>
		<tr>
			<td colspan=2><input type=submit value="update price" /></td>
		</tr>
	</table>
</form>
<BR>
			<table width="510" cellpadding="2" cellspacing="1" border="1">
				<% 
					ArrayList<Product> productsArray = basketCatalog.getProducts();
					for (int i=0; i < productsArray.size(); i++){
						
				%>
					<tr valign="top" align="center">
						<td width="410">
							<p><%=productsArray.get(i).getName()%> </p>
						</td>
						<td width="100">
							<p><%=productsArray.get(i).getPrice()%> $</p>
						</td>
					</tr>	
				<%	
					}
				%>
			</table>

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
