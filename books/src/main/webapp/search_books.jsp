<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Books - PahanaEdu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        .search-box {
            margin-bottom: 20px;
        }
        .search-box input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .search-box button {
            padding: 10px 15px;
            background: #007BFF;
            border: none;
            border-radius: 6px;
            color: white;
            cursor: pointer;
        }
        .search-box button:hover {
            background: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background: white;
            box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background: #007BFF;
            color: white;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .back-btn {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 15px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
        .back-btn:hover {
            background: #218838;
        }
    </style>
</head>
<body>
    <h2>🔎 Search Books</h2>

    <!-- Search form -->
    <form action="SearchBooksServlet" method="get" class="search-box">
        <input type="text" name="keyword" placeholder="Enter book ID, title, author, or category" required>
        <button type="submit">Search</button>
    </form>

    <%
        List<String[]> books = (List<String[]>) request.getAttribute("books");
        if (books != null && !books.isEmpty()) {
    %>
        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
            </tr>
            <%
                for (String[] book : books) {
            %>
            <tr>
                <td><%= book[0] %></td>
                <td><%= book[1] %></td>
                <td><%= book[2] %></td>
                <td><%= book[3] %></td>
                <td>Rs. <%= book[4] %></td>
                <td><%= book[5] %></td>
            </tr>
            <% } %>
        </table>
    <%
        } else if (request.getParameter("keyword") != null) {
    %>
        <p style="color:red;">⚠ No books found for "<%= request.getParameter("keyword") %>"</p>
    <%
        }
    %>

   
    <a href="admin_dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

</body>
</html>
