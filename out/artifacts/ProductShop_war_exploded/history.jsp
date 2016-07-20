<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ include file="preprocess.jsp" %>

<%
    /*-----------access page conditions--------------*/
    boolean redirect = true;

    HttpSession session1 = request.getSession(false);
    if (session1 != null && session.getAttribute("loggedUser") != null) {               //logged in
        redirect = false;
        User u = (User) session.getAttribute("loggedUser");
        if (u.getRole().equals("admin")) { //user is administrator
            //redirect = true;
        }
    }

    if (redirect) {
        response.sendRedirect("index.jsp");
    }

    /*-----------fetch carts from database--------------*/
    if (session1 != null && session.getAttribute("loggedUser") != null) {               //logged in


        User u = (User) session.getAttribute("loggedUser");
        String userId = u.getId();
        try {
            List<Cart> carts = CartDao.getByCus(userId);
            if (carts != null && carts.size() > 0) {
                ArrayList<String> totals = new ArrayList<String>();
                ArrayList<String> payStatuses = new ArrayList<String>();
                ArrayList<String> delStatuses = new ArrayList<String>();

                for (Cart cart : carts) {
                    String payStatus = "UNPAID";
                    if (cart.getPayStatus().equals("PAID")) {
                        payStatus = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(cart.getPayDateTime());
                    }

                    String delStatus = "NOT YET";
                    if (cart.getDelStatus().equals("DELIVERED")) {
                        delStatus = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(cart.getDelDatTime());
                    }

                    totals.add(NumberFormat.getNumberInstance(Locale.US).format(cart.getTotalPrice()) + " VND");
                    payStatuses.add(payStatus);
                    delStatuses.add(delStatus);
                }

                request.setAttribute("totals", totals);
                request.setAttribute("payStatuses", payStatuses);
                request.setAttribute("delStatuses", delStatuses);
                request.setAttribute("carts", carts);
                session.setAttribute("carts", carts);
            } else {
                request.setAttribute("prompt", "<tr><td colspan='6'><p id='promptP'>You have not bought anything from our site!<br/>" +
                        "<a href='index.jsp'><button>Buy now</button></a></p></td></tr>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <meta charset="utf-8">
    <title>PTS laptop shopping website</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link href='http://fonts.googleapis.com/css?family=Terminal+Dosis' rel='stylesheet' type='text/css'>
    <script type="text/javascript" src="js/jquery.js"></script>
    <!--Noty-->
    <script type="text/javascript" src="js/noty/packaged/jquery.noty.packaged.min.js"></script>
    <link rel="stylesheet" href="css/animate.css"/>
    <link rel="stylesheet" href="css/buttons.css"/>
    <!--JQuery UI-->
    <script type="text/javascript" src="js/jquery-ui.js"></script>
    <link rel="stylesheet" href="css/jquery-ui.css"/>
    <!--Font Awesome-->
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
    <!--Tooltipster-->
    <link rel="stylesheet" type="text/css" href="css/tooltipster.css"/>
    <link rel="stylesheet" type="text/css" href="css/tooltipster-shadow.css"/>
    <link rel="stylesheet" type="text/css" href="css/tooltip.css"/>
    <script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>
    <script type="text/javascript" src="js/tooltip.js"></script>
    <!--Login-->
    <link rel="stylesheet" href="css/loginfont.css"/>
    <link type="text/css" rel="stylesheet" href="css/loginstyle.css"/>
    <script type="text/javascript" src="js/log-reg.js"></script>
    <script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
    <script type="text/javascript" src="js/account.js"></script>
    <!--Admin modal-->
    <script type="text/javascript" src="js/admin-modal.js"></script>
    <link rel="stylesheet" type="text/css" href="css/modal-style.css"/>

    <script>
        $(document).ready(function () {
            $("[id^=cart_view_]").click(function () {
                var cartId = $(this).attr('id').replace('cart_view_', '');
                window.location.href = "cart_details.jsp?idCart=" + cartId;
            });
        });
    </script>
</head>

<body>
<header>
    <div class="wrapper">
        <h1><a href="index.jsp" id="brand" title="PTS design">PTS design</a></h1>
        <nav><%= ManufacturerJspGui.toNav(ManufacturerDao.getAll()) %>   <!--generate manufacture links-->
        </nav>
    </div>
</header>

<aside id="top">
    <div class="wrapper">
        <div id='action-bar'>
            <%= actionBar %>   <!--account featured links-->
        </div>
    </div>
</aside>

<!--Login area-->
<div>
    <div class="container">
        <!--include login and register form-->
        <%@ include file="login.jsp" %>
    </div>
</div>

<article id="history">
    <div id="breadcrumb">Shopping History</div>
    <table width="100" border="1" id="basketTable">
        <tr>
            <th scope="col" class="">Receiver</th>
            <th scope="col" class="">Total</th>
            <th scope="col" class="">Address</th>
            <th scope="col" class="">Payment</th>
            <th scope="col" class="">Delivery</th>
            <th scope="col" class="">Options</th>
        </tr>
        <c:forEach items="${carts}" var="cart" varStatus="status">
            <tr id="table_row_${status.index}">
                <!--receiver-->
                <td scope="col" class=''>${cart.receiver} </td>
                <!--total-->
                <td scope="col" class=''>${totals[status.index]}</td>
                <!--address-->
                <td scope="col" class=''>${cart.address}</td>
                <!--status-->
                <td scope="col" class=''>${payStatuses[status.index]}</td>
                <td scope="col" class=''>${delStatuses[status.index]}</td>
                <!--options-->
                <td class=''>
                    <button id="cart_view_${cart.idCart}">Details</button>
                </td>
            </tr>
        </c:forEach>
        <div id="prompt">${prompt}</div>
    </table>
</article>

<footer>
    <div class="wrapper">
        <a href="https://www.facebook.com/groups/1679986465600214/" target="_blank" title="PTS fanpage" class="right"><i
                class="fa fa-facebook-square"></i> PTS
            Web design</a>
        International Training and Education Center<br/>
        13BIT - Project Management Course
        <a href="mailto:1359053@itec.hcmus.edu.vn" id='simpletooltip' title="test" data-tipped-options="skin: 'red'"><i
                class="fa fa-envelope"></i> service@PTS</a>
    </div>
</footer>
</body>
</html>