

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

   
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

            String sql = "SELECT role FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");

              
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                switch (role.toLowerCase()) {
                    case "admin":
                        response.sendRedirect("admin_dashboard.jsp");
                        break;
                    case "cashier":
                        response.sendRedirect("cashier_dashboard.jsp");
                        break;
                    case "customer":
                        response.sendRedirect("customer_dashboard.jsp");
                        break;
                    default:
                        response.sendRedirect("login.jsp?error=Invalid+role");
                        break;
                }
            } else {
               
                response.sendRedirect("login.jsp?error=Invalid+username+or+password");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database+connection+error");
        }
    }
}
