<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz App - Register</title>
</head>
<body>
<h1>Quiz App - Register</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<form action="register" method="post">
    <div>
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
    </div>
    <div>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
    </div>
    <div>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
    </div>
    <div>
        <button type="submit">Register</button>
    </div>
</form>

<p>Already have an account? <a href="login">Login</a></p>
</body>
</html>