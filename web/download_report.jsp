<%@ page import="java.sql.*" %>
<%@ page contentType="application/octet-stream" %>
<%
    String month = request.getParameter("month");
    response.setHeader("Content-Disposition", "attachment; filename=invoice_report_" + month + ".txt");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM bills WHERE DATE_FORMAT(bill_date, '%Y-%m') = ?");
        ps.setString(1, month);
        ResultSet rs = ps.executeQuery();

        out.println("Invoice Report for " + month);
        out.println("----------------------------------------------------");

        while (rs.next()) {
            out.println("Invoice ID: " + rs.getInt("id"));
            out.println("Customer: " + rs.getString("customer_name"));
            out.println("Contact: " + rs.getString("customer_contact"));
            out.println("Payment: " + rs.getString("payment_method"));
            out.println("Total: LKR " + rs.getDouble("total_amount"));
            out.println("Paid: LKR " + rs.getDouble("paid_amount"));
            out.println("Balance: LKR " + rs.getDouble("balance"));
            out.println("Date: " + rs.getString("bill_date"));
            out.println("----------------------------------------------------");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
