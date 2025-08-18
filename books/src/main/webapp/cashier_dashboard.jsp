<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"cashier".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cashier DashboardPahanaEdu</title>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(to right, #f0f4f7, #d9e4ec);
        margin: 0;
        padding: 0;
    }
    header {
        background: #2c3e50;
        color: white;
        padding: 15px 20px;
        text-align: center;
    }
    header h1 {
        margin: 0;
        font-size: 24px;
    }
    .dashboard {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px;
        padding: 30px;
    }
    .card {
        background: white;
        padding: 20px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
    }
    .card h3 {
        margin-bottom: 15px;
        color: #34495e;
    }
    .card a {
        display: inline-block;
        padding: 10px 20px;
        background: #2980b9;
        color: white;
        border-radius: 8px;
        text-decoration: none;
        font-weight: bold;
        transition: background 0.2s ease;
    }
    .card a:hover {
        background: #1f6690;
    }
</style>
</head>
<body>
<header>
    <h1>Cashier Dashboard - Welcome <%= username %> 👋</h1>
</header>

<div class="dashboard">
    <div class="card">
        <h3>📚 Add New Books</h3>
        <a href="cashier_addbook.jsp">Go</a>
    </div>

    <div class="card">
        <h3>🔍 Search customer</h3>
        <a href="cashier_searchCustomer.jsp">Go</a>
    </div>

    <div class="card">
        <h3>🔍 Search Books</h3>
        <a href="search_books.jsp">Go</a>
    </div>

    <div class="card">
        <h3>🧾 Print Bill</h3>
        <a href="print_bill.jsp">Go</a>
    </div>

    <div class="card">
        <h3>🚪 Exit to Login</h3>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

</body>
</html>
