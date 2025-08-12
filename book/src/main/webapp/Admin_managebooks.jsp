<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Books - PahanaEdu</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f5f7fa; margin: 0; }
        h2 { text-align: center; color: #007bff; margin-top: 20px; }
        form {
            background: white; padding: 20px; margin: 20px auto; width: 50%;
            border-radius: 8px; box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        form input { width: 95%; padding: 8px; margin: 6px 0; border: 1px solid #ccc; border-radius: 5px; }
        form button { padding: 10px 16px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }
        form button:hover { background: #0056b3; }
        table { width: 90%; margin: 20px auto; border-collapse: collapse; background: white; }
        table th, table td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        table th { background: #007bff; color: white; }
        img { width: 60px; height: auto; }
        .delete-btn { background: red; color: white; padding: 6px 10px; border: none; border-radius: 5px; cursor: pointer; }
        .delete-btn:hover { background: darkred; }
    </style>
</head>
<body>

<h2>📚 Manage Books - Admin</h2>

<!-- Add Book Form -->
<form action="ManageBooksServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="add">
    <input type="text" name="title" placeholder="Book Title" required>
    <input type="text" name="author" placeholder="Author">
    <input type="text" name="category" placeholder="Category">
    <input type="number" step="0.01" name="price" placeholder="Price" required>
    <input type="number" name="quantity" placeholder="Quantity" required>
    <input type="file" name="image" accept="image/*" required>
    <button type="submit">Add Book</button>
</form>

<!-- Display Books -->
<table>
    <tr>
        <th>ID</th><th>Title</th><th>Author</th><th>Category</th><th>Price</th><th>Qty</th><th>Image</th><th>Action</th>
    </tr>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM books");
            while(rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("author") %></td>
        <td><%= rs.getString("category") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getInt("quantity") %></td>
        <td><img src="book_images/<%= rs.getString("image_name") %>" alt="Book Image"></td>
        <td>
            <form action="ManageBooksServlet" method="post" style="display:inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <button type="submit" class="delete-btn">Delete</button>
            </form>
        </td>
    </tr>
    <%
            }
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
    %>
</table>

</body>
</html>
