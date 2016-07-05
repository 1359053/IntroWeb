package com.mypackage;

import java.util.List;

public class ManufacturerJspGui {
    public static String toNav(List<Manufacturer> list) {
        StringBuilder sb = new StringBuilder();

        for (Manufacturer man : list) {
            sb.append("<li><a href='index.jsp?man="+man.getManId()+"'>"+man.getManName()+"</a></li>");
        }

        return sb.toString();
    }

    public static String toOption(List<Manufacturer> list) {
        StringBuilder sb = new StringBuilder();

        for (Manufacturer man : list) {
            sb.append("<option value='" + man.getManId() + "'>" + man.getManName() + "</option>");
        }

        return sb.toString();
    }
}