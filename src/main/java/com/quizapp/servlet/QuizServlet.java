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
import java.util.List;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("loggedIn") == null || !(boolean) session.getAttribute("loggedIn")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> questions = questionDAO.getRandomQuestions(10);

            session.setAttribute("questions", questions);
            session.setAttribute("currentQuestionIndex", 0);
            session.setAttribute("quizScore", 0);

            response.sendRedirect("quiz.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Unable to load quiz questions");
        }
    }
}