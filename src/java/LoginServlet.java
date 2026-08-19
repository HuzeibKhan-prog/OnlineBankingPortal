import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String em = request.getParameter("t3");
        String ps = request.getParameter("t2");

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM rega WHERE email = ? AND password = ?";
            PreparedStatement psStmt = con.prepareStatement(query);
            psStmt.setString(1, em);
            psStmt.setString(2, ps);

            ResultSet rs = psStmt.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("userName", rs.getString("username"));
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=exception");
        }
    }
}