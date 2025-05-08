<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.quizapp.model.Question" %>
<%@ page import="java.util.List" %>
<%
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    String searchTerm = (String) request.getAttribute("search");
    String successMessage = (String) request.getAttribute("successMessage");
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
                    <a href="<%=request.getContextPath()%>/create-question" class="button-primary">Add New Question</a>
                </div>
                <% if (successMessage != null) { %>
                <p class="alert alert-success"><%= successMessage %></p>
                <% } %>

                <form action="<%=request.getContextPath()%>/AllQuestionServlet" method="GET" class="content-search">
                    <input type="search" class="input" name="search" placeholder="Search question..."
                           value="<%= (searchTerm != null) ? searchTerm : "" %>" style="width: 100%;">
                    <button type="submit" class="button-secondary">Search</button>
                </form>

                <table class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Question Text</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (questions == null || questions.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="3" style="text-align:center;">No questions found.</td>
                    </tr>
                    <%
                    } else {
                        for (Question question : questions) {
                    %>
                    <tr>
                        <td><%= question.getId() %></td>
                        <td><%= question.getQuestionText() %></td>
                        <td>
                            <div class="action-button">
                                <a href="<%=request.getContextPath()%>/detail-question?id=<%= question.getId() %>"
                                   class="button button-detail">
                                    <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                         alt="Detail Icon" class="icon">
                                </a>
                                <a href="<%=request.getContextPath()%>/edit-question?id=<%= question.getId() %>"
                                   class="button button-edit">
                                    <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                         alt="Edit Icon" class="icon">
                                </a>
                                <a href="<%=request.getContextPath()%>/delete-question?id=<%= question.getId() %>"
                                   class="button button-delete"
                                   onclick="return confirm('Are you sure want to delete this question?')">
                                    <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                         alt="Delete Icon" class="icon">
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>