$(document).ready(function () {
    $('#searchBtn').click(function () {
        var keyword = $('#keyword').val().trim();
        //alert(keyword);

        var cat = $('#catFilter').val();
        //alert(cat);

        var man = $('#manFilter').val();
        //alert(man);

        var priceFilter = $('#priceFilter').val();
        var lowPrice = "";
        var highPrice = "";
        if (priceFilter != "") {
            var prices = priceFilter.split("-");
            lowPrice = prices[0].trim();
            highPrice = prices[1].trim();
        }
        //alert(highPrice);
        //alert(lowPrice);

        var sort = $('#sortBy').val();
        var sortBy = "";
        var sortDirection = "";
        if (sort != "") {
            var sorts = sort.split("-");
            sortBy = sorts[0].trim();
            sortDirection = sorts[1].trim();
        }
        //alert(sortBy);
        //alert(sortDirection);

        location.href = "index.jsp?word=" + keyword + "&&cat=" + cat + "&&man=" + man + "&&low=" + lowPrice + "&&high=" + highPrice + "&&sort=" + sortBy + "&&dir=" + sortDirection;
    })

    //$('#sortBy').val(${param.sort}-${param.dir});
})

$(document).ready(function () {
    var sort = getUrlParameter('sort');
    var dir = getUrlParameter('dir');
    if (sort.length > 0) {
        $('#sortBy').val(sort + "-" + dir);
    } else {
        $('#sortBy').val("");
    }

    var high = getUrlParameter('high');
    var low = getUrlParameter('low');
    if (high-low<=10&&high>=10&&!(low==0&&high<10)) {
        $('#priceFilter').val(low + " - " + high);
    } else {
        $('#priceFilter').val("");
    }

    var man = getUrlParameter('man');
    if (man > 0) {
        $('#manFilter').val(man);
    } else {
        $('#manFilter').val();
    }

    var cat = getUrlParameter('cat');
    if (cat > 0) {
        $('#catFilter').val(cat);
    } else {
        $('#catFilter').val();
    }

    $('#keyword').val(getUrlParameter('word'));
});

function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&&');
    for (var i = 0; i < sURLVariables.length; i++) {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) {
            if (sParameterName[1].length > 0) {
                return sParameterName[1];
            }
            else {
                return "";
            }
        }
    }
    return "";
}