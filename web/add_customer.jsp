<%-- 
    Document   : add_customer
    Created on : Jul 28, 2025, 6:08:55 AM
    Author     : SHIMAR IMROOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Customer | Pahana Edu</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background: url("images/bg2.jpg") no-repeat center center fixed;
                background-size: cover;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .page-content {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 40px 20px;
            }

            .form-container {
                width: 400px;
                padding: 40px;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(12px);
                border-radius: 20px;
                box-shadow: 0 0 20px rgba(0,0,0,0.3);
                color: #000;
            }

            .form-container h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #000;
            }

            .form-group {
                position: relative;
                margin-bottom: 30px;
            }

            .form-group input {
                width: 100%;
                padding: 12px 10px;
                font-size: 16px;
                border: none;
                border-radius: 10px;
                background: rgba(255, 255, 255, 0.85);
                outline: none;
                color: #333;
            }

            .form-group label {
                position: absolute;
                top: 12px;
                left: 15px;
                font-size: 14px;
                color: #888;
                pointer-events: none;
                transition: 0.3s ease;
                background-color: transparent;
            }

            .form-group input:focus + label,
            .form-group input:not(:placeholder-shown) + label {
                top: -10px;
                left: 10px;
                background-color: #fff;
                padding: 0 5px;
                font-size: 12px;
                color: #ffaa00;
            }

            .form-container button {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 10px;
                background-color: #ffaa00;
                font-size: 16px;
                color: #000;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s;
            }

            .form-container button:hover {
                background-color: #e69500;
            }
            
            .message-box {
                margin-bottom: 20px;
                padding: 12px 18px;
                border-radius: 10px;
                font-weight: bold;
                text-align: center;
                animation: fadeIn 0.3s ease-in-out;
            }

            .success-box {
                background-color: rgba(144,238,144,0.2);
                border-left: 4px solid green;
                color: green;
            }

            .error-box {
                background-color: rgba(255,182,193,0.2);
                border-left: 4px solid #fa8072;
                color: #fa8072;
            }
        </style>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />


        <div class="page-content">


            <form class="form-container" action="AddCustomerServlet" method="post">
                <h2>Add New Customer</h2>
                <%
                    String success = request.getParameter("success");
                    String error = request.getParameter("error");
                %>

                <% if (success != null) {%>
                <div class="message-box success-box"><%= success%></div>
                <% } else if (error != null) {%>
                <div class="message-box error-box"><%= error%></div>
                <% }%>

                <div class="form-group">
                    <input type="text" name="name" required placeholder=" " />
                    <label>Full Name</label>
                </div>

                <div class="form-group">
                    <input type="text" name="contact" required placeholder=" " />
                    <label>Contact Number</label>
                </div>

                <div class="form-group">
                    <input type="email" name="email" required placeholder=" " />
                    <label>Email Address</label>
                </div>

                <div class="form-group">
                    <input type="text" name="address" required placeholder=" " />
                    <label>Address</label>
                </div>

                <button type="submit">Save Customer</button>
            </form>
        </div>
        <script>
            // Automatically hide success/error messages after 5 seconds
            setTimeout(() => {
                document.querySelectorAll(".message-box").forEach(div => div.style.display = 'none');
            }, 5000);
        </script>

    </body>

</html>
