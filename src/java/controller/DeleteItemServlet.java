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
import javax.servlet.http.*;
import java.sql.*;

@WebServlet(name = "DeleteItemServlet", urlPatterns = {"/DeleteItemServlet"})
public class DeleteItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");
            String sql = "DELETE FROM items WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            int rowsDeleted = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rowsDeleted > 0) {
                response.sendRedirect("view_items.jsp?success=Item deleted successfully!");
            } else {
                response.sendRedirect("view_items.jsp?error=Failed to delete item.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_items.jsp?error=Something went wrong. Try again.");
        }
    }

}
