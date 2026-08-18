<%@page import="java.sql.*,com.bank.util.DBConnection"%>
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
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <div class="container">
        <h2>Welcome, <%= userName %>!</h2>
        <p class="link-text" style="margin-bottom: 20px;">
            Logged in as: <strong><%= userEmail %></strong>
        </p>
        
        <div style="background-color: #e2e8f0; padding: 20px; border-radius: 6px; text-align: center; margin-bottom: 20px;">
            <p style="margin: 0; color: #4a5568; font-size: 14px; font-weight: bold;">Account Balance</p>
            <h1 style="margin: 5px 0 0 0; color: #276749; font-size: 32px;">$<%= String.format("%.2f", currentBalance) %></h1>
        </div>

        <div style="display: flex; flex-direction: column; gap: 10px;">
            <a href="transaction.jsp"><button class="btn">Make a Money Transfer</button></a>
            <a href="history.jsp"><button class="btn" style="background-color: #4a5568;">View Transaction History</button></a>
            <a href="LogoutServlet"><button class="btn" style="background-color: #e53e3e;">Logout</button></a>
        </div>
    </div>

</body>
</html>