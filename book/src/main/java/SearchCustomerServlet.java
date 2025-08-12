

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchCustomerServlet")
public class SearchCustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<Customer> customerList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {

                String sql = "SELECT customer_id, name, address, phone, email FROM customers WHERE name LIKE ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, "%" + keyword + "%");

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setEmail(rs.getString("email"));
                    customerList.add(customer);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.setAttribute("customers", customerList);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("search_customer.jsp").forward(request, response);
    }

   
    public static class Customer {
        private int customerId;
        private String name;
        private String address;
        private String phone;
        private String email;

        public int getCustomerId() { return customerId; }
        public void setCustomerId(int customerId) { this.customerId = customerId; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
    }
}
