package com.quizapp.servlet;

import com.quizapp.dao.QuestionDAO;
import com.quizapp.model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/CreateQuestionServlet")
public class CreateQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String loggedIn = (String) session.getAttribute("loggedIn");
        if (loggedIn == null || !"admin".equals(loggedIn)) {
            response.sendRedirect("login-admin.jsp");
            return;
        }

        request.getRequestDispatcher("create-question.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String questionText = request.getParameter("question_text");
        String correctAnswer = request.getParameter("correct_answear");
        String[] optionTexts = request.getParameterValues("option_text[]");

        if (questionText == null || questionText.trim().isEmpty() ||
                correctAnswer == null || correctAnswer.trim().isEmpty() ||
                optionTexts == null || optionTexts.length != 4) {

            request.setAttribute("errorMessage", "Please fill in all fields. You must provide a question, correct answer, and 4 options.");
            request.getRequestDispatcher("create-question.jsp").forward(request, response);
            return;
        }

        Question question = new Question();
        question.setQuestionText(questionText);
        question.setCorrectAnswer(correctAnswer);

        QuestionDAO questionDAO = new QuestionDAO();
        boolean success = questionDAO.createQuestion(question, Arrays.asList(optionTexts));

        if (success) {
            session.setAttribute("successMessage", "Question created successfully!");
            response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
        } else {
            request.setAttribute("errorMessage", "Failed to create question. Please try again.");
            request.getRequestDispatcher("create-question.jsp").forward(request, response);
        }
    }
}