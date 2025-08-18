<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"customer".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    // DB connection
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");

        String sql = "SELECT * FROM books";
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Dashboard - PahanaEdu</title>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 0;
        background: #f9f9f9;
    }
    /* Navbar */
    nav {
        background: #2c3e50;
        padding: 10px 20px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    nav .logo {
        font-size: 20px;
        color: white;
        font-weight: bold;
    }
    nav ul {
        list-style: none;
        display: flex;
        gap: 15px;
        margin: 0;
        padding: 0;
    }
    nav ul li a {
        color: white;
        text-decoration: none;
        padding: 8px 12px;
        border-radius: 6px;
        transition: background 0.2s;
    }
    nav ul li a:hover {
        background: #34495e;
    }
    /* Book grid */
    .book-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px;
        padding: 20px;
    }
    .book-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        overflow: hidden;
        text-align: center;
        transition: transform 0.2s ease;
    }
    .book-card:hover {
        transform: translateY(-5px);
    }
    .book-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }
    .book-card h3 {
        margin: 10px 0;
        color: #2c3e50;
    }
    .book-card p {
        margin: 0;
        padding: 0 10px;
        color: #555;
    }
    .book-card button {
        margin: 10px;
        padding: 8px 15px;
        background: #27ae60;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .book-card button:hover {
        background: #1f8b4d;
    }
</style>
</head>
<body>

<nav>
    <div class="logo">📚 PahanaEdu</div>
    <ul>
        <li><a href="customer_dashboard.jsp">Home</a></li>
        <li><a href="Buybooks.jsp">Buy Books</a></li>
        <li><a href="addcart.jsp">My Cart</a></li>
        <li><a href="payment.jsp">Payment</a></li>
        <li><a href="Login.jsp">Logout</a></li>
    </ul>
</nav>

<h2 style="text-align:center; margin-top: 20px;">Welcome, <%= username %>! Explore Our Books</h2>

<div class="book-container">
    <%
        while (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String author = rs.getString("author");
            double price = rs.getDouble("price");
            String imageUrl = rs.getString("image_url");
    %>
    <div class="book-card">
        <img src="<%= imageUrl %>" alt="Book Cover">
        <h3><%= title %></h3>
        <p>By <%= author %></p>
        <p><b>Rs. <%= price %></b></p>
        <form action="AddToCartServlet" method="post">
            <input type="hidden" name="bookId" value="<%= id %>">
            <button type="submit">Add to Cart</button>
        </form>
    </div>
    <% } %>
</div>

</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ex) {}
        try { if (pst != null) pst.close(); } catch (Exception ex) {}
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>
