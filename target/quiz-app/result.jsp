<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quizapp.model.User" %>
<%@ page import="com.quizapp.dao.ScoreDAO" %>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Result Page | Program Quiz App</title>

        <%-- STYLE CSS --%>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
        <%-- END STYLE CSS --%>
    </head>
    <body>
        <%
            if (session.getAttribute("loggedIn") == null || !(boolean) session.getAttribute("loggedIn")) {
                response.sendRedirect("login.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");
            int finalQuizScore = (int) session.getAttribute("finalQuizScore");

            ScoreDAO scoreDAO = new ScoreDAO();
            int totalScore = scoreDAO.getTotalScoreByUserId(user.getId());
        %>

        <div class="main">
            <h3 class="main-title">Quiz Results</h3>
            <p class="main-description">Congratulations, <%= user.getName() %>! You have completed the quiz.</p>
            <form class="form" style="grid-template-columns: auto;">
                <div class="form-group">
                    <label for="score_recent">Your score for this quiz</label>
                    <input type="text" id="score_recent" class="input" value="<%= finalQuizScore %>" readonly>
                </div>
                <div class="form-group">
                    <label for="score_total">Your total score</label>
                    <input type="text" id="score_total" class="input" value="<%= totalScore %>" readonly>
                </div>
                <div class="button-group">
                    <a href="index.jsp" class="button-primary" style="width: 100%; text-align: center;">Back to Main Page</a>
                </div>
            </form>
        </div>
    </body>
</html>