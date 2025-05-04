package com.quizapp.dao;

import com.quizapp.model.Score;
import com.quizapp.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScoreDAO {

    public boolean saveScore(Score score) {
        String query = "INSERT INTO scores (user_id, score, date_taken) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, score.getUserId());
            stmt.setInt(2, score.getScore());
            stmt.setDate(3, new java.sql.Date(score.getDateTaken().getTime()));

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Score> getScoresByUserId(int userId) {
        List<Score> scores = new ArrayList<>();
        String query = "SELECT * FROM scores WHERE user_id = ? ORDER BY date_taken DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Score score = new Score();
                    score.setId(rs.getInt("id"));
                    score.setUserId(rs.getInt("user_id"));
                    score.setScore(rs.getInt("score"));
                    score.setDateTaken(new java.util.Date(rs.getDate("date_taken").getTime()));
                    scores.add(score);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return scores;
    }

    public int getTotalScoreByUserId(int userId) {
        String query = "SELECT SUM(score) as total_score FROM scores WHERE user_id = ?";
        int totalScore = 0;

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalScore = rs.getInt("total_score");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalScore;
    }
}