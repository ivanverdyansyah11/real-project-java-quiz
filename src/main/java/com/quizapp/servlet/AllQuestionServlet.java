package com.quizapp.servlet;

import com.quizapp.dao.QuestionDAO;
import com.quizapp.model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/AllQuestionServlet")
public class AllQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String loggedIn = (String) session.getAttribute("loggedIn");
        if (loggedIn == null || !"admin".equals(loggedIn)) {
            response.sendRedirect("login-admin.jsp");
            return;
        }

        QuestionDAO questionDAO = new QuestionDAO();
        List<Question> questions;

        String search = request.getParameter("search");
        if (search != null && !search.trim().isEmpty()) {
            questions = questionDAO.searchQuestions(search);
            request.setAttribute("search", search);
        } else {
            questions = questionDAO.getAllQuestions();
        }

        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }

        request.setAttribute("questions", questions);
        request.getRequestDispatcher("all-question.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}