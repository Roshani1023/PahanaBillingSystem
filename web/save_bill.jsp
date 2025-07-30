<%@page import="java.sql.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@ page contentType="text/plain;charset=UTF-8" %>

<%
    StringBuilder sb = new StringBuilder();
    String line;

    try {
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        // Parse JSON input
        JSONObject data = new JSONObject(sb.toString());

        String name = data.getString("customerName");
        String contact = data.getString("customerContact");
        String method = data.getString("paymentMethod");
        double total = data.getDouble("totalAmount");
        double paid = data.getDouble("paidAmount");
        double balance = data.getDouble("balance");

        JSONArray cart = data.getJSONArray("cartItems");

        // Connect to database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

        // Insert into bills table
        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO bills (customer_name, customer_contact, payment_method, total_amount, paid_amount, balance) VALUES (?, ?, ?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
        );
        ps.setString(1, name);
        ps.setString(2, contact);
        ps.setString(3, method);
        ps.setDouble(4, total);
        ps.setDouble(5, paid);
        ps.setDouble(6, balance);
        ps.executeUpdate();

        ResultSet keys = ps.getGeneratedKeys();
        int billId = 0;
        if (keys.next()) {
            billId = keys.getInt(1);
        }

        // Insert items into bill_items
        PreparedStatement itemStmt = conn.prepareStatement(
                "INSERT INTO bill_items (bill_id, item_name, quantity, price, total) VALUES (?, ?, ?, ?, ?)"
        );

        for (int i = 0; i < cart.length(); i++) {
            JSONObject item = cart.getJSONObject(i);
            String itemName = item.getString("name");
            double price = item.getDouble("price");
            int qty = item.getInt("qty");
            double itemTotal = price * qty;

            itemStmt.setInt(1, billId);
            itemStmt.setString(2, itemName);
            itemStmt.setInt(3, qty);
            itemStmt.setDouble(4, price);
            itemStmt.setDouble(5, itemTotal);
            itemStmt.executeUpdate();
        }

        conn.close();
        response.setContentType("application/json");
        out.print("{\"status\":\"success\",\"redirect\":\"invoice_preview.jsp?bill_id=" + billId + "\"}");

    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    }
%>

