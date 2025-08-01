<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Reports | Pahana Edu</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                padding: 30px;
                background: #f2f2f2;
            }

            .report-container {
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 0 12px rgba(0,0,0,0.1);
                margin-bottom: 40px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 10px;
                border: 1px solid #ccc;
                text-align: left;
            }

            .controls {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            button {
                background-color: #ffaa00;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
            }

            button:hover {
                background-color: #e69500;
            }

            h2 {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="navbar.jsp" />

        <!--Monthly invoice-->
        <div class="report-container">
            <h2>Invoice Report</h2>

            <form method="get">
                <div class="controls">
                    <label>Select Month:</label>
                    <input type="month" name="month" value="<%= request.getParameter("month") != null ? request.getParameter("month") : ""%>" required />
                    <button type="submit">Filter</button>
                    <% if (request.getParameter("month") != null) {%>
                    <a href="download_report.jsp?month=<%= request.getParameter("month")%>">
                        <button type="button">Download Monthly Invoice</button>
                    </a>
                    <% } %>
                </div>
            </form>

            <table>
                <tr>
                    <th>Invoice ID</th>
                    <th>Customer</th>
                    <th>Contact</th>
                    <th>Payment</th>
                    <th>Total</th>
                    <th>Paid</th>
                    <th>Balance</th>
                    <th>Date</th>
                </tr>
                <%
                    if (request.getParameter("month") != null) {
                        String month = request.getParameter("month");
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");
                            PreparedStatement ps = conn.prepareStatement("SELECT * FROM bills WHERE DATE_FORMAT(bill_date, '%Y-%m') = ?");
                            ps.setString(1, month);
                            ResultSet rs = ps.executeQuery();

                            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id")%></td>
                    <td><%= rs.getString("customer_name")%></td>
                    <td><%= rs.getString("customer_contact")%></td>
                    <td><%= rs.getString("payment_method")%></td>
                    <td>LKR <%= rs.getDouble("total_amount")%></td>
                    <td>LKR <%= rs.getDouble("paid_amount")%></td>
                    <td>LKR <%= rs.getDouble("balance")%></td>
                    <td><%= rs.getString("bill_date")%></td>
                </tr>
                <%
                            }
                            rs.close();
                            ps.close();
                            conn.close();
                        } catch (Exception e) {
                            out.print("<tr><td colspan='8' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                        }
                    }
                %>
            </table>
        </div>
        <!-- CHARTS SECTION -->
        <div style="display: flex; justify-content: space-between; margin-top: 40px; gap: 20px;">
            <!-- Bar Chart -->
            <div style="flex: 1; background: #fff; padding: 20px; border-radius: 12px;">
                <h3>Category-wise Sales</h3>
                <canvas id="barChart" width="100%" height="80"></canvas>
            </div>

            <!-- Pie Chart -->
            <div style="flex: 1; background: #fff; padding: 20px; border-radius: 12px;">
                <h3>Sales Summary (This Month)</h3>
                <canvas id="pieChart" width="100%" style="max-height: 500px;"></canvas>
            </div>
        </div>

        <!-- Chart.js CDN -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script>
            // Fetch chart data from backend
            fetch('get_report_data.jsp<%= request.getParameter("month") != null ? "?month=" + request.getParameter("month") : ""%>')
                    .then(res => res.json())
                    .then(data => {
                        // Bar Chart
                        new Chart(document.getElementById("barChart"), {
                            type: 'bar',
                            data: {
                                labels: data.categoryLabels,
                                datasets: [{
                                        label: 'Sales (LKR)',
                                        backgroundColor: '#ffaa00',
                                        data: data.categorySales
                                    }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {display: false},
                                    title: {display: true, text: 'Category-wise Sales'}
                                }
                            }
                        });

                        // Pie Chart
                        new Chart(document.getElementById("pieChart"), {
                            type: 'pie',
                            data: {
                                labels: ['Total Sales', 'Total Paid', 'Total Balance'],
                                datasets: [{
                                        backgroundColor: ['#4CAF50', '#2196F3', '#f44336'],
                                        data: [data.totalSales, data.totalPaid, data.totalBalance]
                                    }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    title: {display: true, text: 'Sales Summary'}
                                }
                            }
                        });
                    });
        </script>


    </body>
</html>
