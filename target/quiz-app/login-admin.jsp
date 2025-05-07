<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login Admin Page | Program Quiz App</title>

        <%-- STYLE CSS --%>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
        <%-- END STYLE CSS --%>
    </head>
    <body>
        <div class="authenticate">
            <h3 class="authenticate-title">Welcome Back Admin</h3>
            <p class="authenticate-description">Welcome back! Please enter your details.</p>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <p class="alert alert-failed"><%= request.getAttribute("errorMessage") %></p>
            <% } %>
            <form action="AdminLoginServlet" method="post" class="form" style="grid-template-columns: auto;">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" class="input" name="username" required placeholder="Enter your username...">
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" class="input" name="password" required placeholder="Enter your password...">
                </div>
                <div class="button-group">
                    <button type="submit" class="button-primary" style="width: 100%; text-align: center;">Login</button>
                </div>
            </form>
            <p class="authenticate-redirect">Move to login user? <a href="login-user.jsp" class="redirect-link">Login User</a></p>
        </div>
    </body>
</html>