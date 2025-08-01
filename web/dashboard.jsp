<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch counts from the database
    int customerCount = 0;
    int itemCount = 0;
    int billCount = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

        Statement st = conn.createStatement();

        ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM customers");
        if (rs.next()) {
            customerCount = rs.getInt(1);
        }
        rs = st.executeQuery("SELECT COUNT(*) FROM items");
        if (rs.next()) {
            itemCount = rs.getInt(1);
        }
        rs = st.executeQuery("SELECT COUNT(*) FROM bills");
        if (rs.next()) {
            billCount = rs.getInt(1);
        }

        rs.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard | Pahana Edu Billing</title>
        <meta charset="UTF-8">
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #ffffff;
            }

            /* Navbar */
            .navbar {
                background-color: rgba(0, 0, 0, 0.95);
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .navbar .logo {
                color: white;
                font-size: 24px;
                font-weight: bold;
            }

            .navbar ul {
                list-style: none;
                display: flex;
                gap: 25px;
            }

            .navbar ul li {
                position: relative;
            }

            .navbar ul li a {
                text-decoration: none;
                color: #fff;
                padding: 8px 15px;
                border-radius: 5px;
                transition: background 0.3s;
            }

            .navbar ul li a:hover {
                background-color: #ffaa00;
                color: #000;
            }

            .navbar ul li ul {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                background-color: rgba(0, 0, 0, 0.95);
                border-radius: 8px;
                padding: 10px 0;
                z-index: 1000;
                min-width: 180px;
            }

            .navbar ul li:hover ul {
                display: block;
            }

            .navbar ul li ul li {
                display: block;
                width: 100%;
                padding: 5px 20px;
                margin: 5px 0;
            }

            .navbar ul li ul li a {
                display: block;
                color: #fff;
                padding: 8px 12px;
            }

            .navbar ul li ul li a:hover {
                background-color: #ffaa00;
                color: #000;
                border-radius: 5px;
            }

            /* Hero */
            .hero {
                text-align: center;
                padding: 80px 20px 20px;
            }

            .hero h1 {
                font-size: 36px;
                color: #000;
                font-family: 'Times New Roman';
            }

            .typewriter {
                display: inline-block;
                font-size: 22px;
                color: #ffaa00;
                white-space: nowrap;
                overflow: hidden;
                border-right: 2px solid #ffaa00;
                animation: typing 3s steps(40, end), blink 0.75s step-end infinite;
            }

            @keyframes typing {
                from { width: 0; }
                to { width: 100%; }
            }

            @keyframes blink {
                50% { border-color: transparent; }
            }

            /* About Section */
            .about-box {
                max-width: 800px;
                margin: 30px auto;
                padding: 20px 30px;
                font-size: 18px;
                color: #222;
                background-color: #fffbe6;
                border-left: 6px solid #ffaa00;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                animation: fadeIn 2s ease-in-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Stats */
            .stats {
                display: flex;
                justify-content: center;
                gap: 50px;
                margin: 60px 0;
                flex-wrap: wrap;
            }

            .stat-box {
                text-align: center;
                background: #fff8e1;
                padding: 20px 30px;
                border-radius: 12px;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
                transition: 0.3s;
            }

            .stat-box:hover {
                transform: scale(1.05);
                background-color: #fff1c1;
            }

            .stat-number {
                font-size: 48px;
                font-weight: bold;
                color: #ffaa00;
            }

            .stat-label {
                font-size: 18px;
                color: #555;
            }

            /* Footer */
            .footer {
                text-align: center;
                padding: 30px;
                color: #aaa;
                background-color: #f4f4f4;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <div class="navbar">
            <div class="logo">Pahana Edu 💡</div>
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li>
                    <a href="#">Manage</a>
                    <ul>
                        <li><a href="add_customer.jsp">Add Customer</a></li>
                        <li><a href="add_item.jsp">Add Item</a></li>
                        <li><a href="generate_bill.jsp">Generate Bill</a></li>
                    </ul>
                </li>
                <li><a href="view_reports.jsp">Reports</a></li>
                <li><a href="help.jsp">Help</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </div>

        <!-- Hero -->
        <div class="hero">
            <h1 class="typewriter">Welcome, <%= username%>. Have a nice day!</h1>
        </div>

        <!-- About -->
        <div class="about-box">
            <p>
                <strong>Pahana Educational Book Shop</strong> is a well-established store dedicated to providing a wide range of high-quality educational books, stationery, and school supplies. 
                From preschool activity books to advanced academic texts, we cater to learners of all levels. 
                Our friendly staff, organized layout, and affordable prices make the shopping experience smooth and satisfying. 
                At Pahana, we believe that every great future begins with the right book in hand.
            </p>
        </div>

        <!-- Stats -->
        <div class="stats">
            <div class="stat-box">
                <div id="customers" class="stat-number">0</div>
                <div class="stat-label">Customers</div>
            </div>
            <div class="stat-box">
                <div id="items" class="stat-number">0</div>
                <div class="stat-label">Items</div>
            </div>
            <div class="stat-box">
                <div id="bills" class="stat-number">0</div>
                <div class="stat-label">Bills Issued</div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            &copy; 2025 Pahana Edu Billing System. All rights reserved.
        </div>

        <!-- Count Animation Script -->
        <script>
            function animateCount(id, target) {
                let count = 0;
                const speed = 20;
                const increment = Math.ceil(target / 100);
                const el = document.getElementById(id);
                const timer = setInterval(() => {
                    count += increment;
                    if (count >= target) {
                        count = target;
                        clearInterval(timer);
                    }
                    el.textContent = count;
                }, speed);
            }

            window.onload = () => {
                animateCount("customers", <%= customerCount%>);
                animateCount("items", <%= itemCount%>);
                animateCount("bills", <%= billCount%>);
            };
        </script>

    </body>
</html>