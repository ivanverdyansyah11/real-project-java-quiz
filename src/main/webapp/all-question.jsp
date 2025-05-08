<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
                <p class="alert alert-success">Lorem ipsum dolor sit amet.</p>
                <p class="alert alert-failed">Lorem ipsum dolor sit amet.</p>
                <form action="<%=request.getContextPath()%>/all-question" method="GET" class="content-search">
                    <input type="search" class="input" name="search" placeholder="Search question..."
                           value="${searchTerm}" style="width: 100%;">
                    <button type="submit" class="button-secondary">Search</button>
                </form>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Question Text</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="3" style="text-align:center;">No questions found.</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>What is the chemical symbol for water?</td>
                            <td>
                                <div class="action-button">
                                    <a href="<%=request.getContextPath()%>/detail-question?id=1"
                                       class="button button-detail">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                             alt="Detail Icon" class="icon">
                                    </a>
                                    <a href="<%=request.getContextPath()%>/edit-question?id=1"
                                       class="button button-edit">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                             alt="Edit Icon" class="icon">
                                    </a>
                                    <button type="button" class="button button-delete" onclick="confirm('Are you sure want to delete this question?')">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                             alt="Delete Icon" class="icon">
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>What is the chemical symbol for water?</td>
                            <td>
                                <div class="action-button">
                                    <a href="<%=request.getContextPath()%>/detail-question?id=1"
                                       class="button button-detail">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                             alt="Detail Icon" class="icon">
                                    </a>
                                    <a href="<%=request.getContextPath()%>/edit-question?id=1"
                                       class="button button-edit">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                             alt="Edit Icon" class="icon">
                                    </a>
                                    <button type="button" class="button button-delete" onclick="confirm('Are you sure want to delete this question?')">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                             alt="Delete Icon" class="icon">
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>What is the chemical symbol for water?</td>
                            <td>
                                <div class="action-button">
                                    <a href="<%=request.getContextPath()%>/detail-question?id=1"
                                       class="button button-detail">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                             alt="Detail Icon" class="icon">
                                    </a>
                                    <a href="<%=request.getContextPath()%>/edit-question?id=1"
                                       class="button button-edit">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                             alt="Edit Icon" class="icon">
                                    </a>
                                    <button type="button" class="button button-delete" onclick="confirm('Are you sure want to delete this question?')">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                             alt="Delete Icon" class="icon">
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>What is the chemical symbol for water?</td>
                            <td>
                                <div class="action-button">
                                    <a href="<%=request.getContextPath()%>/detail-question?id=1"
                                       class="button button-detail">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                             alt="Detail Icon" class="icon">
                                    </a>
                                    <a href="<%=request.getContextPath()%>/edit-question?id=1"
                                       class="button button-edit">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                             alt="Edit Icon" class="icon">
                                    </a>
                                    <button type="button" class="button button-delete" onclick="confirm('Are you sure want to delete this question?')">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                             alt="Delete Icon" class="icon">
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>What is the chemical symbol for water?</td>
                            <td>
                                <div class="action-button">
                                    <a href="<%=request.getContextPath()%>/detail-question?id=1"
                                       class="button button-detail">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                             alt="Detail Icon" class="icon">
                                    </a>
                                    <a href="<%=request.getContextPath()%>/edit-question?id=1"
                                       class="button button-edit">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                             alt="Edit Icon" class="icon">
                                    </a>
                                    <button type="button" class="button button-delete" onclick="confirm('Are you sure want to delete this question?')">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                             alt="Delete Icon" class="icon">
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>What is the chemical symbol for water?</td>
                            <td>
                                <div class="action-button">
                                    <a href="<%=request.getContextPath()%>/detail-question?id=1"
                                       class="button button-detail">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/detail.svg"
                                             alt="Detail Icon" class="icon">
                                    </a>
                                    <a href="<%=request.getContextPath()%>/edit-question?id=1"
                                       class="button button-edit">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/edit.svg"
                                             alt="Edit Icon" class="icon">
                                    </a>
                                    <button type="button" class="button button-delete" onclick="confirm('Are you sure want to delete this question?')">
                                        <img src="<%=request.getContextPath()%>/assets/image/icon/delete.svg"
                                             alt="Delete Icon" class="icon">
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>