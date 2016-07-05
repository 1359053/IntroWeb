package com.mypackage;

import java.util.List;

public class UserJspGui {
    public static String toOption(List<User> list) {
        StringBuilder sb = new StringBuilder();

        for (User u : list) {
            sb.append("<option value='" + u.getId() + "'>" + u.getId() + "</option>");
        }

        return sb.toString();
    }
}
