package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.Locale;

public class ServletUpdateBasket extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/application;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        int sku = Integer.parseInt(request.getParameter("sku"));
        int newCount = Integer.parseInt(request.getParameter("newCount"));
        int oldCount = Integer.parseInt(request.getParameter("oldCount"));

        //---------------------------
        Product p = null;

        try {
            p = ProductDao.getBySku(sku);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }

        Double oldTotalEach = (p != null) ? p.getUnitPrice() * oldCount : 0;
        Double newTotalEach = (p != null) ? p.getUnitPrice() * newCount : 0;
        //---------------------------
        Cookie[] cookies = request.getCookies();
        Double basketTotal = 0.0;

        if (cookies != null) {
            int i;
            for (i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("basketTotal")) {
                    basketTotal = Double.parseDouble(cookies[i].getValue());
                    basketTotal = basketTotal + (newTotalEach - oldTotalEach);
                }
            }
        }

        Cookie c = new Cookie("basketTotal", Double.toString(basketTotal));
        c.setMaxAge(3600 * 24 * 365);
        response.addCookie(c);

        //---------------------------
        StringBuilder data = new StringBuilder();
        data.append(NumberFormat.getNumberInstance(Locale.US).format(newTotalEach) + " VND");
        data.append("-");
        data.append(NumberFormat.getNumberInstance(Locale.US).format(basketTotal) + " VND");


        String json = new Gson().toJson(data);
        //response.setContentType("text/application");
        response.getWriter().write(json);
    }
}
