<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Registration</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="container">
        <h2>Customer Registration</h2>

        <form action="RegistrationServlet" method="post">
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="t1" required>
            </div>

            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="t2" required>
            </div>

            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="t3" required>
            </div>

            <div class="form-group">
                <label>Country:</label>
                <select name="country" required>
                    <option value="" disabled selected>Select your country</option>
                    <option value="India">India</option>
                    <option value="United States">United States</option>
                    <option value="United Kingdom">United Kingdom</option>
                    <option value="Canada">Canada</option>
                    <option value="Australia">Australia</option>
                    <option value="United Arab Emirates">United Arab Emirates</option>
                    <option value="Germany">Germany</option>
                </select>
            </div>

            <button type="submit" class="btn">Register</button>
        </form>
        <br>
        <p class="link-text">
            <a href="index.jsp">Back to Home</a>
        </p>
    </div>
</body>
</html>