<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quizapp.model.User" %>
<%@ page import="com.quizapp.dao.ScoreDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz App - Result</title>
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

<h1>Quiz Results</h1>

<div>
    <h2>Congratulations, <%= user.getName() %>!</h2>
    <p>You have completed the quiz.</p>
    <p>Your score for this quiz: <%= finalQuizScore %></p>
    <p>Your total score now: <%= totalScore %></p>
</div>

<div>
    <a href="index.jsp"><button>Back to Home</button></a>
</div>
</body>
</html>