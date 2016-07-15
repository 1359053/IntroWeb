<%@ include file="preprocess.jsp" %>
<%
    if ((session == null) || (session.getAttribute("loggedUser") == null) || (basketTotalCount == 0)) {               //not logged in
        response.sendRedirect("viewbasket.jsp");
    } else {
        User u = (User) session.getAttribute("loggedUser");
        request.setAttribute("user", u);
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
    <!--Cookie-->
    <script type="text/javascript" src="js/js.cookie.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var address;
            var receiver;
            var postCode;
            var phoneNumber;
            $("#payCartBtn").click(function () {
                noty({
                    text: "<i class='fa fa-credit-card'></i>&nbsp;&nbsp; Please check your information. Are you sure about shipping details?",
                    type: 'warning',
                    dismissQueue: 'true',
                    layout: 'topCenter',
                    theme: 'defaultTheme',
                    timeout: 10000,
                    maxVisible: 3,
                    buttons: [{
                        addClass: 'notyBtn notyBtn-primary', text: 'Ok', onClick: function ($noty) {
                            $noty.close();
                            if (($.trim($("#billAddress").val())) == "")
                                address = "";
                            else
                                address = $.trim($("#billAddress").val()) + ", " + $.trim($("#billCity").val()) + ", " + $.trim($("#billCountry").find("option:selected").text());
                            if ($.trim($("#billReceiver").val()) == "")
                                receiver = "";
                            else
                                receiver = $.trim($("#billReceiver").val()) + " " + $.trim($("#billLName").val());
                            postCode = $.trim($('#billZip').val());
                            phoneNumber = $.trim($('#billPhone').val());
                            $.ajax({
                                type: 'post',
                                dataType: 'json',
                                url: 'ServletCheckOut',
                                data: {
                                    address: address,
                                    receiver: receiver,
                                    postCode: postCode,
                                    phoneNumber: phoneNumber,
                                    method: 'online'
                                },
                                success: function (data) {
                                    $("#iddiv1").html(data);
                                    $("#iddiv2").html("You chose the other option");
                                }
                            });
                        }
                    }, {
                        addClass: 'notyBtn notyBtn-danger', text: 'Cancel', onClick: function ($noty) {
                            $noty.close();
                        }
                    }]
                })
            });

            $("#shipCartBtn").click(function () {
                noty({
                    text: "<i class='fa fa-truck'></i>&nbsp;&nbsp; Please check your information. Are you sure about shipping details?",
                    type: 'warning',
                    dismissQueue: 'true',
                    layout: 'topCenter',
                    theme: 'defaultTheme',
                    timeout: 10000,
                    maxVisible: 3,
                    buttons: [{
                        addClass: 'notyBtn notyBtn-primary', text: 'Ok', onClick: function ($noty) {
                            $noty.close();
                            if (($.trim($("#shipAddress").val())) == "")
                                address = "";
                            else
                                address = $.trim($("#shipAddress").val()) + ", " + $.trim($("#shipCity").val()) + ", " + $.trim($("#shipCountry").find("option:selected").text());
                            if ($.trim($("#shipReceiver").val()) == "")
                                receiver = "";
                            else
                                receiver = $.trim($("#shipReceiver").val()) + " " + $.trim($("#shipLName").val());
                            postCode = $.trim($('#shipZip').val());
                            phoneNumber = $.trim($('#shipPhone').val());
                            $.ajax({
                                type: 'post',
                                dataType: 'json',
                                url: 'ServletCheckOut',
                                data: {
                                    address: address,
                                    receiver: receiver,
                                    postCode: postCode,
                                    phoneNumber: phoneNumber,
                                    method: 'onDelivery'
                                },
                                success: function (data) {
                                    $("#iddiv2").html(data);
                                    $("#iddiv1").html("You chose the other option");
                                }
                            });
                        }
                    }, {
                        addClass: 'notyBtn notyBtn-danger', text: 'Cancel', onClick: function ($noty) {
                            $noty.close();
                        }
                    }]
                })
            });
        })
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

