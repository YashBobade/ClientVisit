<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="Login.css">
<title>Insert title here</title>
</head>
<body>
	<h1>Login</h1>
	<div class="user">
    <form action="LoginServlet" method="post">
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required class="in">
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required class="in">
        </div>
        <button type="submit">Login</button>
    </form>
    </div>
    <p>Not registered yet? <a href="Register.jsp">Register here</a></p>
</body>
</html>