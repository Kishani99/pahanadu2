import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminRegisterCustomerServlet")
public class AdminRegisterCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action"); 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

            if ("add".equalsIgnoreCase(action)) {
               
                String accountNumber = request.getParameter("accountNumber");
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String telephone = request.getParameter("telephone");
                String username = request.getParameter("username");
                String password = request.getParameter("password");

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
                    response.sendRedirect("Admin_registercustomer.jsp?success=Customer+added+successfully");
                } else {
                    response.sendRedirect("Admin_registercustomer.jsp?error=Failed+to+add+customer");
                }

                stmt.close();

            } else if ("delete".equalsIgnoreCase(action)) {
             
                String username = request.getParameter("id"); 

                String sql = "DELETE FROM users WHERE id=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);

                int rows = stmt.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("Admin_registercustomer.jsp?success=Customer+deleted+successfully");
                } else {
                    response.sendRedirect("Admin_registercustomer.jsp?error=Customer+not+found");
                }

                stmt.close();
            }

            conn.close();
        } catch (SQLIntegrityConstraintViolationException e) {
            response.sendRedirect("Admin_registercustomer.jsp?error=Username+already+exists");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin_registercustomer.jsp?error=Database+error");
        }
    }
}
