$(document).ready(function () {
    $('[id^=lnk1]').hover(function () {     //when hover on product image, display tooltip
        var id = $(this).attr('id');
        var sku = id.replace('lnk1', '');
        $.ajax({        //send sku to tooltip servlet
            url: 'ServletTooltip',
            type: 'post',
            dataType: 'json',
            data: {sku: sku},
            success: function (data) {
                //Tipped.create('#' + id, data, {skin: 'blue', fadeIn: 0, fadeOut: 0});
                $('#' + id).tooltipster({
                    theme: 'tooltipster-custom',
                    contentAsHTML: true,
                    interactive: true,
                    content: data
                });
                $('[id^=tooltipBtn]').click(function () {       //when button in tooltip is clicked, add product to basket
                    var id = $(this).attr('id');
                    var sku = id.replace('tooltipBtn', '');

                    //animation
                    var cart = $('#basketTotalCount');
                    var dragImg = $('#img' + sku);
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
            }
        });
    });
});