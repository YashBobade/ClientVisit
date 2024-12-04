
<%@ page import="java.sql.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="Images/elioralogoo.png">
<title>VFlyorions Technologies Pvt Ltd</title>
</head>
<body>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.DriverManager"%>

<%@page import="java.net.ConnectException"%>
<% 
String Referencename=request.getParameter("Referencename");
String Referencenumber=request.getParameter("Referencenumber");
String email=request.getParameter("email");

try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly","root" ,"" );	
	String sql="insert into addreference(Referencename,Referencenumber,email)values('"+Referencename+"','"+Referencenumber+"','"+email+"')";
	PreparedStatement pst=con.prepareStatement(sql);
	int i=pst.executeUpdate();
	if(i>0){
		session.setAttribute("sesreg", "<h1>!!!!!Registration Success!!!!!<h1>");
		response.sendRedirect("AddReference.jsp");
	}
}catch(Exception ex){System.out.println(""+ex);}
%>
</body>
</html>