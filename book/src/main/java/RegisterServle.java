

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServle extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // DB connection settings
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // 1. Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Connect to DB
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

            // 3. Insert customer into database
            String sql = "INSERT INTO users (accountNumber, name, address, telephone, username, password, role) " +
                         "VALUES (?, ?, ?, ?, ?, ?, 'customer')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accountNumber);
            stmt.setString(2, name);
            stmt.setString(3, address);
            stmt.setString(4, telephone);
            stmt.setString(5, username);
            stmt.setString(6, password);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                // Auto login after successful registration
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", "customer");

                // Redirect to customer dashboard
                response.sendRedirect("customer_dashboard.jsp");
            } else {
                response.sendRedirect("register.jsp?error=Registration+failed");
            }

            stmt.close();
            conn.close();

        } catch (SQLIntegrityConstraintViolationException e) {
            // Username already exists
            response.sendRedirect("register.jsp?error=Username+already+exists");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database+error");
        }
    }
}
