package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class ImportDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {

            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public ImportDao() {
    }

    public static Import getBySku(int sku) throws SQLException, NamingException {
        Import anImport = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM import WHERE sku = ?");
            pstmt.setInt(1, sku);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                anImport = new Import();

                anImport.setSku(rs.getInt("sku"));
                anImport.setQuantity(rs.getInt("quantity"));
                anImport.setImportDateTime(rs.getTimestamp("importDateTime"));
                anImport.setUnitPrice(rs.getDouble("unitPrice"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return anImport;
    }

    public static boolean insert(int sku) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("INSERT INTO Import (sku, importDateTime) VALUES (?,?)");
            pstmt.setInt(1, sku);
            pstmt.setTimestamp(2, new Timestamp((new java.util.Date()).getTime()));

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
