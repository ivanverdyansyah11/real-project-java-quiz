package com.quizapp.servlet;

import com.quizapp.dao.QuestionDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        HttpSession session = request.getSession();

        if (idParam == null || idParam.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Invalid question ID!");
            response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
            return;
        }

        try {
            int questionId = Integer.parseInt(idParam);
            QuestionDAO questionDAO = new QuestionDAO();
            boolean success = questionDAO.deleteQuestion(questionId);

            if (success) {
                session.setAttribute("successMessage", "Question deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to delete question. Please try again.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid question ID!");
        }

        response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}