package com.carsales.util;

import com.carsales.model.Car;

public class MergeSort {
    public static Car[] sort(Car[] cars) {
        if (cars.length <= 1) return cars;
        int mid = cars.length / 2;
        Car[] left = new Car[mid];
        Car[] right = new Car[cars.length - mid];
        System.arraycopy(cars, 0, left, 0, mid);
        System.arraycopy(cars, mid, right, 0, cars.length - mid);
        left = sort(left);
        right = sort(right);
        return merge(left, right);
    }

    private static Car[] merge(Car[] left, Car[] right) {
        Car[] result = new Car[left.length + right.length];
        int i = 0, j = 0, k = 0;
        while (i < left.length && j < right.length) {
            if (left[i].getPrice() <= right[j].getPrice()) {
                result[k++] = left[i++];
            } else {
                result[k++] = right[j++];
            }
        }
        while (i < left.length) {
            result[k++] = left[i++];
        }
        while (j < right.length) {
            result[k++] = right[j++];
        }
        return result;
    }
}