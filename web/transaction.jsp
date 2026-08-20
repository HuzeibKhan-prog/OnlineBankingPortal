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
            if ("low_balance".equals(status)) {
                out.println("<p class='error-msg'>Transfer Failed: Insufficient funds in your account!</p>");
            } else if ("no_receiver".equals(status)) {
                out.println("<p class='error-msg'>Transfer Failed: Recipient email does not exist!</p>");
            } else if ("self_transfer".equals(status)) {
                out.println("<p class='error-msg'>Transfer Failed: You cannot transfer money to yourself!</p>");
            } else if ("error".equals(status)) {
                out.println("<p class='error-msg'>Transfer Failed due to a system error.</p>");
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