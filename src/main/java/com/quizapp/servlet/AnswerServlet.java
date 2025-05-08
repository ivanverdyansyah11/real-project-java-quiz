package com.quizapp.servlet;

import com.quizapp.dao.ScoreDAO;
import com.quizapp.model.Question;
import com.quizapp.model.Score;
import com.quizapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/answer")
public class AnswerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String loggedIn = (String) session.getAttribute("loggedIn");
        if (loggedIn == null || !"user".equals(loggedIn)) {
            response.sendRedirect("login-user.jsp");
            return;
        }

        try {
            List<Question> questions = (List<Question>) session.getAttribute("questions");
            int currentIndex = (int) session.getAttribute("currentQuestionIndex");
            Question currentQuestion = questions.get(currentIndex);

            String selectedOption = request.getParameter("option");
            String correctAnswer = currentQuestion.getCorrectAnswer();

            int quizScore = (int) session.getAttribute("quizScore");
            if (selectedOption != null && selectedOption.equalsIgnoreCase(correctAnswer)) {
                quizScore += 10;
                session.setAttribute("quizScore", quizScore);
            }

            currentIndex++;
            if (currentIndex < questions.size()) {
                session.setAttribute("currentQuestionIndex", currentIndex);
                response.sendRedirect("quiz.jsp");
            } else {
                User user = (User) session.getAttribute("user");
                int finalQuizScore = (int) session.getAttribute("quizScore");

                Score score = new Score(user.getId(), finalQuizScore, new Date());
                ScoreDAO scoreDAO = new ScoreDAO();
                scoreDAO.saveScore(score);

                session.setAttribute("finalQuizScore", finalQuizScore);

                response.sendRedirect("result.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Error processing answer");
        }
    }
}
