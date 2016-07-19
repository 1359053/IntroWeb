$(document).ready(function () {
    $('[id^=updateBtn]').click(function () {
        var sku = $(this).attr('id').substring(9);
        //alert(sku);
        self.location = "update.jsp?sku="+sku;
    });
})