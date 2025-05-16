package com.carsales.util;

import com.carsales.model.Review;

public class ReviewNode {
    private Review review;
    private ReviewNode next;

    public ReviewNode(Review review) {
        this.review = review;
        this.next = null;
    }

    public Review getReview() {
        return review;
    }

    public void setReview(Review review) {
        this.review = review;
    }

    public ReviewNode getNext() {
        return next;
    }

    public void setNext(ReviewNode next) {
        this.next = next;
    }
}