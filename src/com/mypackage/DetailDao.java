package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Son on 6/6/2015.
 */
public class DetailDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {

            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public DetailDao() {
    }

    public static boolean insert(Detail detail) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("INSERT INTO Detail (idCart,sku,quantity) VALUES (?,?,?)");
            pstmt.setInt(1, detail.getIdCart());
            pstmt.setInt(2, detail.getSku());
            pstmt.setInt(3, detail.getQuantity());

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

    public static int getSoldCount(int sku) throws SQLException,NamingException{
        int count = 0;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT d.sku, SUM(quantity) AS soldCount FROM detail d, cart c WHERE d.sku = ? AND d.idCart = c.idCart AND c.status = 'PAID' GROUP BY d.sku");
            pstmt.setInt(1, sku);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()){
                count = rs.getInt("soldCount");
            }

            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return count;
    }

    public static List<Detail> getByIdCart(int idCart) throws SQLException, NamingException {
        List<Detail> details = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM detail WHERE idCart=?");
            pstmt.setInt(1, idCart);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Detail detail = new Detail();

                detail.setIdCart(rs.getInt("idCart"));
                detail.setSku(rs.getInt("sku"));
                detail.setQuantity(rs.getInt("quantity"));

                details.add(detail);
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return details;
    }
}
