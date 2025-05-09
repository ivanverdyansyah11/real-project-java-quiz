<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quizapp.model.Question" %>
<%@ page import="java.util.List" %>
<%
    String loggedIn = (String) session.getAttribute("loggedIn");
    if (loggedIn == null || !"admin".equals(loggedIn)) {
        response.sendRedirect("login-admin.jsp");
        return;
    }

    Question question = (Question) request.getAttribute("question");
    java.util.List<Question.Option> options = new java.util.ArrayList<>();

    if (question != null && question.getOptions() != null) {
        options = question.getOptions();
    }

    String[] optionLabels = {"A", "B", "C", "D"};

    // Ensure we have exactly 4 options to display in the form
    while (options.size() < 4) {
        Question.Option emptyOption = new Question.Option();
        emptyOption.setLabel(optionLabels[options.size()]);
        emptyOption.setText("");
        options.add(emptyOption);
    }
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Question Page | Program Quiz App</title>

    <%-- STYLE CSS --%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
    <%-- END STYLE CSS --%>
</head>
<body>
<div class="container container-content">
    <div class="content">
        <div class="content-header">
            <h4 class="header-title">Edit Question</h4>
        </div>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="alert alert-failed"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <form action="EditQuestionServlet" method="post" class="form" style="grid-template-columns: auto auto;">
            <!-- Hidden input for question ID -->
            <input type="hidden" name="id" value="<%= question != null ? question.getId() : "" %>">

            <div class="form-group" style="grid-column: 1/3;">
                <label for="question_text">Question Text</label>
                <input type="text" id="question_text" class="input" name="question_text" required value="<%= question != null ? question.getQuestionText() : "" %>">
            </div>
            <div class="form-group" style="grid-column: 1/3;">
                <label for="correct_answear">Correct Answer</label>
                <select id="correct_answear" class="input" name="correct_answear" required>
                    <% for (String label : optionLabels) { %>
                    <option value="<%= label %>" <%= (question != null && label.equals(question.getCorrectAnswer())) ? "selected" : "" %>><%= label %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label>Option Label</label>
                <% for (int i = 0; i < options.size(); i++) { %>
                <input type="text" class="input" readonly value="<%= options.get(i).getLabel() %>">
                <% } %>
            </div>

            <div class="form-group">
                <label>Option Text</label>
                <% for (int i = 0; i < options.size(); i++) { %>
                <input type="text" class="input" name="option_text[]" required value="<%= options.get(i).getText() %>">
                <% } %>
            </div>

            <div class="button-group" style="grid-column: 1/3;">
                <button type="submit" class="button-primary" style="width: 100%; text-align: center;">Save Changes</button>
                <a href="AllQuestionServlet" class="button-secondary" style="width: 100%; text-align: center;">Back to Question Page</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>