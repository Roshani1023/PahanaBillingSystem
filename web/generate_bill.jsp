
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generate Bill | Pahana Edu</title>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background: url("images/bg2.jpg") no-repeat center center fixed;
                background-size: cover;
                min-height: 100vh;
            }

            .container {
                display: flex;
                padding: 20px;
                gap: 20px;
            }

            .left-panel, .right-panel {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                padding: 20px;
                border-radius: 20px;
                box-shadow: 0 0 20px rgba(0,0,0,0.2);
            }

            .left-panel {
                width: 40%;
            }

            .right-panel {
                width: 60%;
            }

            .item-card {
                background: #fff;
                padding: 10px;
                border-radius: 10px;
                box-shadow: 0 0 5px rgba(0,0,0,0.2);
                margin-bottom: 15px;
                cursor: pointer;
                transition: 0.3s;
            }

            .item-card:hover {
                background-color: #fdf0c2;
            }

            .item-card h4 {
                margin: 0;
                color: #333;
            }

            .cart-item {
                background: #fff;
                padding: 10px;
                border-radius: 8px;
                margin-bottom: 10px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .cart-item input[type=number] {
                width: 60px;
            }

            .total-section {
                margin-top: 20px;
                font-size: 20px;
                font-weight: bold;
                color: #222;
            }

            input, select, button {
                padding: 10px;
                width: 100%;
                margin-bottom: 15px;
                border-radius: 8px;
                border: none;
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

            <!-- Left Panel -->
            <div class="left-panel">
                <h3>Filter by Category</h3>
                <select>
                    <option>All</option>
                    <option>Books</option>
                    <option>Stationery</option>
                    <option>Charts</option>
                </select>

                <div class="item-card" onclick="addItem('Oxford Dictionary', 3200)">
                    <h4>Oxford Dictionary</h4>
                    <p>Price: LKR 3200</p>
                </div>

                <div class="item-card" onclick="addItem('Mathematical Box', 550)">
                    <h4>Mathematical Box</h4>
                    <p>Price: LKR 550</p>
                </div>
            </div>

            <!-- Right Panel -->
            <div class="right-panel">
                <h2>Selected Items</h2>
                <div id="cart"></div>
                <div class="total-section">Total: LKR <span id="total">0.00</span></div>

                <h3>Customer Info</h3>
                <input type="text" placeholder="Customer Name" />
                <input type="text" placeholder="Contact Number" />

                <h3>Payment</h3>
                <select>
                    <option>Cash</option>
                    <option>Card</option>
                </select>

                <input type="number" placeholder="Paying Amount" />
                <div class="total-section">Balance: LKR <span id="balance">0.00</span></div>

                <button onclick="generateInvoice()">Generate Invoice</button>
            </div>
        </div>

        <script>
            let cart = [];

            function addItem(name, price) {
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

                cart.forEach(item => {
                    total += item.qty * item.price;
                    cartDiv.innerHTML += `
                        <div class="cart-item">
                            <span>${item.name} - LKR ${item.price}</span>
                            <input type="number" value="${item.qty}" min="1" onchange="updateQty('${item.name}', this.value)" />
                        </div>
                    `;
                });

                document.getElementById("total").innerText = total.toFixed(2);
            }

            function updateQty(name, qty) {
                const item = cart.find(i => i.name === name);
                item.qty = parseInt(qty);
                renderCart();
            }

            function generateInvoice() {
                alert("Invoice will be generated!");
                // backend integration will go here later
            }
        </script>
    </body>

</html>
