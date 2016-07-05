package com.mypackage;

import java.util.List;

public class CategoryJspGui {
    public static String toOption(List<Category> list) {
        StringBuilder sb = new StringBuilder();

        for (Category cat : list) {
            sb.append("<option value='" + cat.getCatId() + "'>" + cat.getCatName() + "</option>");
        }

        return sb.toString();
    }
}
