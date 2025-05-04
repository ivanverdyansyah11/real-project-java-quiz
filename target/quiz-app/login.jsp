<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login Page | Program Quiz App</title>

        <%-- STYLE CSS --%>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
        <%-- END STYLE CSS --%>
    </head>
    <body>
        <div class="authenticate">
            <h3 class="authenticate-title">Welcome Back</h3>
            <p class="authenticate-description">Welcome back! Please enter your details.</p>
            <% if (request.getParameter("registered") != null && request.getParameter("registered").equals("true")) { %>
                <p class="alert alert-success">Registration successful! Please login.</p>
            <% } %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <p class="alert alert-failed"><%= request.getAttribute("errorMessage") %></p>
            <% } %>
            <form action="login" method="post" class="form" style="grid-template-columns: auto;">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" class="input" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" class="input" name="password" required>
                </div>
                <div class="button-group">
                    <button type="submit" class="button-primary" style="width: 100%; text-align: center;">Login</button>
                </div>
            </form>
            <p class="authenticate-redirect">Don't have an account? <a href="register" class="redirect-link">Register</a></p>
        </div>
    </body>
</html>