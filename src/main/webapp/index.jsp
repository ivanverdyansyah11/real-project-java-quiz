<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quizapp.model.User" %>
<% if (session.getAttribute("loggedIn")==null || !(boolean) session.getAttribute("loggedIn")) {
    response.sendRedirect("login.jsp"); return; } User user=(User) session.getAttribute("user"); %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Main Page | Program Quiz App</title>

        <%-- STYLE CSS --%>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
        <%-- END STYLE CSS --%>
    </head>
    <body>
        <div class="authenticate">lorem5</div>
        <h1>Welcome, <%= user.getName() %>!</h1>

        <div>
            <h2>Data Profile</h2>
            <p>Username: <%= user.getUsername() %>
            </p>
        </div>

        <div>
            <h2>Quiz</h2>
            <p>Ready to test your knowledge?</p>
            <a href="quiz"><button>Start Quiz</button></a>
        </div>

        <div>
            <p><a href="logout">Logout</a></p>
        </div>
    </body>
</html>