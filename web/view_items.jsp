<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Items | Pahana Edu</title>
        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background: url("images/bg2.jpg") no-repeat center center fixed;
                background-size: cover;
            }

            .container {
                padding: 40px;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .message {
                text-align: center;
                font-weight: bold;
                margin-bottom: 20px;
                padding: 10px;
                border-radius: 10px;
            }

            .message.success {
                background-color: rgba(144,238,144,0.2);
                color: green;
                border-left: 4px solid green;
            }

            .message.error {
                background-color: rgba(255,182,193,0.2);
                color: #fa8072;
                border-left: 4px solid #fa8072;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: rgba(255,255,255,0.95);
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 14px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #ffaa00;
                color: #000;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .action-btn {
                padding: 8px 14px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
                color: white;
            }

            .edit-btn {
                background-color: #00b894;
            }

            .delete-btn {
                background-color: #d63031;
            }

            .edit-form {
                background-color: #fffde7;
                padding: 15px;
                margin-top: 10px;
                border: 1px solid #ffaa00;
                border-radius: 10px;
            }

            .edit-form input {
                padding: 10px;
                margin: 8px;
                width: 180px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .edit-form button {
                background-color: #ffaa00;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                cursor: pointer;
                color: #000;
                font-weight: bold;
            }
        </style>
    </head>
    <body>

        <jsp:include page="navbar.jsp" />

        <div class="container">
            <h2>Manage Items</h2>

            <%
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) {
            %>
            <div class="message success"><%= success%></div>
            <% } else if (error != null) {%>
            <div class="message error"><%= error%></div>
            <% } %>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price (LKR)</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>

                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM items");

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String category = rs.getString("category");
                            double price = rs.getDouble("price");
                            int stock = rs.getInt("stock");
                %>
                <tr>
                    <td><%= id%></td>
                    <td><%= name%></td>
                    <td><%= category%></td>
                    <td><%= price%></td>
                    <td><%= stock%></td>
                    <td>
                        <form action="DeleteItemServlet" method="post" style="display:inline;"onclick="return confirm('Are you sure you want to delete this item?');">
                            <input type="hidden" name="id" value="<%= id%>" />
                            <button type="submit" class="action-btn delete-btn">Delete</button>
                        </form>

                        <button onclick="toggleEditForm(<%= id%>)" class="action-btn edit-btn">Edit</button>
                    </td>
                </tr>
                <tr id="edit-form-<%= id%>" style="display:none;">
                    <td colspan="6">
                        <form class="edit-form" action="UpdateItemServlet" method="post">
                            <input type="hidden" name="id" value="<%= id%>">
                            <input type="text" name="name" value="<%= name%>" required>
                            <input type="text" name="category" value="<%= category%>" required>
                            <input type="number" name="price" value="<%= price%>" step="0.01" required>
                            <input type="number" name="stock" value="<%= stock%>" required>
                            <button type="submit">Update</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>

        <script>
            function toggleEditForm(id) {
                const formRow = document.getElementById("edit-form-" + id);
                formRow.style.display = formRow.style.display === "none" ? "table-row" : "none";
            }

            // Hide messages after 5 seconds
            setTimeout(() => {
                document.querySelectorAll(".message").forEach(div => div.style.display = 'none');
            }, 5000);
        </script>

    </body>

</html>
