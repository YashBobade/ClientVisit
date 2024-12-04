<%@ page import="java.sql.*, java.io.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="shortcut icon" href="Images/soft.png">
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-klassy-cafe.css">
    <link rel="stylesheet" href="assets/css/lightbox.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
	<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
	 <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css">
    <link rel="stylesheet" href="Add_ref.css">
    <title>VFlyorions Technologies Pvt Ltd</title>
    
    <style>
    .circle-image {
            width: 50px;
            height: 50px; 
            overflow: hidden; 
            border-radius: 50%;
            display: flex; 
            align-items: center; 
            justify-content: center;
            border: 1px solid #ddd;
            margin-left:2%;
            margin-top:2%;
        }

        .circle-image img {
            width: 100%;
            height: auto;
        }
    .dt-buttons {
            display: flex;
            justify-content: center;
            background-color: #d3d3d3; 
            padding: 3px;
            border-radius: 10px;
            margin-left:2%;
            margin-bottom:21px;
        }
        .dt-buttons button {
        margin: 0px;
        border: none; 
        background: none;
        color: #000;
        padding: 10px 15px;
        cursor: pointer; 
        border-radius: 5px; 
        transition: background 0.3s;
        
        }
        .dt-buttons .buttons-colvis {
            background-color: #d3d3d3; 
        }
        #myTable th, #myTable td {
        text-align: center;
        vertical-align: middle;
    }
        @media (max-width: 768px) {
        .dt-buttons {
            flex-wrap: wrap; 
            justify-content: center;
        }
        .dt-buttons button {
            font-size: 12px; 
            padding: 5px 10px;
            margin: 5px;
        }
    }
    </style>
</head>
<body>
<div >
    <a href="index.jsp"><img src="Images/soft.png" alt="Circular Image" class="circle-image"></a>
