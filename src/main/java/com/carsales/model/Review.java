package com.carsales.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Review {
    private int id;
    private int carId;
    private String userEmail;
    private String userName;
    private int rating;
    private String comment;
    private Date reviewDate;

    public Review() {
        this.reviewDate = new Date();
    }

    public Review(int id, int carId, String userEmail, String userName, int rating, String comment) {
        this.id = id;
        this.carId = carId;
        this.userEmail = userEmail;
        this.userName = userName;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = new Date();
    }

    public Review(int id, int carId, String userEmail, String userName, int rating, String comment, Date reviewDate) {
        this.id = id;
        this.carId = carId;
        this.userEmail = userEmail;
        this.userName = userName;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getFormattedDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
        return formatter.format(reviewDate);
    }
}