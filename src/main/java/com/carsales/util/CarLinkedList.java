package com.carsales.util;

import com.carsales.model.Car;

public class CarLinkedList {
    private CarNode head;

    public CarLinkedList() {
        this.head = null;
    }

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
    }

    public void removeCar(int id) {
        if (head == null) return;
        if (head.getCar().getId() == id) {
            head = head.getNext();
            return;
        }
        CarNode current = head;
        while (current.getNext() != null) {
            if (current.getNext().getCar().getId() == id) {
                current.setNext(current.getNext().getNext());
                return;
            }
            current = current.getNext();
        }
    }

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

    public Car[] toArray() {
        int size = 0;
        CarNode current = head;
        while (current != null) {
            size++;
            current = current.getNext();
        }
        Car[] cars = new Car[size];
        current = head;
        int index = 0;
        while (current != null) {
            cars[index++] = current.getCar();
            current = current.getNext();
        }
        return cars;
    }
}