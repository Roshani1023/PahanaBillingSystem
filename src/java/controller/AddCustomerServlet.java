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
import java.io.IOException;
import java.sql.*;
import java.util.regex.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "AddCustomerServlet", urlPatterns = {"/AddCustomerServlet"})
public class AddCustomerServlet extends HttpServlet {

    private boolean isValidEmail(String email) {
        String emailRegex = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$";
        return Pattern.matches(emailRegex, email);
    }

    private boolean isValidContact(String contact) {
        return contact.matches("^\\d{10}$"); // 10 digits only
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //get form data
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // Validate input
        if (name == null || contact == null || email == null || address == null
                || name.trim().isEmpty() || contact.trim().isEmpty() || email.trim().isEmpty() || address.trim().isEmpty()) {

            response.sendRedirect("add_customer.jsp?error=Please fill in all fields.");
            return;
        }

        if (!isValidEmail(email)) {
            response.sendRedirect("add_customer.jsp?error=Invalid email format.");
            return;
        }

        if (!isValidContact(contact)) {
            response.sendRedirect("add_customer.jsp?error=Contact number must be exactly 10 digits.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

            // Insert into DB
            String sql = "INSERT INTO customers (name, contact, email, address) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, contact);
            stmt.setString(3, email);
            stmt.setString(4, address);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("add_customer.jsp?success=Customer added successfully!");
            } else {
                response.sendRedirect("add_customer.jsp?error=Failed to add customer.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add_customer.jsp?error=Something went wrong. Please try again.");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
            }
        }
    }

}
