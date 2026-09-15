<%@page import="java.sql.*, db.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    double currentBalance = 0.00;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT balance FROM rega WHERE email = ?");
        ps.setString(1, userEmail);
        rs = ps.executeQuery();
        if (rs.next()) {
            currentBalance = rs.getDouble("balance");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Online Banking Portal</title>
    <link rel="stylesheet" type="text/css" href="style.css?v=2">
</head>
<body>

    <div class="page-container">
        <div class="card">
            <div class="section-heading">
                <span>USER DASHBOARD</span>
                <h1>Welcome, <%= userName %>!</h1>
                <p>Logged in as: <strong><%= userEmail %></strong></p>
            </div>

            <div class="balance-card">
                <p class="balance-label">Account Balance</p>
                <h1 class="balance-amount">$<%= String.format("%.2f", currentBalance) %></h1>
            </div>

            <div class="action-stack">
                <a href="transaction.jsp" class="btn-primary" style="text-align: center; text-decoration: none;">Make a Money Transfer</a>
                <a href="history.jsp" class="btn-primary btn-secondary" style="text-align: center; text-decoration: none;">View Transaction History</a>
                <a href="LogoutServlet" class="btn-primary btn-danger" style="text-align: center; text-decoration: none;">Logout</a>
            </div>
        </div>
    </div>

</body>
</html>