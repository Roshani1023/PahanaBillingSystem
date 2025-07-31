<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.*" %>
<%@ page contentType="application/json;charset=UTF-8" %>
<%
    String month = request.getParameter("month");
    JSONArray categoryLabels = new JSONArray();
    JSONArray categorySales = new JSONArray();
    double totalSales = 0, totalPaid = 0, totalBalance = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

        // Category-wise Sales (sum of item totals)
        String[] categories = {"School Books", "Stationery", "Charts"};
        for (String cat : categories) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT SUM(bi.total) as cat_total " +
                "FROM bill_items bi JOIN bills b ON bi.bill_id = b.id " +
                "JOIN items i ON i.name = bi.item_name " +
                "WHERE i.category = ?" +
                (month != null ? " AND DATE_FORMAT(b.bill_date, '%Y-%m') = ?" : "")
            );

            ps.setString(1, cat);
            if (month != null) ps.setString(2, month);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                categoryLabels.put(cat);
                categorySales.put(rs.getDouble("cat_total"));
            }
            rs.close(); ps.close();
        }

        // Total Sales Summary
        PreparedStatement totalStmt = conn.prepareStatement(
            "SELECT SUM(total_amount) as total, SUM(paid_amount) as paid, SUM(balance) as balance " +
            "FROM bills " +
            (month != null ? "WHERE DATE_FORMAT(bill_date, '%Y-%m') = ?" : "")
        );

        if (month != null) totalStmt.setString(1, month);

        ResultSet rs2 = totalStmt.executeQuery();
        if (rs2.next()) {
            totalSales = rs2.getDouble("total");
            totalPaid = rs2.getDouble("paid");
            totalBalance = rs2.getDouble("balance");
        }
        rs2.close(); totalStmt.close(); conn.close();

        // Return JSON
        JSONObject result = new JSONObject();
        result.put("categoryLabels", categoryLabels);
        result.put("categorySales", categorySales);
        result.put("totalSales", totalSales);
        result.put("totalPaid", totalPaid);
        result.put("totalBalance", totalBalance);

        out.print(result.toString());

    } catch (Exception e) {
        JSONObject err = new JSONObject();
        err.put("error", e.getMessage());
        out.print(err.toString());
    }
%>
