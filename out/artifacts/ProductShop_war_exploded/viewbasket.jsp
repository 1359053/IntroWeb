<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ include file="preprocess.jsp" %>

<%
    /*-------------------------------process basket info saved in cookie to get list of basketItems and quantity in basket------------------------------*/
    cookies = request.getCookies();
    String[] basketSkus = null;
    String[] basketCounts = null;
    String[] basketUnitPrices = null;
    String[] basketTotalEachs = null;
    Product[] basketItems = null;
    Double basketTotal = 0.0;
    String checkOutBtn = "";
    String prompt = "";

    if ((session != null) && (session.getAttribute("loggedUser") != null)) {
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("skus")) {   //get SKUs
                    basketSkus = cookie.getValue().split("-", 0);
                }
                if (cookie.getName().equals("counts")) {   //get counts
                    basketCounts = cookie.getValue().split("-", 0);
                }
            }

            if ((basketSkus != null) && (basketTotalCount > 0)) {     //basket has at least one product
                checkOutBtn = "<div id='checkOutBtn'><a href='checkout.jsp'><button class='continue'><i class='fa fa-check'></i> Check out</button></a></div>";
                basketItems = new Product[basketSkus.length];
                basketUnitPrices = new String[basketSkus.length];
                basketTotalEachs = new String[basketSkus.length];
                for (int i = 0; i < basketSkus.length; i++) {       //get products
                    basketItems[i] = ProductDao.getBySku(Integer.parseInt(basketSkus[i]));
                    basketUnitPrices[i] = NumberFormat.getNumberInstance(Locale.US).format(basketItems[i].getUnitPrice());
                    basketTotalEachs[i] = NumberFormat.getNumberInstance(Locale.US).format(basketItems[i].getUnitPrice() * Integer.parseInt(basketCounts[i]));
                    basketTotal += basketItems[i].getUnitPrice() * Integer.parseInt(basketCounts[i]);
                }
            } else {
                prompt = "<tr><td colspan='5'><p id='promptP'>There is no product in your basket!<br/><a href='index.jsp'><button>Buy now</button></a></p></td></tr>";
            }
        }
    } else {
        prompt = "<tr><td colspan='5'><p id='promptP'>Please login to view and check out your basket!</p></td></tr>";
    }

    request.setAttribute("basketItems", basketItems);
    request.setAttribute("basketCounts", basketCounts);
    request.setAttribute("basketUnitPrices", basketUnitPrices);
    request.setAttribute("basketTotalEachs", basketTotalEachs);
    request.setAttribute("basketTotal", NumberFormat.getNumberInstance(Locale.US).format(basketTotal));
    request.setAttribute("prompt", prompt);

    c = new Cookie("basketTotal", Double.toString(basketTotal));
    c.setMaxAge(3600 * 24 * 365);
    response.addCookie(c);
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
    <link rel="stylesheet" type="text/css" href="css/tooltipster.css" />
    <link rel="stylesheet" type="text/css" href="css/tooltipster-shadow.css" />
    <link rel="stylesheet" type="text/css" href="css/tooltip.css" />
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
    <link rel="stylesheet" type="text/css" href="css/modal-style.css" />
    <!--Cookie-->
    <script type="text/javascript" src="js/js.cookie.js"></script>
    <script type="text/javascript">
        function updateBasket(sku, index, newCount) {
            var counts = readCookie("counts");
            var array = counts.split("-");

            var oldCount = array[index];
            array[index] = newCount;

            var totalCount = 0;
            for (var i = 0; i < array.length - 1; i++) {
                totalCount += parseInt(array[i]);
            }
            $("#basketTotalCount").html("<i class='fa fa-shopping-cart'></i> (" + totalCount + ")");

            var gap = newCount - oldCount;
            var text = " <b>" + $('#basketRow' + index + ' b').html()+"</b>";
            if (gap > 0 && newCount > 0) {
                text = '<i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;' + gap + text + ' was added to your shopping cart!';
            }
            else if (gap < 0 && newCount > 0) {
                gap = gap * (-1);
                text = '<i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;' + gap + text + ' was removed from your shopping cart!';
            }
            else {
                text = '<i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;' + "All" + text + ' was removed from your shopping cart!';
            }
            var n = noty({
                text: text,
                type: 'success',
                dismissQueue: 'true',
                layout: 'topRight',
                closeWith: ['click'],
                theme: 'relax',
                maxVisible: 5,
                timeout     : 10000,
                animation: {
                    open: 'animated bounceInRight', // Animate.css class names
                    close: 'animated bounceOutRight', // Animate.css class names
                    easing: 'swing', // unavailable - no need
                    speed: 500 // unavailable - no need
                }
            });
            if(newCount>0) {    //highlight total per product
                $('#totalEachs' + sku).fadeIn(400).fadeOut(400).fadeIn(400).fadeOut(400).fadeIn(400).fadeOut(400).fadeIn(400);
            }
            if(totalCount>0) {    //highlight basket total
                $('#basketTotal').fadeIn(400).fadeOut(400).fadeIn(400).fadeOut(400).fadeIn(400).fadeOut(400).fadeIn(400);
            }

                if (totalCount == 0) {
                $('#checkOutBtn').fadeOut("slow", function () {
                    $(this).remove();
                    $("#basketTable tr:first").after("<tr><td colspan='5'><p id='promptP'>There is no product in your basket!<br/><a href='index.jsp'><button>Buy now</button></a></p></td></tr>");
                });
            }

            $.ajax({
                url: 'ServletUpdateBasket',
                type: 'post',
                dataType: 'json',
                data: {sku: sku, newCount: newCount, oldCount: oldCount},
                success: function (data) {
                    var array = data.split("-");
                    $("#totalEachs" + sku).html(array[0]);
                    $("#basketTotal").html(array[1]);
                }
            });

            var string = "";
            for (var i = 0; i < array.length - 1; i++) {
                string += array[i] + "-";
            }
            createCookie("counts", string, 365);

            if (newCount <= 0) {
                $("#basketRow" + index).fadeOut("slow", function () {
                    $(this).remove();
                });
            }
        }

        $(document).ready(function () {
            $("[id^=basketRemoveBtn]").click(function () {
                var id = $(this).attr("id");
                var sku = id.replace('basketRemoveBtn', '');
                var index = $(this).attr("basketRow");
                var newCount = 0;

                updateBasket(sku, index, newCount);
            });

            $("[id^=count]").change(function () {
                var id = $(this).attr("id");
                var sku = id.replace('count', '');
                var index = $(this).attr("basketRow");
                var newCount = $(this).val(); //need to validate data
                newCount = (newCount > 0) ? newCount : 0;

                updateBasket(sku, index, newCount);
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

<article id="basket">
    <div id="breadcrumb">Shopping Cart</div>
    <table width="100" border="1" id="basketTable">
        <tr>
            <th scope="col" class="description">Product</th>
            <th scope="col" class="options">Details</th>
            <th scope="col" class="options">Unit Price</th>
            <th scope="col" class="options">Total per product</th>
            <th scope="col" class="price">Remove</th>
        </tr>
        <c:forEach items="${basketItems}" var="p" varStatus="status">
            <c:if test="${basketCounts[status.index] > 0}">
                <tr id="basketRow${status.index}">
                    <td class='description'>
                        <a href='detail.jsp?sku=${p.sku}'>
                            <img src='images/big/${p.picture}' alt='${p.name}'/>
                        </a><br/>
                        <a href='detail.jsp?sku=${p.sku}'><b>${p.name}</b></a>
                    </td>
                    <td class='options'>
                        <table class='table_detail'>
                            <tr>
                                <td>Processor:</td>
                                <td>${p.processor}</td>
                            </tr>
                            <tr>
                                <td>Ram:</td>
                                <td>${p.ram} GB</td>
                            </tr>
                            <tr>
                                <td>Screen:</td>
                                <td>${p.screen} inch</td>
                            </tr>
                            <tr>
                                <td>HDD:</td>
                                <td>${p.hdd} GB</td>
                            </tr>
                            <tr>
                                <td>Quantity:</td>
                                <td><input id="count${p.sku}" size="5" type="text"
                                           value="${basketCounts[status.index]}" basketRow="${status.index}"/></td>
                            </tr>
                        </table>
                    </td>
                    <td class='price'>${basketUnitPrices[status.index]} VND</td>
                    <td class='price'>
                        <div id="totalEachs${p.sku}">${basketTotalEachs[status.index]} VND</div>
                    </td>
                    <td class='price'>
                        <button id='basketRemoveBtn${p.sku}' basketRow='${status.index}'>Remove</button>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        <div id="prompt">${prompt}</div>
        <tr>
            <th colspan="3" align="left">Total</th>
            <th colspan="2"><em>
                <div id="basketTotal"><c:out value="${basketTotal}"/> VND</div>
            </em></th>
        </tr>
    </table>
    <%= checkOutBtn %>
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