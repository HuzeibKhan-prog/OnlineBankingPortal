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
        <title>Transfer Money</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>

        <div class="container">
            <h2>Fund Transfer</h2>
            <%
                String status = request.getParameter("status");

                if ("no_receiver".equals(status)) {
            %>
            <script type="text/javascript">
                alert("Transfer Failed: Recipient email does not exist!");
            </script>
            <%
            } else if ("self_transfer".equals(status)) {
            %>
            <script type="text/javascript">
                alert("Transfer Failed: You cannot transfer money to your own account!");
            </script>
            <%
            } else if ("low_balance".equals(status)) {
            %>
            <script type="text/javascript">
                alert("Transfer Failed: Insufficient balance!");
            </script>
            <%
            } else if ("success".equals(status)) {
            %>
            <script type="text/javascript">
                alert("Success: Transfer completed successfully!");
            </script>
            <%
                }
            %>

            <form action="TransactionServlet" method="post" onsubmit="this.querySelector('button[type=submit]').disabled = true;">
                <div class="form-group">
                    <label>Recipient Email:</label>
                    <input type="email" name="receiver" required placeholder="recipient@example.com">
                </div>

                <div class="form-group">
                    <label>Amount ($):</label>
                    <input type="number" step="0.01" min="0.01" name="amount" required placeholder="0.00">
                </div>

                <button type="submit" class="btn">Send Money</button>
            </form>
            <br>
            <p class="link-text">
                <a href="dashboard.jsp">Back to Dashboard</a>
            </p>
        </div>

    </body>
</html>