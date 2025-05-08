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

@WebServlet("/DetailQuestionServlet")
public class DetailQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String loggedIn = (String) session.getAttribute("loggedIn");
        if (loggedIn == null || !"admin".equals(loggedIn)) {
            response.sendRedirect("login-admin.jsp");
            return;
        }

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
                session.setAttribute("errorMessage", "Question not found!");
                response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
                return;
            }

            request.setAttribute("question", question);
            request.getRequestDispatcher("detail-question.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/AllQuestionServlet");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}