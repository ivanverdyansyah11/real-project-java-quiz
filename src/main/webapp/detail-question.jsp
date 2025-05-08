<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.scholarportal.model.Admin, com.scholarportal.model.Question" %>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detail Question Page | Student Management System</title>

        <%-- STYLE CSS --%>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
        <%-- END STYLE CSS --%>
    </head>
    <body>
        <div class="container container-content">
            <div class="content">
                <div class="content-header">
                    <h4 class="header-title">Detail Question</h4>
                </div>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <p class="alert alert-failed"><%= request.getAttribute("errorMessage") %></p>
                <% } %>
                <form class="form" style="grid-template-columns: auto auto;">
                    <div class="form-group" style="grid-column: 1/3;">
                        <label for="question_text">Question Text</label>
                        <input type="text" id="question_text" class="input" name="question_text" readonly value="">
                    </div>
                    <div class="form-group" style="grid-column: 1/3;">
                        <label for="correct_answear">Correct Answear</label>
                        <select id="correct_answear" class="input" name="correct_answear" readonly>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Option Label</label>
                        <input type="text" id="option_label" class="input" name="option_label[]" readonly value="A">
                        <input type="text" id="option_label" class="input" name="option_label[]" readonly value="B">
                        <input type="text" id="option_label" class="input" name="option_label[]" readonly value="C">
                        <input type="text" id="option_label" class="input" name="option_label[]" readonly value="D">
                    </div>
                    <div class="form-group">
                        <label>Option Text</label>
                        <input type="text" id="option_text" class="input" name="option_text[]" readonly value="">
                        <input type="text" id="option_text" class="input" name="option_text[]" readonly value="">
                        <input type="text" id="option_text" class="input" name="option_text[]" readonly value="">
                        <input type="text" id="option_text" class="input" name="option_text[]" readonly value="">
                    </div>
                    <div class="button-group" style="grid-column: 1/3;">
                        <a href="AllQuestionServlet" class="button-secondary" style="width: 100%; text-align: center;">Back to Question Page</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>