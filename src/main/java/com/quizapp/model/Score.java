package com.quizapp.model;

import java.util.Date;

public class Score {
    private int id;
    private int userId;
    private int score;
    private Date dateTaken;

    public Score() {
    }

    public Score(int userId, int score, Date dateTaken) {
        this.userId = userId;
        this.score = score;
        this.dateTaken = dateTaken;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Date getDateTaken() {
        return dateTaken;
    }

    public void setDateTaken(Date dateTaken) {
        this.dateTaken = dateTaken;
    }
}