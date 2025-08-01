<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Help | Pahana Edu Billing System</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                background: #f2f2f2;
                font-family: 'Segoe UI', sans-serif;
            }

            .help-container {
                max-width: 900px;
                margin: 60px auto;
                background: #fff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0,0,0,0.15);
                animation: slideIn 0.8s ease-out;
            }

            @keyframes slideIn {
                from { opacity: 0; transform: translateY(30px); }
                to { opacity: 1; transform: translateY(0); }
            }

            h1 {
                text-align: center;
                color: #ffaa00;
                margin-bottom: 30px;
                transition: all 0.3s ease-in-out;
            }

            h2 {
                margin-top: 30px;
                color: #333;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
            }

            p {
                color: #444;
                line-height: 1.7;
            }

            ul {
                padding-left: 20px;
                margin-top: 10px;
            }

            li {
                margin-bottom: 8px;
            }

            .contact {
                background: #f9f9f9;
                padding: 20px;
                margin-top: 40px;
                border-radius: 10px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .nav-link {
                display: inline-block;
                margin-top: 15px;
                background: #ffaa00;
                color: #000;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: bold;
                transition: 0.3s ease;
            }

            .nav-link:hover {
                background: #e69900;
                transform: scale(1.05);
            }

            .faq {
                margin-top: 40px;
            }

            .faq-item {
                background: #fcfcfc;
                border: 1px solid #ddd;
                padding: 15px 20px;
                margin-bottom: 10px;
                border-radius: 10px;
                transition: 0.3s ease;
            }

            .faq-item:hover {
                background: #fffce0;
                transform: scale(1.01);
            }

            .faq-item h4 {
                margin: 0;
                color: #333;
            }

            .faq-item p {
                margin-top: 8px;
                font-size: 14px;
                color: #555;
            }
        </style>
    </head>
    <body>

        <jsp:include page="navbar.jsp" />
        <div class="help-container">
            <h1>Help & User Guide</h1>

            <h2>1. Introduction</h2>
            <p>Welcome to the <strong>Pahana Edu Billing System</strong>. This web-based solution helps streamline customer transactions, manage inventory, generate invoices, and analyze sales data through interactive reports.</p>

            <h2>2. Adding a Customer</h2>
            <ul>
                <li>Navigate to <strong>Customers</strong>.</li>
                <li>Click <strong>Add Customer</strong>.</li>
                <li>Enter customer’s name and contact, then submit.</li>
            </ul>

            <h2>3. Managing Items</h2>
            <ul>
                <li>Click <strong>Items</strong> in the navbar.</li>
                <li>Add new item by entering details and clicking Add.</li>
                <li>Edit or delete existing items from the table.</li>
            </ul>

            <h2>4. Generating a Bill</h2>
            <ul>
                <li>Select <strong>Generate Bill</strong>.</li>
                <li>Choose items from the left panel. They will appear in the right cart.</li>
                <li>Update quantities, fill customer & payment details.</li>
                <li>Click <strong>Generate Invoice</strong> to preview the invoice.</li>
            </ul>

            <h2>5. Reports</h2>
            <ul>
                <li>Go to <strong>Reports</strong>.</li>
                <li>Select a month to filter invoices.</li>
                <li>Below: View bar chart (category-wise) and pie chart (summary).</li>
                <li>Download button allows exporting invoice data.</li>
            </ul>

            <h2>6. Logout</h2>
            <p>Click the <strong>Logout</strong> button from the top navigation to safely exit the system.</p>

            <div class="faq">
                <h2>7. Frequently Asked Questions (FAQs)</h2>

                <div class="faq-item">
                    <h4>💡 How can I update the price of an item?</h4>
                    <p>Go to the Items section, find the item in the list and click the edit icon. You can then update the name or price.</p>
                </div>

                <div class="faq-item">
                    <h4>🧾 Can I reprint or view old invoices?</h4>
                    <p>Yes. Navigate to the Reports section, select a month, and all invoices for that month will be listed.</p>
                </div>

                <div class="faq-item">
                    <h4>📊 Why are my charts not updating?</h4>
                    <p>Ensure the correct month is selected in the report filter. Also, check if there are any invoices recorded for that month.</p>
                </div>

                <div class="faq-item">
                    <h4>🔒 How secure is the system?</h4>
                    <p>The system uses role-based access and basic server-side validations. Future versions may include authentication and backup options.</p>
                </div>
            </div>

            <div class="contact">
                <h3>Still Need Help?</h3>
                <p>Email us at <strong>support@pahanaedu.lk</strong> or call <strong>+94 77 123 4567</strong></p>
                <a href="dashboard.jsp" class="nav-link">⬅ Back to Dashboard</a>
            </div>
        </div>

    </body>
</html>