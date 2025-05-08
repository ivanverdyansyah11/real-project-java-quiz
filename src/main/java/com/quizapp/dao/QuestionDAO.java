package com.quizapp.dao;

import com.quizapp.model.Question;
import com.quizapp.util.DBConnection;

import java.sql.*;
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
            conn = DBConnection.getConnection();
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
                if (conn != null) DBConnection.closeConnection(conn);
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

    public boolean createQuestion(Question question, List<String> optionTexts) {
        Connection conn = null;
        PreparedStatement stmtQuestion = null;
        PreparedStatement stmtOption = null;
        ResultSet generatedKeys = null;
        boolean success = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String insertQuestionSql = "INSERT INTO questions (question_text, correct_answear) VALUES (?, ?)";
            stmtQuestion = conn.prepareStatement(insertQuestionSql, Statement.RETURN_GENERATED_KEYS);
            stmtQuestion.setString(1, question.getQuestionText());
            stmtQuestion.setString(2, question.getCorrectAnswer());
            int questionRowsAffected = stmtQuestion.executeUpdate();

            if (questionRowsAffected > 0) {
                generatedKeys = stmtQuestion.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int questionId = generatedKeys.getInt(1);

                    String insertOptionSql = "INSERT INTO quizzes (question_id, option_label, option_text) VALUES (?, ?, ?)";
                    stmtOption = conn.prepareStatement(insertOptionSql);

                    String[] labels = {"A", "B", "C", "D"};
                    for (int i = 0; i < Math.min(labels.length, optionTexts.size()); i++) {
                        stmtOption.setInt(1, questionId);
                        stmtOption.setString(2, labels[i]);
                        stmtOption.setString(3, optionTexts.get(i));
                        stmtOption.addBatch();
                    }

                    int[] optionRowsAffected = stmtOption.executeBatch();
                    success = optionRowsAffected.length == Math.min(labels.length, optionTexts.size());
                }
            }

            if (success) {
                conn.commit();
            } else {
                conn.rollback();
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (stmtOption != null) stmtOption.close();
                if (stmtQuestion != null) stmtQuestion.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    DBConnection.closeConnection(conn);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    public boolean updateQuestion(Question question, List<String> optionTexts) {
        Connection conn = null;
        PreparedStatement stmtQuestion = null;
        PreparedStatement stmtOption = null;
        boolean success = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String updateQuestionSql = "UPDATE questions SET question_text = ?, correct_answear = ? WHERE id = ?";
            stmtQuestion = conn.prepareStatement(updateQuestionSql);
            stmtQuestion.setString(1, question.getQuestionText());
            stmtQuestion.setString(2, question.getCorrectAnswer());
            stmtQuestion.setInt(3, question.getId());
            int questionRowsAffected = stmtQuestion.executeUpdate();

            if (questionRowsAffected > 0) {
                List<Integer> optionIds = new ArrayList<>();
                try (PreparedStatement stmtGetOptions = conn.prepareStatement("SELECT id FROM quizzes WHERE question_id = ? ORDER BY option_label")) {
                    stmtGetOptions.setInt(1, question.getId());
                    ResultSet rs = stmtGetOptions.executeQuery();
                    while (rs.next()) {
                        optionIds.add(rs.getInt("id"));
                    }
                }

                if (optionIds.size() == optionTexts.size()) {
                    String updateOptionSql = "UPDATE quizzes SET option_text = ? WHERE id = ?";
                    stmtOption = conn.prepareStatement(updateOptionSql);

                    for (int i = 0; i < optionIds.size(); i++) {
                        stmtOption.setString(1, optionTexts.get(i));
                        stmtOption.setInt(2, optionIds.get(i));
                        stmtOption.addBatch();
                    }

                    int[] optionRowsAffected = stmtOption.executeBatch();
                    success = optionRowsAffected.length == optionIds.size();
                }
            }

            if (success) {
                conn.commit();
            } else {
                conn.rollback();
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (stmtOption != null) stmtOption.close();
                if (stmtQuestion != null) stmtQuestion.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    DBConnection.closeConnection(conn);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    public boolean deleteQuestion(int questionId) {
        Connection conn = null;
        PreparedStatement stmtDeleteOptions = null;
        PreparedStatement stmtDeleteQuestion = null;
        boolean success = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String deleteOptionsSql = "DELETE FROM quizzes WHERE question_id = ?";
            stmtDeleteOptions = conn.prepareStatement(deleteOptionsSql);
            stmtDeleteOptions.setInt(1, questionId);
            stmtDeleteOptions.executeUpdate();

            String deleteQuestionSql = "DELETE FROM questions WHERE id = ?";
            stmtDeleteQuestion = conn.prepareStatement(deleteQuestionSql);
            stmtDeleteQuestion.setInt(1, questionId);
            int questionRowsAffected = stmtDeleteQuestion.executeUpdate();

            success = questionRowsAffected > 0;

            if (success) {
                conn.commit();
            } else {
                conn.rollback();
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (stmtDeleteOptions != null) stmtDeleteOptions.close();
                if (stmtDeleteQuestion != null) stmtDeleteQuestion.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    DBConnection.closeConnection(conn);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }
}