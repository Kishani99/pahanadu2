<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Customers - PahanaEdu</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; }
        h2 { text-align: center; color: #007bff; }
        form { text-align: center; margin: 20px; }
        input[type="text"] {
            padding: 8px; width: 250px; border: 1px solid #ccc; border-radius: 5px;
        }
        button {
            padding: 8px 14px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;
        }
        button:hover { background: #0056b3; }
        table { width: 80%; margin: auto; border-collapse: collapse; background: white; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #007bff; color: white; }
    </style>
</head>
<body>

<h2>🔍 Search Customers</h2>

<form method="get" action="">
    <input type="text" name="keyword" placeholder="Enter name or account number" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
    <button type="submit">Search</button>
</form>

<table>
    <tr>
        <th>ID</th><th>Name</th><th>Account No</th><th>Address</th><th>Phone</th>
    </tr>
    <%
        String keyword = request.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");
                String sql = "SELECT * FROM customers WHERE name LIKE ? OR account_number LIKE ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyword + "%");
                ps.setString(2, "%" + keyword + "%");
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("account_number") %></td>
        <td><%= rs.getString("address") %></td>
        <td><%= rs.getString("phone") %></td>
    </tr>
    <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
            }
        }
    %>
</table>

</body>
</html>
