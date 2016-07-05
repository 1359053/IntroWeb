package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {

            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public CategoryDao() {
    }

    //get all category
    public static List<Category> getAll() throws SQLException, NamingException {
        List<Category> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM category");

            while (rs.next()) {
                Category cat = new Category();

                cat.setCatId(rs.getInt("catId"));
                cat.setCatName(rs.getString("catName"));

                list.add(cat);
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

    public static Category getById(int id) throws SQLException, NamingException {
        Category cat = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM category WHERE catId = ?");
            pstmt.setInt(1, id);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                cat = new Category();

                cat.setCatId(rs.getInt("catId"));
                cat.setCatName(rs.getString("catName"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return cat;
    }

    public boolean update(Category cat) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("UPDATE Category SET catname=? WHERE catid=?");
            pstmt.setString(1, cat.getCatName());
            pstmt.setInt(2, cat.getCatId());

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

    public static boolean delete(int catId) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("DELETE FROM Category WHERE catId=?");
            pstmt.setInt(1, catId);

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

    public static boolean insert(String catName) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("INSERT INTO Category (catName) VALUES (?)");
            pstmt.setString(1, catName);

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

    public static boolean isExisted(int catId) throws SQLException, NamingException {
        boolean existed = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Category WHERE catId=?");
            pstmt.setInt(1, catId);

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

    public static boolean isExisted(String catName) throws SQLException, NamingException {
        boolean existed = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Category WHERE catName=?");
            pstmt.setString(1, catName);

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
}
