<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ include file="preprocess.jsp" %>

<%
    //get search parameters
    String word = "";
    int cat = 0;
    int man = 0;
    int lowPrice = 0;
    int highPrice = 0;
    String sort = "";
    String dir = "";
    int currentPage = 1;
    int rows = 10;

    if (request.getParameterMap().containsKey("word")) {
        word = request.getParameter("word");
    }
    if (request.getParameterMap().containsKey("sort")) {
        sort = request.getParameter("sort");
    }
    if (request.getParameterMap().containsKey("dir")) {
        dir = request.getParameter("dir");
    }
    if (request.getParameterMap().containsKey("cat") && !request.getParameter("cat").equals("")) {
        cat = Integer.parseInt(request.getParameter("cat"));
    }
    if (request.getParameterMap().containsKey("page") && !request.getParameter("page").equals("")) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    if (request.getParameterMap().containsKey("man") && !request.getParameter("man").equals("")) {
        man = Integer.parseInt(request.getParameter("man"));
    }
    if (request.getParameterMap().containsKey("low") && !request.getParameter("low").equals("")) {
        lowPrice = Integer.parseInt(request.getParameter("low"));
    }
    if (request.getParameterMap().containsKey("high") && !request.getParameter("high").equals("")) {
        highPrice = Integer.parseInt(request.getParameter("high"));
    }
    if (lowPrice == highPrice) {
        Product p = ProductDao.getMostExpensiveProduct();
        if (p != null) {
            highPrice = (int)(Math.ceil(p.getUnitPrice() / 1000000));
        }
    }

   /* System.out.print(word + "-");
    System.out.print(cat + "-");
    System.out.print(man + "-");
    System.out.print(lowPrice + "-");
    System.out.print(highPrice + "-");
    System.out.print(sort + "-");
    System.out.print(dir + "-");
    System.out.print(currentPage + "-");
    System.out.println();*/

    //search products
    List<Product> list = null;
    try {
        list = ProductDao.search(word, cat, man, 1000000 * lowPrice, 1000000 * highPrice, sort, dir);
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (NamingException e) {
        e.printStackTrace();
    }

    /* generate page links */
    int size = 0;
    String pagination = "";
    int totalPages = 1;
    if (list != null) {
        size = list.size();
        totalPages = ((size % rows) == 0) ? (size / rows) : (size / rows) + 1;
        pagination = ProductJspGui.paginate("index.jsp?word=" + word + "&&cat=" + cat + "&&man=" + man + "&&low=" + lowPrice + "&&high=" + highPrice + "&&sort=" + sort + "&&dir=" + dir, currentPage, totalPages);  //generate page links
    }

    //get list of products for one page
    String grid;
    if (list != null && size != 0) {
        List<Product> subList = null;
        if (currentPage < totalPages) {
            subList = list.subList((currentPage - 1) * rows, currentPage * rows);
        } else {
            subList = list.subList((currentPage - 1) * rows, size);
        }
        grid = ProductJspGui.toGrid(subList);

        HttpSession session1 = request.getSession(false);

        if (session1 != null && session1.getAttribute("loggedUser") != null) {               //logged in
            User u = (User) session1.getAttribute("loggedUser");
            if (u.getRole().equals("admin")) {       //logged in as admin
                grid = ProductJspGui.toGridAdmin(subList);
            }
        }
    } else {
        grid = "<p>Sorry, we can't find your products</p>";
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
    <!--Login-->
    <link rel="stylesheet" href="css/loginfont.css"/>
    <link type="text/css" rel="stylesheet" href="css/loginstyle.css"/>
    <script type="text/javascript" src="js/log-reg.js"></script>
    <script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
    <script type="text/javascript" src="js/account.js"></script>
    <!--Tipped-->
    <link rel="stylesheet" type="text/css" href="css/tipped.css"/>
    <script type="text/javascript" src="js/tipped.js"></script>
    <script type="text/javascript" src="js/tooltip-add-prod.js"></script>
    <!--Tooltipster-->
    <link rel="stylesheet" type="text/css" href="css/tooltipster.css" />
    <link rel="stylesheet" type="text/css" href="css/tooltipster-shadow.css" />
    <link rel="stylesheet" type="text/css" href="css/tooltip.css" />
    <script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>
    <script type="text/javascript" src="js/tooltip.js"></script>
    <!--Creative buttons-->
    <script type="text/javascript" src="CreativeButtons/js/classie.js"></script>
    <script type="text/javascript" src="CreativeButtons/js/modernizr.custom.js"></script>
    <link rel="stylesheet" href="CreativeButtons/css/component.css"/>
    <!--Search & filter-->
    <script type="text/javascript" src="js/search-prod.js"></script>
    <!--Delete product-->
    <script type="text/javascript" src="js/del-prod.js"></script>
    <!--Update product-->
    <script type="text/javascript" src="js/update-prod.js"></script>
    <!--Admin modal-->
    <script type="text/javascript" src="js/admin-modal.js"></script>
    <link rel="stylesheet" type="text/css" href="css/modal-style.css" />
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

<!--Products area-->
<article id="grid">
    <header>
        <div class="paging">
            <%= pagination  %>      <!--page links-->
        </div>
        <input type="text" id="keyword" name="keyword" placeholder="Keyword"/>
        <select id="catFilter">
            <option value="" selected>Category...</option>
            <%= CategoryJspGui.toOption(CategoryDao.getAll()) %>
        </select>
        <select id="manFilter">
            <option value="" selected>Brand...</option>
            <%= ManufacturerJspGui.toOption(ManufacturerDao.getAll()) %>
        </select>
        <select id="priceFilter">
            <option value="" selected>Price...</option>
            <%= ProductJspGui.toPriceOption()%>
        </select>
        <select id="sortBy">
            <option value="" selected>Sort...</option>
            <option value="pri-asc">Cheapest</option>
            <option value="pri-desc">Highest price</option>
            <option value="imp-asc" hidden>Oldest</option>
            <option value="imp-desc">Newest</option>
            <option value="vie-asc" hidden>Fewest view</option>
            <option value="vie-desc">Most view</option>
            <option value="sal-asc" hidden>Poor buy</option>
            <option value="sal-desc">Best buy</option>
        </select>
        <button id="searchBtn"><i class="fa fa-search fa-flip-horizontal fa-border"></i></button>
    </header>

    <!--products will be displayed here-->
    <ul id="items">
        <%= grid %>
    </ul>

    <footer>
        <div class="paging">
            <%= pagination  %>      <!--page links-->
        </div>
    </footer>
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
