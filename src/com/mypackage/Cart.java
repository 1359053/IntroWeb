package com.mypackage;

import java.sql.Date;
import java.sql.Timestamp;

public class Cart {
    private int idCart;
    private String idCus;
    private String payStatus;
    private String delStatus;
    private String address;
    private String receiver;
    private Timestamp orderDateTime;
    private Timestamp delDatTime;
    private Timestamp payDateTime;
    private double totalPrice;
    private String phoneNumber;
    private String postcode;

    public Cart() {
    }

    public Timestamp getPayDateTime() {
        return payDateTime;
    }

    public void setPayDateTime(Timestamp payDateTime) {
        this.payDateTime = payDateTime;
    }

    public String getDelStatus() {
        return delStatus;
    }

    public void setDelStatus(String delStatus) {
        this.delStatus = delStatus;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getIdCart() {
        return idCart;
    }

    public void setIdCart(int idCart) {
        this.idCart = idCart;
    }

    public String getIdCus() {
        return idCus;
    }

    public void setIdCus(String idCus) {
        this.idCus = idCus;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public Timestamp getOrderDateTime() {
        return orderDateTime;
    }

    public void setOrderDateTime(Timestamp orderDateTime) {
        this.orderDateTime = orderDateTime;
    }

    public Timestamp getDelDatTime() {
        return delDatTime;
    }

    public void setDelDatTime(Timestamp delDatTime) {
        this.delDatTime = delDatTime;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

}
