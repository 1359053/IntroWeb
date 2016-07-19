<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="preprocess.jsp" %>
<%
    //access page conditions
    boolean redirect = false;

    HttpSession session1 = request.getSession(false);
    if (session1 != null && session.getAttribute("loggedUser") != null) {               //logged in
        User u = (User) session.getAttribute("loggedUser");
        if (!u.getRole().equals("admin")) { //user is not administrator
            redirect = true;
        }
    } else {
        redirect = true;
    }

    if (redirect) {
        response.sendRedirect("index.jsp");
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
    <script type="text/javascript" src="/js/noty/packaged/jquery.noty.packaged.min.js"></script>
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
    <!--Admin modal-->
    <script type="text/javascript" src="js/admin-modal.js"></script>
    <link rel="stylesheet" type="text/css" href="css/modal-style.css"/>
    <!--Login-->
    <link rel="stylesheet" href="css/loginfont.css"/>
    <link type="text/css" rel="stylesheet" href="css/loginstyle.css"/>
    <script type="text/javascript" src="js/log-reg.js"></script>
    <script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
    <script type="text/javascript" src="js/account.js"></script>

    <script>
        $(window).load(function () {
            var intervalFunc = function () {
                $('#file-name').val($('#update_picture').val().replace('C:\\fakepath\\', ''));
            };
            $('#browse-click').on('click', function () {
                $('#update_picture').click();
                setInterval(intervalFunc, 1);
            });
            $('#upload-click').on('click', function () {
                $.ajax({
                    url: 'ServletAddProd',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        sessionName: 'model',
                        sessionValue: $('#update_model').val().trim()
                    },
                    success: function (data) {
                    }
                });
                $('#picture_submit').click();
                $('#upload_status').html('Please wait... <i class="fa fa-cog fa-lg fa-spin"></i>');
                setTimeout(function () {
                    var upload_status = $('#hiddenFrame').contents().find('body').html();
                    //alert(upload_status);
                    $('#upload_status').html(upload_status);
                }, 3000)
            });

            var intervalFunc_big = function () {
                $('#file-name-big').val($('#update_picture-big').val().replace('C:\\fakepath\\', ''));
            };
            $('#browse-click-big').on('click', function () {
                $('#update_picture-big').click();
                setInterval(intervalFunc_big, 1);
            });
            $('#upload-click-big').on('click', function () {
                $.ajax({
                    url: 'ServletAddProd',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        sessionName: 'model',
                        sessionValue: $('#update_model').val().trim()
                    },
                    success: function (data) {
                    }
                });
                $('#picture_submit-big').click();
                $('#upload_status-big').html('Please wait... <i class="fa fa-cog fa-lg fa-spin"></i>');
                setTimeout(function () {
                    var upload_status = $('#hiddenFrame-big').contents().find('body').html();
                    //alert(upload_status);
                    $('#upload_status-big').html(upload_status);
                }, 3000)
            });
        });

        $(document).ready(function () {
            $('button.continue').click(function () {
                var update_model = $('#update_model').val().trim();
                var update_price = $('#update_price').val().trim();
                var update_category = $('#update_category').val();
                var update_manufacturer = $('#update_manufacturer').val();
                var update_processor = $('#update_processor').val().trim();
                var update_ram = $('#update_ram').val().trim();
                var update_screen = $('#update_screen').val().trim();
                var update_hdd = $('#update_hdd').val().trim();
                var update_picture = update_model + "." + $('#update_picture').val().trim().replace('C:\\fakepath\\', '').split('.').pop();
                if ($('#update_picture').val().trim() == "") {
                    update_picture = "";
                }
                //alert(update_sku + '\n' + update_model + '\n' + update_price + '\n' + update_category + '\n' + update_manufacturer + '\n' + update_processor + '\n' + update_ram + '\n' + update_screen + '\n' + update_hdd + '\n' + update_picture);
                noty({
                    dismissQueue: 'true',
                    force: 'true',
                    layout: 'topCenter',
                    theme: 'relax',
                    timeout: 3000,
                    maxVisible: 1,
                    text: 'Please wait... <i class="fa fa-cog fa-lg fa-spin"></i>',
                    type: 'warning'
                });
                setTimeout(function () {
                    $.ajax({
                        url: 'ServletAddProd',
                        type: 'post',
                        dataType: 'json',
                        data: {
                            update_model: update_model,
                            update_price: update_price,
                            update_category: update_category,
                            update_manufacturer: update_manufacturer,
                            update_processor: update_processor,
                            update_ram: update_ram,
                            update_screen: update_screen,
                            update_hdd: update_hdd,
                            update_picture: update_picture
                        },
                        success: function (data) {
                            var sku = parseInt(data);
                            //alert('ok');
                            if (sku > 0) {
                                noty({
                                    dismissQueue: 'true',
                                    force: 'true',
                                    layout: 'topCenter',
                                    theme: 'relax',
                                    timeout: 10000,
                                    closeWith: ['click'],
                                    maxVisible: 1,
                                    text: '<i class="fa fa-check"></i>&nbsp;&nbsp; Product is created successfully!',
                                    type: 'success'
                                });
                                setTimeout(function () {
                                    window.location.href = "update.jsp?sku=" + sku;
                                }, 2500);
                            } else {
                                noty({
                                    dismissQueue: 'true',
                                    force: 'true',
                                    layout: 'topCenter',
                                    theme: 'relax',
                                    timeout: 10000,
                                    closeWith: ['click'],
                                    maxVisible: 1,
                                    text: '<i class="fa fa-times"></i>&nbsp;&nbsp; Creating failed!',
                                    type: 'error'
                                });
                            }
                            ;
                        }
                    });
                }, 3000)
            });
        })
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

