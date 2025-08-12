<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Customer Account - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .register-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .input-group {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 10px;
            background: #f9f9f9;
        }
        .input-group i {
            margin-right: 10px;
            color: #555;
        }
        .input-group input {
            border: none;
            outline: none;
            background: none;
            flex: 1;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #2196F3;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
        }
        button:hover {
            background: #1976D2;
        }
        .delete-btn {
            background: #dc3545;
        }
        .delete-btn:hover {
            background: #a71d2a;
        }
        /* Message boxes */
        .message {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 10px;
            font-weight: 600;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .message i {
            font-size: 1.3rem;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2><i class="fas fa-user-plus"></i> New Customer Registration</h2>

    <%-- Display success or error messages --%>
    <%
        String successMsg = (String) request.getAttribute("successMessage");
        String errorMsg = (String) request.getAttribute("errorMessage");
        if (successMsg != null) {
    %>
        <div class="message success"><i class="fas fa-check-circle"></i> <%= successMsg %></div>
    <% } else if (errorMsg != null) { %>
        <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= errorMsg %></div>
    <% } %>

    <form action="RegisterServlet" method="post">
        <div class="input-group">
            <i class="fas fa-id-card"></i>
            <input type="text" name="accountNumber" placeholder="Account Number" required>
        </div>
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="name" placeholder="Full Name" required>
        </div>
        <div class="input-group">
            <i class="fas fa-map-marker-alt"></i>
            <input type="text" name="address" placeholder="Address" required>
        </div>
        <div class="input-group">
            <i class="fas fa-phone"></i>
            <input type="text" name="telephone" placeholder="Telephone" required>
        </div>
        <div class="input-group">
            <i class="fas fa-user-circle"></i>
            <input type="text" name="username" placeholder="Username" required>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required>
        </div>
        <button type="submit"><i class="fas fa-check"></i> Register</button>
    </form>
    
    <h2><i class="fas fa-trash-alt"></i> Delete Customer</h2>
    <form action="CustomerServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this customer?');">
        <input type="hidden" name="action" value="delete">
        <div class="input-group">
            <i class="fas fa-id-card"></i>
            <input type="number" name="id" placeholder="Customer ID" required>
        </div>
        <button type="submit" class="delete-btn"><i class="fas fa-trash-alt"></i> Delete Customer</button>
    </form>
</div>
</body>
</html>
