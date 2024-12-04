<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;500;600;700&display=swap" rel="stylesheet">  
    <link rel="shortcut icon" href="Images/br.png">
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-klassy-cafe.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="assets/css/lightbox.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>VFlyorions Technologies Pvt Ltd</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript"></script>
    <style>
                #video {
            width: 100px;
            max-width: 100px;
            border: 1px solid black;
            margin-left:5%;
            border-radius:5px;
        }
        #canvas {
            display: none;
            width: 100px;
            height: 100px;
        }
        #previewImage {
            max-width: 100px;
            max-height: 100px; 
           	display:none;
           	
        }
        .previewImage1{
        	margin-right:100px;
        }
    </style>
   
    
</head>
<body>
<div >
    <a href="index.jsp"><img src="Images/soft.png" alt="Circular Image" class="circle-image"></a>
    
</div>
    <div>
    <div>
        <nav class="Navbar">
            <img src="Images/soft.png" alt="Software" width="250px" height="150px" class="vf">
            
            <br>
            <br>
            
            <div>
                <div class="Nav_name" >
                    <ul><a href="index.jsp">Home</a></ul>
                    <ul><a href="client_history.jsp">Client History</a></ul>
                    <ul><a href="AddReference.jsp">Add Reference</a></ul>
                    <ul><a href="client_revisit.jsp">Client Revisit</a></ul>
                </div>
            </div>
        </nav>
        </div>
        <br>
        <br>
        
        <h1><span id="typing-animation" style="margin-left: 550px";></span></h1>
        

        <br>
        <br>
        
        <div class="video"></div>
            <video src="Images/visitorbannervideo.mp4" autoplay muted width="100%" height="400" ></video>
        </div>
        <br>
<div class="formtitle">
    <h1>Client Entry Form</h1>
    <hr width="50%" color="red">
</div>
<form id="visitorForm" action="Client_servlet" method="post" onsubmit="return showSuccessMessage()" enctype="multipart/form-data">
<div class="user-details">
                    <div class="input-box">
                        
                                <input class="in" type="text" placeholder="Your Name*" name="name" required>
                            </div>
                            <div class="input-box">
                                
                                <input class="in" type="text" placeholder="Your Address*"  name="address"  required>
                            </div>
                        
                        
                            <div class="input-box">
           					 <input class="in" type="number" name="phone" placeholder="Phone Number*" required id="phone" min="0" oninput="validatePhoneNumber()">
        					</div>
                    
                    <div class="input-box">
                        
                        <input class="in1" type="text" placeholder="Purpose*" required  name="purpose" onsubmit="validatePhoneNumber()" >
                    </div>

                    <div class="input-box">
                       
                        <input class="in" type="text" placeholder="Remark*" required  name="remark" >
                    </div>
					<div class="input-box">
                        <input class="in" type="date"  name="date"placeholder="dd-mm-yy" required "date">
                    </div> 
                 <div class="input-box">
            	<select required class="in6" id="referencename" name="reference"  name="reference" >
                <option value="Reference">Reference</option>
                 <% 
           
                        List<String> referenceNames = new ArrayList<>();
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
                            String sqlSelect = "SELECT Referencename FROM addreference";
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery(sqlSelect);
                            while (rs.next()) {
                                referenceNames.add(rs.getString("Referencename"));
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
                    <div class="input-box">
            	<select id="referencenumber" class="in5"  name="referenceContact" required  name="referenceContact" >
                <option value="">Reference Contact</option>
                <% 
                        List<String> referenceContacts = new ArrayList<>();
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");
                            String sqlSelect = "SELECT Referencenumber FROM addreference";
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery(sqlSelect);
                            while (rs.next()) {
                                referenceContacts.add(rs.getString("Referencenumber"));
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
                   
                    <div class="input-box">
            <select required class="in4"  name="interviewed" >
                <option value="Interviewed">Interviewed</option>
                <option value="Yash">Yash</option>
                <option value="Nikhil">Nikhil</option>
                <option value="Rohit">Rohit</option>
                <option value="yash123">yash123</option>
                <option value="Rohan">Rohan</option>
                <option value="Veer">Veer</option>
                <option value="Harsh">Harsh</option>
                <option value="Mohit">Mohit</option>
            </select>
        </div>
        <div class="inp1">
            <input type="file" id="cameraInput" name="image" accept="image/*" class="im" required>
        </div>
        <br>
        <div class="inp">
            <video id="video" autoplay></video>
            <canvas id="canvas" width="100" height="100"></canvas>
        </div>
        <img id="previewImage" class="previewImage1" alt="Captured Image">
        <div>
            <button type="button" id="captureButton" class="cap">Capture</button>
            <br>
            <button type="submit" class="subm">Submit</button>
        </div>
    </div>
</form>

    	<br>
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
			function validatePhoneNumber() {
			    var phoneInput = document.getElementById("phone");
			
			  
			    if (phoneInput.value.length > 10) {
			     
			        phoneInput.value = phoneInput.value.slice(0, 10);
			   
			        alert("Phone number limit is 10 digits only.");
			    }
			}
			function showSuccessMessage() {
			    
			    

			    alert("Data submitted successfully.");
			    

			    return true;
			}
	</script>
	<script>
	        const video = document.getElementById('video');
	        const captureButton = document.getElementById('captureButton');
	        const canvas = document.getElementById('canvas');
	        const cameraInput = document.getElementById('cameraInput');
	        const previewImage = document.getElementById('previewImage');

	        cameraInput.addEventListener('click', (event) => {
	            navigator.mediaDevices.getUserMedia({ video: true })
	                .then((stream) => {
	                    video.srcObject = stream;
	                    video.play();
	                })
	                .catch((err) => {
	                    console.error("Error accessing camera: " + err);
	                });
	        });
	
	       
	        captureButton.addEventListener('click', () => {
	            const context = canvas.getContext('2d');
	            context.drawImage(video, 0, 0, canvas.width, canvas.height);
	            const capturedImage = canvas.toDataURL('image/png');
	            previewImage.src = capturedImage;
	            previewImage.style.display = 'block';
	            canvas.toBlob((blob) => {
	                const file = new File([blob], 'Your Image_captured.png', { type: 'image/png' });
	                const dataTransfer = new DataTransfer();
	                dataTransfer.items.add(file);
	                cameraInput.files = dataTransfer.files;
	            }, 'image/png');
	        });
	        cameraInput.addEventListener('change', (event) => {
	            const file = event.target.files[0];
	            if (file) {
	                const reader = new FileReader();
	                reader.onload = function(e) {
	                    previewImage.src = e.target.result;
	                    previewImage.style.display = 'block';
	                };
	                reader.readAsDataURL(file);
	            }
	        });
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

</body>
</html>