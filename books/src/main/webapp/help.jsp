<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help - PahanaEdu</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fa;
            margin: 0;
        }
        .navbar {
            background: white;
            padding: 15px;
            color: white;
            text-align: center;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        h2 {
            color: #34495e;
            margin-top: 25px;
        }
        p {
            color: #555;
            line-height: 1.6;
        }
        .faq {
            margin: 15px 0;
        }
        .contact-box {
            background: #ecf0f1;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 18px;
            margin-top: 15px;
            background: #27ae60;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #219150;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>PahanaEdu Bookshop - Help & Support</h2>
    </div>

    <div class="container">
        <h1>Need Help?</h1>
        <p>Welcome to the PahanaEdu Bookshop Help Center. Here are some frequently asked questions and answers.</p>

        <div class="faq">
            <h2>1. How do I register?</h2>
            <p>Click on the <b>Register</b> button on the login page, fill in your details, and create an account. Once registered, you can log in with your credentials.</p>
        </div>

        <div class="faq">
            <h2>2. How do I add books to my cart?</h2>
            <p>Browse the books page, click <b>Add to Cart</b> on the book you want, and it will appear in your cart.</p>
        </div>

        <div class="faq">
            <h2>3. How can I pay for my books?</h2>
            <p>We currently support <b>Cash on Delivery</b>. After checkout, your order will be recorded, and you can pay when the books are delivered.</p>
        </div>

        <div class="faq">
            <h2>4. I forgot my password. What should I do?</h2>
            <p>Please contact our support team to reset your password.</p>
        </div>

        <div class="faq">
            <h2>5. How do I contact support?</h2>
            <p>If you can’t find your answer here, reach out to us using the contact details below.</p>
        </div>

        <div class="contact-box">
            <h3>📞 Contact Support</h3>
            <p>Email: <a href="mailto:support@pahanaedu.com">support@pahanaedu.com</a></p>
            <p>Phone: 0764848122</p>
            <p>Available: Mon–Fri, 9:00 AM – 6:00 PM</p>
        </div>

        <a href="home.jsp" class="btn">⬅ Back to Home</a>
    </div>
</body>
</html>
