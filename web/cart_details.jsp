<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.NumberFormat" %>
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
    if (session1 != null && session.getAttribute("loggedUser") != null &&
            request.getParameterMap().containsKey("idCart") &&
            !request.getParameter("idCart").equals("")) {               //logged in, valid idCart
        int idCart = Integer.parseInt(request.getParameter("idCart"));
        User u = (User) session.getAttribute("loggedUser");
        if (u.getRole().equals("admin")) { //user is administrator, access all cart
            redirect = false;
        } else {            //user is not admin, access this user's carts only
            String userId = u.getId();
            try {
                List<Cart> carts = CartDao.getByCus(userId);    //get logged user's carts
                if (carts != null && carts.size() > 0) {
                    for (Cart cart : carts) {
                        if (cart.getIdCart() == idCart) {
                            redirect = false;
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (NamingException e) {
                e.printStackTrace();
            }
        }
    }

    if (redirect) {
        response.sendRedirect("index.jsp");
    }

    /*-----------fetch products from cart--------------*/
    if (session1 != null &&
            session.getAttribute("loggedUser") != null &&
            request.getParameterMap().containsKey("idCart") &&
            !request.getParameter("idCart").equals("")) {
        String prompt = "";
        int idCart = Integer.parseInt(request.getParameter("idCart"));
        try {
            Cart cart = CartDao.getById(idCart);
            if (cart != null) {
                List<Detail> details = DetailDao.getByIdCart(idCart);

                if (details.size() > 0) {
                    ArrayList<Product> products = new ArrayList<Product>();
                    ArrayList<String> unitPrices = new ArrayList<String>();
                    ArrayList<String> totalEachs = new ArrayList<String>();

                    for (Detail detail : details) {
                        Product p = ProductDao.getBySku(detail.getSku());
                        products.add(p);
                        unitPrices.add(NumberFormat.getNumberInstance(Locale.US).format(p.getUnitPrice()));
                        totalEachs.add(NumberFormat.getNumberInstance(Locale.US).format(p.getUnitPrice() * detail.getQuantity()));
                    }

                    String total = NumberFormat.getNumberInstance(Locale.US).format(cart.getTotalPrice());

                    request.setAttribute("cart", cart);
                    request.setAttribute("details", details);
                    request.setAttribute("products", products);
                    request.setAttribute("unitPrices", unitPrices);
                    request.setAttribute("totalEachs", totalEachs);
                    request.setAttribute("total", total);
                } else {
                    prompt = "<tr><td colspan='4'><p id='promptP'>There is no product in this cart!</p></td></tr>";

                }
            } else {
                prompt = "<tr><td colspan='4'><p id='promptP'>Cart doesn't exist!</p></td></tr>";

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }
        request.setAttribute("prompt", prompt);
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
    <!--Cookie-->
    <script type="text/javascript" src="js/js.cookie.js"></script>

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

<article id="basket">
    <div id="breadcrumb">Shopping History - Cart Details</div>
    <table width="100" border="1" id="basketTable">
        <tr>
            <th scope="col" class="">Product</th>
            <th scope="col" class="">Details</th>
            <th scope="col" class="">Unit Price</th>
            <th scope="col" class="">Total per product</th>
        </tr>
        <c:forEach items="${details}" var="d" varStatus="status">
            <tr id="table_row_${status.index}">
                <td class='description'>
                    <a href='detail.jsp?sku=${d.sku}'>
                        <img src='images/big/${products[status.index].picture}' alt='${products[status.index].name}'/>
                    </a><br/>
                    <a href='detail.jsp?sku=${d.sku}'><b>${products[status.index].name}</b></a>
                </td>
                <td class='options'>
                    <table class='table_detail'>
                        <tr>
                            <td>Processor:</td>
                            <td>${products[status.index].processor}</td>
                        </tr>
                        <tr>
                            <td>Ram:</td>
                            <td>${products[status.index].ram} GB</td>
                        </tr>
                        <tr>
                            <td>Screen:</td>
                            <td>${products[status.index].screen} inch</td>
                        </tr>
                        <tr>
                            <td>HDD:</td>
                            <td>${products[status.index].hdd} GB</td>
                        </tr>
                        <tr>
                            <td>Quantity:</td>
                            <td>${d.quantity}</td>
                        </tr>
                    </table>
                </td>
                <td class='price'>${unitPrices[status.index]} VND</td>
                <td class='price'>
                    <div id="totalEachs${d.sku}">${totalEachs[status.index]} VND</div>
                </td>
            </tr>
        </c:forEach>
        <div id="prompt">${prompt}</div>
        <tr>
            <th colspan="3" align="left">Total</th>
            <th><em>
                <div id="basketTotal"><c:out value="${total}"/> VND</div>
            </em></th>
        </tr>
    </table>
</article>

<footer>
    <div class="wrapper">
        <a href="https://www.facebook.com/groups/1582741855289987/" target="_blank" title="PTS fanpage" class="right"><i
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