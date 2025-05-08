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
import java.util.Arrays;

@WebServlet("/EditQuestionServlet")
public class EditQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
            return;
        }

        try {
            int questionId = Integer.parseInt(idParam);
            QuestionDAO questionDAO = new QuestionDAO();
            Question question = questionDAO.getQuestionById(questionId);

            if (question == null) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Question not found!");
                response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
                return;
            }

            request.setAttribute("question", question);
            request.getRequestDispatcher("edit-question.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String idParam = request.getParameter("id");
        String questionText = request.getParameter("question_text");
        String correctAnswer = request.getParameter("correct_answear");
        String[] optionTexts = request.getParameterValues("option_text[]");

        // Basic validation
        if (idParam == null || idParam.trim().isEmpty() ||
                questionText == null || questionText.trim().isEmpty() ||
                correctAnswer == null || correctAnswer.trim().isEmpty() ||
                optionTexts == null || optionTexts.length != 4) {

            request.setAttribute("errorMessage", "Please fill in all fields. You must provide a question, correct answer, and 4 options.");

            if (idParam != null && !idParam.trim().isEmpty()) {
                try {
                    int questionId = Integer.parseInt(idParam);
                    QuestionDAO dao = new QuestionDAO();
                    Question question = dao.getQuestionById(questionId);
                    request.setAttribute("question", question);
                } catch (NumberFormatException e) {
                    // Ignore, will redirect below
                }
            }

            request.getRequestDispatcher("edit-question.jsp").forward(request, response);
            return;
        }

        try {
            int questionId = Integer.parseInt(idParam);

            // Create question object
            Question question = new Question();
            question.setId(questionId);
            question.setQuestionText(questionText);
            question.setCorrectAnswer(correctAnswer);

            // Update in database
            QuestionDAO questionDAO = new QuestionDAO();
            boolean success = questionDAO.updateQuestion(question, Arrays.asList(optionTexts));

            if (success) {
                // Set success message and redirect
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Question updated successfully!");
                response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
            } else {
                request.setAttribute("errorMessage", "Failed to update question. Please try again.");
                Question originalQuestion = questionDAO.getQuestionById(questionId);
                request.setAttribute("question", originalQuestion);
                request.getRequestDispatcher("edit-question.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
        }
    }
}