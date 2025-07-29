
<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Customers | Pahana Edu</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background: #f9f9f9;
            }

            .container {
                padding: 40px;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 14px 18px;
                text-align: left;
                border: 1px solid #ddd;
            }

            th {
                background-color: #ffaa00;
                color: #000;
                font-weight: bold;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .action-icons {
                display: flex;
                gap: 10px;
            }

            .action-icons a {
                text-decoration: none;
                font-size: 18px;
                color: #333;
                transition: 0.3s;
                cursor: pointer;
            }

            .action-icons a:hover {
                color: #ffaa00;
            }

            .edit-form td {
                background-color: #ffffe0;
            }

            .edit-form input[type="text"],
            .edit-form input[type="email"] {
                width: 95%;
                padding: 6px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .edit-form button {
                padding: 8px 12px;
                border: none;
                background-color: #ffaa00;
                color: black;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
        <script>
            function toggleEdit(id) {
                var formRow = document.getElementById("edit-row-" + id);
                formRow.style.display = formRow.style.display === "table-row" ? "none" : "table-row";
            }
        </script>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
        %>

        <% if (success != null) {%>
        <div style="background-color: rgba(144,238,144,0.2); border-left: 4px solid green; color: green; padding: 10px 20px; margin: 15px auto; width: 90%; border-radius: 10px; font-weight: bold;">
            <%= success%>
        </div>
        <% } else if (error != null) {%>
        <div style="background-color: rgba(255,182,193,0.2); border-left: 4px solid #fa8072; color: #fa8072; padding: 10px 20px; margin: 15px auto; width: 90%; border-radius: 10px; font-weight: bold;">
            <%= error%>
        </div>
        <% } %>

        <div class="container">
            <h2>Customer List</h2>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>Contact</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        int count = 1;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM customers";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                int customerId = rs.getInt("id");
                                String name = rs.getString("name");
                                String contact = rs.getString("contact");
                                String email = rs.getString("email");
                                String address = rs.getString("address");
                    %>
                    <tr>
                        <td><%= count++%></td>
                        <td><%= name%></td>
                        <td><%= contact%></td>
                        <td><%= email%></td>
                        <td><%= address%></td>
                        <td class="action-icons">
                            <a onclick="toggleEdit(<%= customerId%>)">🖉</a>
                            <a href="DeleteCustomerServlet?id=<%= customerId%>" onclick="return confirm('Are you sure you want to delete this customer?');">🗑</a>
                        </td>
                    </tr>
                    <tr id="edit-row-<%= customerId%>" class="edit-form" style="display: none;">
                <form action="UpdateCustomerServlet" method="post">
                    <input type="hidden" name="id" value="<%= customerId%>" />
                    <td colspan="6">
                        <table style="width:100%; border:none;">
                            <tr>
                                <td><input type="text" name="name" value="<%= name%>" required></td>
                                <td><input type="text" name="contact" value="<%= contact%>" required></td>
                                <td><input type="email" name="email" value="<%= email%>" required></td>
                                <td><input type="text" name="address" value="<%= address%>" required></td>
                                <td colspan="2"><button type="submit">Update</button></td>
                            </tr>
                        </table>
                    </td>
                </form>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6'>Error loading data: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) {
                            rs.close();
                        }
                        if (stmt != null) {
                            stmt.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
        <!--Success error message disapear in 5s-->
        <script>
            setTimeout(() => {
                document.querySelectorAll("div[style*='border-left']").forEach(div => div.style.display = 'none');
            }, 5000);
        </script>

    </body>

</html>
