package com.quizapp.dao;

import com.quizapp.model.Question;
import com.quizapp.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class QuestionDAO {

    public List<Question> searchQuestions(String keyword) {
        List<Question> questions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM questions WHERE id LIKE ? OR question_text LIKE ?";
            stmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Question question = new Question();
                question.setId(rs.getInt("id"));
                question.setQuestionText(rs.getString("question_text"));
                question.setCorrectAnswer(rs.getString("correct_answear"));
                questions.add(question);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) DBUtil.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return questions;
    }

    public List<Question> getAllQuestions() {
        List<Question> questions = new ArrayList<>();
        String queryQuestions = "SELECT * FROM questions";
        String queryOptions = "SELECT * FROM quizzes WHERE question_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmtQuestions = conn.prepareStatement(queryQuestions)) {

            ResultSet rsQuestions = stmtQuestions.executeQuery();

            while (rsQuestions.next()) {
                Question question = new Question();
                question.setId(rsQuestions.getInt("id"));
                question.setQuestionText(rsQuestions.getString("question_text"));
                question.setCorrectAnswer(rsQuestions.getString("correct_answear"));

                try (PreparedStatement stmtOptions = conn.prepareStatement(queryOptions)) {
                    stmtOptions.setInt(1, question.getId());
                    ResultSet rsOptions = stmtOptions.executeQuery();

                    while (rsOptions.next()) {
                        Question.Option option = new Question.Option();
                        option.setId(rsOptions.getInt("id"));
                        option.setLabel(rsOptions.getString("option_label"));
                        option.setText(rsOptions.getString("option_text"));
                        question.addOption(option);
                    }
                }

                questions.add(question);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return questions;
    }

    public List<Question> getRandomQuestions(int count) {
        List<Question> allQuestions = getAllQuestions();
        Collections.shuffle(allQuestions);
        return allQuestions.size() <= count ? allQuestions : allQuestions.subList(0, count);
    }

    public Question getQuestionById(int questionId) {
        Question question = null;
        String queryQuestion = "SELECT * FROM questions WHERE id = ?";
        String queryOptions = "SELECT * FROM quizzes WHERE question_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmtQuestion = conn.prepareStatement(queryQuestion)) {

            stmtQuestion.setInt(1, questionId);
            ResultSet rsQuestion = stmtQuestion.executeQuery();

            if (rsQuestion.next()) {
                question = new Question();
                question.setId(rsQuestion.getInt("id"));
                question.setQuestionText(rsQuestion.getString("question_text"));
                question.setCorrectAnswer(rsQuestion.getString("correct_answear"));

                try (PreparedStatement stmtOptions = conn.prepareStatement(queryOptions)) {
                    stmtOptions.setInt(1, question.getId());
                    ResultSet rsOptions = stmtOptions.executeQuery();

                    while (rsOptions.next()) {
                        Question.Option option = new Question.Option();
                        option.setId(rsOptions.getInt("id"));
                        option.setLabel(rsOptions.getString("option_label"));
                        option.setText(rsOptions.getString("option_text"));
                        question.addOption(option);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return question;
    }
}