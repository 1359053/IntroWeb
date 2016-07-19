function toTitleCase(str) {
    return str.replace(/(?:^|\s)\w/g, function (match) {
        return match.toUpperCase();
    });
}

$(document).ready(function () {
    $('#modal_add_trigger').leanModal({top: 200, overlay: 0.6, closeButton: ".modal_close"});
    $('#modal_del_trigger').leanModal({top: 200, overlay: 0.6, closeButton: ".modal_close"});

//----------------------------add modal-------------------------
    // Calling add category form
    $("#add_cat_form").click(function () {
        $(".social_add").hide();
        $(".add_cat").show();
        return false;
    });

    // Calling add manufacturer form
    $("#add_man_form").click(function () {
        $(".social_add").hide();
        $(".add_man").show();
        return false;
    });

    // Going back to Social add forms
    $(".add_back_btn").click(function () {
        $(".add_man").hide();
        $(".add_cat").hide();
        $(".header_title").html("");
        $(".social_add").show();
        return false;
    });

    //add cat
    $("#add_cat_last").click(function () {
        $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>");
        setTimeout(function () {
            $.ajax({
                url: "ServletAddCat",
                type: 'post',
                dataType: 'json',
                data: {
                    catName: toTitleCase($("#cat_name").val().trim())
                },
                success: function (data) {
                    if (data == "true") {
                        $(".header_title").html("Category added! Refreshing page... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
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
    });

    //add man
    $("#add_man_last").click(function () {
        $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>");
        setTimeout(function () {
            $.ajax({
                url: "ServletAddMan",
                type: 'post',
                dataType: 'json',
                data: {
                    manName: $("#man_name").val().trim().toUpperCase()
                },
                success: function (data) {
                    if (data == "true") {
                        $(".header_title").html("Brand added! Refreshing page... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
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
    });

//----------------------------del modal-------------------------
    // Calling del category form
    $("#del_cat_form").click(function () {
        $(".social_del").hide();
        $(".del_cat").show();
        return false;
    });

    // Calling del category confirm
    $("#del_cat_last").click(function () {
        var cat_name_sel = $("#cat_name_sel");
        if (cat_name_sel.val().trim() != "") {
            $(".del_cat").hide();
            $(".header_title").html("");
            $("#del_cat_name").html(cat_name_sel.find("option:selected").text()).css({
                'font-weight':'bold'
            });
            $(".del_cat_confirm").show();
        } else {
            $(".header_title").html("Please choose a category first!").css({
                color: 'red'
            });
        }
        return false;
    });

    // Calling del manufacturer form
    $("#del_man_form").click(function () {
        $(".social_del").hide();
        $(".del_man").show();
        return false;
    });

    // Calling del manufacturer confirm
    $("#del_man_last").click(function () {
        var man_name_sel = $("#man_name_sel");
        if (man_name_sel.val().trim() != "") {
            $(".del_man").hide();
            $(".header_title").html("");
            $("#del_man_name").html(man_name_sel.find("option:selected").text()).css({
                'font-weight':'bold'
            });
            $(".del_man_confirm").show();
        } else {
            $(".header_title").html("Please choose a brand first!").css({
                color: 'red'
            });
        }
        return false;
    });

    // Going back to Social del forms
    $(".del_back_btn").click(function () {
        $(".del_man").hide();
        $(".del_cat").hide();
        $(".del_man_confirm").hide();
        $(".del_cat_confirm").hide();
        $(".header_title").html("");
        $(".social_del").show();
        return false;
    });

    //del cat
    $("#del_cat_ok").click(function () {
        $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>");
        setTimeout(function () {
            $.ajax({
                url: "ServletDelCat",
                type: 'post',
                dataType: 'json',
                data: {
                    catId: $("#cat_name_sel").val().trim()
                },
                success: function (data) {
                    if (data == "true") {
                        $(".header_title").html("Category deleted! Refreshing page... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
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
    });


    //del man
    $("#del_man_ok").click(function () {
        $(".header_title").html("Please wait... <i class='fa fa-cog fa-spin fa-lg'></i>");
        setTimeout(function () {
            $.ajax({
                url: "ServletDelMan",
                type: 'post',
                dataType: 'json',
                data: {
                    manId: $("#man_name_sel").val().trim()
                },
                success: function (data) {
                    if (data == "true") {
                        $(".header_title").html("Brand deleted! Refreshing page... <i class='fa fa-cog fa-spin fa-lg'></i>").css({
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
    });
});

