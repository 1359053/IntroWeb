package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

/**
 * Created by Son on 6/2/2015.
 */
public class ViewTrackingDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {
            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public ViewTrackingDao() {
    }

    public static ViewTracking getBySku(int sku) throws SQLException, NamingException {
        ViewTracking v = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM viewtracking WHERE sku = ?");
            pstmt.setInt(1, sku);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                v = new ViewTracking();

                v.setSku(rs.getInt("sku"));
                v.setTotalViews(rs.getInt("totalViews"));
                v.setLastView(rs.getTimestamp("lastView"));
                v.setLastUserId(rs.getString("lastUserId"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return v;
    }

    public static boolean updateTotalViews(int sku, String userId) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            ViewTracking v = getBySku(sku);
            PreparedStatement pstmt;
            Timestamp lastView = new Timestamp((new java.util.Date()).getTime());

            if (v == null) {
                pstmt = connection.prepareStatement("INSERT INTO viewtracking (sku, totalViews, lastView, lastUserId) VALUES (?,1,?,?)");
                pstmt.setInt(1, sku);
                pstmt.setTimestamp(2, lastView);
                pstmt.setString(3, userId);
            } else {
                pstmt = connection.prepareStatement("UPDATE viewtracking SET totalViews = IFNULL(totalViews, 0) + 1, lastView = ?, lastUserId = ? WHERE sku = ?");
                pstmt.setTimestamp(1, lastView);
                pstmt.setString(2, userId);
                pstmt.setInt(3, sku);
            }

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

        return success;
    }
}
