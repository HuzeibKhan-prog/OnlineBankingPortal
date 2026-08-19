import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String un = request.getParameter("t1");
        String ps = request.getParameter("t2");
        String em = request.getParameter("t3");
        String c = request.getParameter("country");

        try (Connection con = DBConnection.getConnection()) {
            String query = "INSERT INTO rega (username, password, email, country) VALUES (?, ?, ?, ?)";
            PreparedStatement psStmt = con.prepareStatement(query);
            psStmt.setString(1, un);
            psStmt.setString(2, ps);
            psStmt.setString(3, em);
            psStmt.setString(4, c);

            int rows = psStmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("login.jsp?msg=registered");
            } else {
                out.println("<h3>Registration Failed!</h3>");
            }
        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}