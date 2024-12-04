<%@ page import="java.sql.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <link rel="shortcut icon" href="Images/soft.png">
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-klassy-cafe.css">
	<link rel="stylesheet" href="client_history.css">
    <link rel="stylesheet" href="assets/css/lightbox.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="shortcut icon" href="Images/soft.png">
  	<link rel="stylesheet" href="client_history.css">
  
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css"/>
		<script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css">
  	  
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
    .custom-button {
        background-color: #4CAF50; 
        color: green;              
        border: none;              
        padding: 10px 15px;       
        text-align: center;       
        text-decoration: none;     
        display: inline-block;   
        font-size: 14px;       
        margin: 5px;          
        cursor: pointer;          
        border-radius: 5px;      
        transition: background-color 0.3s; 
    }
    
    .custom-button:hover {
        background-color: #45a049; /* Darker green on hover */
    }
    .dt-buttons {
            display: flex;
            justify-content: center;
            background-color: #d3d3d3; 
            padding: 3px;
            border-radius: 10px;
            margin-left:1%;
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
            justify-content:
        }
        .dt-buttons button {
            font-size: 12px;
            padding: 5px 10px; 
            margin: 5px;
        }
        
    }

.butt{
    display: flex;
    justify-content: center;
}

.butt {
    margin: 0 5px;
    padding: 5px 10px;
    border: none; 
    border-radius: 5px;
    color: white;
    cursor: pointer;
}

 .edit {
    background-color: #007bff;
}

.delete {
    background-color: #dc3545;
}

.edit:hover {
    background-color: white; 
}

.delete:hover {
    background-color: #c82333;
}
    
</style>
</head>
<body>
<div >
    <a href="index.jsp"><img src="Images/soft.png" alt="Circular Image" class="circle-image"></a>
</div>
    <div>
        <nav class="Navbar">
            <img src="Images/soft.png" alt="Software" width="250px" height="150px" class="vf">
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
                 <a href="index.jsp" class="hm">Home Page</a>
            <br>
            
            <div class="box">
                <h3 style="margin: 5px;">Search By DOB:</h3>
                
                <input type="date" name="search" id="searchBox" class="search-input">
                <button class="search" type="submit" onclick="searchByDate()">Search</button>
                <br><br>
                
               
                <br>
                  <table id="myTable">
			        <thead>
			            <tr>
			                <th>Sr No.</th>
			                <th>Image</th>
			                <th>Name</th>
			                <th>Address</th>
			                <th>Phone</th>
			                <th>Purpose</th>
			                <th>Remark</th>
			                <th>Reference</th>
			                <th>Reference Contact</th>
			                <th>Interviewed By</th>
			                <th>Date</th>
			                <th>Actions</th>
			            </tr>
			        </thead>
        			<tbody>
				        <%
				            Connection con = null;
				            PreparedStatement pst = null;
				            ResultSet rs = null;
				
				            try {
				                Class.forName("com.mysql.jdbc.Driver");
				                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
				                
				                // Fetch all visitors
				                String sqlSelect = "SELECT * FROM client_history ORDER BY id DESC";
				                pst = con.prepareStatement(sqlSelect);
				                rs = pst.executeQuery();
				                
				                int srNo = 1;
				                while (rs.next()) {
				                	String id = rs.getString("id"); 
				                    String name = rs.getString("name");
				                    String address = rs.getString("address");
				                    String phone = rs.getString("phone");
				                    String purpose = rs.getString("purpose");
				                    String remark = rs.getString("remark");
				                    String reference = rs.getString("reference");
				                    String referenceContact = rs.getString("referenceContact");
				                    String interviewed = rs.getString("interviewed");
				                    String date = rs.getString("date");
				                   // Blob imageBlob = rs.getBlob("image");
				                   String image = rs.getString("image");
				                    
				        %>
				                     
			                <tr class="adddata">
			                    <td><%= srNo++ %></td>
                             	<td>
                             		<a href="<%= image %>" data-lightbox="client-images">
                    				<img src="<%= image %>" width="90" height="90" alt="Image not available" />
               				 	</td>
                       
			                    <td><%= name %></td>
			                    <td><%= address %></td>
			                    <td><%= phone %></td>
			                    <td><%= purpose %></td>
			                    <td><%= remark %></td>
			                    <td><%= reference %></td>
			                    <td><%= referenceContact %></td>
			                    <td><%= interviewed %></td>
			                    <td><%= date %></td>
			                    <td>
			                        <!-- <form action="DeleteVisitorServlet" method="post" style="display:inline;">-->
			                          
			                           <form action="client_history.jsp" method="post" class="butt">
			                           <a href="edit_client.jsp?id=<%= id %>" class="edit">Edit</a>
                            			<input type="hidden" name="id" value="<%= id %>">
                        				</form>
                        				 <form action="delete.jsp" method="post" class="butt">
									        <input type="hidden" name="id" value="<%= id %>">
									        <button type="submit" class="delete">Delete</button>
									    </form> 
                        				
                        		</td>
			                </tr>
        				<%
				                }
				            } catch (Exception e) {
				                e.printStackTrace();
				            } finally {
				                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
				                if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
				                if (con != null) try { con.close(); } catch (SQLException ignored) {}
				            }
        				%>
        				<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
    <div class="alert">
        <%= msg %>
    </div>
