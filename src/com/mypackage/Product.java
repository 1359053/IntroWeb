package com.mypackage;
// Data transfer object

public class Product {
    private int sku;
    private int catId;
    private String name;
    private int manId;
    private String processor;
    private int ram;
    private double screen;
    private int hdd;
    private String picture;
    private double unitPrice;

    public Product() {
    }

    public Product(int sku, int catId, String name, int manId, String processor, int ram, double screen, int hdd, String picture, double unitPrice) {
        if (sku >= 0) {
            this.sku = sku;
        }
        this.name = name;
        if (manId >= 0) {
            this.manId = manId;
        }
        if (catId >= 0) {
            this.catId = catId;
        }
        this.processor = processor;
        this.ram = ram;
        this.screen = screen;
        this.hdd = hdd;
        this.picture = picture;
        if (unitPrice >= 0) {
            this.unitPrice = unitPrice;
        }
    }

    public Product(int sku, int catId, int manId, String name) {
        if (sku >= 0) {
            this.sku = sku;
        }
        this.name = name;
        if (manId >= 0) {
            this.manId = manId;
        }
        if (catId >= 0) {
            this.catId = catId;
        }
    }

    //for testing
    public Product(int sku, String name) {
        if (sku >= 0) {
            this.sku = sku;
        }
        this.name = name;
    }

    //for testing
    public Product(String name) {
        this.name = name;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public int getHdd() {
        return hdd;
    }

    public void setHdd(int hdd) {
        this.hdd = hdd;
    }

    public double getScreen() {
        return screen;
    }

    public void setScreen(double screen) {
        this.screen = screen;
    }

    public int getRam() {
        return ram;
    }

    public void setRam(int ram) {
        this.ram = ram;
    }

    public String getProcessor() {
        return processor;
    }

    public void setProcessor(String processor) {
        this.processor = processor;
    }


    public int getSku() {
        return sku;
    }

    public void setSku(int sku) {
        if (sku >= 0) {
            this.sku = sku;
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getManId() {
        return manId;
    }

    public void setManId(int manId) {
        if (manId >= 0) {
            this.manId = manId;
        }
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        if (catId >= 0) {
            this.catId = catId;
        }
    }
}
