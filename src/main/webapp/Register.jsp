<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="Register.css">

</head>
<body>

<h1>Registration</h1>
<div class="user">
    <form action="RegisterServlet" method="post">
        <div>
            <label for="name" class="text">Name:</label>
            <input type="text" id="name" name="name" required class="in" placeholder="Enter Name">
        </div>
        <div>
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" required class="in"placeholder="Enter Age">
        </div>
        <div>
            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required class="in1">
                <option value="Male">Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required class="in"placeholder="Enter Email">
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required class="in"placeholder="Enter Password">
        </div>
        <button type="submit" class="sub">Register</button>
    </form>
    </div>
    <p>Already registered? <a href="Login.jsp">Login here</a></p>
</body>
</html>