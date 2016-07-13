<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file="preprocess.jsp" %>
<%
    Product p = null;
    int sku = 0;

    if (request.getParameterMap().containsKey("sku")) { //get sku from url and get product from database
        sku = Integer.parseInt(request.getParameter("sku"));
        try {
            p = ProductDao.getBySku(sku);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }
    } else { //url has no sku parameter
        response.sendRedirect("index.jsp");
    }

    //update view count----------------
    User u = (User) session.getAttribute("loggedUser");
    if (p != null && (u == null || !u.getRole().equals("admin"))) {
        String userId = (u == null) ? "" : u.getId();
        ViewTrackingDao.updateTotalViews(sku, userId);
    }

    //display product detail----------------
    if (p != null) { //if product is in database, set request param so EL can be used
        request.setAttribute("pIsNull", "false");
        request.setAttribute("p", p);
        request.setAttribute("pUnitPrice", NumberFormat.getNumberInstance(Locale.US).format(p.getUnitPrice()));
        request.setAttribute("pCatName", (CategoryDao.getById(p.getCatId()) != null) ? CategoryDao.getById(p.getCatId()).getCatName() : "N/A");
        request.setAttribute("pManName", (ManufacturerDao.getById(p.getManId()) != null) ? ManufacturerDao.getById(p.getManId()).getManName() : "N/A");
        request.setAttribute("pTotalViews", (ViewTrackingDao.getBySku(sku) != null) ? ViewTrackingDao.getBySku(sku).getTotalViews() : "N/A");
        request.setAttribute("pImportDateTime", (ImportDao.getBySku(sku) != null) ? new SimpleDateFormat("dd-MM-yyyy").format(new Date(ImportDao.getBySku(sku).getImportDateTime().getTime())) : "N/A");
        request.setAttribute("pSoldCount", DetailDao.getSoldCount(sku));
    } else {  //product is not existed in database
        request.setAttribute("pIsNull", "true");
    }
%>


<html>
<head>
    <meta charset="utf-8">
    <title>DHS laptop shopping website</title>
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
    <!--Admin modal-->
    <script type="text/javascript" src="js/admin-modal.js"></script>
    <link rel="stylesheet" type="text/css" href="css/modal-style.css" />
    <!--Login-->
    <link rel="stylesheet" href="css/loginfont.css"/>
    <link type="text/css" rel="stylesheet" href="css/loginstyle.css"/>
    <script type="text/javascript" src="js/log-reg.js"></script>
    <script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
    <script type="text/javascript" src="js/account.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var pIsNull = "${pIsNull}";
            if (pIsNull != "false") {
                $("#mainview").html("<div id='breadcrumb'>Product Information</div><div id='error'>This product is not available.<br/><a href='index.jsp'>Return to main page</a></div>");
            }

            $('button.continue').click(function () {       //when button is clicked, add product to basket
                                                           //animation
                var cart = $('#basketTotalCount');
                var dragImg = $('#images').find("img").eq(0);
                if (dragImg) {
                    var cloneImg = dragImg.clone()
                            .offset({
                                top: dragImg.offset().top,
                                left: dragImg.offset().left
                            })
                            .css({
                                'opacity': '0.5',
                                'position': 'absolute',
                                'height': '150px',
                                'width': '150px',
                                'z-index': '100'
                            })
                            .appendTo($('body'))
                            .animate({
                                'top': cart.offset().top + 10,
                                'left': cart.offset().left + 10,
                                'width': 75,
                                'height': 75
                            }, 1000, 'easeInOutExpo');

                    cloneImg.animate({
                        'width': 0,
                        'height': 0
                    }, function () {
                        $(this).detach()
                    });
                }

                //add product to basket
                var sku = "${param.sku}";
                setTimeout(function () {
                    $.ajax({        //send sku to basket servlet
                        url: 'ServletAddToBasket',
                        type: 'post',
                        dataType: 'json',
                        data: {sku: sku},
                        success: function (data) {
                            $('#basketTotalCount').html("<i class='fa fa-shopping-cart'></i> (" + data + ")");
                        }
                    });
                }, 1500);
            });
        });
    </script>
</head>

<body>
<header>
    <div class="wrapper">
        <h1><a href="index.jsp" id="brand" title="DHS design">DHS design</a></h1>
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

<article id="mainview">
    <div id="breadcrumb">Product Information</div>
    <div id="description">
        <h1>Model: ${p.name} </h1>
        <strong id="price">Price: ${pUnitPrice} VND </strong>

        <table>
            <tr>
                <td>Category</td>
                <td>${pCatName}</td>
            </tr>
            <tr>
                <td>Brand</td>
                <td>${pManName}</td>
            </tr>
            <tr>
                <td>Processor</td>
                <td>${p.processor}</td>
            </tr>
            <tr>
                <td>RAM</td>
                <td>${p.ram} GB</td>
            </tr>
            <tr>
                <td>Screen</td>
                <td>${p.screen} inches</td>
            </tr>
            <tr>
                <td>HDD</td>
                <td>${p.hdd} GB</td>
            </tr>
            <tr>
                <td>Available from</td>
                <td>${pImportDateTime}</td>
            </tr>
            <tr>
                <td>Views</td>
                <td>${pTotalViews}</td>
            </tr>
            <tr>
                <td>Sold</td>
                <td>${pSoldCount}</td>
            </tr>
        </table>

        <p>
            <button class='continue'><i class='fa fa-shopping-cart'></i> Add to cart</button>
        </p>
        <div id="tabs">
            <ul>
                <li><a href="index.jsp"><i class="fa fa-arrow-left"></i> Return to main page</a></li>
                <li><a href="viewbasket.jsp"><i class="fa fa-shopping-cart"></i> Go to your basket</a></li>
            </ul>
        </div>
    </div>
    <div id="images"><img src='images/big/${p.picture}'></div>
</article>

<footer>
    <div class="wrapper">
        <a href="https://www.facebook.com/groups/1582741855289987/" target="_blank" title="DHS fanpage" class="right"><i
                class="fa fa-facebook-square"></i> DHS
            Web design</a>
        International Training and Education Center<br/>
        13BIT2 - Advanced Web Programming Course
        <a href="mailto:1359053@itec.hcmus.edu.vn" id='simpletooltip' title="test" data-tipped-options="skin: 'red'"><i
                class="fa fa-envelope"></i> service@DHS</a>
    </div>
</footer>
</body>
</html>
