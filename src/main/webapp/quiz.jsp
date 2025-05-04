<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.quizapp.model.Question" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Quiz App - Quiz</title>
            </head>

            <body>
                <% if (session.getAttribute("loggedIn")==null || !(boolean) session.getAttribute("loggedIn")) {
                    response.sendRedirect("login.jsp"); return; } List<Question> questions = (List<Question>)
                        session.getAttribute("questions");
                        int currentIndex = (int) session.getAttribute("currentQuestionIndex");
                        Question currentQuestion = questions.get(currentIndex);
                        %>

                        <h1>Quiz</h1>

                        <div>
                            <h2>Question <%= currentIndex + 1 %> of <%= questions.size() %>
                            </h2>
                            <p>
                                <%= currentQuestion.getQuestionText() %>
                            </p>

                            <form action="answer" method="post">
                                <% for (Question.Option option : currentQuestion.getOptions()) { %>
                                    <div>
                                        <input type="radio" id="option<%= option.getLabel() %>" name="option"
                                            value="<%= getOptionValue(option.getLabel()) %>" required>
                                        <label for="option<%= option.getLabel() %>">
                                            <%= option.getLabel() %>: <%= option.getText() %>
                                        </label>
                                    </div>
                                    <% } %>
                                        <button type="submit">Submit Answer</button>
                            </form>
                        </div>

                        <%! private int getOptionValue(String label) { switch(label) { case "A" : return 1; case "B" :
                            return 2; case "C" : return 3; case "D" : return 4; default: return 0; } } %>
            </body>

            </html>