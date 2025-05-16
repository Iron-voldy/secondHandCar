package com.carsales.util;

import com.carsales.model.Car;

/**
 * A custom linked list implementation to store Car objects.
 * This class provides basic operations for a car inventory management system.
 */
public class CarLinkedList {
    private CarNode head;
    private int size;

    /**
     * Initializes an empty car linked list.
     */
    public CarLinkedList() {
        this.head = null;
        this.size = 0;
    }

    /**
     * Adds a car to the end of the linked list.
     * @param car The car to be added
     */
    public void addCar(Car car) {
        CarNode newNode = new CarNode(car);
        if (head == null) {
            head = newNode;
        } else {
            CarNode current = head;
            while (current.getNext() != null) {
                current = current.getNext();
            }
            current.setNext(newNode);
        }
        size++;
    }

    /**
     * Removes a car with the specified ID from the linked list.
     * @param id The ID of the car to be removed
     * @return true if car was found and removed, false otherwise
     */
    public boolean removeCar(int id) {
        if (head == null) return false;

        if (head.getCar().getId() == id) {
            head = head.getNext();
            size--;
            return true;
        }

        CarNode current = head;
        while (current.getNext() != null) {
            if (current.getNext().getCar().getId() == id) {
                current.setNext(current.getNext().getNext());
                size--;
                return true;
            }
            current = current.getNext();
        }
        return false;
    }

    /**
     * Finds a car with the specified ID in the linked list.
     * @param id The ID of the car to find
     * @return The car if found, null otherwise
     */
    public Car findCar(int id) {
        CarNode current = head;
        while (current != null) {
            if (current.getCar().getId() == id) {
                return current.getCar();
            }
            current = current.getNext();
        }
        return null;
    }

    /**
     * Searches for cars that match a specific make or model (case insensitive).
     * @param keyword The search keyword
     * @return Array of matching cars
     */
    public Car[] searchCars(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return toArray();
        }

        keyword = keyword.toLowerCase();
        int count = 0;
        CarNode current = head;

        // First pass: count matching cars
        while (current != null) {
            Car car = current.getCar();
            if (car.getMake().toLowerCase().contains(keyword) ||
                    car.getModel().toLowerCase().contains(keyword)) {
                count++;
            }
            current = current.getNext();
        }

        // Second pass: populate result array
        Car[] result = new Car[count];
        current = head;
        int index = 0;

        while (current != null && index < count) {
            Car car = current.getCar();
            if (car.getMake().toLowerCase().contains(keyword) ||
                    car.getModel().toLowerCase().contains(keyword)) {
                result[index++] = car;
            }
            current = current.getNext();
        }

        return result;
    }

    /**
     * Returns the number of cars in the linked list.
     * @return The size of the linked list
     */
    public int size() {
        return size;
    }

    /**
     * Converts the linked list to an array of Cars.
     * @return Array containing all cars in the linked list
     */
    public Car[] toArray() {
        Car[] cars = new Car[size];
        CarNode current = head;
        int index = 0;

        while (current != null) {
            cars[index++] = current.getCar();
            current = current.getNext();
        }

        return cars;
    }
}