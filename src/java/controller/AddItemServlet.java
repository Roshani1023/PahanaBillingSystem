/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.*;

@WebServlet(name = "AddItemServlet", urlPatterns = {"/AddItemServlet"})
public class AddItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");

        // Basic validation
        if (name == null || category == null || priceStr == null || stockStr == null
                || name.trim().isEmpty() || category.trim().isEmpty() || priceStr.trim().isEmpty() || stockStr.trim().isEmpty()) {
            response.sendRedirect("add_item.jsp?error=Please fill in all fields.");
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            if (price <= 0 || stock < 0) {
                response.sendRedirect("add_item.jsp?error=Invalid price or stock value.");
                return;
            }

            // DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

            // SQL Insert
            String sql = "INSERT INTO items (name, category, price, stock) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setDouble(3, price);
            stmt.setInt(4, stock);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("add_item.jsp?success=Item added successfully!");
            } else {
                response.sendRedirect("add_item.jsp?error=Failed to add item.");
            }

            stmt.close();
            conn.close();

        } catch (NumberFormatException e) {
            response.sendRedirect("add_item.jsp?error=Price and stock must be numeric.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add_item.jsp?error=Something went wrong. Try again.");
        }

    }

}
