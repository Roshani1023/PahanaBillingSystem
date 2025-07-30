<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Generate Bill | Pahana Edu</title>
        <style>
            * { box-sizing: border-box; }
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background: url("images/bg2.jpg") no-repeat center center fixed;
                background-size: cover;
            }
            .container {
                display: flex;
                padding: 20px;
                gap: 20px;
            }
            .left-panel, .right-panel {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(12px);
                padding: 20px;
                border-radius: 20px;
                box-shadow: 0 0 20px rgba(0,0,0,0.2);
                overflow-y: auto;
                max-height: 90vh;
            }
            .left-panel { flex: 1.3; }
            .right-panel { flex: 2; }

            .category-title {
                font-size: 18px;
                font-weight: bold;
                margin: 20px 0 10px;
                color: #000;
                border-bottom: 1px solid #ccc;
            }

            .item-bar {
                background: #fff;
                margin-bottom: 10px;
                padding: 10px 15px;
                display: flex;
                justify-content: space-between;
                border-radius: 10px;
                cursor: pointer;
                box-shadow: 0 0 5px rgba(0,0,0,0.1);
                transition: 0.3s;
            }

            .item-bar:hover {
                background-color: #fceba1;
            }

            .cart-item {
                background: #fff;
                padding: 12px 15px;
                border-radius: 8px;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 15px;
                box-shadow: 0 0 5px rgba(0,0,0,0.1);
            }


            .cart-item input[type=number] {
                width: 60px;
            }

            input, select, button {
                padding: 10px;
                width: 100%;
                margin-bottom: 15px;
                border-radius: 8px;
                border: none;
            }

            .total-section {
                font-size: 18px;
                font-weight: bold;
                margin: 15px 0;
                color: #000;
            }

            button {
                background: #ffaa00;
                color: #000;
                font-weight: bold;
                cursor: pointer;
            }

            button:hover {
                background-color: #e69500;
            }
        </style>
    </head>
    <body>

        <jsp:include page="navbar.jsp" />

        <div class="container">
            <!-- LEFT PANEL -->
            <div class="left-panel">
                <h2>Available Items</h2>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_billing", "root", "");

                        String[] categories = {"School Books", "Stationery", "Charts"};

                        for (String category : categories) {
                %>
                <div class="category-title"><%= category%></div>
                <%
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM items WHERE category=?");
                    ps.setString(1, category);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        String itemName = rs.getString("name");
                        double price = rs.getDouble("price");
                %>
                <div class="item-bar" onclick="addToCart('<%= itemName%>', <%= price%>)">
                    <span><%= itemName%></span>
                    <span>LKR <%= price%></span>
                </div>
                <%
                            }
                            rs.close();
                            ps.close();
                        }
                        conn.close();
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
                    }
                %>
            </div>

            <!-- RIGHT PANEL -->
            <div class="right-panel">
                <h2>Selected Items</h2>
                <div id="cart"></div>
                <div class="total-section">Total: LKR <span id="total">0.00</span></div>

                <h3>Customer Info</h3>
                <input type="text" id="customerName" placeholder="Customer Name" />
                <input type="text" id="customerContact" placeholder="Contact Number" />

                <h3>Payment</h3>
                <select id="paymentMethod">
                    <option>Cash</option>
                    <option>Card</option>
                </select>
                <input type="number" id="payingAmount" placeholder="Paying Amount" oninput="onPayingInputChange(this)" />
                <div class="total-section">Balance: LKR <span id="balance">0.00</span></div>

                <button onclick="generateInvoice()">Generate Invoice</button>
            </div>
        </div>

        <script>
            let cart = [];

            function addToCart(name, price) {
                const existing = cart.find(item => item.name === name);
                if (existing) {
                    existing.qty++;
                } else {
                    cart.push({name, price, qty: 1});
                }
                renderCart();
            }

            function renderCart() {
                const cartDiv = document.getElementById("cart");
                cartDiv.innerHTML = "";
                let total = 0;

                cart.forEach((item, index) => {
                    const itemTotal = item.qty * item.price;
                    total += itemTotal;

                    const row = document.createElement("div");
                    row.style.display = "flex";
                    row.style.alignItems = "center";
                    row.style.justifyContent = "space-between";
                    row.style.padding = "6px 0";
                    row.style.borderBottom = "1px solid #ccc";
                    row.style.fontSize = "15px";

                    // Name
                    const name = document.createElement("div");
                    name.textContent = item.name;
                    name.style.flex = "2";

                    // Quantity Controls
                    const qtyBox = document.createElement("div");
                    qtyBox.style.display = "flex";
                    qtyBox.style.alignItems = "center";
                    qtyBox.style.gap = "5px";

                    const minusBtn = document.createElement("button");
                    minusBtn.textContent = "−";
                    minusBtn.style.width = "30px";
                    minusBtn.style.padding = "2px 0";
                    minusBtn.onclick = () => {
                        if (item.qty > 1) {
                            item.qty--;
                            renderCart();
                        }
                    };

                    const qtyInput = document.createElement("input");
                    qtyInput.type = "number";
                    qtyInput.min = "1";
                    qtyInput.value = item.qty;
                    qtyInput.style.width = "40px";
                    qtyInput.style.textAlign = "center";
                    qtyInput.onchange = () => updateQty(index, qtyInput.value);

                    const plusBtn = document.createElement("button");
                    plusBtn.textContent = "+";
                    plusBtn.style.width = "30px";
                    plusBtn.style.padding = "2px 0";
                    plusBtn.onclick = () => {
                        item.qty++;
                        renderCart();
                    };

                    qtyBox.appendChild(minusBtn);
                    qtyBox.appendChild(qtyInput);
                    qtyBox.appendChild(plusBtn);

                    // Total Price
                    const price = document.createElement("div");
                    price.textContent = `${itemTotal.toFixed(2)}`;
                    price.style.flex = "1";
                    price.style.textAlign = "right";
                    price.style.marginRight = "10px";

                    // Delete Icon
                    const del = document.createElement("span");
                    del.innerHTML = "🗑";
                    del.style.cursor = "pointer";
                    del.style.color="red";
                    del.onclick = () => {
                        cart.splice(index, 1);
                        renderCart();
                    };

                    row.appendChild(name);
                    row.appendChild(qtyBox);
                    row.appendChild(price);
                    row.appendChild(del);

                    cartDiv.appendChild(row);
                });

                document.getElementById("total").innerText = total.toFixed(2);
                calculateBalance(document.getElementById("payingAmount").value);
            }

            function calculateBalance(paying) {
                const total = parseFloat(document.getElementById("total").innerText);
                const balance = parseFloat(paying || 0) - total;
                document.getElementById("balance").innerText = balance.toFixed(2);
            }

            function onPayingInputChange(input) {
                calculateBalance(input.value);
            }

            function generateInvoice() {
                alert("Invoice generated!");
                console.log(cart);
                }
        </script>

    </body>
</html>