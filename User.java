package com.mypackage;

public class User {
    private String id;
    private String password;
    private String name;
    private String address;
    private String phone;
    private String role;

    public User() {
    }

    public User(String id, String password, String name, String address, String phone, String role) {
        if (!id.equals("")) {
            this.id = id;
        }
        if (!password.equals("")) {
            this.password = password;
        }
        this.name = name;
        this.address = address;
        this.phone = phone;
        if (role.equals("admin") || role.equals("user")) {
            this.role = role;
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        if (!id.equals("")) {
            this.id = id;
        }
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        if (!password.equals("")) {
            this.password = password;
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        if (role.equals("admin") || role.equals("user")) {
            this.role = role;
        }
    }
}
