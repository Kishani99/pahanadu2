<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection
    String dbURL = "jdbc:mysql://localhost:3306/pahanaedu";
    String dbUser = "root";
    String dbPass = "";

    String name = "", address = "", phone = "";
    double totalAmount = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Fetch customer details
        PreparedStatement ps = conn.prepareStatement("SELECT name, address, telephone FROM customers WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            address = rs.getString("address");
            phone = rs.getString("telephone");
        }

        // Fetch cart details
        PreparedStatement ps2 = conn.prepareStatement("SELECT b.title, c.quantity, b.price FROM cart c JOIN books b ON c.book_id=b.id WHERE c.username=?");
        ps2.setString(1, username);
        ResultSet rs2 = ps2.executeQuery();
        while (rs2.next()) {
            totalAmount += rs2.getInt("quantity") * rs2.getDouble("price");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment - PahanaEdu</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f9f9f9; margin: 0; }
        .container { max-width: 600px; margin: 30px auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #2c3e50; }
        .details { margin-bottom: 20px; }
        .details p { margin: 5px 0; }
        .payment-option { margin: 15px 0; }
        .btn { background: #27ae60; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; width: 100%; }
        .btn:hover { background: #1f8b4d; }
    </style>
</head>
<body>
<div class="container">
    <h2>Payment - Cash on Delivery</h2>

    <div class="details">
        <h3>Customer Details</h3>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Address:</strong> <%= address %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
    </div>

    <div class="details">
        <h3>Order Summary</h3>
        <p><strong>Total Amount:</strong> Rs. <%= totalAmount %></p>
    </div>

    <form action="PlaceOrderServlet" method="post">
        <input type="hidden" name="username" value="<%= username %>">
        <input type="hidden" name="total" value="<%= totalAmount %>">
        <div class="payment-option">
            <input type="radio" name="paymentMethod" value="Cash on Delivery" checked> Cash on Delivery
        </div>
        <button type="submit" class="btn">Confirm Order</button>
    </form>
</div>
</body>
</html>
