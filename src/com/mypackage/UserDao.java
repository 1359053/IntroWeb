package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class UserDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {
            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public UserDao() {
    }

    public static User getById(String id) {
        User u = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM User WHERE id = ?");
            pstmt.setString(1, id);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                u = new User();

                u.setId(id);
                u.setPassword(rs.getString("password"));
                u.setName(rs.getString("name"));
                u.setAddress(rs.getString("address"));
                u.setPhone(rs.getString("phone"));
                u.setRole(rs.getString("role"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return u;
    }

    //Check if user is existed
    public static boolean isExisted(String id) {
        boolean existed = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM User WHERE id=?");
            pstmt.setString(1, id);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                existed = true;
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return existed;
    }

    public static boolean insert(User u) throws SQLException, NamingException {
        boolean success = false;

        if (!isExisted(u.getId())) {
            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
                Connection connection = ds.getConnection();

                PreparedStatement pstmt = connection.prepareStatement("INSERT INTO User (id, password, name, address, phone, role) VALUES (?,?,?,?,?,?)");
                pstmt.setString(1, u.getId());
                pstmt.setString(2, u.getPassword());
                pstmt.setString(3, u.getName());
                pstmt.setString(4, u.getAddress());
                pstmt.setString(5, u.getPhone());
                pstmt.setString(6, u.getRole());

                if (pstmt.executeUpdate() > 0) {
                    success = true;
                }

                pstmt.close();
                connection.close();
            } catch (SQLException sqle) {
                System.out.println("SQL Exception thrown: " + sqle);
            } catch (NamingException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    //Get all users
    public static List<User> getAll() throws SQLException, NamingException {
        List<User> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM User");

            while (rs.next()) {
                User u = new User();

                u.setId(rs.getString("id"));
                u.setPassword(rs.getString("password"));
                u.setName(rs.getString("name"));
                u.setAddress(rs.getString("address"));
                u.setPhone(rs.getString("phone"));
                u.setRole(rs.getString("role"));

                list.add(u);
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean update(User u) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();
            /*
            System.out.println(u.getName());
            System.out.println(u.getAddress());
            System.out.println(u.getPhone());
            System.out.println(u.getRole());
            System.out.println(u.getPassword());
            System.out.println(u.getId());
            */

            PreparedStatement pstmt;
            connection.prepareStatement("");
            if (u.getPassword() == null) {
                pstmt = connection.prepareStatement("UPDATE User SET name=?, address=?, phone=?, role=? WHERE id=?");
                pstmt.setString(1, u.getName());
                pstmt.setString(2, u.getAddress());
                pstmt.setString(3, u.getPhone());
                pstmt.setString(4, u.getRole());
                pstmt.setString(5, u.getId());
            } else {
                pstmt = connection.prepareStatement("UPDATE User SET password=? WHERE id=?");
                pstmt.setString(1, u.getPassword());
                pstmt.setString(2, u.getId());
            }
            //System.out.println(pstmt);


            if (pstmt.executeUpdate() > 0) {
                success = true;
            }

            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }
        //System.out.println(success);
        return success;
    }
}
