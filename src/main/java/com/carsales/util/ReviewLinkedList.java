package com.carsales.util;

import com.carsales.model.Review;

import java.util.ArrayList;
import java.util.List;

/**
 * A custom linked list implementation to store Review objects.
 * This class provides CRUD operations for reviews.
 */
public class ReviewLinkedList {
    private ReviewNode head;
    private int size;

    /**
     * Initializes an empty review linked list.
     */
    public ReviewLinkedList() {
        this.head = null;
        this.size = 0;
    }

    /**
     * Adds a review to the end of the linked list.
     * @param review The review to be added
     */
    public void addReview(Review review) {
        ReviewNode newNode = new ReviewNode(review);
        if (head == null) {
            head = newNode;
        } else {
            ReviewNode current = head;
            while (current.getNext() != null) {
                current = current.getNext();
            }
            current.setNext(newNode);
        }
        size++;
    }

    /**
     * Removes a review with the specified ID from the linked list.
     * @param id The ID of the review to be removed
     * @return true if review was found and removed, false otherwise
     */
    public boolean removeReview(int id) {
        if (head == null) return false;

        if (head.getReview().getId() == id) {
            head = head.getNext();
            size--;
            return true;
        }

        ReviewNode current = head;
        while (current.getNext() != null) {
            if (current.getNext().getReview().getId() == id) {
                current.setNext(current.getNext().getNext());
                size--;
                return true;
            }
            current = current.getNext();
        }
        return false;
    }

    /**
     * Updates an existing review.
     * @param updatedReview The updated review object
     * @return true if the review was found and updated, false otherwise
     */
    public boolean updateReview(Review updatedReview) {
        ReviewNode current = head;
        while (current != null) {
            if (current.getReview().getId() == updatedReview.getId()) {
                current.setReview(updatedReview);
                return true;
            }
            current = current.getNext();
        }
        return false;
    }

    /**
     * Finds a review with the specified ID in the linked list.
     * @param id The ID of the review to find
     * @return The review if found, null otherwise
     */
    public Review findReview(int id) {
        ReviewNode current = head;
        while (current != null) {
            if (current.getReview().getId() == id) {
                return current.getReview();
            }
            current = current.getNext();
        }
        return null;
    }

    /**
     * Gets all reviews for a specific car.
     * @param carId The ID of the car
     * @return List of reviews for the specified car
     */
    public List<Review> getReviewsForCar(int carId) {
        List<Review> carReviews = new ArrayList<>();
        ReviewNode current = head;

        while (current != null) {
            if (current.getReview().getCarId() == carId) {
                carReviews.add(current.getReview());
            }
            current = current.getNext();
        }

        return carReviews;
    }

    /**
     * Gets all reviews in the linked list.
     * @return Array of all reviews
     */
    public Review[] getAllReviews() {
        return toArray();
    }

    /**
     * Returns the average rating for a specific car.
     * @param carId The ID of the car
     * @return The average rating or 0 if no reviews exist
     */
    public double getAverageRatingForCar(int carId) {
        List<Review> carReviews = getReviewsForCar(carId);
        if (carReviews.isEmpty()) {
            return 0;
        }

        int sum = 0;
        for (Review review : carReviews) {
            sum += review.getRating();
        }

        return (double) sum / carReviews.size();
    }

    /**
     * Returns the number of reviews in the linked list.
     * @return The size of the linked list
     */
    public int size() {
        return size;
    }

    /**
     * Converts the linked list to an array of Reviews.
     * @return Array containing all reviews in the linked list
     */
    public Review[] toArray() {
        Review[] reviews = new Review[size];
        ReviewNode current = head;
        int index = 0;

        while (current != null) {
            reviews[index++] = current.getReview();
            current = current.getNext();
        }

        return reviews;
    }
}