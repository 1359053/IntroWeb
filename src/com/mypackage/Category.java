package com.mypackage;

public class Category {
    private int catId;
    private String catName;

    public Category() {
    }

    public Category(int catId, String catName) {
        this.catName = catName;
        if (catId >= 0) {
            this.catId = catId;
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

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }
}
