
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login | Pahana Edu Billing System</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                background: url("images/bg.jpg") no-repeat center center fixed;
                background-size: cover;
                font-family: 'Segoe UI', sans-serif;
            }

            .login-box {
                width: 380px;
                padding: 40px;
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(10px);
                color: #fff;
                border-radius: 20px;
                box-shadow: 0 0 20px rgba(0,0,0,0.3);
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            .login-box h2 {
                text-align: center;
                margin-bottom: 30px;
            }

            .login-box label {
                display: block;
                margin: 10px 0 5px;
                color: black;
            }

            .login-box input[type="text"],
            .login-box input[type="password"] {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 8px;
                margin-bottom: 20px;
                background-color: rgba(255,255,255,0.85);
                color: #000;
                font-size: 14px;
            }

            .login-box input[type="submit"] {
                width:105%;
                padding: 12px;
                background-color: #00aaff;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                color: white;
                cursor: pointer;
                transition: 0.3s;
            }

            .login-box input[type="submit"]:hover {
                background-color: #0077cc;
            }

            .error-msg {
                text-align: center;
                color: red;
                margin-top: 10px;
            }

            .alert-box {
                background-color: rgba(255, 100, 100, 0.15);
                border: 1px solid #ff6666;
                color: #fff;
                padding: 12px;
                border-radius: 10px;
                margin-top: 20px;
                font-weight: 500;
                text-align: center;
                backdrop-filter: blur(3px);
                box-shadow: 0 0 10px rgba(255, 0, 0, 0.2);
            }

        </style>
    </head>
    <body>
        <%
            String logout = request.getParameter("logout");
            if ("success".equals(logout)) {
        %>
        <div style="background-color: #d4edda; color: #155724; padding: 10px; border-left: 5px solid green; margin: 20px; border-radius: 8px;">
            You have been logged out successfully.
        </div>
        <%
            }
        %>

        <div class="login-box">
            <h2>Login</h2>
            <%
                String error = null;
                if (session != null) {
                    error = (String) session.getAttribute("error");
                    session.removeAttribute("error"); // removes it after showing once
                }
                if (error != null) {
            %>
            <div class="alert-box">
                ⚠ <%= error%>
            </div>
            <%
                }
            %>

            <form action="LoginServlet" method="post">
                <label>Username:</label>
                <input type="text" name="username" required>

                <label>Password:</label>
                <input type="password" name="password" required>

                <input type="submit" value="Login">
            </form>


        </div>

    </body>
</html>
