<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="com.ynkl.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
	String connectionURL = "jdbc:mysql://localhost:3306/ntua_internetapps_2020";
	Connection connection = null;
	Statement statement = null;	
	String pageState = "ORDER_START";
%>

<head>
	<title>E-shop page</title>
	<link rel=stylesheet type="text/css" href="style.css">
</head>

<%
	
	String username = String.valueOf(session.getAttribute("SessionUsername"));	
	if (username.equals("null")){
		pageState = "ORDER_FAIL_NO_USER";	
	}

	Catalog basketCatalog = (Catalog) session.getAttribute("SessionBasketCatalog");	
	if (pageState == "ORDER_START"){
		if (basketCatalog == null || basketCatalog.getProducts().size() == 0){
			basketCatalog = new Catalog();
			session.setAttribute("SessionBasketCatalog", basketCatalog);
			pageState = "ORDER_EMPTY";
		}	
	}
	
	if (pageState == "ORDER_START"){
		Integer totalPrice = basketCatalog.getPrice();
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		connection = DriverManager.getConnection(connectionURL, "root", "");
		statement = connection.createStatement();
		String insertSql = "INSERT INTO orders (username, price) VALUES ('" + username + "', " + totalPrice + ");";
		int resultInt = statement.executeUpdate(insertSql);

		String filePath = application.getRealPath("/users.txt");
		System.out.println("Path of file: " + filePath);
		FileWriter filewrt = new FileWriter(filePath,true);
		BufferedWriter fileout = new BufferedWriter(filewrt);
		fileout.write("--------------------------------"); fileout.newLine();		
		fileout.write(username + " makes order that costs " + totalPrice + " pennies" ); fileout.newLine();		

		if (resultInt == 1){
			String searchSql = "SELECT max(id) FROM orders WHERE username='" + username +"';";
			ResultSet resultSet = statement.executeQuery(searchSql);


			String order_id = "0";
			if (resultSet != null && resultSet.next()){
				order_id = resultSet.getString("max(id)");
			}
			if (order_id != "0"){

				//System.out.println("Order id:" + order_id);
				fileout.write("The order has id " + order_id + " and contains the following products:" ); fileout.newLine();		
				
				Set<String> productsIds = basketCatalog.getIds();
				for(String prod_id : productsIds){
					System.out.println(prod_id);
					insertSql = "INSERT INTO order_products (order_id, prod_id) VALUES (" + order_id + ", " + prod_id + ");";
					resultInt = statement.executeUpdate(insertSql);
					//System.out.println(prod_id);
					fileout.write(prod_id); fileout.newLine();		
					if (resultInt != 1){
						pageState = "ORDER_FAIL";
						break;
					}
				}
			}
			else{
				pageState = "ORDER_FAIL";
			}

		}
		else{
			pageState = "ORDER_FAIL";
		}
		
		fileout.write("--------------------------------"); fileout.newLine();		
		fileout.close();		
		
		if (pageState == "ORDER_START"){
			pageState = "ORDER_SUCCESS";
			basketCatalog = new Catalog();
			session.setAttribute("SessionBasketCatalog", basketCatalog);
		}
	}
%>


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
						<% if (pageState != "ORDER_FAIL_NO_USER"){%>
							<p>Welcome, <%=username%> </p>
						<%	} %>
					</td>
				</tr>
				<tr valign="top">
					<td width="510">
<!------------------------ Content zone, add your content below ---------------------------->
<center><h3>Order Page</h3></center>

			<%	if (pageState == "ORDER_SUCCESS"){	%>
					<p>Your order was successful :)</p>
			<% 	} else if (pageState == "ORDER_FAIL") {	%>
					<p>Your order failed :(</p>
			<%	} else if (pageState == "ORDER_EMPTY"){ %>
					<p>Your basket is empty :|</p>
			<%	} else if (pageState == "ORDER_FAIL_NO_USER"){ %>
					<p>You have to <a href="./login.jsp">login</a> first </p>
			<%	} %>

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
