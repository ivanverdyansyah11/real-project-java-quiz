<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quizapp.model.User" %>
<%@ page import="com.quizapp.dao.ScoreDAO" %>

<!doctype html>
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
        <%
            String loggedIn = (String) session.getAttribute("loggedIn");
            if (loggedIn == null || !"user".equals(loggedIn)) {
                response.sendRedirect("login-user.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");

            ScoreDAO scoreDAO = new ScoreDAO();
            int totalScore = scoreDAO.getTotalScoreByUserId(user.getId());
        %>

        <div class="main">
            <h3 class="main-title">Welcome, <%= user.getName() %>!</h3>
            <p class="main-description">A fun and interactive quiz app designed to test your knowledge across various topics anytime, anywhere.</p>
            <form class="form" style="grid-template-columns: auto;">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" class="input" value="<%= user.getName() %>" readonly>
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" class="input" value="<%= user.getUsername() %>" readonly>
                </div>
                <div class="form-group">
                    <label for="score_total">Your total score</label>
                    <input type="text" id="score_total" class="input" value="<%= totalScore %>" readonly>
                </div>
                <div class="button-group">
                    <a href="quiz" class="button-primary" style="width: 100%; text-align: center;">Start Quiz</a>
                    <a href="logout" class="button-secondary" style="width: 100%; text-align: center;">Logout</a>
                </div>
            </form>
        </div>
    </body>
</html>