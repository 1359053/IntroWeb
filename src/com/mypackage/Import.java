package com.mypackage;

import java.sql.Timestamp;

/**
 * Created by Son on 5/20/2015.
 */
public class Import {
    private int sku;
    private Timestamp importDateTime;
    private int quantity;
    private double unitPrice;

    public Import() {
    }

    public Import(int sku, Timestamp importDateTime, int quantity, double unitPrice) {
        this.sku = sku;
        this.importDateTime = importDateTime;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getSku() {
        return sku;
    }

    public void setSku(int sku) {
        this.sku = sku;
    }

    public Timestamp getImportDateTime() {
        return importDateTime;
    }

    public void setImportDateTime(Timestamp importDateTime) {
        this.importDateTime = importDateTime;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity >= 0) {
            this.quantity = quantity;
        }
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        if (unitPrice >= 0) {
            this.unitPrice = unitPrice;
        }
    }
}
