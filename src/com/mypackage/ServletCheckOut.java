package com.mypackage;

import com.google.gson.Gson;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ServletCheckOut extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String address = request.getParameter("address");
        String receiver = request.getParameter("receiver");
        String postcode = request.getParameter("postCode");
        String phoneNumber = request.getParameter("phoneNumber");
        String method = request.getParameter("method");

        StringBuilder error = new StringBuilder();

        Timestamp orderDateTime = new Timestamp(System.currentTimeMillis());
        Timestamp payDateTime;
        Timestamp delDateTime = null;

        String payStatus;
        if (method.equals("online")) {
            payStatus = "PAID";
            payDateTime = orderDateTime;
        } else {
            payStatus = "UNPAID";
            payDateTime = null;
        }

        Calendar ca = Calendar.getInstance();
        ca.add(Calendar.DATE, 10);
        Date estimatedDelDate = new java.sql.Date(ca.getTimeInMillis());  //current date + 10 days


        HttpSession session = request.getSession();
        if ((session != null) && (session.getAttribute("loggedUser") != null)) { //logged in
            User u = (User) session.getAttribute("loggedUser");
            String idCus = u.getId();
            /*System.out.print(idCus);
            System.out.print(u.getName());
            System.out.print(u.getAddress());*/

            if (address.equals("")) {
                address = u.getAddress();
            }
            if (receiver.equals("")) {
                receiver = u.getName();
            }
            if (phoneNumber.equals("")) {
                phoneNumber = u.getPhone();
            }

            String[] basketSkusString = null;
            int[] basketSkus = null;
            String[] basketCountsString = null;
            int[] basketCounts = null;
            Cookie[] cookies = request.getCookies();
            int basketTotalCount = 0;
            double basketTotal = 0.0;
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("skus")) {   //get SKUs
                        basketSkusString = c.getValue().split("-", 0);
                        basketSkus = new int[basketSkusString.length];
                        for (int i = 0; i < basketSkusString.length; i++) {
                            basketSkus[i] = Integer.parseInt(basketSkusString[i]);
                        }
                    }
                    if (c.getName().equals("counts")) {   //get counts
                        basketCountsString = c.getValue().split("-", 0);
                        basketCounts = new int[basketCountsString.length];
                        for (int i = 0; i < basketCountsString.length; i++) {
                            basketCounts[i] = Integer.parseInt(basketCountsString[i]);
                        }
                    }
                    if (c.getName().equals("basketTotal")) {   //get basketTotal
                        basketTotal = Double.parseDouble(c.getValue());
                    }
                    if (c.getName().equals("basketTotalCount")) {   //get basketTotalCount
                        basketTotalCount = Integer.parseInt(c.getValue());
                    }
                }

                if ((basketSkus != null) && (basketTotalCount > 0)) {     //basket has at least one product
                    try {
                        Cart cart = new Cart();
                        cart.setIdCart(0);
                        cart.setIdCus(idCus);
                        cart.setPayStatus(payStatus);
                        cart.setAddress(address);
                        cart.setReceiver(receiver);
                        cart.setOrderDateTime(orderDateTime);
                        cart.setPayDateTime(payDateTime);
                        cart.setDelDatTime(delDateTime);
                        cart.setTotalPrice(basketTotal);
                        cart.setPhoneNumber(phoneNumber);
                        cart.setPostcode(postcode);
                        cart.setDelStatus("NOT YET");

                        int idCart = CartDao.insert(cart);

                        if (idCart > 0) { //inserted successfully
                            int i;
                            for (i = 0; i < basketSkus.length; i++) {
                                if (basketCounts[i] > 0) {
                                    if (!DetailDao.insert(new Detail(idCart, basketSkus[i], basketCounts[i]))) {
                                        error.append("Cannot save laptop " + (ProductDao.getBySku(basketSkus[i])).getName() + " to your cart in database.");
                                    }
                                }
                            }
                            if (i == basketSkus.length) {       //all cart items are paid and saved
                                error.append("Successful!<br/>Thank you for choosing our service.<br/>");
                                if ((method.equals("online"))) {
                                    error.append("Your laptop(s) is paid.<br/>Shipping time will be from today to " + new SimpleDateFormat("dd-MM-yyyy").format(estimatedDelDate) + ".");
                                } else {
                                    error.append("You will have to pay for your laptop(s) on delivery.<br/>Shipping time will be from today to " + new SimpleDateFormat("dd-MM-yyyy").format(estimatedDelDate) + ".");
                                }

                                //clear cart info from cookie
                                Cookie cook = new Cookie("skus", "");
                                cook.setMaxAge(0);
                                response.addCookie(cook);
                                cook = new Cookie("counts", "");
                                cook.setMaxAge(0);
                                response.addCookie(cook);
                            }
                        } else {
                            error.append("Cannot save your cart to database.");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (NamingException e) {
                        e.printStackTrace();
                    }
                } else {    //no item in basket
                    error.append("There is no product in your basket!<br/><a href='index.jsp'><button>Buy now</button></a>");
                }
            } else {    //null cookie
                error.append("There is no product in your basket!<br/><a href='index.jsp'><button>Buy now</button></a>");
            }

        } else {  //not logged in
            error.append("Please login to pay your basket!");
        }

        String json = new Gson().toJson(error);
        response.getWriter().write(json);
    }
}
