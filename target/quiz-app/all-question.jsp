<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quizapp.model.Question" %>
<%@ page import="java.util.List" %>
<%
    String loggedIn = (String) session.getAttribute("loggedIn");
    if (loggedIn == null || !"admin".equals(loggedIn)) {
        response.sendRedirect("login-admin.jsp");
        return;
    }

    List<Question> questions = (List<Question>) request.getAttribute("questions");
    String search = (String) request.getAttribute("search");
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>All Question Page | Program Quiz App</title>

    <%-- STYLE CSS --%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
    <%-- END STYLE CSS --%>
</head>
<body>
<div class="container container-content">
    <div class="content">
        <div class="content-header">
            <h4 class="header-title">All Questions</h4>
            <div class="button-group">
                <a href="CreateQuestionServlet" class="button-primary">Add New Question</a>
                <a href="logout" class="button-secondary" style="width: 100%; text-align: center;">Logout</a>
            </div>
        </div>
        <% if (request.getAttribute("successMessage") != null) { %>
        <p class="alert alert-success"><%= request.getAttribute("successMessage") %></p>
        <% } %>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="alert alert-failed"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <form action="AllQuestionServlet" method="get" class="content-search">
            <input type="search" class="input" name="search" placeholder="Search question..."
                   value="<%= search != null ? search : "" %>" style="width: 100%;">
            <button type="submit" class="button-secondary">Search</button>
        </form>
        <table class="table" style="display: inline-block;">
            <thead>
            <tr>
                <th>ID</th>
                <th>Question</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <% if (questions != null && !questions.isEmpty()) { %>
            <% for (Question s : questions) { %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getQuestionText() %></td>
                <td>
                    <div class="action-button">
                        <a href="DetailQuestionServlet?id=<%= s.getId() %>"
                           class="button button-detail">
                            <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                 alt="Detail Icon" class="icon">
                        </a>
                        <a href="EditQuestionServlet?id=<%= s.getId() %>"
                           class="button button-edit">
                            <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                 alt="Edit Icon" class="icon">
                        </a>
                        <a href="DeleteQuestionServlet?id=<%= s.getId() %>"
                           class="button button-delete"
                           onclick="return confirm('Are you sure want to delete this question?');">
                            <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                 alt="Delete Icon" class="icon">
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="3" style="text-align:center;">No questions found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>