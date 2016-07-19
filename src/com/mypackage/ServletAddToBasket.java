package com.mypackage;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ServletAddToBasket extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        //get sku of adding product from post request
        int addingSku = Integer.parseInt(request.getParameter("sku"));

        //get basket info from cookie
        Cookie[] cookies = request.getCookies();
        String[] temp = null;
        List<Integer> skus = new ArrayList<>();
        List<Integer> counts = new ArrayList<>();

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("skus")) {   //get SKUs
                    temp = c.getValue().split("-", 0);
                    for (String sku : temp) {
                        skus.add(Integer.parseInt(sku));
                    }
                }
                if (c.getName().equals("counts")) {   //get counts
                    temp = c.getValue().split("-", 0);
                    for (String count : temp) {
                        counts.add(Integer.parseInt(count));
                    }
                }
            }
        }

        //add product to basket
        int pos = skus.indexOf(addingSku);

        if (pos >= 0) {     //the product doesn't exist in basket
            counts.set(pos, counts.get(pos) + 1);
        } else {        //the product is not existed in basket
            skus.add(addingSku);
            counts.add(1);
        }

        //save basket to cookie
        StringBuilder sb1 = new StringBuilder();
        for (int sku : skus) {
            sb1.append(sku).append("-");
        }
        Cookie c = new Cookie("skus", sb1.toString());
        c.setMaxAge(3600 * 24 * 365);
        response.addCookie(c);

        StringBuilder sb2 = new StringBuilder();
        for (int count : counts) {
            sb2.append(count).append("-");
        }
        c = new Cookie("counts", sb2.toString());
        c.setMaxAge(3600 * 24 * 365);
        response.addCookie(c);

        //return total number of products in basket through JSON
        int totalCount = 0;
        for (int count : counts) {
            totalCount += count;
        }
        String json = new Gson().toJson(totalCount);
        //response.setContentType("text/plain");
        response.getWriter().write(json);
    }
}