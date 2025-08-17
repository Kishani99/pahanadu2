<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buy Books - PahanaEdu</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f6f9; padding: 20px; }
        h2 { text-align: center; color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; background: #fff; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #3498db; color: #fff; }
        button { padding: 5px 10px; background: #27ae60; color: white; border: none; cursor: pointer; border-radius: 5px; }
        button:hover { background: #1e8449; }
        .cart-link { display: block; margin-top: 20px; text-align: right; }
    </style>
</head>
<body>
    <h2>📚 Buy Books - PahanaEdu</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Book</th>
            <th>Author</th>
            <th>Category</th>
            <th>Price</th>
            <th>quantity</th>
            <th>Action</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");

                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM books");

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getString("author") %></td>
                        <td><%= rs.getString("category") %></td>
                        <td>Rs. <%= rs.getDouble("price") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td>
                            <form action="AddToCartServlet" method="post">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <input type="hidden" name="title" value="<%= rs.getString("title") %>">
                                <input type="hidden" name="price" value="<%= rs.getDouble("price") %>">
                                <input type="number" name="quantity" value="1" min="1" max="<%= rs.getInt("quantity") %>">
                                <button type="submit">Add to Cart</button>
                            </form>
                        </td>
                    </tr>
        <%
                }
                rs.close();
                st.close();
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='7' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>

    <div class="cart-link">
        <a href="cart.jsp">🛒 View Cart & Checkout</a>
    </div>
</body>
</html>
