<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session Guard: Ensures user is logged in before accessing this page
    if (session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transfer Money - Online Banking Portal</title>
    <link rel="stylesheet" type="text/css" href="style.css?v=2">
</head>
<body>

    <div class="page-container">
        <div class="card">
            <div class="section-heading">
                <span>QUICK TRANSFER</span>
                <h1>Fund Transfer</h1>
                <p>Send money securely to another registered user.</p>
            </div>

            <%
                String status = request.getParameter("status");
                if (status != null) {
                    if ("no_receiver".equals(status)) {
            %>
                <div class="alert-error">Transfer Failed: Recipient email does not exist!</div>
            <%
                    } else if ("self_transfer".equals(status)) {
            %>
                <div class="alert-error">Transfer Failed: You cannot transfer money to your own account!</div>
            <%
                    } else if ("low_balance".equals(status)) {
            %>
                <div class="alert-error">Transfer Failed: Insufficient balance!</div>
            <%
                    } else if ("success".equals(status)) {
            %>
                <div class="alert-success">Success: Transfer completed successfully!</div>
            <%
                    }
                }
            %>

            <form action="TransactionServlet" method="post" onsubmit="this.querySelector('button[type=submit]').disabled = true;">
                <div class="form-group">
                    <label for="receiver">Recipient Email:</label>
                    <input type="email" id="receiver" name="receiver" class="form-control" placeholder="recipient@example.com" required>
                </div>

                <div class="form-group">
                    <label for="amount">Amount ($):</label>
                    <input type="number" id="amount" name="amount" class="form-control" step="0.01" min="0.01" placeholder="0.00" required>
                </div>

                <button type="submit" class="btn-primary">Send Money</button>
            </form>

            <a href="dashboard.jsp" class="link-secondary">Back to Dashboard</a>
        </div>
    </div>

</body>
</html>