package com.mypackage;

public class Detail {
    private int idCart;
    private int sku;
    private int quantity;

    public Detail() {
    }

    public Detail(int idCart, int sku, int quantity) {
        this.idCart = idCart;
        this.sku = sku;
        this.quantity = quantity;
    }

    public int getIdCart() {
        return idCart;
    }

    public void setIdCart(int idCart) {
        this.idCart = idCart;
    }

    public int getSku() {
        return sku;
    }

    public void setSku(int sku) {
        this.sku = sku;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