</div>
    <div>
        <nav class="Navbar">
            <img src="Images/soft.png" alt="vflyorions" width="250px" height="150px" class="vf">
            <br><br>
            <div>
                <div class="Nav_name">
                    <ul><a href="index.jsp">Home</a></ul>
                    <ul><a href="client_history.jsp">Client History</a></ul>
                    <ul><a href="AddReference.jsp">Add Reference</a></ul>
                    <ul><a href="client_revisit.jsp">Client Revisit</a></ul>
                </div>
            </div>
        </nav>
     </div>
    <br>
    <h1><span id="typing-animation" style="color: #fc1302; margin-left: 550px;"></span></h1>
        
    <div>
        <img class="page2" src="Images/page2.png" alt="">
    </div>
    <br>
    <a href="index.jsp" class="hm">Home /</a><a href="Add Reference.jsp"> Reference Data Table</a>
    <br>
    <div class="box">
		    <h2 class="head">Reference Data Table</h2>
		    <form action="Add_Reference.jsp" method="post" onsubmit="return showSuccessMessage()">
		    <div class="search-input">
		    <input type="text" name="Referencename" id="searchBox" class="search-inputs"  placeholder="Enter Reference Name" required>
		    <input type="number" name="Referencenumber" id="phone" class="search-inputs"  placeholder="Enter Reference Number" required min="0" oninput="validatePhoneNumber()">
		    <input type="email" name="email" id="searchBox" class="search-inputs"  placeholder="Enter Email Address" required>
		    </div>
		    <br>
		    <button class="search" type="submit">Add References</button>
		    </form>
		     
		    <br>
		    
		    <%
		        String Referencename = request.getParameter("Referencename");
		        String Referencenumber = request.getParameter("Referencenumber");
		        String email = request.getParameter("email");
		        String deleteId = request.getParameter("deleteId");
		        String editId = request.getParameter("editId");
		        String updatedReferencename = request.getParameter("updatedReferencename");
		        String updatedReferencenumber = request.getParameter("updatedReferencenumber");
		        String updatedEmail = request.getParameter("email");
		
		        Connection con = null;
		        PreparedStatement pst = null;
		
		        try {
		            Class.forName("com.mysql.jdbc.Driver");
		            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
		            
		            if (Referencename != null && Referencenumber != null) {
		                String sqlInsert = "INSERT INTO addreference (Referencename, Referencenumber, email) VALUES (?, ?, ?)";
		                pst = con.prepareStatement(sqlInsert);
		                pst.setString(1, Referencename);
		                pst.setString(2, Referencenumber);
		                pst.setString(3, email);
		                pst.executeUpdate();
		                
		                request.setAttribute("referenceAdded", true);
		            }
		            String sqlSelect = "SELECT * FROM addreference ORDER BY id DESC";
		            Statement stmt = con.createStatement();
		            ResultSet rs = stmt.executeQuery(sqlSelect);
		         
		   	 %>
		   	 <% if (request.getAttribute("referenceAdded") != null) { %>
		    <script>
		        alert('Reference added successfully!');
		    </script>
		<% } %>
		    
		    <table id="myTable">
		        <thead>
		            <tr>
		                <th>Sr No.</th>
		                <th>Reference Name</th>
		                <th>Contact No.</th>
		                <th>Email</th>
		                <th>Actions</th>
		            </tr>
		        </thead>
		        <tbody>
		    <%
		            int srNo = 1;
		            while (rs.next()) {
		            	String id = rs.getString("id");
		                String names = rs.getString("Referencename");
		                String number = rs.getString("Referencenumber");
		                String emails = rs.getString("email");
		    %>
		                <tr>
		                    <td><%= srNo++ %></td>
		                    <td><%= names %></td>
		                    <td><%= number %></td>
		                    <td><%= emails%></td>
		                    <td>
		                    <form action="Add Reference.jsp" method="post" style="display:inline;">
		                    	 <a href="edit_reference.jsp?id=<%= id %>" class="edit">Edit</a>
		                   		 <input type="hidden" name="editId" value="<%= id %>">
		                   	</form>
		                     
		                    <form action="deleteAppe.jsp" method="post" style="display:inline;">
								<input type="hidden" name="id" value="<%= id %>">
								<button type="submit" class="delete">Delete</button>
							</form> 
		                    </td>
		                </tr>
		    <%
		            }
		    %>
		        </tbody>
		    </table>
		    </div>
    <%
        } catch (Exception ex) {
            out.println("<h1>Error: " + ex.getMessage() + "</h1>");
        } finally {
            if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    %>    
	<%
    	ResultSet editRs = null;
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
	        if (editId != null) {
	
	            String sqlFetch = "SELECT * FROM addreference WHERE id = ?";
	            pst = con.prepareStatement(sqlFetch);
	            pst.setString(1, editId);
	            editRs = pst.executeQuery();
	
	            if (editRs.next()) {
	                String editName = editRs.getString("Referencename");
	                String editNumber = editRs.getString("Referencenumber");
	                String editemail = editRs.getString("email");
	          
	%>

	<%
	            }
	        }
	    } catch (Exception ex) {
	        out.println("<h1>Error: " + ex.getMessage() + "</h1>");
	    } finally {
	        if (editRs != null) try { editRs.close(); } catch (SQLException ignored) {}
	        if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
	        if (con != null) try { con.close(); } catch (SQLException ignored) {}
	    }
	%>

