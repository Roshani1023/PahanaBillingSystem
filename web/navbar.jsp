<%-- 
    Document   : navbar
    Created on : Jul 28, 2025, 6:13:59 AM
    Author     : SHIMAR IMROOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
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

            /* Dropdown */
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
                text-decoration: none;
                padding: 8px 12px;
                transition: 0.3s;
            }

            .navbar ul li ul li a:hover {
                background-color: #ffaa00;
                color: #000;
                border-radius: 5px;
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
                    <a href="#">Customer</a>
                    <ul>
                        <li><a href="add_customer.jsp">Add Customer</a></li>
                        <li><a href="view_customers.jsp">Manage Customers</a></li>
                        
                    </ul>
                </li>
                <li>
                    <a href="#">Items</a>
                    <ul>
                        
                        <li><a href="add_item.jsp">Add Item</a></li>
                        <li><a href="view_items.jsp">Manage Items</a></li>
                        
                    </ul>
                </li>
                <li><a href="generate_bill.jsp">Generate Bill</a></li>
                <li><a href="view_reports.jsp">Reports</a></li>
                <li><a href="help.jsp">Help</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </body>
</html>
