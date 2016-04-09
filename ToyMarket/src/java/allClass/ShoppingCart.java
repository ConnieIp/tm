/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package allClass;

import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author PuiWa
 */
public class ShoppingCart {
    private double total;
    private int numOfItems;
    private HashMap<Toy,Integer> toys;

    public ShoppingCart() {
        this.total = 0;
        this.numOfItems = 0;
        this.toys = new HashMap<Toy,Integer>();
    }
    
    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getNumberOfItems() {
        return numOfItems;
    }

    public void setNumOfItems(int numOfItems) {
        this.numOfItems = numOfItems;
    }

    public HashMap<Toy,Integer> getToys() {
        return toys;
    }

    public void setToys(HashMap<Toy,Integer> toys) {
        this.toys = toys;
    }
}
