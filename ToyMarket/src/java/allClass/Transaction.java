/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package allClass;

/**
 *
 * @author PuiWa
 */
public class Transaction {
    private String transactID;
    private ShoppingCart cart;
    private String date;
    
    public Transaction() {
        transactID = null;
        cart = null;
        date = null;
    }

    public String getTransactID() {
        return transactID;
    }

    public void setTransactID(String transactID) {
        this.transactID = transactID;
    }

    public ShoppingCart getCart() {
        return cart;
    }

    public void setCart(ShoppingCart cart) {
        this.cart = cart;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
