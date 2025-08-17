

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");  
        if (username == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("bookId"));

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

            // Check if book already in cart
            String checkSql = "SELECT * FROM cart WHERE username=? AND book_id=?";
            pst = conn.prepareStatement(checkSql);
            pst.setString(1, username);
            pst.setInt(2, bookId);
            rs = pst.executeQuery();

            if (rs.next()) {
            
                int currentQty = rs.getInt("quantity");
                String updateSql = "UPDATE cart SET quantity=? WHERE username=? AND book_id=?";
                PreparedStatement updatePst = conn.prepareStatement(updateSql);
                updatePst.setInt(1, currentQty + 1);
                updatePst.setString(2, username);
                updatePst.setInt(3, bookId);
                updatePst.executeUpdate();
                updatePst.close();
            } else {
               
                String insertSql = "INSERT INTO cart (username, book_id, quantity) VALUES (?, ?, 1)";
                PreparedStatement insertPst = conn.prepareStatement(insertSql);
                insertPst.setString(1, username);
                insertPst.setInt(2, bookId);
                insertPst.executeUpdate();
                insertPst.close();
            }

            response.sendRedirect("customer_dashboard.jsp?success=Book+added+to+cart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customer_dashboard.jsp?error=Could+not+add+to+cart");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
