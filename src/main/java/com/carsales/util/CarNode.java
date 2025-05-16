package com.carsales.util;

import com.carsales.model.Car;

public class CarNode {
    private Car car;
    private CarNode next;

    public CarNode(Car car) {
        this.car = car;
        this.next = null;
    }

    public Car getCar() { return car; }
    public void setCar(Car car) { this.car = car; }
    public CarNode getNext() { return next; }
    public void setNext(CarNode next) { this.next = next; }
}