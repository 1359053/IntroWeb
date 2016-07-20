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
        User u = (User) session.getAttribute("loggedUser");
        if (u.getRole().equals("admin")) { //user is administrator
            redirect = false;
        }
    }

    if (!request.getParameterMap().containsKey("userId") || request.getParameter("userId").equals("")) { //invalid url parameter
        redirect = true;
    }

    if (redirect) {
        response.sendRedirect("index.jsp");
    }

    /*-----------fetch carts from database--------------*/
    if (request.getParameterMap().containsKey("userId") && !request.getParameter("userId").equals("")) {   //valid url parameter
        String userId = request.getParameter("userId");
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
            } else {
                request.setAttribute("prompt", "<tr><td colspan='6'><p id='promptP'>This user have not bought anything from our site!<br/>");
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
            $('#userFilter').val('${param.userId}');

            $('#searchBtn').click(function () {
                var userId = $('#userFilter').val();
                window.location.href = "history_admin.jsp?userId=" + userId;
            });

            $("[id^=cart_view_]").click(function () {
                var cartId = $(this).attr('id').replace('cart_view_', '');
                window.location.href = "cart_details.jsp?idCart=" + cartId;
            });

            $('[id^=cart_del_]').click(function () {
                var delCart = $(this);
                var cartId = $(this).attr('id').replace('cart_del_', '');
                noty({
                    text: "<i class='fa fa-trash'></i>&nbsp;&nbsp; Do you want to remove this cart?",
                    type: 'warning',
                    dismissQueue: 'true',
                    layout: 'topCenter',
                    theme: 'defaultTheme',
                    timeout: 10000,
                    maxVisible: 1,
                    buttons: [{
                        addClass: 'notyBtn notyBtn-primary', text: 'Ok', onClick: function ($noty) {
                            $noty.close();
                            $.ajax({
                                url: 'ServletDelCart',
                                type: 'post',
                                dataType: 'json',
                                data: {cartId: cartId},
                                success: function (data) {
                                    //alert(data);
                                    if (data == "true") {
                                        delCart.parent().parent().fadeOut("slow", function () {
                                            $(this).remove();
                                        });
                                        setTimeout(function () {
                                            noty({
                                                dismissQueue: 'true',
                                                force: 'true',
                                                layout: 'topCenter',
                                                theme: 'relax',
                                                timeout: 10000,
                                                closeWith: ['click'],
                                                maxVisible: 1,
                                                text: '<i class="fa fa-check"></i>&nbsp;&nbsp; The cart is deleted successfully!',
                                                type: 'success'
                                            });
                                        }, 1000)
                                    }
                                    else {
                                        noty({
                                            dismissQueue: 'true',
                                            force: 'true',
                                            layout: 'topCenter',
                                            theme: 'relax',
                                            timeout: 10000,
                                            closeWith: ['click'],
                                            maxVisible: 1,
                                            text: '<i class="fa fa-times"></i>&nbsp;&nbsp; Can not delete the cart!',
                                            type: 'error'
                                        });
                                    }
                                }
                            });
                        }
                    }, {
                        addClass: 'notyBtn notyBtn-danger', text: 'Cancel', onClick: function ($noty) {
                            $noty.close();
                        }
                    }]
                });
            });

            $('[id^=cart_set_del_]').click(function () {
                var cartId = $(this).attr('id').replace('cart_set_del_', '');
                noty({
                    text: "<i class='fa fa-trash'></i>&nbsp;&nbsp; Do you want to set this cart delivered at current date time?",
                    type: 'warning',
                    dismissQueue: 'true',
                    layout: 'topCenter',
                    theme: 'defaultTheme',
                    timeout: 10000,
                    maxVisible: 1,
                    buttons: [{
                        addClass: 'notyBtn notyBtn-primary', text: 'Ok', onClick: function ($noty) {
                            $noty.close();
                            $.ajax({
                                url: 'ServletSetCartDel',
                                type: 'post',
                                dataType: 'json',
                                data: {cartId: cartId},
                                success: function (data) {
                                    //alert(data);
                                    if (data == "true") {
                                        noty({
                                            dismissQueue: 'true',
                                            force: 'true',
                                            layout: 'topCenter',
                                            theme: 'relax',
                                            timeout: 10000,
                                            closeWith: ['click'],
                                            maxVisible: 1,
                                            text: '<i class="fa fa-check"></i>&nbsp;&nbsp; The cart is set to delivered at current date time!',
                                            type: 'success'
                                        });
                                        setTimeout(function () {
                                            location.reload();
                                        }, 1500)
                                    }
                                    else {
                                        noty({
                                            dismissQueue: 'true',
                                            force: 'true',
                                            layout: 'topCenter',
                                            theme: 'relax',
                                            timeout: 10000,
                                            closeWith: ['click'],
                                            maxVisible: 1,
                                            text: '<i class="fa fa-times"></i>&nbsp;&nbsp; Can not set this cart to delivered!',
                                            type: 'error'
                                        });
                                    }
                                }
                            });
                        }
                    }, {
                        addClass: 'notyBtn notyBtn-danger', text: 'Cancel', onClick: function ($noty) {
                            $noty.close();
                        }
                    }]
                });
            });

            $('[id^=cart_set_pay_]').click(function () {
                var cartId = $(this).attr('id').replace('cart_set_pay_', '');
                noty({
                    text: "<i class='fa fa-trash'></i>&nbsp;&nbsp; Do you want to set this cart paid at current date time?",
                    type: 'warning',
                    dismissQueue: 'true',
                    layout: 'topCenter',
                    theme: 'defaultTheme',
                    timeout: 10000,
                    maxVisible: 1,
                    buttons: [{
                        addClass: 'notyBtn notyBtn-primary', text: 'Ok', onClick: function ($noty) {
                            $noty.close();
                            $.ajax({
                                url: 'ServletSetCartPay',
                                type: 'post',
                                dataType: 'json',
                                data: {cartId: cartId},
                                success: function (data) {
                                    //alert(data);
                                    if (data == "true") {
                                        noty({
                                            dismissQueue: 'true',
                                            force: 'true',
                                            layout: 'topCenter',
                                            theme: 'relax',
                                            timeout: 10000,
                                            closeWith: ['click'],
                                            maxVisible: 1,
                                            text: '<i class="fa fa-check"></i>&nbsp;&nbsp; The cart is set to paid at current date time!',
                                            type: 'success'
                                        });
                                        setTimeout(function () {
                                            location.reload();
                                        }, 1500)
                                    }
                                    else {
                                        noty({
                                            dismissQueue: 'true',
                                            force: 'true',
                                            layout: 'topCenter',
                                            theme: 'relax',
                                            timeout: 10000,
                                            closeWith: ['click'],
                                            maxVisible: 1,
                                            text: '<i class="fa fa-times"></i>&nbsp;&nbsp; Can not set this cart to paid!',
                                            type: 'error'
                                        });
                                    }
                                }
                            });
                        }
                    }, {
                        addClass: 'notyBtn notyBtn-danger', text: 'Cancel', onClick: function ($noty) {
                            $noty.close();
                        }
                    }]
                });
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
    <header id="filter">
        <select id="userFilter">
            <option value="" selected>User...</option>
            <%= UserJspGui.toOption(UserDao.getAll())%>
        </select>
        <select id="payFilter">
            <option value="" selected>Payment...</option>
            <option value="PAID">PAID</option>
            <option value="UNPAID">UNPAID</option>
        </select>
        <select id="delFilter">
            <option value="" selected>Delivery...</option>
            <option value="DELIVERED">DELIVERED</option>
            <option value="NOT YET">NOT YET</option>
        </select>
        <select id="sortBy">
            <option value="" selected>Sort...</option>
            <option value="total-asc">Lowest total</option>
            <option value="total-desc">Highest total</option>
            <option value="receiver-asc">Receiver</option>
            <option value="order-desc">Most recent ordered</option>
            <option value="vie-asc">Most recent paid</option>
            <option value="vie-desc">Most recent delivered</option>
        </select>

        <div class="paging">
            <!--page links-->
        </div>
        <button id="searchBtn"><i class="fa fa-search fa-flip-horizontal fa-border"></i></button>
    </header>
    <table width="100" border="1" id="basketTable">
        <tr>
            <th scope="col" class="col1">Receiver</th>
            <th scope="col" class="col2">Total</th>
            <th scope="col" class="col3">Address</th>
            <th scope="col" class="col4">Payment</th>
            <th scope="col" class="col5">Delivery</th>
            <th scope="col" class="col6">Options</th>
        </tr>
        <c:forEach items="${carts}" var="cart" varStatus="status">
            <tr id="table_row_${status.index}">
                <!--receiver-->
                <td scope="col" class='col1'>${cart.receiver} </td>
                <!--total-->
                <td scope="col" class='col2'>${totals[status.index]}</td>
                <!--address-->
                <td scope="col" class='col3'>${cart.address}</td>
                <!--status-->
                <td scope="col" class='col4'>${payStatuses[status.index]}</td>
                <td scope="col" class='col5'>${delStatuses[status.index]}</td>
                <!--options-->
                <td class='col6'>
                    <button id="cart_view_${cart.idCart}">Details</button>
                    <button id="cart_del_${cart.idCart}">Delete</button>
                    <button id="cart_set_del_${cart.idCart}">Set Delivered</button>
                    <button id="cart_set_pay_${cart.idCart}">Set Paid</button>
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