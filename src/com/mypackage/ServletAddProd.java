package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ServletAddProd extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("update_model").trim();
        String priceStr = request.getParameter("update_price").trim();
        String catStr = request.getParameter("update_category").trim();
        String manStr = request.getParameter("update_manufacturer").trim();
        String proc = request.getParameter("update_processor").trim();
        String ramStr = request.getParameter("update_ram").trim();
        String scrStr = request.getParameter("update_screen").trim();
        String hddStr = request.getParameter("update_hdd").trim();
        String pic = request.getParameter("update_picture").trim();
        pic = pic.replaceAll("[^a-zA-Z0-9.-]", "_");

        System.out.println(catStr + "----" + manStr + "----" + name + "----" + proc + "----" + ramStr + "----" + scrStr + "----" + hddStr + "----" + pic + "----1--" + priceStr);

        int ram = 0;
        if (ramStr.length() > 0 && Integer.parseInt(ramStr) > 0) {
            ram = Integer.parseInt(ramStr);
        }
        System.out.println(ram);

        int hdd = 0;
        if (hddStr.length() > 0 && Integer.parseInt(hddStr) > 0) {
            hdd = Integer.parseInt(hddStr);
        }
        System.out.println(hdd);

        int cat = 0;
        if (catStr.length() > 0 && Integer.parseInt(catStr) > 0) {
            cat = Integer.parseInt(catStr);
        }
        System.out.println(cat);

        int man = 0;
        if (manStr.length() > 0 && Integer.parseInt(manStr) > 0) {
            man = Integer.parseInt(manStr);
        }
        System.out.println(man);

        double screen = 0.0;
        if (scrStr.length() > 0 && Double.parseDouble(scrStr) > 0) {
            screen = Double.parseDouble(scrStr);
        }
        System.out.println(screen);

        double price = 0;
        if (priceStr.length() > 0 && Double.parseDouble(priceStr) > 0) {
            price = Double.parseDouble(priceStr);
        }
        System.out.println(price);

        //update product info
        int insertedSku = 0;

        if (ram * hdd * cat * man * screen * price != 0 && !proc.equals("") && !name.equals("")) {
            try {
                Product p = new Product();

                p.setSku(0);
                p.setCatId(cat);
                p.setManId(man);
                p.setName(name);
                p.setProcessor(proc);
                p.setRam(ram);
                p.setHdd(hdd);
                p.setPicture(pic);
                p.setUnitPrice(price);
                p.setScreen(screen);

                insertedSku = ProductDao.insert(p);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (NamingException e) {
                e.printStackTrace();
            }
        }

        String json = new Gson().toJson(insertedSku);
        response.getWriter().write(json);
    }
}

