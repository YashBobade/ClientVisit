<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
    String referenceName = request.getParameter("referenceName");
    StringBuilder options = new StringBuilder(); 
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
        
        String sqlSelect = "SELECT Referencenumber FROM addreference WHERE Referencename = ?";
        PreparedStatement pst = con.prepareStatement(sqlSelect);
        pst.setString(1, referenceName);
        ResultSet rs = pst.executeQuery();
        
        while (rs.next()) {
            String refContact = rs.getString("Referencenumber");
            options.append("<option value=\"").append(refContact).append("\">").append(refContact).append("</option>");
        }
        
        con.close();
    } catch (Exception e) {
        out.println("<h1>Error: " + e.getMessage() + "</h1>");
    }
   
    out.print(options.toString());
%>


</body>
</html>