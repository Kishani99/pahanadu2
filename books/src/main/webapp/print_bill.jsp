<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
    String url = "jdbc:mysql://localhost:3306/pahanaedu";
    String user = "root";
    String pass = "";

    String searchName = request.getParameter("customerName");
    String billDate = request.getParameter("billDate");
    double totalAmount = 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Print and Bill - PahanaEdu</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f9f9f9;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #2c3e50;
        }
        .search-box {
            background: #fff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        input, button {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-right: 5px;
        }
        button {
            background: #27ae60;
            color: white;
            border: none;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        table th, table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        table th {
            background: #3498db;
            color: white;
        }
        .total {
            font-weight: bold;
            background: #ecf0f1;
        }
        .print-btn {
            margin-top: 15px;
            background: #2980b9;
        }
    </style>
</head>
<body>
    <h2>🧾 Print Bill - PahanaEdu</h2>

    <div class="search-box">
        <form method="get">
            <input type="text" name="customerName" placeholder="Search by Customer Name" value="<%= searchName != null ? searchName : "" %>">
            <input type="date" name="billDate" value="<%= billDate != null ? billDate : "" %>">
            <button type="submit">Search</button>
        </form>
    </div>

    <table>
        <tr>
            <th>Book Name</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Total</th>
        </tr>

        <%
            if (searchName != null && !searchName.trim().isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(url, user, pass);

                    String sql = "SELECT book_name, quantity, price, (quantity * price) AS total_price " +
                                 "FROM bill_history WHERE customer_name LIKE ? " +
                                 (billDate != null && !billDate.trim().isEmpty() ? "AND bill_date = ?" : "");
                    
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, "%" + searchName + "%");

                    if (billDate != null && !billDate.trim().isEmpty()) {
                        ps.setString(2, billDate);
                    }

                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        double rowTotal = rs.getDouble("total_price");
                        totalAmount += rowTotal;
        %>
                        <tr>
                            <td><%= rs.getString("book_name") %></td>
                            <td><%= rs.getInt("quantity") %></td>
                            <td>Rs. <%= rs.getDouble("price") %></td>
                            <td>Rs. <%= rowTotal %></td>
                        </tr>
        <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='4' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
                }
            }
        %>

        <tr class="total">
            <td colspan="3">Total Amount</td>
            <td>Rs. <%= totalAmount %></td>
        </tr>
    </table>

    <button class="print-btn" onclick="window.print()">🖨 Print Bill</button>
</body>
</html>
