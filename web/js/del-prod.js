$(document).ready(function () {
    $('[id^=delBtn]').click(function () {
        var delProd = $(this);
        var sku = delProd.attr('id').substr(6);
        var model = $('#lnk2' + sku).html();
        //alert(sku);
        var n = noty({
            text: "<i class='fa fa-trash'></i>&nbsp;&nbsp; Do you want to remove " + model + " from your website and database?",
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
                        url: 'ServletDelProd',
                        type: 'post',
                        dataType: 'json',
                        data: {sku: sku},
                        success: function (data) {
                            //alert(data);
                            if (data == true) {
                                delProd.parent().fadeOut("slow", function () {
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
                                        text: '<i class="fa fa-check"></i>&nbsp;&nbsp; ' + model + ' is deleted successfully!',
                                        type: 'success'
                                    });
                                }, 1000);
                                setTimeout(function () {
                                    location.reload();
                                },2500);
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
                                    text: '<i class="fa fa-times"></i>&nbsp;&nbsp; Can not delete ' + model,
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
})