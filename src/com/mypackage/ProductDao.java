package com.mypackage;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ProductDao {
    static {
        try {
            // loads com.mysql.jdbc.Driver into memory
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnf) {
            System.out.println("Driver could not be loaded: " + cnf);
        }
    }

    public ProductDao() {
    }

    //Get all products
    public static List<Product> getAll() throws SQLException, NamingException {
        List<Product> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from Product");

            while (rs.next()) {
                Product p = new Product();

                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("unitPrice"));

                list.add(p);
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

    //Get products by page
    public static List<Product> getAllPaging(int page, int rowsPerPage) throws SQLException, NamingException {
        List<Product> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("select * from Product limit ?,?");
            pstmt.setInt(1, (page - 1) * rowsPerPage);
            pstmt.setInt(2, rowsPerPage);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("unitPrice"));

                list.add(p);
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return list;
    }

    //Get product by SKU
    public static Product getBySku(int sku) throws SQLException, NamingException {
        Product p = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("select * from Product where SKU = ?");
            pstmt.setInt(1, sku);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                p = new Product();
                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("unitPrice"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return p;
    }

    public static Product getMostExpensiveProduct() throws SQLException, NamingException {
        Product p = null;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("select * from Product ORDER BY unitPrice DESC limit 1");

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                p = new Product();
                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("unitPrice"));
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return p;
    }

    public static List<Product> search(String word, int cat, int man, double low, double high, String sort, String dir) throws SQLException, NamingException {
        List<Product> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * " +
                    "FROM Product " +
                    "WHERE (name LIKE ? or ? IS NULL) " +
                    "AND (catId = ? or ? = 0) " +
                    "AND (manId = ? or ? = 0) " +
                    "AND (unitPrice BETWEEN ? AND ?)");

            if (sort.equals("pri")) {   //sort by price
                pstmt = connection.prepareStatement("SELECT * " +
                        "FROM Product " +
                        "WHERE (name LIKE ? or ? IS NULL) " +
                        "AND (catId = ? or ? = 0) " +
                        "AND (manId = ? or ? = 0) " +
                        "AND (unitPrice BETWEEN ? AND ?) " +
                        "ORDER BY unitPrice " + dir);
            }
            if (sort.equals("imp")) {       //sort by import date time
                pstmt = connection.prepareStatement("SELECT * " +
                        "FROM Product p, Import i " +
                        "WHERE (p.name LIKE ? or ? IS NULL) " +
                        "AND (p.catId = ? or ? = 0) " +
                        "AND (p.manId = ? or ? = 0) " +
                        "AND (p.unitPrice BETWEEN ? AND ?) " +
                        "AND p.sku = i.sku " +
                        "ORDER BY i.importDateTime " + dir);
            }
            if (sort.equals("vie")) {       //sort by view count
                pstmt = connection.prepareStatement("SELECT * " +
                        "FROM Product p, ViewTracking v " +
                        "WHERE (p.name LIKE ? or ? IS NULL) " +
                        "AND (p.catId = ? or ? = 0) " +
                        "AND (p.manId = ? or ? = 0) " +
                        "AND (p.unitPrice BETWEEN ? AND ?) " +
                        "AND p.sku = v.sku " +
                        "ORDER BY v.totalViews " + dir);
            }
            if (sort.equals("sal")) {       //sort by sold count
                pstmt = connection.prepareStatement("SELECT d.sku, name, catId, manId, processor, ram, screen, hdd, picture, unitPrice , SUM(d.quantity) as soldCount " +
                        "FROM Product p, Cart c, Detail d " +
                        "WHERE (p.name LIKE ? or ? IS NULL) " +
                        "AND (p.catId = ? or ? = 0) " +
                        "AND (p.manId = ? or ? = 0) " +
                        "AND (p.unitPrice BETWEEN ? AND ?) " +
                        "AND p.sku = d.sku " +
                        "AND d.idCart = c.idCart " +
                        "AND c.status = 'paid' " +
                        "GROUP BY d.sku " +
                        "ORDER BY soldCount " + dir);
            }

            pstmt.setString(1, "%" + word + "%");
            pstmt.setString(2, word);
            pstmt.setInt(3, cat);
            pstmt.setInt(4, cat);
            pstmt.setInt(5, man);
            pstmt.setInt(6, man);
            pstmt.setDouble(7, low);
            pstmt.setDouble(8, high);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("unitPrice"));

                list.add(p);
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return list;
    }

    //insert a product
    public static int insert(Product p) throws SQLException, NamingException {
        int last_inserted_id = -1;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("INSERT INTO Product (manid, name, processor, ram, screen, hdd, picture, catid, unitPrice) VALUES (?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, p.getManId());
            pstmt.setString(2, p.getName());
            pstmt.setString(3, p.getProcessor());
            pstmt.setInt(4, p.getRam());
            pstmt.setDouble(5, p.getScreen());
            pstmt.setInt(6, p.getHdd());
            pstmt.setString(7, p.getPicture());
            pstmt.setInt(8, p.getCatId());
            pstmt.setDouble(9, p.getUnitPrice());

            pstmt.executeUpdate();
            ResultSet rs = pstmt.getGeneratedKeys();

            if (rs.next()) {
                last_inserted_id = rs.getInt(1);
            }

            pstmt.close();
            connection.close();

            ImportDao.insert(last_inserted_id);
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return last_inserted_id;
    }

    //delete a product by sku
    public static boolean deleteBySku(int sku) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("DELETE FROM Product WHERE SKU=?");
            pstmt.setInt(1, sku);

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

    public static boolean update(Product p) throws SQLException, NamingException {
        boolean success = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("UPDATE Product SET name=?, manid=?, processor=?, ram=?, screen=?, hdd=?, picture=?, catid=?, unitPrice=? WHERE SKU=?");
            pstmt.setString(1, p.getName());
            pstmt.setInt(2, p.getManId());
            pstmt.setString(3, p.getProcessor());
            pstmt.setInt(4, p.getRam());
            pstmt.setDouble(5, p.getScreen());
            pstmt.setInt(6, p.getHdd());
            pstmt.setString(7, p.getPicture());
            pstmt.setInt(8, p.getCatId());
            pstmt.setDouble(9, p.getUnitPrice());
            pstmt.setInt(10, p.getSku());

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

    public static boolean isExisted(int sku) throws SQLException, NamingException {
        boolean existed = false;

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Product WHERE sku=?");
            pstmt.setInt(1, sku);

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

    //Get all products
    public List<Product> getAllByCat(int catId) throws SQLException, NamingException {
        List<Product> list = new ArrayList<>();

      /*  String database = "ProductShop";
        String connectionURL = "jdbc:mysql://localhost:3306/" + database;
        String dbUser = "admin";
        String dbPassword = "123";

        Connection connection;*/

        try {
            //connection = DriverManager.getConnection(connectionURL, dbUser, dbPassword);
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();


            PreparedStatement pstmt = connection.prepareStatement("select * from Product where catid = ?");
            pstmt.setInt(1, catId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("unitPrice"));

                list.add(p);
            }
            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return list;
    }

    //get products by category and paging
    public List<Product> getByCatPaging(int catId, int page, int rows) throws SQLException, NamingException {
        List<Product> list = new ArrayList<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("select * from Product where catid = ? limit ?,?");
            pstmt.setInt(1, catId);
            pstmt.setInt(2, (page - 1) * rows);
            pstmt.setInt(3, rows);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("unitPrice"));

                list.add(p);
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return list;
    }

    //insert a list of products
    public List<Boolean> insert(List<Product> list) throws SQLException, NamingException {
        List<Boolean> success = null;

        if (list != null && list.size() > 0) {
            success = new ArrayList<>();

            for (Product p : list) {
                boolean succ = false;

                if (p != null && insert(p) > 0) {
                    succ = true;
                }

                success.add(succ);
            }
        }

        return success;
    }

    public Map<Import, Product> getNewestPaging(int page, int rows) throws SQLException, NamingException {
        Map<Import, Product> map = new LinkedHashMap<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Product p JOIN Import i ON p.sku = i.sku ORDER BY i.importDateTime DESC limit ?,?");
            pstmt.setInt(1, (page - 1) * rows);
            pstmt.setInt(2, rows);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                Import imp = new Import();

                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("p.unitPrice"));

                imp.setSku(rs.getInt("sku"));
                imp.setImportDateTime(rs.getTimestamp("importDateTime"));
                imp.setQuantity(rs.getInt("quantity"));
                imp.setUnitPrice(rs.getDouble("i.unitPrice"));

                map.put(imp, p);
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return map;
    }

    public Map<ViewTracking, Product> getMostView() throws SQLException, NamingException {
        Map<ViewTracking, Product> map = new LinkedHashMap<>();

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/myDB");
            Connection connection = ds.getConnection();

            PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Product p JOIN ViewTracking v ON p.sku = v.sku ORDER BY v.totalViews DESC limit 9");

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                ViewTracking v = new ViewTracking();

                p.setSku(rs.getInt("sku"));
                p.setName(rs.getString("name"));
                p.setCatId(rs.getInt("catId"));
                p.setManId(rs.getInt("manId"));
                p.setProcessor(rs.getString("processor"));
                p.setRam(rs.getInt("ram"));
                p.setScreen(rs.getDouble("screen"));
                p.setHdd(rs.getInt("hdd"));
                p.setPicture(rs.getString("picture"));
                p.setUnitPrice(rs.getDouble("p.unitPrice"));

                v.setSku(rs.getInt("sku"));
                v.setTotalViews(rs.getInt("totalViews"));
                v.setLastView(rs.getTimestamp("lastView"));
                v.setLastUserId(rs.getString("lastUserId"));

                map.put(v, p);
            }

            rs.close();
            pstmt.close();
            connection.close();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("SQL Exception thrown: " + sqle);
        }

        return map;
    }
}