<article id="address">
    <div id="breadcrumb">Check out</div>
    <div><u>Note</u> If you don't give information on the receiver's name or the receiver's full address, the laptop(s)
        will be delivered under your registered name and to your registered address.
    </div>
    <div id="iddiv1">
        <p>
            <label for="billReceiver">Receiver</label>
            <input id="billReceiver" name="billReceiver" type="text" value="${user.name}">
        </p>

        <p>
            <label for="billAddress">Address</label>
            <input id="billAddress" name="billAddress" type="text" value="${user.address}">
        </p>

        <p>
            <label for="billCity">City</label>
            <input id="billCity" name="billCity" type="text" value="">
        </p>

        <p>
            <label for="billCountry">Country</label>
            <select id="billCountry" name="billCountry">
                <option value="AR">Argentina</option>
                <option value="AW">Aruba</option>
                <option value="AU">Australia</option>
                <option value="BS">Bahamas</option>
                <option value="BB">Barbados</option>
                <option value="BE">Belgium</option>
                <option value="BM">Bermuda</option>
                <option value="BR">Brazil</option>
                <option value="CA">Canada</option>
                <option value="KY">Cayman Islands</option>
                <option value="CL">Chile</option>
                <option value="CN">China (People's Republic)</option>
                <option value="CX">Christmas Island</option>
                <option value="CR">Costa Rica</option>
                <option value="CY">Cyprus</option>
                <option value="DK">Denmark</option>
                <option value="EG">Egypt</option>
                <option value="FI">Finland</option>
                <option value="FR">France</option>
                <option value="DE">Germany</option>
                <option value="GR">Greece</option>
                <option value="GU">Guam</option>
                <option value="GT">Guatemala</option>
                <option value="HK">Hong Kong</option>
                <option value="IS">Iceland</option>
                <option value="IE">Ireland (Republic of Ireland)</option>
                <option value="IL">Israel</option>
                <option value="IT">Italy</option>
                <option value="JM">Jamaica</option>
                <option value="JP">Japan</option>
                <option value="KW">Kuwait</option>
                <option value="LU">Luxembourg</option>
                <option value="MW">Malawi</option>
                <option value="MX">Mexico</option>
                <option value="MC">Monaco</option>
                <option value="NL">Netherlands (Holland)</option>
                <option value="AN">Netherlands Antilles</option>
                <option value="NZ">New Zealand</option>
                <option value="NO">Norway</option>
                <option value="PA">Panama</option>
                <option value="PE">Peru</option>
                <option value="PH">Philippines</option>
                <option value="PL">Poland</option>
                <option value="PT">Portugal</option>
                <option value="PR">Puerto Rico</option>
                <option value="SA">Saudi Arabia</option>
                <option value="SG">Singapore</option>
                <option value="ZA">South Africa</option>
                <option value="KP">South Korea (Republic of Korea)</option>
                <option value="ES">Spain</option>
                <option value="SE">Sweden</option>
                <option value="CH">Switzerland</option>
                <option value="TW">Taiwan</option>
                <option value="TH">Thailand</option>
                <option value="TT">Trinidad and Tobago</option>
                <option value="TR">Turkey</option>
                <option value="AE">United Arab Emirates</option>
                <option value="GB">United Kingdom</option>
                <option value="US">United States</option>
                <option value="UM">United States Minor Outlying Islands</option>
                <option value="VE">Venezuela</option>
                <option value="VI">Vietnam</option>
                <option value="VG">Virgin Islands (British)</option>
                <option value="" selected="selected"></option>
            </select>
        </p>
        <p>
            <label for="billZip">Post code</label>
            <input id="billZip" name="billZip" type="text">
        </p>

        <p>
            <label for="billPhone">Phone number</label>
            <input id="billPhone" name="billPhone" type="text" value="${user.phone}">
        </p>

        <p style="text-align: center">
            <button id="payCartBtn" class="continue"><i class='fa fa-credit-card'></i> Pay online</button>
        </p>
    </div>

    <div id="iddiv2">
        <p>
            <label for="shipReceiver">Receiver</label>
            <input name="shipReceiver" type="text" id="shipReceiver" value="${user.name}">
        </p>

        <p>
            <label for="shipAddress">Address</label>
            <input name="shipAddress" type="text" id="shipAddress" value="${user.address}">
        </p>

        <p>
            <label for="shipCity">City</label>
            <input name="shipCity" type="text" id="shipCity">
        </p>

        <p>
            <label for="shipCountry">Country</label>
            <select id="shipCountry" name="shipCountry">
                <option value="AR">Argentina</option>
                <option value="AW">Aruba</option>
                <option value="AU">Australia</option>
                <option value="BS">Bahamas</option>
                <option value="BB">Barbados</option>
                <option value="BE">Belgium</option>
                <option value="BM">Bermuda</option>
                <option value="BR">Brazil</option>
                <option value="CA">Canada</option>
                <option value="KY">Cayman Islands</option>
                <option value="CL">Chile</option>
                <option value="CN">China (People's Republic)</option>
                <option value="CX">Christmas Island</option>
                <option value="CR">Costa Rica</option>
                <option value="CY">Cyprus</option>
                <option value="DK">Denmark</option>
                <option value="EG">Egypt</option>
                <option value="FI">Finland</option>
                <option value="FR">France</option>
                <option value="DE">Germany</option>
                <option value="GR">Greece</option>
                <option value="GU">Guam</option>
                <option value="GT">Guatemala</option>
                <option value="HK">Hong Kong</option>
                <option value="IS">Iceland</option>
                <option value="IE">Ireland (Republic of Ireland)</option>
                <option value="IL">Israel</option>
                <option value="IT">Italy</option>
                <option value="JM">Jamaica</option>
                <option value="JP">Japan</option>
                <option value="KW">Kuwait</option>
                <option value="LU">Luxembourg</option>
                <option value="MW">Malawi</option>
                <option value="MX">Mexico</option>
                <option value="MC">Monaco</option>
                <option value="NL">Netherlands (Holland)</option>
                <option value="AN">Netherlands Antilles</option>
                <option value="NZ">New Zealand</option>
                <option value="NO">Norway</option>
                <option value="PA">Panama</option>
                <option value="PE">Peru</option>
                <option value="PH">Philippines</option>
                <option value="PL">Poland</option>
                <option value="PT">Portugal</option>
                <option value="PR">Puerto Rico</option>
                <option value="SA">Saudi Arabia</option>
                <option value="SG">Singapore</option>
                <option value="ZA">South Africa</option>
                <option value="KP">South Korea (Republic of Korea)</option>
                <option value="ES">Spain</option>
                <option value="SE">Sweden</option>
                <option value="CH">Switzerland</option>
                <option value="TW">Taiwan</option>
                <option value="TH">Thailand</option>
                <option value="TT">Trinidad and Tobago</option>
                <option value="TR">Turkey</option>
                <option value="AE">United Arab Emirates</option>
                <option value="GB">United Kingdom</option>
                <option value="US">United States</option>
                <option value="UM">United States Minor Outlying Islands</option>
                <option value="VE">Venezuela</option>
                <option value="VI">Vietnam</option>
                <option value="VG">Virgin Islands (British)</option>
                <option value="" selected="selected"></option>
            </select>
        </p>
        <p>
            <label for="shipZip">Post code</label>
            <input name="shipZip" type="text" id="shipZip">
        </p>

        <p>
            <label for="shipPhone">Phone number</label>
            <input id="shipPhone" name="shipPhone" type="text" value="${user.phone}">
        </p>

        <p style="text-align: center">
            <button id="shipCartBtn" class="continue"><i class='fa fa-truck'></i> Pay on delivery</button>
        </p>
    </div>
    <div id="tabs"><a href="viewbasket.jsp">Back to your basket</a></div>

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
