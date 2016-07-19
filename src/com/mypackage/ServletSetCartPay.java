package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

public class ServletSetCartPay extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String cartId = request.getParameter("cartId");

        System.out.print(cartId);

        String result = "";

        if (cartId.equals("")) {
            result = "Cart ID can't be blank! <i class='fa fa-times'></i>";
        } else {
            int id = Integer.parseInt(cartId);
            try {
                if (!CartDao.isExisted(id)) {
                    result = "This cart doesn't exist! <i class='fa fa-times'></i>";
                } else {
                    Timestamp current = new Timestamp(System.currentTimeMillis());
                    result = CartDao.setPayDateTime(id, current) ? "true" : "Failed! <i class='fa fa-times'></i>";
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (NamingException e) {
                e.printStackTrace();
            }
        }

        String json = new Gson().toJson(result);
        response.getWriter().write(json);
    }
}
