package com.mypackage;

import javax.naming.NamingException;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

public class ProductJspGui {
    public static String toGrid(List<Product> list) {
        StringBuilder sb = new StringBuilder();

        for (Product p : list) {
            sb.append("<li>" +
                    "<a href='detail.jsp?sku=" + p.getSku() + "' id='lnk1" + p.getSku() + "'>" +
                    "<img src='images/small/" + p.getPicture() + "' alt='" + p.getName() + "' id='img" + p.getSku() + "'/>" +
                    "</a>" +
                    "<a href='detail.jsp?sku=" + p.getSku() + "' id='lnk2" + p.getSku() + "'>" + p.getName() + "</a>" +
                    "<strong>" + NumberFormat.getNumberInstance(Locale.US).format(p.getUnitPrice()) + " VND</strong>" +
                    "</li>");
        }

        return sb.toString();
    }

    public static String toGridAdmin(List<Product> list) {
        StringBuilder sb = new StringBuilder();

        for (Product p : list) {
            sb.append("<li>" +
                    "<a href='detail.jsp?sku=" + p.getSku() + "' id='lnk1" + p.getSku() + "'>" +
                    "<img src='images/small/" + p.getPicture() + "' alt='" + p.getName() + "' id='img" + p.getSku() + "'/>" +
                    "</a>" +
                    "<a href='detail.jsp?sku=" + p.getSku() + "' id='lnk2" + p.getSku() + "'>" + p.getName() + "</a>" +
                    "<strong>" + NumberFormat.getNumberInstance(Locale.US).format(p.getUnitPrice()) + " VND</strong>" +
                    "<button class='btn btn-5 btn-5a' id='delBtn" + p.getSku() + "'><i class='fa fa-trash fa-lg'></i></button>" +
                    "<button class='btn btn-5 btn-5a' id='updateBtn" + p.getSku() + "'><i class='fa fa-pencil fa-lg'></i></button>" +
                    "</li>");
        }

        return sb.toString();
    }

    public static String toTooltip(Product p) {
        StringBuilder data = new StringBuilder();

        data.append("<html>");
        data.append("<div id='tooltip'>");
        data.append("<p>" + p.getName() + "</p>");
        data.append("<p id='price'>" + NumberFormat.getNumberInstance(Locale.US).format(p.getUnitPrice()) + " VND </p>");
        data.append("<table><tr><td>Processor</td><td>" + p.getProcessor() + "</td></tr>");
        data.append("<tr><td>RAM</td><td>" + p.getRam() + " GB</td></tr>");
        data.append("<tr><td>Screen</td><td>" + p.getScreen() + " inches</td></tr>");
        data.append("<tr><td>HDD</td><td>" + p.getHdd() + "GB</td></tr></table>");
        data.append("<button value='" + p.getSku() + "' class='continue' id='tooltipBtn" + p.getSku() + "'><i class='fa fa-shopping-cart'></i> Add to cart</button>");
        data.append("</div>");
        data.append("</html>");

        return data.toString();
    }

    public static String paginate(String pageUrl, int current_page, int total_pages) {
        String pagination = "";

        if (total_pages > 0 && total_pages != 1 && current_page <= total_pages) { //verify total pages and current page number
            int right_links = current_page + 3;
            int previous = current_page - 1; //previous link
            int i;

            if (current_page > 1) {
                int previous_link = (previous == 0) ? 1 : previous;
                pagination += "<a href='" + pageUrl + "&&page=1' title='First'><i class='fa fa-angle-double-left'></i></a>&nbsp;"; //first link
                pagination += "<a href='" + pageUrl + "&&page=" + previous_link + "' title='Previous'><i class='fa fa-angle-left'></i></a>&nbsp;"; //previous link

                if (current_page - 2 > 1) {
                    pagination += " ... ";
                }

                for (i = (current_page - 2); i < current_page; i++) { //Create left-hand side links
                    if (i > 0) {
                        pagination += "<a href='" + pageUrl + "&&page=" + i + "' title='Page " + i + "'>" + i + "</a>&nbsp;";
                    }
                }
            }

            pagination += "<strong>" + current_page + "</strong>";

            for (i = current_page + 1; i < right_links; i++) { //create right-hand side links
                if (i <= total_pages) {
                    pagination += "&nbsp;<a href='" + pageUrl + "&&page=" + i + "' title='Page " + i + "'>" + i + "</a>";
                }
            }

            if (i - 1 < total_pages) {
                pagination += " ... ";
            }

            if (current_page < total_pages) {
                int next_link = (current_page + 2 > total_pages) ? total_pages : current_page + 1;
                pagination += "&nbsp;<a href='" + pageUrl + "&&page=" + next_link + "' title='Next'><i class='fa fa-angle-right'></i></a>"; //next link
                pagination += "&nbsp;<a href='" + pageUrl + "&&page=" + total_pages + "' title='Last'><i class='fa fa-angle-double-right'></i></a>&nbsp;"; //last link
            }

        }

        return pagination; //return pagination links
    }

    public static String toPriceOption() throws SQLException, NamingException {
        StringBuilder sb = new StringBuilder();

        Product p = ProductDao.getMostExpensiveProduct();

        double min = 0.0;
        double max = Math.ceil(p.getUnitPrice() / 1000000);
        double step = 10.0;
        int count = 0;

        while (min + count * step < max) {
            double low = min + count * step;
            double high = (low + step >= max) ? max : (low + step);
            String str = NumberFormat.getNumberInstance(Locale.US).format(low) + " - " + NumberFormat.getNumberInstance(Locale.US).format(high);
            sb.append("<option value='" + str + "'>" + str + " million VND</option>");
            count++;
        }

        return sb.toString();
    }
}
