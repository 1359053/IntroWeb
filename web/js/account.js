$(document).ready(function () {
    $('#modal_acc_trigger').leanModal({top: 200, overlay: 0.6, closeButton: ".modal_close"});

    // Calling edit info form
    $("#info_form").click(function () {
        $(".social_acc").hide();
        $(".info_acc").show();
        return false;
    });

    // Calling change pass form
    $("#pass_form").click(function () {
        $(".social_acc").hide();
        $(".pass_acc").show();
        return false;
    });

    // Going back to Social acc forms
    $(".back_btn").click(function () {
        $(".pass_acc").hide();
        $(".info_acc").hide();
        $(".header_title").html("");
        $(".social_acc").show();
        return false;
    });

    var old_email = $("#old_email").val().trim();
    var old_name = $('#old_name').val().trim();
    var old_phone = $('#old_phone').val().trim();
    var old_add = $('#old_add').val().trim();
    var phoneRegExp = new RegExp(/^(\(?(0|\+44)[1-9]{1}\d{1,4}?\)?\s?\d{3,4}\s?\d{3,4})$/);

    //check update info
    var chk_name = -1;
    var chk_add = -1;
    var chk_phone = -1;

    //check name
    $("#info_name").change(function () {
        $(".header_title").html("");
        var name = $(this).val().trim();
        if (name == "") {
            name = old_email;
        }
        if (name != old_name) {
            chk_name = 1;
        }
    });

    //check phone
    $("#info_phone").change(function () {
        $(".header_title").html("");
        var phone = $(this).val().trim();
        if (phone.match(phoneRegExp) && phone != old_phone) {
            chk_phone = 1;
            $("#chk_phone").html("<i class='fa fa-check'></i>").css({color: 'blue'});
        } else {
            chk_phone = 0;
            $("#chk_phone").html("is invalid! <i class='fa fa-times'></i>").css({color: 'red'});
        }
    });

    //check address
    $("#info_add").change(function () {
        $(".header_title").html("");
        var add = $(this).val().trim();
        if (add != "" && add != old_add) {
            chk_add = 1;
            $("#chk_add").html("<i class='fa fa-check'></i>").css({color: 'blue'});
        } else {
            chk_add = 0;
            $("#chk_add").html("can't be blank! <i class='fa fa-times'></i>").css({color: 'red'});
        }
    });

    //update info
    $("#info_ok").click(function () {
        if (chk_add == -1 && chk_phone == -1 && chk_name == -1) {
            $(".header_title").html("Nothing change!").css({
                'color': 'red'
            });
        } else {
            var name = $("#info_name").val().trim();
            if (name == "") {
                name = old_email;
            }
            var phone = $("#info_phone").val().trim();
            var address = $("#info_add").val().trim();

            //check phone
            if (phone.match(phoneRegExp)) {
                chk_phone = 1;
                $("#chk_phone").html("<i class='fa fa-check'></i>").css({color: 'blue'});
            } else {
                chk_phone = 0;
                $("#chk_phone").html("is invalid! <i class='fa fa-times'></i>").css({color: 'red'});
            }

            //check address
            if (address != "") {
                chk_add = 1;
                $("#chk_add").html("<i class='fa fa-check'></i>").css({color: 'blue'});
            } else {
                chk_add = 0;
                $("#chk_add").html("can't be blank! <i class='fa fa-times'></i>").css({color: 'red'});
            }
            //alert(chk_name + "/" + chk_add + "/" + chk_phone);

            if (chk_add != 0 && chk_phone != 0 && chk_name != 0) {
                $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>");
                setTimeout(function () {
                    $.ajax({
                        url: "ServletAccEditInfo",
                        type: 'post',
                        dataType: 'json',
                        data: {
                            old_email: old_email,
                            name: name,
                            address: address,
                            phone: phone
                        },
                        success: function (data) {
                            if (data == "true") {
                                $(".header_title").html("Account information is updated! Refreshing... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
                                    'color': 'blue'
                                });
                                setTimeout(function () {
                                    location.reload();
                                }, 2500);
                            } else {
                                $(".header_title").html(data).css({
                                    'color': 'red'
                                });
                            }
                        }
                    });
                }, 2500);
            }
        }
    });

    //check password change
    var chk_old_pass = 0;
    var chk_new_pass = 0;
    var chk_new_pass_con = 0;

    //check old pass
    $("#old_pass").change(function () {
        if ($("#old_pass").val() == $("#old_key").val()) {
            chk_old_pass = 1;
            $("#chk_old_pass").html("<i class='fa fa-check'></i>").css({color:'blue'});
        }
        else {
            chk_old_pass = 0;
            $("#chk_old_pass").html("not match! <i class='fa fa-times'></i>").css({color:'red'});
        }
    });

    //check new pass
    $("#new_pass").change(function () {
        var pass = $(this).val().trim();
        if (pass != "") {
            if (pass.length >= 8 && pass.length <= 16) {
                chk_new_pass = 1;
                $("#chk_new_pass").html("<i class='fa fa-check'></i>").css({color:'blue'});
            } else {
                chk_new_pass = 0;
                $("#chk_new_pass").html("length must be 8-16 characters! <i class='fa fa-times'></i>").css({color:'red'});
            }
        } else {
            chk_new_pass = 0;
            $("#chk_new_pass").html("can't be blank! <i class='fa fa-times'></i>").css({color:'red'});
        }
    });

    //check new pass confirm
    $("#new_pass_con").change(function () {
        if ($("#new_pass").val() == $("#new_pass_con").val() && chk_new_pass != 0) {
            chk_new_pass_con = 1;
            $("#chk_new_pass_con").html("<i class='fa fa-check'></i>").css({color:'blue'});
        } else {
            chk_new_pass_con = 0;
            $("#chk_new_pass_con").html("not match! <i class='fa fa-times'></i>").css({color:'red'});
        }
    });

    //change pass
    $("#pass_ok").click(function () {
        //alert(chk_old_pass + "/" + chk_new_pass + "/" + chk_new_pass_con);

        //check old pass
        if ($("#old_pass").val() == $("#old_key").val()) {
            chk_old_pass = 1;
            $("#chk_old_pass").html("<i class='fa fa-check'></i>").css({color:'blue'});
        }
        else {
            chk_old_pass = 0;
            $("#chk_old_pass").html("not match! <i class='fa fa-times'></i>").css({color:'red'});
        }

        //check new pass
        var pass = $("#new_pass").val().trim();
        if (pass != "") {
            if (pass.length >= 8 && pass.length <= 16) {
                chk_new_pass = 1;
                $("#chk_new_pass").html("<i class='fa fa-check'></i>").css({color:'blue'});
            } else {
                chk_new_pass = 0;
                $("#chk_new_pass").html("length must be 8-16 characters! <i class='fa fa-times'></i>").css({color:'red'});
            }
        } else {
            chk_new_pass = 0;
            $("#chk_new_pass").html("can't be blank! <i class='fa fa-times'></i>").css({color:'red'});
        }

        //check new pass confirm
        if ($("#new_pass").val() == $("#new_pass_con").val() && chk_new_pass != 0) {
            chk_new_pass_con = 1;
            $("#chk_new_pass_con").html("<i class='fa fa-check'></i>").css({color:'blue'});
        } else {
            chk_new_pass_con = 0;
            $("#chk_new_pass_con").html("not match! <i class='fa fa-times'></i>").css({color:'red'});
        }

        if (chk_old_pass == 1 && chk_new_pass == 1 && chk_new_pass_con == 1) {
            $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>");
            setTimeout(function () {
                $.ajax({
                    url: "ServletAccEditPass",
                    type: 'post',
                    dataType: 'json',
                    data: {
                        old_email: old_email,
                        pass: pass
                    },
                    success: function (data) {
                        if (data == "true") {
                            $(".header_title").html("Account password is updated! Refreshing... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
                                'color': 'blue'
                            });
                            setTimeout(function () {
                                location.reload();
                            }, 2500);
                        } else {
                            $(".header_title").html(data).css({
                                'color': 'red'
                            });
                        }
                    }
                });
            }, 2500);
        }
    });
});