<br>
		<div>
				<footer class="footer">
	                <div class="social-icons">
	                  <a href="https://www.facebook.com/vflyorionstechologies"><i class="fab fa-facebook-f" id="f"></i></a>
	                  <a href="https://www.instagram.com/vflyorions_ngp/"><i class="fab fa-instagram" id="f"></i></a>
	                  <a href="https://www.linkedin.com/company/vflyorions-technologies-pvt-ltd/"><i class="fab fa-linkedin-in" id="f"></i></a>
	                  <a href="https://www.youtube.com/channel/UC_ZsCfvJgZYqOUc9IVxAQqQ?themeRefresh=1"><i class="fab fa-youtube" id="f"></i></a>
	                </div>
	                <div>
	                    <a href="index.jsp"><img src="Images/baglogo.PNG" alt="Software" width="170px" class="fi"></a>
	                </div>
	                <div class="footer-section">
            			<p>&copy; Copyright Software Technologies Pvt Ltd.</p>
       				 </div>
                </footer>
        </div>
		<script>
			function validatePhoneNumber() {
			    var phoneInput = document.getElementById("phone");
			
			  
			    if (phoneInput.value.length > 10) {
			     
			        phoneInput.value = phoneInput.value.slice(0, 10);
			   
			        alert("Phone number limit is 10 digits only.");
			    }
			}
			function showSuccessMessage() {

			    alert("Reference Data Added Successfully.");

			    return true;
			}
			
	</script>
  		<script>
                const typingAnimationElement = document.getElementById('typing-animation');
                const typingTexts = [
                	'Software Technologies ',
                    'IT Services  ',
                    'BPO Services',
                    'Digital Marketing'
                ];
                function playTypingAnimation(text) {              
                for (let i = 0; i < text.length; i++) {
                    setTimeout(() => {
                    typingAnimationElement.textContent += text[i];
                    }, i * 200); 
                }
                setTimeout(() => {
                    typingAnimationElement.textContent = '';
                    playTypingAnimation(typingTexts[(typingTexts.indexOf(text) + 1) % typingTexts.length]);
                }, text.length * 200);
                }
                playTypingAnimation(typingTexts[0]);
  		</script>

		<script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
		<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
		<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
		<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
	    <script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.colVis.min.js"></script>
	    
    <div>
    	<script>
			    $(document).ready(function() {
			        $('#myTable').DataTable({
			            dom: 'Bfrtip',
			            buttons: [
			            	{
			                    extend: 'copyHtml5',
			                    text: 'Copy',
			                    title: 'VFlyorions Technologies Pvt Ltd',
			                    exportOptions: {
			                        columns: ':visible' 
			                    },
			                    action: function (e, dt, button, config) {
			                       
			                        $.fn.dataTable.ext.buttons.copyHtml5.action.call(this, e, dt, button, config);
			                        
			                       
			                    }
			                },
			            	{
			                    extend: 'csvHtml5',
			                    text: 'CSV',
			                    title: 'VFlyorions Technologies Pvt Ltd',
			                    exportOptions: {
			                        columns: ':visible' 
			                    },
			                    action: function (e, dt, button, config) {
			                        
			                        $.fn.dataTable.ext.buttons.csvHtml5.action.call(this, e, dt, button, config);
			                        
			                        alert('CSV file has been downloaded!');
			                    }
			                },
			                {
			                    extend: 'excelHtml5',
			                    text: 'Excel',
			                    title: 'VFlyorions Technologies Pvt Ltd',
			                    exportOptions: {
			                        columns: ':visible' 
			                    },
			                    action: function (e, dt, button, config) {
			                        
			                        $.fn.dataTable.ext.buttons.excelHtml5.action.call(this, e, dt, button, config);
			                       
			                        alert('Excel file has been downloaded!');
			                    }
			                },
			                {
			                    extend: 'pdfHtml5',
			                    text: 'PDF',
			                    className: 'custom-button',
			                    title: 'VFlyorions Technologies Pvt Ltd',
			                    orientation: 'landscape',
			                   
			                    exportOptions: {
			                        columns: ':visible' 
			                    },
			                    action: function (e, dt, button, config) {
			                        
			                        $.fn.dataTable.ext.buttons.pdfHtml5.action.call(this, e, dt, button, config);
			                       
			                        alert('PDF file has been downloaded!');
			                    }
			                },
			                {
			                    extend: 'print',
			                    text: 'Print',
			                    title: 'VFlyorions Technologies Pvt Ltd',
			                    exportOptions: {
			                        columns: ':visible' 
			                    },
			                    action: function (e, dt, button, config) {
			                     
			                        $.fn.dataTable.ext.buttons.print.action.call(this, e, dt, button, config);
			                     
			                        alert('Print dialog opened for the table!');
			                    }
			                },
			                {
			                    extend: 'colvis',
			                    text: 'Column Visibility'
			                }
			            ]
			        });
			    });
		</script>
	</div>
</body>
</html>