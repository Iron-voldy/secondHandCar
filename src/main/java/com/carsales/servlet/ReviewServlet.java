package com.carsales.servlet;

import com.carsales.model.Car;
import com.carsales.model.Review;
import com.carsales.util.ReviewLinkedList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/reviews", "/reviews/*"})
public class ReviewServlet extends HttpServlet {
    private ReviewLinkedList reviewList = new ReviewLinkedList();
    private int nextId = 1;

    @Override
    public void init() throws ServletException {
        loadReviewsFromFile();
        getServletContext().setAttribute("ReviewServlet", this);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        if (pathInfo.equals("/") || pathInfo.equals("/list")) {
            listAllReviews(request, response);
        } else if (pathInfo.startsWith("/car/")) {
            try {
                int carId = Integer.parseInt(pathInfo.substring(5));
                listReviewsForCar(carId, request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID");
            }
        } else if (pathInfo.startsWith("/add/")) {
            try {
                int carId = Integer.parseInt(pathInfo.substring(5));
                showAddForm(carId, request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID");
            }
        } else if (pathInfo.startsWith("/edit/")) {
            try {
                int reviewId = Integer.parseInt(pathInfo.substring(6));
                showEditForm(reviewId, request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review ID");
            }
        } else if (pathInfo.startsWith("/delete/")) {
            try {
                int reviewId = Integer.parseInt(pathInfo.substring(8));
                deleteReview(reviewId, request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        if (pathInfo.startsWith("/add")) {
            addReview(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            updateReview(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listAllReviews(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Review[] reviews = reviewList.getAllReviews();
        request.setAttribute("reviews", reviews);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/review/list.jsp");
        dispatcher.forward(request, response);
    }

    private void listReviewsForCar(int carId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Review> reviews = reviewList.getReviewsForCar(carId);
        double averageRating = reviewList.getAverageRatingForCar(carId);

        // Get car details from CarServlet
        CarServlet carServlet = (CarServlet) getServletContext().getAttribute("CarServlet");
        Car car = null;
        if (carServlet != null) {
            car = carServlet.getCarDetails(carId);
        }

        request.setAttribute("car", car);
        request.setAttribute("reviews", reviews);
        request.setAttribute("averageRating", averageRating);
        request.setAttribute("carId", carId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/review/car_reviews.jsp");
        dispatcher.forward(request, response);
    }

    private void showAddForm(int carId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get car details from CarServlet
        CarServlet carServlet = (CarServlet) getServletContext().getAttribute("CarServlet");
        Car car = null;
        if (carServlet != null) {
            car = carServlet.getCarDetails(carId);
        }

        request.setAttribute("car", car);
        request.setAttribute("carId", carId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/review/add.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(int reviewId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Review review = reviewList.findReview(reviewId);
        if (review != null) {
            // Get car details from CarServlet
            CarServlet carServlet = (CarServlet) getServletContext().getAttribute("CarServlet");
            Car car = null;
            if (carServlet != null) {
                car = carServlet.getCarDetails(review.getCarId());
            }

            request.setAttribute("car", car);
            request.setAttribute("review", review);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/review/edit.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Review not found");
        }
    }

    private void addReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review review = new Review(nextId++, carId, userEmail, userName, rating, comment);
        reviewList.addReview(review);
        saveReviewsToFile();

        // Set success message
        request.getSession().setAttribute("message", "Review successfully added!");
        request.getSession().setAttribute("messageType", "success");

        response.sendRedirect(request.getContextPath() + "/reviews/car/" + carId);
    }

    private void updateReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));
        int carId = Integer.parseInt(request.getParameter("carId"));
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review existingReview = reviewList.findReview(reviewId);
        if (existingReview != null) {
            Review updatedReview = new Review(reviewId, carId, userEmail, userName, rating, comment, existingReview.getReviewDate());
            boolean updated = reviewList.updateReview(updatedReview);

            if (updated) {
                saveReviewsToFile();
                request.getSession().setAttribute("message", "Review successfully updated!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Failed to update review!");
                request.getSession().setAttribute("messageType", "danger");
            }

            response.sendRedirect(request.getContextPath() + "/reviews/car/" + carId);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Review not found");
        }
    }

    private void deleteReview(int reviewId, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Review review = reviewList.findReview(reviewId);
        int carId = -1;

        if (review != null) {
            carId = review.getCarId();
        }

        boolean removed = reviewList.removeReview(reviewId);
        if (removed) {
            saveReviewsToFile();
            request.getSession().setAttribute("message", "Review successfully deleted!");
            request.getSession().setAttribute("messageType", "success");
        } else {
            request.getSession().setAttribute("message", "Review not found!");
            request.getSession().setAttribute("messageType", "danger");
        }

        if (carId != -1) {
            response.sendRedirect(request.getContextPath() + "/reviews/car/" + carId);
        } else {
            response.sendRedirect(request.getContextPath() + "/reviews");
        }
    }

    private void loadReviewsFromFile() {
        File dataDir = new File(getServletContext().getRealPath("/WEB-INF/data"));
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        File reviewsFile = new File(dataDir, "reviews.txt");
        if (!reviewsFile.exists()) {
            return; // Start with empty list if file doesn't exist
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(reviewsFile))) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6) {
                    try {
                        int id = Integer.parseInt(parts[0]);
                        int carId = Integer.parseInt(parts[1]);
                        String userEmail = parts[2];
                        String userName = parts[3];
                        int rating = Integer.parseInt(parts[4]);
                        String comment = parts[5];
                        Date reviewDate = parts.length > 6 ? dateFormat.parse(parts[6]) : new Date();

                        Review review = new Review(id, carId, userEmail, userName, rating, comment, reviewDate);
                        reviewList.addReview(review);
                        if (id >= nextId) {
                            nextId = id + 1;
                        }
                    } catch (NumberFormatException | ParseException e) {
                        // Skip malformed records
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            // Start with empty list if there's an error
        }
    }

    private void saveReviewsToFile() {
        File dataDir = new File(getServletContext().getRealPath("/WEB-INF/data"));
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        try (PrintWriter writer = new PrintWriter(new FileWriter(new File(dataDir, "reviews.txt")))) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Review[] reviews = reviewList.getAllReviews();
            for (Review review : reviews) {
                writer.println(review.getId() + "|" +
                        review.getCarId() + "|" +
                        review.getUserEmail() + "|" +
                        review.getUserName() + "|" +
                        review.getRating() + "|" +
                        review.getComment() + "|" +
                        dateFormat.format(review.getReviewDate()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Method to be accessed by other servlets
    public double getAverageRatingForCar(int carId) {
        return reviewList.getAverageRatingForCar(carId);
    }

    public List<Review> getReviewsForCar(int carId) {
        return reviewList.getReviewsForCar(carId);
    }
}