package com.carsales.servlet;

import com.carsales.model.Car;
import com.carsales.util.CarLinkedList;
import com.carsales.util.FileUtil;
import com.carsales.util.MergeSort;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.*;

@WebServlet(name = "CarServlet", urlPatterns = {"/cars", "/cars/*"})
public class CarServlet extends HttpServlet {
    private CarLinkedList carList = new CarLinkedList();
    private int nextId = 1;

    @Override
    public void init() throws ServletException {
        loadCarsFromFile();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            listCars(request, response);
        } else if (pathInfo.startsWith("/add")) {
            showAddForm(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            try {
                int id = Integer.parseInt(pathInfo.substring(6));
                showEditForm(id, request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID");
            }
        } else if (pathInfo.startsWith("/delete/")) {
            try {
                int id = Integer.parseInt(pathInfo.substring(8));
                deleteCar(id, request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID");
            }
        } else if (pathInfo.startsWith("/view/")) {
            try {
                int id = Integer.parseInt(pathInfo.substring(6));
                viewCar(id, request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID");
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
            addCar(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            updateCar(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Car[] carsArray = carList.toArray();
        carsArray = MergeSort.sort(carsArray);
        List<Car> cars = Arrays.asList(carsArray);
        request.setAttribute("cars", cars);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/car/list.jsp");
        dispatcher.forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/car/add.jsp");
        dispatcher.forward(request, response);
    }

    private void addCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                String make = null, model = null, yearStr = null, priceStr = null, description = null;
                String savePath = getServletContext().getRealPath("/images/cars");
                List<String> imageNames = FileUtil.saveUploadedFiles(items, savePath);
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        switch (item.getFieldName()) {
                            case "make": make = item.getString(); break;
                            case "model": model = item.getString(); break;
                            case "year": yearStr = item.getString(); break;
                            case "price": priceStr = item.getString(); break;
                            case "description": description = item.getString(); break;
                        }
                    }
                }
                int year = Integer.parseInt(yearStr);
                double price = Double.parseDouble(priceStr);
                String[] images = imageNames.toArray(new String[0]);
                Car car = new Car(nextId++, make, model, year, price, description, images);
                carList.addCar(car);
                saveCarsToFile();
                response.sendRedirect(request.getContextPath() + "/cars");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing upload: " + e.getMessage());
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Form must be multipart/form-data");
        }
    }

    private void showEditForm(int id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Car car = carList.findCar(id);
        if (car != null) {
            request.setAttribute("car", car);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/car/edit.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
        }
    }

    private void updateCar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                int id = 0;
                String make = null, model = null, yearStr = null, priceStr = null, description = null;
                String savePath = getServletContext().getRealPath("/images/cars");
                List<String> imageNames = FileUtil.saveUploadedFiles(items, savePath);
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        switch (item.getFieldName()) {
                            case "id": id = Integer.parseInt(item.getString()); break;
                            case "make": make = item.getString(); break;
                            case "model": model = item.getString(); break;
                            case "year": yearStr = item.getString(); break;
                            case "price": priceStr = item.getString(); break;
                            case "description": description = item.getString(); break;
                        }
                    }
                }
                Car car = carList.findCar(id);
                if (car != null) {
                    car.setMake(make);
                    car.setModel(model);
                    car.setYear(Integer.parseInt(yearStr));
                    car.setPrice(Double.parseDouble(priceStr));
                    car.setDescription(description);
                    if (!imageNames.isEmpty()) {
                        car.setImages(imageNames.toArray(new String[0]));
                    }
                    saveCarsToFile();
                    response.sendRedirect(request.getContextPath() + "/cars");
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing upload: " + e.getMessage());
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Form must be multipart/form-data");
        }
    }

    private void deleteCar(int id, HttpServletRequest request, HttpServletResponse response) throws IOException {
        carList.removeCar(id);
        saveCarsToFile();
        response.sendRedirect(request.getContextPath() + "/cars");
    }

    private void viewCar(int id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Car car = carList.findCar(id);
        if (car != null) {
            request.setAttribute("car", car);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/car/view.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
        }
    }

    private void loadCarsFromFile() {
        File dataDir = new File(getServletContext().getRealPath("/WEB-INF/data"));
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        File carsFile = new File(dataDir, "cars.txt");
        if (!carsFile.exists()) {
            return; // Start with empty list if file doesn't exist
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(carsFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    try {
                        int id = Integer.parseInt(parts[0]);
                        String make = parts[1];
                        String model = parts[2];
                        int year = Integer.parseInt(parts[3]);
                        double price = Double.parseDouble(parts[4]);
                        String description = parts[5];
                        String[] images = parts.length > 6 ? parts[6].split(";") : new String[0];
                        Car car = new Car(id, make, model, year, price, description, images);
                        carList.addCar(car);
                        if (id >= nextId) {
                            nextId = id + 1;
                        }
                    } catch (NumberFormatException e) {
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

    private void saveCarsToFile() {
        File dataDir = new File(getServletContext().getRealPath("/WEB-INF/data"));
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        try (PrintWriter writer = new PrintWriter(new FileWriter(new File(dataDir, "cars.txt")))) {
            Car[] cars = carList.toArray();
            for (Car car : cars) {
                writer.println(car.getId() + "," + car.getMake() + "," + car.getModel() + "," + car.getYear() + "," + car.getPrice() + "," + car.getDescription() + "," + String.join(";", car.getImages()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}