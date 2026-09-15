<%@page import="java.sql.*,db.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session Guard: Ensures user is logged in
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction History - Online Banking Portal</title>
    <link rel="stylesheet" type="text/css" href="style.css?v=3">
</head>
<body>

    <div class="page-container wide">
        <div class="card">
            <div class="section-heading">
                <span>ACCOUNT ACTIVITY</span>
                <h1>Transaction History</h1>
                <p>View all past outgoing and incoming transfers.</p>
            </div>

            <% if ("success".equals(request.getParameter("status"))) { %>
                <div class="alert-success">Transaction Completed Successfully!</div>
            <% } %>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Sender</th>
                        <th>Receiver</th>
                        <th>Amount</th>
                        <th>Date & Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            con = DBConnection.getConnection();
                            String query = "SELECT * FROM transactions WHERE sender_email = ? OR receiver_email = ? ORDER BY timestamp DESC";
                            ps = con.prepareStatement(query);
                            ps.setString(1, userEmail);
                            ps.setString(2, userEmail);
                            rs = ps.executeQuery();

                            boolean hasRecords = false;
                            while (rs.next()) {
                                hasRecords = true;

                                String sender = rs.getString("sender_email");
                                double amount = rs.getDouble("amount");

                                boolean isSent = userEmail.equalsIgnoreCase(sender);
                                String amountColor = isSent ? "#dc2626" : "#16a34a";
                                String prefix = isSent ? "-$" : "+$";
                    %>
                    <tr>
                        <td><%= rs.getString("transaction_id")%></td>
                        <td><%= sender%></td>
                        <td><%= rs.getString("receiver_email")%></td>
                        <td style="font-weight: 600; color: <%= amountColor%>;">
                            <%= prefix%><%= String.format("%.2f", amount)%>
                        </td>
                        <td><%= rs.getTimestamp("timestamp")%></td>
                    </tr>
                    <%
                            }
                            if (!hasRecords) {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: #64748b;">No transactions found.</td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='5' class='alert-error'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) {}
                            if (ps != null) try { ps.close(); } catch (SQLException e) {}
                            if (con != null) try { con.close(); } catch (SQLException e) {}
                        }
                    %>
                </tbody>
            </table>

            <a href="dashboard.jsp" class="link-secondary">Back to Dashboard</a>
        </div>
    </div>

</body>
</html>