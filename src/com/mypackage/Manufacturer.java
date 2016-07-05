package com.mypackage;

/**
 * Created by Son on 5/27/2015.
 */
public class Manufacturer {
    private int manId;
    private String manName;

    public Manufacturer() {
    }

    public Manufacturer(int manId, String manName) {
        this.manId = manId;
        this.manName = manName;
    }

    public Manufacturer(String manName) {
        this.manName = manName;
    }

    public int getManId() {
        return manId;
    }

    public void setManId(int manId) {
        this.manId = manId;
    }

    public String getManName() {
        return manName;
    }

    public void setManName(String manName) {
        this.manName = manName;
    }
}
