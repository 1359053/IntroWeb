package com.mypackage;

import java.sql.Timestamp;

/**
 * Created by Son on 5/23/2015.
 */
public class ViewTracking {
    private int sku;
    private int totalViews;
    private Timestamp lastView;
    private String lastUserId;

    public ViewTracking() {
    }

    public ViewTracking(int sku, int totalViews, Timestamp lastView, String lastUserId) {
        this.sku = sku;
        this.totalViews = totalViews;
        this.lastView = lastView;
        this.lastUserId = lastUserId;
    }

    public int getSku() {
        return sku;
    }

    public void setSku(int sku) {
        this.sku = sku;
    }

    public int getTotalViews() {
        return totalViews;
    }

    public void setTotalViews(int totalViews) {
        this.totalViews = totalViews;
    }

    public Timestamp getLastView() {
        return lastView;
    }

    public void setLastView(Timestamp lastView) {
        this.lastView = lastView;
    }

    public String getLastUserId() {
        return lastUserId;
    }

    public void setLastUserId(String lastUserId) {
        this.lastUserId = lastUserId;
    }
}