<%
        // Clear the message after displaying it
        session.removeAttribute("msg");
    }
%>
        				
        				
        				
       				 </tbody>
    			</table>
    		</div>
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
	                    <a href="index.jsp"><img src="Images/baglogo.PNG" alt="" width="170px" class="fi"></a>
	                </div>
	                <div class="footer-section">
            			<p>&copy; Copyright Software Technologies Pvt Ltd.</p>
       				 </div>
                </footer>
        </div>

      		<script>
			    function searchByDate() {
			        const inputDate = document.getElementById("searchBox").value;
			        const table = document.getElementById("myTable");
			        const trs = table.getElementsByTagName("tr");
			
			        for (let i = 1; i < trs.length; i++) { 
			            const tdDate = trs[i].getElementsByTagName("td")[10];
			            if (tdDate) {
			                const dateText = tdDate.textContent || tdDate.innerText;
			                trs[i].style.display = dateText === inputDate ? "" : "none";
			            }
			        }
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
    
 
    		 
		<script>
				
				let rowCount = 1;
				
				
				document.getElementById('visitorForm').addEventListener('submit', function(event) {
				    event.preventDefault(); 
				
				  
				    var fullName = document.getElementById('fullName').value;
				
				   
				    var imageFile = document.getElementById('imageUpload').files[0];
				
				    
				    if (!fullName || !imageFile) {
				        alert("Please provide full name and image.");
				        return;
				    }
				
				    
				    var reader = new FileReader();
				    reader.onload = function(e) {
				        
				        var tableBody = document.querySelector('#myTable tbody');
				
				        
				        var newRow = document.createElement('tr');
				
				      
				        var srNoCell = document.createElement('td');
				        srNoCell.textContent = rowCount;
				        newRow.appendChild(srNoCell);
				
				        
				        var imgCell = document.createElement('td');
				        var imgElement = document.createElement('img');
				        imgElement.src = e.target.result;
				        imgElement.style.width = '50px';
				        imgElement.style.height = '50px';
				        imgCell.appendChild(imgElement);
				        newRow.appendChild(imgCell);
				
				     
				        var nameCell = document.createElement('td');
				        nameCell.textContent = fullName;
				        newRow.appendChild(nameCell);
				
				      
				        for (let i = 0; i < 9; i++) {
				            var emptyCell = document.createElement('td');
				            emptyCell.textContent = '-';
				            newRow.appendChild(emptyCell);
				        }
				
				        tableBody.appendChild(newRow);
				
				 
				        rowCount++;
				
			
				        document.getElementById('fullName').value = '';
				        document.getElementById('imageUpload').value = '';
				    };
				

				    reader.readAsDataURL(imageFile);
				});

		</script>
		
    <script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.colVis.min.js"></script>
    <script src="assets/js/lightbox.js"></script>
		
	
	<script>
	    lightbox.option({
	      'resizeDuration': 200,
	      'wrapAround': true
	    });
	</script>
    <div class="scbut">
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
			                        columns: ':visible',
			                        format: {
			                            body: function (data, row, column, node) {
			                                if ($(node).find('img').length) {
			                                    return $(node).html(); // Export the HTML that contains the image
			                                }
			                                return data;
			                            }
			                        }
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
<script>
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    var status = getUrlParameter('status');
    var action = getUrlParameter('action');

    if (status === 'success') {
        if (action === 'add') {
            alert('Client Data has been successfully Added.');
        } else if (action === 'update') {
            alert('Enter Valid details');
        }
    }
</script>
</div>
</body>
</html>