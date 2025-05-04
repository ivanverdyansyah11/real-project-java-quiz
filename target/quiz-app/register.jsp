<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Register Page | Program Quiz App</title>

        <%-- STYLE CSS --%>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
        <%-- END STYLE CSS --%>
    </head>
    <body>
        <div class="authenticate">
            <h3 class="authenticate-title">Create Your Account</h3>
            <p class="authenticate-description">Sign up now to unlock exclusive features and seamless access.</p>
            <% if (request.getAttribute("errorMessage") != null) { %>
            <p class="alert alert-failed"><%= request.getAttribute("errorMessage") %></p>
            <% } %>
            <form action="register" method="post" class="form" style="grid-template-columns: auto;">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" class="input" name="name" required placeholder="Enter your name...">
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" class="input" name="username" required placeholder="Enter your username...">
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" class="input" name="password" required placeholder="Enter your password...">
                </div>
                <div class="button-group">
                    <button type="submit" class="button-primary" style="width: 100%; text-align: center;">Register</button>
                </div>
            </form>
            <p class="authenticate-redirect">Already have an account? <a href="login" class="redirect-link">Login</a></p>
        </div>
    </body>
</html>