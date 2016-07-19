$(document).ready(function () {
    var check_email = 0;
    var check_password = 0;
    var check_confirm_password = 0;
    var check_address = 0;
    var check_phone = 0;

    $("#modal_trigger").leanModal({top: 200, overlay: 0.6, closeButton: ".modal_close"});

    // Calling Login Form
    $("#login_form").click(function () {
        $(".social_login").hide();
        $(".user_login").show();
        return false;
    });

    // Calling Register Form 1
    $("#register_form").click(function () {
        $(".social_login").hide();
        $(".user_register").show();
        return false;
    });

    //Check email
    $("#reg_email").change(function () {
        var emailRegExp = new RegExp(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        var email = $(this).val().trim();
        if (email != "" && email.match(emailRegExp)) {
            $.ajax({
                url: "ServletCheckUserId",
                type: 'post',
                dataType: 'json',
                data: {userId: $(this).val()},
                success: function (data) {
                    if (data == false) {
                        check_email = 1;
                        $("#check_email").html("<i class='fa fa-check'></i>");
                    } else {
                        check_email = 0;
                        $("#check_email").html("already associated with an account! <i class='fa fa-times'></i>");
                    }
                }
            });
        } else {
            check_email = 0;
            $("#check_email").html("is invalid! <i class='fa fa-times'></i>");
        }
    });

    //check password
    $("#reg_password").change(function () {
        var pass = $(this).val().trim();
        if (pass != "") {
            if (pass.length >= 8 && pass.length <= 16) {
                check_password = 1;
                $("#check_password").html("<i class='fa fa-check'></i>");
            } else {
                check_password = 0;
                $("#check_password").html("length must be 8-16 characters! <i class='fa fa-times'></i>");
            }
        } else {
            check_password = 0;
            $("#check_password").html("can't be blank! <i class='fa fa-times'></i>");
        }
    });

    //check retyping password
    $("#reg_confirm_password").change(function () {
        if ($("#reg_password").val() == $("#reg_confirm_password").val() && check_password != 0) {
            check_confirm_password = 1;
            $("#check_match_password").html("<i class='fa fa-check'></i>");
        } else {
            check_confirm_password = 0;
            $("#check_match_password").html("is not match! <i class='fa fa-times'></i>");
        }
    });

    //check phone
    $("#reg_phone").change(function () {
        var phoneRegExp = new RegExp(/^(\(?(0|\+44)[1-9]{1}\d{1,4}?\)?\s?\d{3,4}\s?\d{3,4})$/);
        var phone = $(this).val().trim();
        if (phone.match(phoneRegExp)) {
            check_phone = 1;
            $("#check_phone").html("<i class='fa fa-check'></i>");
        } else {
            check_phone = 0;
            $("#check_phone").html("is invalid! <i class='fa fa-times'></i>");
        }
    });

    //check address
    $("#reg_address").change(function () {
        if ($(this).val().trim() != "") {
            check_address = 1;
            $("#check_address").html("<i class='fa fa-check'></i>");
        } else {
            check_address = 0;
            $("#check_address").html("can't be blank! <i class='fa fa-times'></i>");
        }
    });

    // Calling Register Form 2
    $("#reg2").click(function () {

        //Check email
        var emailRegExp = new RegExp(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        var email = $('#reg_email').val().trim();
        if (email != "" && email.match(emailRegExp)) {
            $.ajax({
                url: "ServletCheckUserId",
                type: 'post',
                dataType: 'json',
                data: {userId: email},
                success: function (data) {
                    if (data == false) {
                        check_email = 1;
                        $("#check_email").html("<i class='fa fa-check'></i>");
                    } else {
                        check_email = 0;
                        $("#check_email").html("had been used! <i class='fa fa-times'></i>");
                    }
                }
            });
        } else {
            check_email = 0;
            $("#check_email").html("can't be blank! <i class='fa fa-times'></i>");
        }

        //check password
        var pass = $("#reg_password").val().trim();
        if (pass != "") {
            if (pass.length >= 8 && pass.length <= 16) {
                check_password = 1;
                $("#check_password").html("<i class='fa fa-check'></i>");
            } else {
                check_password = 0;
                $("#check_password").html("length must be 8-16 characters! <i class='fa fa-times'></i>");
            }
        } else {
            check_password = 0;
            $("#check_password").html("can't be blank! <i class='fa fa-times'></i>");
        }
        //check retyping password
        if ($("#reg_password").val() == $("#reg_confirm_password").val() && check_password != 0) {
            check_confirm_password = 1;
            $("#check_match_password").html("<i class='fa fa-check'></i>");
        } else {
            check_confirm_password = 0;
            $("#check_match_password").html("not match! <i class='fa fa-times'></i>");
        }

        if (check_email == 1 && check_confirm_password == 1 && check_password == 1) { //all input is ok
            $(".user_register").hide();
            $(".user_register2").show();
        }
        return false;
    });

    // Going back to Social Forms
    $(".back_btn").click(function () {
        $(".user_login").hide();
        $(".user_register").hide();
        $(".user_register2").hide();
        $(".header_title").html('');
        $(".social_login").show();
        return false;
    });


    $("#reg_last").click(function () {
        var email = $("#reg_email").val().trim();
        var pass = $("#reg_password").val().trim();
        var name = $("#reg_name").val().trim();
        if(name==""){
            name = email;
        }
        var phone = $("#reg_phone").val().trim();
        var address = $("#reg_address").val().trim();

        //check phone
        var phoneRegExp = new RegExp(/^(\(?(0|\+44)[1-9]{1}\d{1,4}?\)?\s?\d{3,4}\s?\d{3,4})$/);
        if (phone.match(phoneRegExp)) {
            check_phone = 1;
            $("#check_phone").html("<i class='fa fa-check'></i>");
        } else {
            check_phone = 0;
            $("#check_phone").html("is invalid! <i class='fa fa-times'></i>");
        }

        //check address
        if (address != "") {
            check_address = 1;
            $("#check_address").html("<i class='fa fa-check'></i>");
        } else {
            check_address = 0;
            $("#check_address").html("can't be blank! <i class='fa fa-times'></i>");
        }

        if (check_phone == 1 && check_password == 1 && check_address == 1 && check_confirm_password == 1 && check_email == 1) {
            $(".user_register2").hide();
            $(".header_title").html('Please wait... <i class="fa fa-spin fa-cog fa-lg"></i>').css({
                color: 'gray'
            });
            setTimeout(function () {
                $.ajax({
                    url: "ServletUserReg",
                    type: 'post',
                    dataType: 'json',
                    data: {
                        id: email,
                        name: name,
                        password: pass,
                        address: address,
                        phone: phone
                    },
                    success: function (data) {
                        if (data == true) {
                            $(".header_title").html('Congratulation! Your new account is created.<br/>Signing in... <i class="fa fa-spin fa-cog fa-lg"></i>').css({
                                color: 'blue'
                            });
                            $(".popupBody").html();//all tags in popup will be replaced
                            setTimeout(function () {
                                $.ajax({
                                    url: 'ServletLogin',
                                    type: 'post',
                                    dataType: 'json',
                                    data: {id: email, password: pass},
                                    success: function (data) {
                                        if (data == "true") {
                                            location.reload();
                                        } else {
                                            $(".header_title").html(data).css({
                                                color: 'red'
                                            });
                                        }
                                    }
                                })
                            }, 3000)
                        }
                    }
                })
            }, 3000)
        }
        return false;
    });

    //login
    $("#login_email").change(function(){
        var emailRegExp = new RegExp(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        var email = $("#login_email").val().trim();
        if (email != "" && email.match(emailRegExp)) {
            $(".header_title").html("");
        }
    });

    //click event
    $("#log_last").click(function () {
        var emailRegExp = new RegExp(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        var email = $("#login_email").val().trim();
        var rememberChecked = $('#remember').is(':checked') ? 1 : 0;
        if (email.match(emailRegExp)) {
            $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
                color: 'gray'
            });
            setTimeout(function () {
                $.ajax({
                    url: "ServletLogin",
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if (data == "true") {
                            $(".header_title").html("Welcome back! You're signing in... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
                                color: 'blue'
                            });
                            setTimeout(function () {
                                location.reload();
                            }, 2500);
                        } else {
                            $(".header_title").html(data).css({
                                color: 'red'
                            });
                        }
                    },
                    data: {
                        id: email,
                        password: $("#login_password").val(),
                        rememberChecked: rememberChecked
                    }
                });
            }, 2500);
        } else {
            $(".header_title").html("Invalid email address. Please check! <i class='fa fa-times'></i>").css({
                color: 'red'
            });
        }
    });

    //enter event
    $('#login_email,#login_password,#remember').keypress(function (e) {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode == '13') {
            var rememberChecked = $('#remember').is(':checked') ? 1 : 0;
            var emailRegExp = new RegExp(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
            var email = $("#login_email").val().trim();
            if (email.match(emailRegExp)) {
                $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
                    color: 'gray'
                });
                setTimeout(function () {
                    $.ajax({
                        url: "ServletLogin",
                        type: 'post',
                        dataType: 'json',
                        success: function (data) {
                            if (data == "true") {
                                $(".header_title").html("Welcome back! You're signing in... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
                                    color: 'blue'
                                });
                                setTimeout(function () {
                                    location.reload();
                                }, 2500);
                            } else {
                                $(".header_title").html(data).css({
                                    color: 'red'
                                });
                            }
                        },
                        data: {
                            id: email,
                            password: $("#login_password").val(),
                            rememberChecked: rememberChecked
                        }
                    });
                }, 2500);
            } else {
                $(".header_title").html("Invalid email address. Please check! <i class='fa fa-times'></i>").css({
                    color: 'red'
                });
            }
        }
    });

});

//Đặt ở ngoài và sau document
function isNumber(n) {
    return !isNaN(parseFloat(n))
}