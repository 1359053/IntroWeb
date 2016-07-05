package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {

            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public CartDao() {
    }

    public static List<Cart> getByCus(String idCus) throws SQLException, NamingException {
        List<Cart> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM cart WHERE idCus=?");
            pstmt.setString(1, idCus);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();

                cart.setIdCart(rs.getInt("idCart"));
                cart.setIdCus(rs.getString("idCus"));
                cart.setPayStatus(rs.getString("payStatus"));
                cart.setAddress(rs.getString("address"));
                cart.setReceiver(rs.getString("receiver"));
                cart.setOrderDateTime(rs.getTimestamp("orderDateTime"));
                cart.setDelDatTime(rs.getTimestamp("delDateTime"));
                cart.setTotalPrice(rs.getDouble("totalPrice"));
                cart.setPhoneNumber(rs.getString("phoneNumber"));
                cart.setPostcode(rs.getString("postcode"));
                cart.setDelStatus(rs.getString("delStatus"));
                cart.setPayDateTime(rs.getTimestamp("payDateTime"));

                list.add(cart);
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static Cart getById(int idCart) throws SQLException, NamingException {
        Cart cart = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM cart WHERE idCart=?");
            pstmt.setInt(1, idCart);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                cart = new Cart();

                cart.setIdCart(rs.getInt("idCart"));
                cart.setIdCus(rs.getString("idCus"));
                cart.setPayStatus(rs.getString("payStatus"));
                cart.setAddress(rs.getString("address"));
                cart.setReceiver(rs.getString("receiver"));
                cart.setOrderDateTime(rs.getTimestamp("orderDateTime"));
                cart.setDelDatTime(rs.getTimestamp("delDateTime"));
                cart.setTotalPrice(rs.getDouble("totalPrice"));
                cart.setPhoneNumber(rs.getString("phoneNumber"));
                cart.setPostcode(rs.getString("postcode"));
                cart.setDelStatus(rs.getString("delStatus"));
                cart.setPayDateTime(rs.getTimestamp("payDateTime"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return cart;
    }

    public static int insert(Cart cart) throws SQLException, NamingException {
        int last_inserted_id = -1;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("INSERT INTO Cart (idCus,payStatus,address,receiver,orderDateTime,delDateTime,totalPrice,phoneNumber,postcode,delStatus,payDateTime) VALUES (?,?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, cart.getIdCus());
            pstmt.setString(2, cart.getPayStatus());
            pstmt.setString(3, cart.getAddress());
            pstmt.setString(4, cart.getReceiver());
            pstmt.setTimestamp(5, cart.getOrderDateTime());
            pstmt.setTimestamp(6, cart.getDelDatTime());
            pstmt.setDouble(7, cart.getTotalPrice());
            pstmt.setString(8, cart.getPhoneNumber());
            pstmt.setString(9, cart.getPostcode());
            pstmt.setString(10, cart.getDelStatus());
            pstmt.setTimestamp(11, cart.getPayDateTime());

            pstmt.executeUpdate();
            ResultSet rs = pstmt.getGeneratedKeys();

            if (rs.next()) {
                last_inserted_id = rs.getInt(1);
            }

            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return last_inserted_id;
    }

    public static boolean isExisted(int cartId) throws SQLException, NamingException {
        boolean existed = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Cart WHERE idCart=?");
            pstmt.setInt(1, cartId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                existed = true;
            }

            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return existed;
    }

    public static boolean delete(int cartId) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("DELETE FROM Cart WHERE idCart=?");
            pstmt.setInt(1, cartId);

            if (pstmt.executeUpdate() > 0) {
                success = true;
            }

            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return success;
    }

    public static boolean setPayDateTime(int cartId, Timestamp dt) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("UPDATE Cart SET payDateTime=?, payStatus=? WHERE idCart=?");
            pstmt.setTimestamp(1, dt);
            pstmt.setString(2,"PAID");
            pstmt.setInt(3, cartId);

            if (pstmt.executeUpdate() > 0) {
                success = true;
            }

            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return success;
    }

    public static boolean setDelDateTime(int cartId, Timestamp dt) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("UPDATE Cart SET delDateTime=?, delStatus=? WHERE idCart=?");
            pstmt.setTimestamp(1, dt);
            pstmt.setString(2,"DELIVERED");
            pstmt.setInt(3, cartId);

            if (pstmt.executeUpdate() > 0) {
                success = true;
            }

            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return success;
    }
}
