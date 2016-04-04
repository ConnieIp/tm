/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shoppingcart;

/**
 *
 * @author PuiWa
 */
public class ShoppingCartOrderBean {
    private int userID;
    private int toyID;
    private float totalPrice;
    
    public ShoppingCartOrderBean() {
        this.userID = -1;
        this.toyID = -1;
        this.totalPrice = -1;
    }
    
    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    public float getTotalPrice() {
        return this.totalPrice;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public int getUserID() {
        return this.userID;
    }
    
    public void setToyID(int toyID) {
        this.toyID = toyID;
    }
    
    public int getToyID() {
        return this.toyID;
    }
}
