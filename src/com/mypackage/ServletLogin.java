package com.mypackage;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ServletLogin extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String rememberChecked = "0";

        if (request.getParameterMap().containsKey("rememberChecked")) { //login automatically after registering, url will not contain rememberChecked value
            rememberChecked = request.getParameter("rememberChecked");
        }

        HttpSession session = request.getSession(true);
        StringBuilder result = new StringBuilder();

        Cookie[] cookies = request.getCookies();
        int bannedTimeout = 30;          ////timeout for preventing logging in
        int maxTry = 3;                    //max number of login try
        int remainingTry = maxTry;  //initial value of max try

        if (cookies != null) {      //get attempt count from cookie
            int i;
            for (i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("remainingTry")) {
                    remainingTry = Integer.parseInt(cookies[i].getValue());       //and decrease by 1
                }
            }
        }

        boolean loggedIn = false;

        if (remainingTry > 0) {            //if login is still allowed
            if (UserDao.isExisted(id)) {
                User u = UserDao.getById(id);

                if (password.equals(u.getPassword())) {        //if input id and password are correct -> logged in
                    session.setAttribute("loggedUser", u);

                    if (rememberChecked.equals("1")) {         //save credential to cookie if remember me box is checked
                        Cookie c = new Cookie("userId", id);
                        c.setMaxAge(3600 * 24 * 365);
                        response.addCookie(c);
                        c = new Cookie("password", password);
                        c.setMaxAge(3600 * 24 * 365);
                        response.addCookie(c);
                    }

                    loggedIn = true;
                    result.append("true"); //go to home page after logging in
                    Cookie c = new Cookie("remainingTry", "3"); //reset remaining try
                    c.setMaxAge(bannedTimeout);
                    response.addCookie(c);
                } else {      //if password is wrong, save remaining try to cookie
                    result.append("The password is incorrect. Remaining try: " + Integer.toString(remainingTry - 1));
                    Cookie c = new Cookie("remainingTry", Integer.toString(remainingTry - 1));
                    c.setMaxAge(bannedTimeout); //timeout for preventing logging in
                    response.addCookie(c);
                }

            } else {    //not existed user id, save remaining try to cookie
                result.append("This user doesn't exist. Remaining try: " + Integer.toString(remainingTry - 1));
                Cookie c = new Cookie("remainingTry", Integer.toString(remainingTry - 1));
                c.setMaxAge(bannedTimeout);  //timeout for preventing logging in
                response.addCookie(c);
            }
        }

        if ((remainingTry - 1 <= 0) && !loggedIn) {    //no attempt is available and last try failed
            result.append("<br/>Max try exceeded. Login is blocked for " + bannedTimeout / 60.0 + " minutes.");
            //remainingTry = 0;
        }

        String json = new Gson().toJson(result);
        //response.setContentType("text/plain");
        response.getWriter().write(json);
    }
}
