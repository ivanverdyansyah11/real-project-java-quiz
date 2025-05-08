<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quizapp.model.Question" %>
<%@ page import="java.util.List" %>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quiz Page | Program Quiz App</title>

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

            List<Question> questions = (List<Question>) session.getAttribute("questions");
            int currentIndex = (int) session.getAttribute("currentQuestionIndex");
            Question currentQuestion = questions.get(currentIndex);
        %>

        <div class="main">
            <h3 class="main-title"><%= currentQuestion.getQuestionText() %></h3>
            <p class="main-description">Question <%= currentIndex + 1 %> of <%= questions.size() %></p>
            <form action="answer" method="post" class="form" style="grid-template-columns: auto;">
                <% for (Question.Option option : currentQuestion.getOptions()) { %>
                <div class="form-group" style="flex-direction: row !important;">
                    <input type="radio" id="option<%= option.getLabel() %>" name="option"
                           value="<%= option.getLabel() %>" required>
                    <label for="option<%= option.getLabel() %>">
                        <%= option.getLabel() %>: <%= option.getText() %>
                    </label>
                </div>
                <% } %>
                <div class="button-group">
                    <button type="submit" class="button-primary" style="width: 100%; text-align: center;">Submit Answer</button>
                </div>
            </form>
        </div>
    </body>
</html>