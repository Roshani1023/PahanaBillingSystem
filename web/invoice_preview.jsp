<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int billId = Integer.parseInt(request.getParameter("bill_id"));
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String customerName = "", contact = "", payment = "";
    double total = 0, paid = 0, balance = 0;
    String billDate = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

        // Get bill details
        ps = conn.prepareStatement("SELECT * FROM bills WHERE id = ?");
        ps.setInt(1, billId);
        rs = ps.executeQuery();
        if (rs.next()) {
            customerName = rs.getString("customer_name");
            contact = rs.getString("customer_contact");
            payment = rs.getString("payment_method");
            total = rs.getDouble("total_amount");
            paid = rs.getDouble("paid_amount");
            balance = rs.getDouble("balance");
            billDate = rs.getString("bill_date");
        }
        rs.close();
        ps.close();
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Invoice Preview</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: #f9f9f9;
                padding: 40px;
            }
            .invoice {
                background: #fff;
                padding: 30px;
                border-radius: 12px;
                max-width: 700px;
                margin: auto;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            h2 { margin-top: 0; }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border-bottom: 1px solid #ccc;
                text-align: left;
            }
            .totals {
                margin-top: 20px;
                text-align: right;
            }
        </style>
    </head>
    <body>
        <div class="invoice">
            <h2>Invoice #<%= billId %></h2>
            <p><strong>Date:</strong> <%= billDate %></p>
            <p><strong>Customer:</strong> <%= customerName %></p>
            <p><strong>Contact:</strong> <%= contact %></p>
            <p><strong>Payment Method:</strong> <%= payment %></p>

            <table>
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Load items
                        ps = conn.prepareStatement("SELECT * FROM bill_items WHERE bill_id = ?");
                        ps.setInt(1, billId);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            String item = rs.getString("item_name");
                            int qty = rs.getInt("quantity");
                            double price = rs.getDouble("price");
                            double itemTotal = rs.getDouble("total");
                    %>
                    <tr>
                        <td><%= item %></td>
                        <td><%= qty %></td>
                        <td>LKR <%= price %></td>
                        <td>LKR <%= itemTotal %></td>
                    </tr>
                    <%
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                    %>
                </tbody>
            </table>

            <div class="totals">
                <p><strong>Total:</strong> LKR <%= total %></p>
                <p><strong>Paid:</strong> LKR <%= paid %></p>
                <p><strong>Balance:</strong> LKR <%= balance %></p>
            </div>
        </div>
    </body>
</html>

<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading invoice: " + e.getMessage() + "</p>");
    }
%>

