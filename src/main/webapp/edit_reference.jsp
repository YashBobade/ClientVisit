<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="Images/elioralogoo.png">
<title>VFlyorions Technologies Pvt Ltd</title>
<link rel="stylesheet" href="edit_reference.css">
</head>
<body>

<%
    String id = request.getParameter("id");
    String editName = "";
    String editNumber = "";
    String editemail ="";

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

  
        String sqlSelect = "SELECT * FROM addreference WHERE id = ?";
        pst = con.prepareStatement(sqlSelect);
        pst.setString(1, id);
        rs = pst.executeQuery();

        if (rs.next()) {
            editName = rs.getString("Referencename");
            editNumber = rs.getString("Referencenumber");
            editemail = rs.getString("email");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>
<div class="editform">
	<h2>Edit Reference</h2><a class="bck" href="client_history.jsp">Back</a>
	<form action="EditReferenceServlet" method="post" onsubmit="return showSuccessMessage()">
	    <input type="hidden" name="id" value="<%= id %>">
	    <div style="padding: 10px;">
	            <label for="fullName"><b>Reference Name</b></label>
	            <input type="text" id="fullName" name="Referencename" value="<%= editName %>"  required>
	        </div>
	        <div style="padding: 10px;">
	            <label for="address"><b>Reference Contact</b></label>
	            <input type="number" id="address" name="Referencenumber" value="<%= editNumber %>"  required>
	        </div>
	        <div style="padding: 10px;">
	            <label for="address"><b>Email</b></label>
	            <input class="email" type="email" id="address" name="email" value="<%= editemail %>"  required>
	        </div>
	    <button class="sub" type="submit">Save changes</button>
	</form>
</div>
<script>
function showSuccessMessage() {
	    

	    alert("Your Data Edited Successfully");

	    return true;
	}
    </script>
</body>
</html>