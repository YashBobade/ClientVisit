<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="Images/elioralogoo.png">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>VFlyorions Technologies Pvt Ltd</title>
<link rel="stylesheet" href="edit_client.css">
</head>
<body>

<%
    String id = request.getParameter("id");
	String image="";
    String name = "";
    String address = "";
    String phone = "";
    String purpose = "";
    String remark = "";
    String reference = "";
    String referenceContact = "";
    String interviewedBy = "";
    String date = "";

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

       
        String sqlSelect = "SELECT * FROM client_history WHERE id = ?";
        pst = con.prepareStatement(sqlSelect);
        pst.setString(1, id);
        rs = pst.executeQuery();

        if (rs.next()) {
        	image = rs.getString("image");
            name = rs.getString("name");
            address = rs.getString("address");
            phone = rs.getString("phone");
            purpose = rs.getString("purpose");
            remark = rs.getString("remark");
            reference = rs.getString("reference");
            referenceContact = rs.getString("referenceContact");
            interviewedBy = rs.getString("interviewed");
            date = rs.getString("date");
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
	 
    <h2>Edit Client</h2> <a class="bck" href="client_history.jsp">Back</a>
    <form action="EditServlet" method="post" class="form" enctype="multipart/form-data" onsubmit="return showSuccessMessage()">
        <input type="hidden" name="id" value="<%= id %>" class="input">
        <div style="padding: 10px;">
            
            <% if (image != null && !image.isEmpty()) { %>
                <img id="imagePreview" src="<%= image %>" alt="Client Image" style="max-width: 200px; max-height: 200px;"/><br>
            <% } %>
            <input type="file" id="image" name="image" value="<%= image %>" required class="input" onchange="previewImage(event)">
            
        </div>
        
        <div style="padding: 10px;">
           <b>Name:</b><br>
            <input type="text" id="name" name="name" value="<%= name %>" required class="input">
        </div>
        <div style="padding: 10px;">
            <b>Address:</b><br>
            <input type="text" id="address" name="address" value="<%= address %>" required class="input">
        </div>
        <div style="padding: 10px;">
            <b>Phone:</b><br>
            <input type="text" id="phone" name="phone" value="<%= phone %>" required class="input">
        </div>
        <div style="padding: 10px;">
           <b>Purpose:</b><br>
            <input type="text" id="purpose" name="purpose" value="<%= purpose %>" required class="input">
        </div>
        <div style="padding: 10px;">
            <b>Remark:</b><br>
            <input type="text" id="remark" name="remark" value="<%= remark %>" required class="input">
        </div>
        <div style="padding: 10px;">
            <b>Date:</b><br>
            <input type="date" id="date" name="date" value="<%= date %>" required class="input">
        </div>
        <div style="padding: 10px;">
        	<b>Reference:</b><br>
            <select id="referencename" required class="in2" name="reference">
                            <option value="<%= reference %>"><%= reference %></option>
                        <% 
                        
                        List<String> referenceNames = new ArrayList<>();
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
                            String sqlSelect = "SELECT Referencename FROM addreference";
                            Statement stmt = con1.createStatement();
                            ResultSet rs1 = stmt.executeQuery(sqlSelect);
                            while (rs1.next()) {
                                referenceNames.add(rs1.getString("Referencename"));
                            }
                            con.close();
                        } catch (Exception e) {
                            out.println("<h1>Error: " + e.getMessage() + "</h1>");
                        }

                        for (String refName : referenceNames) {
                    %>
                        <option value="<%= refName %>"><%= refName %></option>
                    <%
                        }
                    %>
                    </select>
        </div>
        <div style="padding: 10px;">
        <b>Reference Contact:</b><br>
            <select id="referencenumber" required class="in2" name="referenceContact">
                           <option value="<%= referenceContact %>"><%= referenceContact %></option>
                      <% 
                   
                        List<String> referenceContacts = new ArrayList<>();
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
                            String sqlSelect = "SELECT Referencenumber FROM addreference";
                            Statement stmt = con1.createStatement();
                            ResultSet rs1 = stmt.executeQuery(sqlSelect);
                            while (rs1.next()) {
                                referenceContacts.add(rs1.getString("Referencenumber"));
                            }
                            con.close();
                        } catch (Exception e) {
                            out.println("<h1>Error: " + e.getMessage() + "</h1>");
                        }

                        for (String refContact : referenceContacts) {
                    %>
                        <option value="<%= refContact %>"><%= refContact %></option>
                        
                    <%
                        }
                    %>
                    </select>
        </div>
        			<div style="padding: 10px;">
           			<b>Intreviewed:</b><br>
            		 <select required class="in2" name="interviewed">
                            <option value=<%= interviewedBy %>><%= interviewedBy %></option>
                          <option value="Yash">Yash</option>
                            <option value="Mohit">Mohit</option>
                            <option value="Rohit">Rohit</option>
                     </select>
        </div>
        
        
        <button class="sub" type="submit">Save changes</button>
    </form>
</div>
<script>
    function previewImage(event) {
        const file = event.target.files[0];
        const reader = new FileReader(); 
        reader.onload = function() {
            const imagePreview = document.getElementById('imagePreview'); 
            imagePreview.src = reader.result; // Set the src of the image to the selected file
        }
        if (file) {
            reader.readAsDataURL(file);
        }
    }
</script>
<script>
        $(document).ready(function() {
            $('#referencename').change(function() {
                var referenceName = $(this).val();
                $.ajax({
                    url: 'fetchContact.jsp',
                    type: 'GET',
                    data: { referenceName: referenceName },
                    success: function(response) {                       
                        $('#referencenumber').empty();
                        $('#referencenumber').append('<option value="">Reference Contact</option>');
                        $('#referencenumber').append(response);
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error: " + status + ": " + error);
                    }
                });
            });
        });
    </script>
    <script>
    function showSuccessMessage() {
	    
	    alert("Your Data Edited Successfully");
	    
	  
	    return true;
	}
    </script>
</body>
</html>
