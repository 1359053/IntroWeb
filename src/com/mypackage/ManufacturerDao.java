package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ManufacturerDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {
            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public ManufacturerDao() {
    }

    //Get all manufacturers
    public static List<Manufacturer> getAll() throws SQLException, NamingException {
        List<Manufacturer> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from Manufacturer");

            while (rs.next()) {
                Manufacturer man = new Manufacturer();

                man.setManId(rs.getInt("manId"));
                man.setManName(rs.getString("manName"));

                list.add(man);
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

    public static Manufacturer getById(int id) throws SQLException, NamingException {
        Manufacturer man = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM manufacturer WHERE manId = ?");
            pstmt.setInt(1, id);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                man = new Manufacturer();

                man.setManId(rs.getInt("manId"));
                man.setManName(rs.getString("manName"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return man;
    }

    public static boolean isExisted(int manId) throws SQLException, NamingException {
        boolean existed = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Manufacturer WHERE manId=?");
            pstmt.setInt(1, manId);

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

    public static boolean isExisted(String manName) throws SQLException, NamingException {
        boolean existed = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Manufacturer WHERE manName=?");
            pstmt.setString(1, manName);

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

    public static boolean insert(String manName) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("INSERT INTO Manufacturer (manName) VALUES (?)");
            pstmt.setString(1, manName);

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

    public static boolean delete(int manId) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("DELETE FROM Manufacturer WHERE manId=?");
            pstmt.setInt(1, manId);

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
