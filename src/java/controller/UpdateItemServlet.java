/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;


@WebServlet(name = "UpdateItemServlet", urlPatterns = {"/UpdateItemServlet"})
public class UpdateItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");

        if (name == null || category == null || priceStr == null || stockStr == null
                || name.trim().isEmpty() || category.trim().isEmpty()) {
            response.sendRedirect("view_items.jsp?error=Please fill all fields correctly.");
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");
            String sql = "UPDATE items SET name=?, category=?, price=?, stock=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setDouble(3, price);
            stmt.setInt(4, stock);
            stmt.setInt(5, id);

            int rowsUpdated = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rowsUpdated > 0) {
                response.sendRedirect("view_items.jsp?success=Item updated successfully!");
            } else {
                response.sendRedirect("view_items.jsp?error=Failed to update item.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_items.jsp?error=Something went wrong. Try again.");
        }
    }
}
