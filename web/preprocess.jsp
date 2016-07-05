<%@ page import="com.mypackage.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="add.jsp" %>
<%@ include file="del.jsp" %>
<%@ include file="account.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    Cookie[] cookies = request.getCookies();

    /*------------------------------process cookie to get basket count for displaying in action bar------------------------------*/
    String[] temp;
    int basketTotalCount = 0;
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("counts")) {   //get counts
                temp = c.getValue().split("-");
                for (String count : temp) {
                    if (!count.equals("")) {
                        basketTotalCount += Integer.parseInt(count);
                    }
                }
            }
        }
    }

    Cookie c = new Cookie("basketTotalCount", Integer.toString(basketTotalCount));
    c.setMaxAge(3600 * 24 * 365);
    response.addCookie(c);

    /*------------------------------display action bar according to login context, process cookie for login info------------------------------*/
    String actionBar = "Hello Guest, <a id='modal_trigger' name='login_section' href='#modal' title='Sign in or register an account'><i class='fa fa-sign-in'></i></a> " +
            "<a href='viewbasket.jsp' id='basketTotalCount' title='Shopping cart'><i class='fa fa-shopping-cart'></i> (" + basketTotalCount + ")</a><div></div>";      //display action for guest

    if (session.getAttribute("loggedUser") != null) {               //logged in
        User u = (User) session.getAttribute("loggedUser");
        if (u.getRole().equals("admin")) {                          //logged in as administrator, display action for admin
            actionBar = "Hello " + u.getName() + ", <a href='#modal_acc' id='modal_acc_trigger' title='Account information'><i class='fa fa-user'></i></a> " +
                    "<a href='#modal_add' id='modal_add_trigger' title='Add'><i class='fa fa-plus'></i></a> " +
                    "<a href='#modal_del' id='modal_del_trigger' title='Delete'><i class='fa fa-minus'></i></a> " +
                    "<a href='viewbasket.jsp' id='basketTotalCount' title='View shopping cart'><i class='fa fa-shopping-cart'></i> (" + basketTotalCount + ")</a> " +
                    "<a href='history_admin.jsp?userId=admin' title='View shopping history'><i class='fa fa-history'></i></a> " +
                    "<a href='index.jsp?logout=1' title='Sign out'><i class='fa fa-sign-out'></i></a><div></div>";
        } else if (u.getRole().equals("user")) {                    //logged in as user, display action for user
            actionBar = "Hello " + u.getName() + ", <a href='#modal_acc' id='modal_acc_trigger' title='Account information'><i class='fa fa-user'></i></a> " +
                    "<a href='viewbasket.jsp' id='basketTotalCount' title='Shopping cart'><i class='fa fa-shopping-cart'></i> (" + basketTotalCount + ")</a> " +
                    "<a href='history.jsp' title='Shopping history'><i class='fa fa-history'></i></a> " +
                    "<a href='index.jsp?logout=1' title='Sign out'><i class='fa fa-sign-out'></i></a><div></div>";
        }

        if (request.getParameterMap().containsKey("logout")) {      //process logout request
            session = request.getSession(false);            //clean up all session info
            if (session != null) {
                session.invalidate();
            }

            for (Cookie cookie : request.getCookies()) {      //clear all cookies info
                cookie.setValue("");
                cookie.setMaxAge(0);

                response.addCookie(cookie);
            }

            response.sendRedirect("index.jsp");
        }
    } else {                                                        //not logged in -> search cookie -> set session
        //Cookie[] cookies = request.getCookies();
        String userId = null;
        String password = null;

        if (cookies != null) {                                      //iterate through cookies and get user id, password
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userId")) {
                    userId = cookie.getValue();
                }
                if (cookie.getName().equals("password")) {
                    password = cookie.getValue();
                }
            }

            if ((userId != null) && (password != null)) {           //if user id and password are in cookie, set session, go to index.jsp as logged in user
                User u = UserDao.getById(userId);
                if ((u != null) && (u.getPassword().equals(password))) {
                    session.setAttribute("loggedUser", u);
                    response.sendRedirect("index.jsp");
                }
            }
        }
    }

%>