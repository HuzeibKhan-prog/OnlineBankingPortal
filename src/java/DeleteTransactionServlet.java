import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class DeleteTransactionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session Guard: Ensure user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String txnId = request.getParameter("txnId");

        if (txnId == null || txnId.trim().isEmpty()) {
            response.sendRedirect("history.jsp?status=delete_error");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            
            // 2. Secure Delete: Ensure the user owns this transaction (either as sender or receiver)
            String deleteQuery = "DELETE FROM transactions WHERE transaction_id = ? AND (sender_email = ? OR receiver_email = ?)";
            ps = con.prepareStatement(deleteQuery);
            ps.setString(1, txnId);
            ps.setString(2, userEmail);
            ps.setString(3, userEmail);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("history.jsp?status=deleted");
            } else {
                response.sendRedirect("history.jsp?status=delete_error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("history.jsp?status=delete_error");
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }
    }
}