<article id="update">
    <div id="breadcrumb">Create New Product</div>
    <div id="description">
        <input name="update_sku" value="" hidden/>

        <p><label>Model</label><input type="text" name="update_model" id="update_model" value=""/></p>

        <p><label>Price (VND)</label><input type="text" name="update_price" id="update_price" value=""/>
        </p>

        <p>
            <label>Category</label>
            <select id="update_category">
                <%= CategoryJspGui.toOption(CategoryDao.getAll()) %>
            </select>
        </p>

        <p>
            <label>Brand</label>
            <select id="update_manufacturer">
                <%= ManufacturerJspGui.toOption(ManufacturerDao.getAll()) %>
            </select>
        </p>

        <p><label>Processor</label><input type="text" name="update_processor" id="update_processor"
                                          value=""/></p>

        <p><label>RAM (GB)</label><input type="text" name="update_ram" id="update_ram" value=""/></p>

        <p><label>Screen (inches)</label><input type="text" name="update_screen" id="update_screen"
                                                value=""/></p>

        <p><label>HDD (GB)</label><input type="text" name="update_hdd" id="update_hdd" value=""/></p>

        <!---------------------------------------------------------------->
        <p><label>Small picture</label><input type="text" id="file-name" placeholder="No file chosen" disabled/></p>

        <p>
            <label>&nbsp;</label>
            <button id="browse-click" style="width: auto">Browse</button>
            <button id="upload-click" style="width: auto">Upload</button>
            <span id="upload_status"></span>
        </p>

        <iframe id="hiddenFrame" name="hiddenFrame" hidden></iframe>

        <form id="UploadForm" action="ServletUploadSmallImage" method="post" enctype="multipart/form-data"
              target="hiddenFrame"
              hidden>
            <input type="file" name="file" id="update_picture"/>
            <input type="submit" value="Upload" id="picture_submit"/>
        </form>

        <!---------------------------------------------------------------->
        <p><label>Big picture</label><input type="text" id="file-name-big" placeholder="No file chosen" disabled/></p>

        <p>
            <label>&nbsp;</label>
            <button id="browse-click-big" style="width: auto">Browse</button>
            <button id="upload-click-big" style="width: auto">Upload</button>
            <span id="upload_status-big"></span>
        </p>

        <iframe id="hiddenFrame-big" name="hiddenFrame-big" hidden></iframe>

        <form id="UploadForm-big" action="ServletUploadBigImage" method="post" enctype="multipart/form-data"
              target="hiddenFrame-big"
              hidden>
            <input type="file" name="file" id="update_picture-big"/>
            <input type="submit" value="Upload" id="picture_submit-big"/>
        </form>
        <!---------------------------------------------------------------->

        <button class='continue'><i class='fa fa-pencil'></i> Create</button>

        <div id="tabs">
            <ul>
            </ul>
        </div>
    </div>
    <div id="images"><img src='images/big/' title="Big image of product"></div>
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
