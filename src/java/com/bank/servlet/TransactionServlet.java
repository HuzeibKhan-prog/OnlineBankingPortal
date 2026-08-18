package com.bank.servlet;

import com.bank.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String sender = (String) session.getAttribute("userEmail");
        String receiver = request.getParameter("receiver");
        double transferAmount = Double.parseDouble(request.getParameter("amount"));

        // 1. Prevent self-transfer
        if (sender.equalsIgnoreCase(receiver)) {
            response.sendRedirect("transaction.jsp?status=self_transfer");
            return;
        }

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            // Enable manual transaction management
            con.setAutoCommit(false);
            // 2. Check if recipient exists in 'rega' table
            PreparedStatement checkReceiver = con.prepareStatement("SELECT balance FROM rega WHERE email = ?");
            checkReceiver.setString(1, receiver);
            ResultSet rsReceiver = checkReceiver.executeQuery();

            if (!rsReceiver.next()) {
                con.rollback(); 
                response.sendRedirect("transaction.jsp?status=no_receiver");
                return;
            }
            // 3. Check if sender has enough balance
            PreparedStatement checkSender = con.prepareStatement("SELECT balance FROM rega WHERE email = ?");
            checkSender.setString(1, sender);
            ResultSet rsSender = checkSender.executeQuery();

            if (rsSender.next()) {
                double currentBalance = rsSender.getDouble("balance");

                if (currentBalance < transferAmount) {
                    con.rollback(); 
                    response.sendRedirect("transaction.jsp?status=low_balance");
                    return;
                }
            }
            // 4. Deduct money from sender (-amount)
            PreparedStatement deductPs = con.prepareStatement("UPDATE rega SET balance = balance - ? WHERE email = ?");
            deductPs.setDouble(1, transferAmount);
            deductPs.setString(2, sender);
            deductPs.executeUpdate();
            // 5. Add money to receiver (+amount)
            PreparedStatement addPs = con.prepareStatement("UPDATE rega SET balance = balance + ? WHERE email = ?");
            addPs.setDouble(1, transferAmount);
            addPs.setString(2, receiver);
            addPs.executeUpdate();
            // 6. Generate unique Transaction ID (e.g., TXN84920481)
            String txnId = "TXN" + (int)(Math.random() * 90000000 + 10000000);
            // 7. Record entry into history table
            PreparedStatement insertTx = con.prepareStatement(
                "INSERT INTO transactions (transaction_id, sender_email, receiver_email, amount) VALUES (?, ?, ?, ?)"
            );
            insertTx.setString(1, txnId);
            insertTx.setString(2, sender);
            insertTx.setString(3, receiver);
            insertTx.setDouble(4, transferAmount);
            insertTx.executeUpdate();
            // Commit all balance updates and history logging atomically
            con.commit();
            response.sendRedirect("history.jsp?status=success");

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (Exception ex) {} 
            }
            e.printStackTrace();
            response.sendRedirect("transaction.jsp?status=error");
        } finally {
            if (con != null) {
                try { 
                    con.setAutoCommit(true); 
                    con.close(); 
                } catch (Exception e) {}
            }
        }
    }
}